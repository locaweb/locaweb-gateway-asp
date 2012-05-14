<!-- #include file="locaweb/LocawebGateway.asp" -->
<html>
<head>
  <title>Exemplo Cartão | Gateway de Pagamentos</title>
</head>
<body>
  <h1>Exemplo Cartão</h1>
<%
If Request.Form("acao") <> "criar" Then 'acao
%>
  <form method="post" action="cartao.asp">
    <input type="hidden" name="acao" value="criar" />
    URL retorno: <input type="text" name="UrlRetorno" value="http://localhost:456/retorno.asp" size="150" /><br />
    Capturar: <select name="Capturar">
      <option value="true">Sim</option>
      <option value="false">Não</option>
    </select><br />
  
    <br />Pagamento:<br />
    Operadora: <select name="PagamentoMeioPagamento">
      <option value="cielo">Cielo E-commerce</option>
      <option value="redecard_web">Redecard Komerci Integrado</option>
      <option value="redecard_ws">Redecard Komerci WebService</option>
    </select><br />
    Bandeira: <select name="PagamentoBandeira">
      <option value="visa">Visa</option>
      <option value="mastercard">Mastercard</option>
      <option value="diners">Diners</option>
      <option value="elo">Elo</option>
      <option value="discover">Discover</option>
    </select><br />
    Tipo de operação: <select name="PagamentoTipoOperacao">
      <option value="credito_a_vista">Crédito à vista</option>
      <option value="parcelado_loja">Parcelado loja</option>
      <option value="parcelado_administradora">Parcelado administradora</option>
      <option value="debito">Débito</option>
    </select><br />
    Parcelas: <select name="PagamentoParcelas">
    <% For i = 1 to 12 %>
      <option value="<%= i %>"><%= i %></option>
    <% Next %>
    </select><br />
  
    <br />Cartão<br />
    Número: <input type="text" name="PagamentoCartaoNumero" value="" /><br />
    CVV: <input type="text" name="PagamentoCartaoCvv" value="" /><br />
    Validade: <input type="text" name="PagamentoCartaoValidade" value="" /><br />
  
    <br />Pedido<br />
    Número: <input type="text" name="PedidoNumero" value="1234" /><br />
    Total: <input type="text" name="PedidoTotal" value="123.45" /><br />
    Moeda: <input type="text" name="PedidoMoeda" value="real" /><br />
    Descrição: <input type="text" name="PedidoDescricao" value="Pedido de teste Locaweb" /><br />
  
    <br />Comprador<br />
    Nome: <input type="text" name="CompradorNome" value="Pedro Bonamides" /><br />
    Documento: <input type="text" name="CompradorDocumento" value="12345678909" /><br />
    Endereço: <input type="text" name="CompradorEndereco" value="Rua Itapaiúna" /><br />
    Número: <input type="text" name="CompradorNumero" value="2434" /><br />
    Bairro: <input type="text" name="CompradorBairro" value="Jardim Morumbi" /><br />
    Cidade: <input type="text" name="CompradorCidade" value="São Paulo" /><br />
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
  Set cartao = New LocawebGatewayTransacaoDados

  With cartao
    .UrlRetorno = Request.Form("UrlRetorno")
    .Capturar = CBool(Request.Form("Capturar"))

    .PedidoNumero = Request.Form("PedidoNumero")
    .PedidoTotal = Request.Form("PedidoTotal")
    .PedidoMoeda = Request.Form("PedidoMoeda")
    .PedidoDescricao = Request.Form("PedidoDescricao")

    .PagamentoMeioPagamento = Request.Form("PagamentoMeioPagamento")
    .PagamentoBandeira = Request.Form("PagamentoBandeira")
    .PagamentoCartaoNumero = Request.Form("PagamentoCartaoNumero")
    .PagamentoCartaoCvv = Request.Form("PagamentoCartaoCvv")
    .PagamentoCartaoValidade = Request.Form("PagamentoCartaoValidade")
    .PagamentoTipoOperacao = Request.Form("PagamentoTipoOperacao")
    .PagamentoParcelas = CInt(Request.Form("PagamentoParcelas"))

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
  Set transacao = gateway.Criar(cartao)

  If transacao.TemErro Then
    Response.Write("<h2>Erros encontrados</h2>")
    Response.Write("Código de erro: " & transacao.ErroCodigo & "<br />")
    Response.Write("Mensagem de erro: " & transacao.ErroMensagem & "<br />")
    Response.Write("<p><a href=""javascript:history.back();"">Voltar</a></p>")
  Else
    urlRedirect = transacao.UrlAcesso
  End If

  'Sempre libere os recursos dos objetos após utilizá-los.'
  Set cartao = Nothing
  Set transacao = Nothing
  Set gateway = Nothing 

  If urlRedirect <> "" Then
    Response.Redirect(urlRedirect)
  End If
End If 'acao
%>
</body>
</html>