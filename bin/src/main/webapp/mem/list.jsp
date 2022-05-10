<%@page import="model2_shop.com.vo.MemberVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table{
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="/header_nav.jsp" %>
	<h1>멤버 관리 페이지 입니다.</h1>
	<h2>
		<a href="insert.do">멤버 등록</a>
	</h2>
	<%
		List<MemberVo> mem_list=(List<MemberVo>)request.getAttribute("mem_list");
		//boolean delete=(boolean)(request.getSession().getAttribute("delete"));
		// HttpSession session=request.getSession() => 미리 만들어져 있다.
		// PrintWriter out=response.getWrite() => 미리 만들어져 있다.
	%>
<%
	if(session.getAttribute("delete")!=null){	
		boolean delete=(boolean)session.getAttribute("delete");
	%>
	<%if(delete){ %>
	<script>alert("삭제 성공");</script>
	<%}else{%>
	<script>alert("삭제 실패");</script>
	<%} 
		session.removeAttribute("delete");
	}
%>
<%
	if(session.getAttribute("insert")!=null){	
		boolean insert=(boolean)session.getAttribute("insert");
	%>
	<%if(insert){ %>
	<script>alert("등록 성공");</script>
	<%}else{%>
	<script>alert("등록 실패");</script>
	<%} 
		session.removeAttribute("insert");
	}
%>
<%
	if(session.getAttribute("update")!=null){	
		boolean insert=(boolean)session.getAttribute("update");
	%>
	<%if(insert){ %>
	<script>alert("수정 성공");</script>
	<%}else{%>
	<script>alert("수정 실패");</script>
	<%} 
		session.removeAttribute("update");
	}
%>
	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>PW</th>
				<th>PHONE</th>
				<th>EMAIL</th>
				<th>NAME</th>
				<th>ADDRESS</th>
				<th>ADDRESS_DETAIL</th>
				<th>SIGNUP_TIME</th>
				<th>BIRTH</th>
				<th>GRADE</th>
				<th>수정페이지</th>
			</tr>
		</thead>
		<tbody>
			<%for(MemberVo mem : mem_list){ %>
				<tr>
					<td><%=mem.getId() %></td>
					<td><%=mem.getPw() %></td>
					<td><%=mem.getPhone() %></td>
					<td><%=mem.getEmail() %></td>
					<td><%=mem.getName() %></td>
					<td><%=mem.getAddress() %></td>
					<td><%=mem.getAddress_detail() %></td>
					<td><%=mem.getSignup_time() %></td>
					<td><%=mem.getBirth() %></td>
					<td><%=mem.getGrade() %></td>
					<td><a href="./modify.do?id=<%=mem.getId()%>">수정</a></td>
				</tr>
			<%} %>
		</tbody>
	</table>
</body>
</html>





