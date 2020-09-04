<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="guestbook.service.SearchGuestnameService" %>
<%@ page import="guestbook.model.Message"%>
<%@ page import="guestbook.service.InvalidPassowrdException" %>
<%@ page import="guestbook.service.MessageSearchView"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String search = request.getParameter("search");

	SearchGuestnameService messageSearchService = SearchGuestnameService.getInstance();
	
	MessageSearchView viewData =	messageSearchService.getMessageSearch(search);
%>
<html>
<head>
	<title>검색화면</title> 
</head>
<body>
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
		<td>메시지: ${message.message }  </td>
		<td><a href="confirmUpdate.jsp?messageId=${message.id}">[업데이트하기]</a></td>
		<td><a href="confirmDeletion.jsp?messageId=${message.id}">[삭제하기]</a>
		</td>
	</tr>
	</c:forEach>	
</table>

</c:if>
<a href="list.jsp">[목록 보기]</a>
</body>
</html>