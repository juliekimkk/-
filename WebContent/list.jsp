<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="guestbook.model.Message"%>
<%@ page import="guestbook.service.MessageListView"%>
<%@ page import="guestbook.service.GetMessageListService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String pageNumberStr = request.getParameter("page");
	out.println(pageNumberStr);
	int pageNumber = 1;
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
		out.println(pageNumber);
		out.println(pageNumberStr);
	}

	GetMessageListService messageListService = 
			GetMessageListService.getInstance();
	
	MessageListView viewData =
			messageListService.getMessageList(pageNumber);
%>
<c:set var="viewData" value="<%= viewData %>"/>
<html>
<head>
	<title>방명록 메시지 목록</title>
</head>
<body>


<c:if test="${viewData.isEmpty()}">
등록된 메시지가 없습니다.
</c:if>




<c:if test="${!viewData.isEmpty()}">
<table border="1">
	<c:forEach var="message" items="${viewData.messageList}">
	<tr>
		<td>
		<td>메시지 번호: ${message.id} </td>
		<td>손님 이름: ${message.guestName }</td>
		<td>메시지: <a href="confirmUpdate.jsp?messageId=${message.id}">[업데이트하기]</a>  </td>
		<td><a href="confirmDeletion.jsp?messageId=${message.id}">[삭제하기]</a>
		</td>
	</tr>
	</c:forEach>
</table>

<c:forEach var="pageNum" begin="1" end="${viewData.pageTotalCount}">   
<a href="list.jsp?page=${pageNum}">[${pageNum}]</a>
</c:forEach>

</c:if>
</body>
</html>