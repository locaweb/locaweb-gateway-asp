<%
Class LocawebGatewayRequest
    Public Url
    Private m_method
    Private m_responseStatus
    Private m_responseBody

    Private Sub Class_Initialize()
        m_method = "POST"
    End Sub

    Private Sub Class_Terminate()
    End Sub

    Public Property Get Method
        Method = m_method
    End Property

    Public Property Let Method(value)
        m_method = value
    End Property

    Public Property Get ResponseStatus
        ResponseStatus = m_responseStatus
    End Property

    Public Property Get ResponseBody
        ResponseBody = m_responseBody
    End Property

    Public Sub Send()
        SendWithData("")
    End Sub

    Public Sub SendWithData(data)
        Dim xmlHttp
        Set xmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
        
        xmlHttp.setOption 2, 13056 'Ignore all certificate errors.
        xmlHttp.Open Me.Method, Me.Url, False
        xmlHttp.SetRequestHeader "Accept", "application/json"
        xmlHttp.SetRequestHeader "Content-Type", "application/json; charset=utf-8"
        xmlHttp.Send data
        
        m_responseStatus = xmlHttp.status
        m_responseBody = xmlHttp.ResponseText

        Set xmlHttp = Nothing
    End Sub
End Class
%>