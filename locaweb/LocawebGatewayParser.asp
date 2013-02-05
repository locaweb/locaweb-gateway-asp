<%
Class LocawebGatewayParser
    Public Function GetTransacao(body)
        Dim transacao
        Set transacao = new LocawebGatewayTransacao

        FillData transacao, body
        FillError transacao, body

        Set GetTransacao = transacao
    End Function

    Private Sub FillData(ByRef transacao, body)
        If Not HasData(body) Then
            Exit Sub
        End If

        Dim data : Set data = JSON.Parse(body)

        transacao.ID = data.transacao.id
        transacao.Status = data.transacao.status
        transacao.NumeroPedido = data.transacao.numero_pedido
        transacao.MeioPagamento = data.transacao.meio_pagamento

    If transacao.MeioPagamento <> "redecard_ws" Then
        transacao.UrlAcesso = data.transacao.url_acesso
	End If
        
        Set transacao.Detalhes = GetDetalhes(data.transacao)

        Set data = Nothing
    End Sub

    Private Function HasData(body)
        HasData = InStr(body, """transacao"":{""id"":") <> 0
    End Function

    Private Function GetDetalhes(transacao)
        Dim detalhes : detalhes = Filter(transacao.Keys(), "detalhes")

        If (UBound(detalhes) = -1) Then
            Set GetDetalhes = Server.CreateObject("Scripting.Dictionary")
        Else
            Set GetDetalhes = transacao.detalhes.ToDictionary()
        End If
    End Function

    Private Sub FillError(ByRef transacao, body)
        SetError transacao, body

        If Not transacao.TemErro Then
            Exit Sub
        End If

        Dim data : Set data = JSON.Parse(body)

        transacao.ErroCodigo = data.transacao.erro.codigo
        transacao.ErroMensagem = data.transacao.erro.mensagem

        Set data = Nothing
    End Sub

    Private Sub SetError(ByRef transacao, body)
        transacao.TemErro = InStr(body, """erro"":null") = 0
    End Sub
End Class
%>
