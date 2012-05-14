<!-- #include file="locaweb/LocawebGateway.asp" -->
<html>
  <head>
    <title>Exemplo de retorno | Gateway de Pagamentos</title>
  </head>
  <body>
    <h1>Exemplo de retorno</h1>
<%
idTransacao = CInt(Request.QueryString("transacao"))

If (idTransacao = 0) Then
  Response.Write("Transação não informada.")
  Response.End
End If

Set gateway = New LocawebGateway
Set transacao = gateway.Consultar(idTransacao)

Response.Write("<h2>Dados da transação</h2>")
Response.Write("ID: " & transacao.ID & "<br />")
Response.Write("Status: " & transacao.Status & "<br />")
Response.Write("Número do pedido: " & transacao.NumeroPedido & "<br />")
Response.Write("Meio de pagamento: " & transacao.MeioPagamento & "<br />")
Response.Write("URL de acesso: " & transacao.UrlAcesso & "<br />")
Response.Write("Detalhes: <br />")

'A propriedade Detalhes é um objeto do tipo "Scripting.Dictionary".'
'As chaves do dicionário variam de acordo com o meio de pagamento da transação.'
Dim key : For Each key In transacao.Detalhes.keys()
  Response.Write("- " & key & ": " & transacao.Detalhes(key) & "<br />")
Next

If transacao.TemErro Then
  Response.Write("<h2>Erros encontrados</h2>")
  Response.Write("Código de erro: " & transacao.ErroCodigo & "<br />")
  Response.Write("Mensagem de erro: " & transacao.ErroMensagem & "<br />")
End If

'Sempre libere os recursos dos objetos após utilizá-los.'
Set transacao = Nothing
Set gateway = Nothing 
%>
  <br />
  <p><a href="index.asp">Voltar</a></p>
  </body>
</html>