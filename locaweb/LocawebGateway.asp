<!-- #include file="LocawebGatewayConfig.asp" -->
<!-- #include file="LocawebGatewayParser.asp" -->
<!-- #include file="LocawebGatewayRequest.asp" -->
<!-- #include file="LocawebGatewayTransacao.asp" -->
<!-- #include file="LocawebGatewayTransacaoDados.asp" -->
<!-- #include file="json/aspjson.asp" -->
<!-- #include file="json/json2.1.asp" -->
<%
Class LocawebGateway
    Private m_url
    Private m_token
    Private m_request
    Private m_parser

    Private Sub Class_Initialize()
        m_url = GetUrl()
        m_token = LocawebGatewayToken
        Set m_request = New LocawebGatewayRequest
        Set m_parser = New LocawebGatewayParser
    End Sub

    Private Sub Class_Terminate()
        Set m_request = Nothing
        Set m_parser = Nothing
    End Sub

    Public Property Get Url
        Url = m_url
    End Property

    Public Property Get Token
        Token = m_token
    End Property

    Private Property Get Request
        Set Request = m_request
    End Property

    Private Property Get Parser
        Set Parser = m_parser
    End Property

    Public Function Criar(dados)
        Request.Url = Me.Url & "?token=" & Me.Token
        Request.Method = "POST"
        Request.SendWithData(dados.ToJson())

        Set Criar = Parse(Request)
    End Function

    Public Function Consultar(id)
        Request.Url = Me.Url & CStr(id) & "/?token=" & Me.Token
        Request.Method = "GET"
        Request.Send()

        Set Consultar = Parse(Request)
    End Function

    Public Function Capturar(id)
        Request.Url = Me.Url & CStr(id) & "/capturar/?token=" & Me.Token
        Request.Method = "POST"
        Request.Send()

        Set Capturar = Parse(Request)
    End Function

    Public Function Cancelar(id)
        Request.Url = Me.Url & CStr(id) & "/estornar/?token=" & Me.Token
        Request.Method = "POST"
        Request.Send()

        Set Cancelar = Parse(Request)
    End Function

    Private Function Parse(request)
        Set Parse = Parser.GetTransacao(request.ResponseBody)
    End Function

    Private Function GetUrl()
        If LCase(LocawebGatewayAmbiente) = "producao" Then
            GetUrl = "https://api.gatewaylocaweb.com.br/v1/transacao/"
        Else
            GetUrl = "https://api-sandbox.gatewaylocaweb.com.br/v1/transacao/"
        End If
    End Function
End Class
%>
