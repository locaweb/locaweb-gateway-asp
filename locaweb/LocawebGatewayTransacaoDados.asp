<%
Class LocawebGatewayTransacaoDados
    Public UrlRetorno
    Public Capturar

    Public PedidoNumero
    Public PedidoTotal
    Public PedidoMoeda
    Public PedidoDescricao

    Public PagamentoMeioPagamento
    Public PagamentoDataVencimento
    Public PagamentoBandeira
    Public PagamentoCartaoNumero
    Public PagamentoCartaoCvv
    Public PagamentoCartaoValidade
    Public PagamentoTipoOperacao
    Public PagamentoParcelas

    Public CompradorNome
    Public CompradorDocumento
    Public CompradorEndereco
    Public CompradorNumero
    Public CompradorBairro
    Public CompradorCidade
    Public CompradorEstado
    Public CompradorCEP

    Public Function ToJson()
        Dim json : Set json = JSObject()

        SetTransacao(json)
        SetPedido(json)
        SetPagamento(json)
        SetComprador(json)

        ToJson = json.jsString()
        Set json = Nothing
    End Function

    Private Function SetTransacao(ByRef json)
        Set json("transacao") = JSObject()
        json("transacao")("url_retorno") = UrlRetorno
        json("transacao")("capturar") = Capturar
    End Function

    Private Function SetPedido(ByRef json)
        Set json("transacao")("pedido") = JSObject()
        json("transacao")("pedido")("numero") = PedidoNumero
        json("transacao")("pedido")("total") = PedidoTotal
        json("transacao")("pedido")("moeda") = PedidoMoeda
        json("transacao")("pedido")("descricao") = PedidoDescricao
    End Function

    Private Function SetPagamento(ByRef json)
        Set json("transacao")("pagamento") = JSObject()
        json("transacao")("pagamento")("meio_pagamento") = PagamentoMeioPagamento
        json("transacao")("pagamento")("data_vencimento") = PagamentoDataVencimento
        json("transacao")("pagamento")("bandeira") = PagamentoBandeira
        json("transacao")("pagamento")("cartao_numero") = PagamentoCartaoNumero
        json("transacao")("pagamento")("cartao_cvv") = PagamentoCartaoCvv
        json("transacao")("pagamento")("cartao_validade") = PagamentoCartaoValidade
        json("transacao")("pagamento")("tipo_operacao") = PagamentoTipoOperacao
        json("transacao")("pagamento")("parcelas") = PagamentoParcelas
    End Function

    Private Function SetComprador(ByRef json)
        Set json("transacao")("comprador") = JSObject()
        json("transacao")("comprador")("nome") = CompradorNome
        json("transacao")("comprador")("documento") = CompradorDocumento
        json("transacao")("comprador")("endereco") = CompradorEndereco
        json("transacao")("comprador")("numero") = CompradorNumero
        json("transacao")("comprador")("bairro") = CompradorBairro
        json("transacao")("comprador")("cidade") = CompradorCidade
        json("transacao")("comprador")("estado") = CompradorEstado
        json("transacao")("comprador")("cep") = CompradorCEP
    End Function
End Class
%>