<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="guestbook.service.UpdateMessageService" %>
<%@ page import="guestbook.service.InvalidPassowrdException" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>


<%

	request.setCharacterEncoding("utf-8");
	String guest_name = request.getParameter("guest_name");
	String message2 = request.getParameter("message");
	int messageId = Integer.parseInt(request.getParameter("messageId"));
	String password = request.getParameter("password");
	String image = request.getParameter("image");
	boolean invalidPassowrd = false;

	try {
		UpdateMessageService updateService = 
				UpdateMessageService.getInstance();
		updateService.updateMessage(messageId, guest_name, message2, password, image);
	} catch(InvalidPassowrdException ex) {
		invalidPassowrd = true;
	}
%>
<html>
<head>
	<title>방명록 메시지 업데이트함</title> 
</head>
<body>
<%  if (!invalidPassowrd) { %>
메시지를 업데이트하였습니다.
<%  } else { %>
입력한 암호가 올바르지 않습니다. 암호를 확인해주세요.
<%  }%>
<br/>
<a href="list.jsp">[목록 보기]</a>
</body>
</html>