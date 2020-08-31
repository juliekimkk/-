<%@ page contentType="text/html; charset=utf-8" %>
<%@ page errorPage="errorView.jsp" %>
<%@ page import="guestbook.model.Message" %>
<%@ page import="guestbook.service.UpdateMessageService" %>
<%@ page import="guestbook.service.listMessageService" %>
<html>
<head>
    <title>방명록 메시지 업데이트 확인</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
		int messageId = Integer.parseInt(request.getParameter("messageId"));
       // String password =request.getParameter("password");

		listMessageService listService = 	listMessageService.getInstance();
		Message message = listService.listMessage(messageId); 
		
		/* int messageId = Integer.parseInt(request.getParameter("messageId"));
        //String password =request.getParameter("password");

		UpdateMessageService UpdateService = 	UpdateMessageService.getInstance();
		UpdateService.updateMessage(message.getId(),message.getGuestName(),message.getMessage(),messag); */
		
		//(int messageId, String guest_name, String message2, String password)
		
	
%>
<%-- <%=message.getGuestName() %> --%>
<form action="updateMessage.jsp" method="post">
<input type="text" name="guest_name" value="<%=message.getGuestName() %>">
<input type="text" name="message" value="<%= message.getMessage()%>">
<input type="hidden" name="messageId" value="${param.messageId}">

메시지를 업데이트하시려면 암호를 입력하세요:<br>
암호: <input type="password" name="password" > <br>
<input type="submit" value="메시지 업데이트하기">
</form>
</body>
</html>