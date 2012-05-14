<%
Class LocawebGatewayTransacao
    Public ID
    Public Status
    Public NumeroPedido
    Public MeioPagamento
    Public UrlAcesso
    Public Detalhes
    Public ErroCodigo
    Public ErroMensagem

    Private m_temErro

    Private Sub Class_Initialize()
        m_temErro = False
        Set Me.Detalhes = Server.CreateObject("Scripting.Dictionary")
    End Sub

    Private Sub Class_Terminate()
        Set Me.Detalhes = Nothing
    End Sub

    Public Property Get TemErro
        TemErro = m_temErro
    End Property

    Public Property Let TemErro(value)
        m_temErro = value
    End Property
End Class
%>