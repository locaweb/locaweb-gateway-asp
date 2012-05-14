<!-- #include file="locaweb/LocawebGateway.asp" -->
<html>
<head>
  <title>Exemplos Gateway de Pagamentos</title>
</head>
<body>
  <h1>Exemplos Gateway de Pagamentos</h1>
  <h2>Configuração utilizada</h2>
  <p>
    Token: <b><%= LocawebGatewayToken %></b><br />
    Ambiente: <b><%= LocawebGatewayAmbiente %></b>
  </p>
  <hr />
  <h2>Exemplos</h2>
  <ul>
    <li><a href="boleto.asp">Boleto</a></li>
    <li><a href="cartao.asp">Cartão</a></li>
  </ul>
</body>
</html>
