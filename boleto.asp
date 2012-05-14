<!-- #include file="locaweb/LocawebGateway.asp" -->
<html>
<head>
  <title>Exemplo Boleto | Gateway de Pagamentos</title>
</head>
<body>
  <h1>Exemplo Boleto</h1>
<%
If Request.Form("acao") <> "criar" Then 'acao
%>
  <form method="post" action="boleto.asp">
    <input type="hidden" name="acao" value="criar" />
    Banco: <select name="MeioPagamento">
      <option value="boleto_banco_brasil">Banco do Brasil</option>
      <option value="boleto_bradesco">Bradesco</option>
      <option value="boleto_caixa">Caixa Econ�mica Federal</option>
      <option value="boleto_hsbc">HSBC</option>
      <option value="boleto_itau">Ita�</option>
      <option value="boleto_santander">Santander</option>
    </select><br />

    Data Vencimento: <input type="text" name="DataVencimento" value="23122012" /><br />

  
    <br />Pedido<br />
    N�mero: <input type="text" name="PedidoNumero" value="1234" /><br />
    Total: <input type="text" name="PedidoTotal" value="123.45" /><br />
    Moeda: <input type="text" name="PedidoMoeda" value="real" /><br />
    Descri��o: <input type="text" name="PedidoDescricao" value="Um descri��o teste" /><br />
  
    <br />Comprador<br />
    Nome: <input type="text" name="CompradorNome" value="Pedro Bonamides" /><br />
    Documento: <input type="text" name="CompradorDocumento" value="12345678909" /><br />
    Endere�o: <input type="text" name="CompradorEndereco" value="Rua Itapai�na" /><br />
    N�mero: <input type="text" name="CompradorNumero" value="2434" /><br />
    Bairro: <input type="text" name="CompradorBairro" value="Jardim Morumbi" /><br />
    Cidade: <input type="text" name="CompradorCidade" value="S�o Paulo" /><br />
    Estado: <input type="text" name="CompradorEstado" value="SP" /><br />
    CEP: <input type="text" name="CompradorCEP" value="05707-001" /><br />
    <br />
    <br />
    <input type="submit" value=" Criar " />
  </form>
  <br />
  <p><a href="index.asp">Voltar</a></p>
<%
Else 'acao
  Set boleto = New LocawebGatewayTransacaoDados

  With boleto
    .PagamentoMeioPagamento = Request.Form("MeioPagamento")
    .PagamentoDataVencimento = Request.Form("DataVencimento")

    .PedidoNumero = Request.Form("PedidoNumero")
    .PedidoTotal = Request.Form("PedidoTotal")
    .PedidoMoeda = Request.Form("PedidoMoeda")
    .PedidoDescricao = Request.Form("PedidoDescricao")

    .CompradorNome = Request.Form("CompradorNome")
    .CompradorDocumento = Request.Form("CompradorDocumento")
    .CompradorEndereco = Request.Form("CompradorEndereco")
    .CompradorNumero = Request.Form("CompradorNumero")
    .CompradorBairro = Request.Form("CompradorBairro")
    .CompradorCidade = Request.Form("CompradorCidade")
    .CompradorEstado = Request.Form("CompradorEstado")
    .CompradorCEP = Request.Form("CompradorCEP")
  End With

  Set gateway = New LocawebGateway
  Set transacao = gateway.Criar(boleto)

  If transacao.TemErro Then
    Response.Write("<h2>Erros encontrados</h2>")
    Response.Write("C�digo de erro: " & transacao.ErroCodigo & "<br />")
    Response.Write("Mensagem de erro: " & transacao.ErroMensagem & "<br />")
    Response.Write("<p><a href=""javascript:history.back();"">Voltar</a></p>")
  Else
    Response.Write("<h2>Dados da transa��o</h2>")
    Response.Write("ID: " & transacao.ID & "<br />")
    Response.Write("Status: " & transacao.Status & "<br />")
    Response.Write("N�mero do pedido: " & transacao.NumeroPedido & "<br />")
    Response.Write("Meio de pagamento: " & transacao.MeioPagamento & "<br />")
    Response.Write("URL de acesso: " & transacao.UrlAcesso & "<br />")
    Response.Write("<hr />")
    Response.Write("<a href=""" & transacao.UrlAcesso & """ target=""_blank"">Clique aqui para exibir o boleto</a><br />")
  End If

  'Sempre libere os recursos dos objetos ap�s utiliz�-los.'
  Set boleto = Nothing
  Set transacao = Nothing
  Set gateway = Nothing
End If 'acao
%>
</body>
</html>
