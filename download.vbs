On Error Resume Next
Set args = Wscript.Arguments
url = args(0)
target = args(1)

WScript.Echo "Downloading " & url & " to " & target & "..."

Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
http.Open "GET", url, False
http.Send
status = http.Status
If status <> 200 Then
  WScript.Echo "Failed to download: HTTP " & status
  WScript.Quit 1
End If
Set stream = CreateObject("ADODB.Stream")
stream.Open
stream.Type = 1
stream.Write http.ResponseBody
stream.Position = 0
stream.SaveToFile target, 2
If err.number <> 0 Then
  WScript.Echo "Error dwonloading file"
  WScript.Quit 1
End If
stream.Close
WScript.Echo "Done"
