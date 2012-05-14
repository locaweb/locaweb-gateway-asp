# Locaweb Gateway ASP

## Configuração

- Copie a pasta "locaweb" para sua aplicação.
- No arquivo locaweb/LocawebGatewayConfig.asp configure seu token e ambiente.
- Em todos os arquivos ASP que você for utilizar o Locaweb Gateway ASP, faça o include do arquivo locaweb/LocawebGateway.asp, como no exemplo abaixo:


    <!-- #include file="locaweb/LocawebGateway.asp" -->
    <%
      'Seu código aqui...'
    %>


## Uso

### Criação de transação

#### Exemplo de Boleto Itaú

    <!-- #include file="locaweb/LocawebGateway.asp" -->
    <%
    Set boleto = New LocawebGatewayTransacaoDados

    With boleto
      .PagamentoMeioPagamento = "boleto_itau"
      .PagamentoDataVencimento = "23122012"

      .PedidoNumero = "72812923"
      .PedidoTotal = 123.45
      .PedidoMoeda = "real"
      .PedidoDescricao = "Bola de Basquete Never Flat Spalding (1)"

      .CompradorNome = "Pedro Bonamides"
      .CompradorDocumento = "12345678909"
      .CompradorEndereco = "Rua Itapaiúna"
      .CompradorNumero = "5434"
      .CompradorBairro = "Jardim Morumbi"
      .CompradorCidade = "São Paulo"
      .CompradorEstado = "SP"
      .CompradorCEP = "05707-001"
    End With

    Set gateway = New LocawebGateway
    Set transacao = gateway.Criar(boleto)

    If transacao.TemErro Then
      Response.Write("<h2>Erros encontrados</h2>")
      Response.Write("Código de erro: " & transacao.ErroCodigo & "<br />")
      Response.Write("Mensagem de erro: " & transacao.ErroMensagem & "<br />")
    Else
      Response.Write("<h2>Dados da transação</h2>")
      Response.Write("ID: " & transacao.ID & "<br />")
      Response.Write("Status: " & transacao.Status & "<br />")
      Response.Write("Número do pedido: " & transacao.NumeroPedido & "<br />")
      Response.Write("Meio de pagamento: " & transacao.MeioPagamento & "<br />")
      Response.Write("URL de acesso: " & transacao.UrlAcesso & "<br />")
    End If

    'Sempre libere os recursos dos objetos após utilizá-los.'
    Set boleto = Nothing
    Set transacao = Nothing
    Set gateway = Nothing
    %>


#### Exemplo de Cielo E-Commerce

    <!-- #include file="locaweb/LocawebGateway.asp" -->
    <%
    Set cielo = New LocawebGatewayTransacaoDados

    With cielo
      .UrlRetorno = "http://www.sualoja.com.br/retorno"
      .Capturar = True

      .PedidoNumero = "987654"
      .PedidoTotal = 123.45
      .PedidoMoeda = "real"
      .PedidoDescricao = "Bola de Basquete Never Flat Spalding (1)"

      .PagamentoMeioPagamento = "cielo"
      .PagamentoBandeira = "Visa"
      .PagamentoCartaoNumero = "4012001037141112"
      .PagamentoCartaoCvv = "123"
      .PagamentoCartaoValidade = "082015"
      .PagamentoTipoOperacao = "credito_a_vista"
      .PagamentoParcelas = 1

      .CompradorNome = "Pedro Bonamides"
      .CompradorDocumento = "1234568909"
      .CompradorEndereco = "Rua Itapaiúna"
      .CompradorNumero = "5434"
      .CompradorBairro = "Jardim Morumbi"
      .CompradorCidade = "São Paulo"
      .CompradorEstado = "SP"
      .CompradorCEP = "05707-001"
    End With

    Set gateway = New LocawebGateway
    Set transacao = gateway.Criar(cielo)

    If transacao.TemErro Then
      Response.Write("<h2>Erros encontrados</h2>")
      Response.Write("Código de erro: " & transacao.ErroCodigo & "<br />")
      Response.Write("Mensagem de erro: " & transacao.ErroMensagem & "<br />")
    Else
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
    End If

    'Sempre libere os recursos dos objetos após utilizá-los.'
    Set cielo = Nothing
    Set transacao = Nothing
    Set gateway = Nothing
    %>


### Consulta de transação

    <!-- #include file="locaweb/LocawebGateway.asp" -->
    <%
    Set gateway = New LocawebGateway
    Set transacao = gateway.Consultar(999) 'O parâmetro é o ID da transação.'

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


### Cancelamento de transação

    <!-- #include file="locaweb/LocawebGateway.asp" -->
    <%
    Set gateway = New LocawebGateway
    Set transacao = gateway.Cancelar(999) 'O parâmetro é o ID da transação.'

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


### Captura de transação

    <!-- #include file="locaweb/LocawebGateway.asp" -->
    <%
    Set gateway = New LocawebGateway
    Set transacao = gateway.Capturar(999) 'O parâmetro é o ID da transação.'

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

