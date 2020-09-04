<%@ page contentType="text/html; charset=utf-8"%>
<%@ page errorPage="errorView.jsp"%>
<%@ page import="guestbook.model.Message"%>
<%@ page import="guestbook.service.UpdateMessageService"%>
<%@ page import="guestbook.service.listMessageService"%>
<html>
<head>
<style>
.asd {
	height: 50px;
}

</style>
<title>방명록 메시지 업데이트 확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	int messageId = Integer.parseInt(request.getParameter("messageId"));
	// String password =request.getParameter("password");

	listMessageService listService = listMessageService.getInstance();
	Message message = listService.listMessage(messageId);

	//밑에 hidden messageld는 양식에 있는 만큼 맞춰줘야해서 숨겨주고 적어줌 그리고 <%=messge.getGuestName() 이 양식은 화면에 나오게 하는 방식.
	%>
	<%-- <%=message.getGuestName() %> --%>
	<form action="updateMessage.jsp" method="post">
		<input type="text" name="guest_name" value="<%=message.getGuestName()%>"> 
		<input class="asd" type="text" name="message" value="<%=message.getMessage()%>"size="50px" > 
		<input type="hidden" name="messageId" value="${param.messageId}">
		파일붙이기 : <input type="file" name="file1"/><br/>
		 메시지를 업데이트하시려면 암호를 입력하세요:<br> 암호: <input type="password" name="password">
		<br> <input type="submit" value="메시지 업데이트하기">
	</form>
</body>
</html>