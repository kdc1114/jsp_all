<%@page import="model2_shop.com.vo.CategoryVo"%>
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
<%
if(session.getAttribute("delete")!=null){
	boolean delete=(boolean)session.getAttribute("delete");
	String msg="";
	if(delete){ 
		msg="<script>alert(\"삭제 성공\");</script>";
	}else{ 
		msg="<script>alert(\"삭제 실패\");</script>";
	} 
	out.append(msg);
	session.removeAttribute("delete");
}
%>
<%
	if(session.getAttribute("cateinsert")!=null){
		boolean insert=(boolean)session.getAttribute("cateinsert");
	%>
	<%if(insert){ %>
	<script>alert("등록 성공");</script>
	<%}else{ %>
	<script>alert("등록 실패");</script>
	<%}
		session.removeAttribute("cateinsert");
	}
%>
<body>
	<%@ include file="/header_nav.jsp" %>
	<h1>카테고리 관리 페이지 입니다.</h1>
	<h2>
		<a href="cateinsert.do">카테고리 등록</a>
	</h2>
	<%
		List<CategoryVo> cate_list=(List<CategoryVo>)request.getAttribute("cate_list");
	%>
	<table>
		<thead>
			<tr>
				<th>CATE_NUM</th>
				<th>NAME</th>
				<th>SUB</th>
				<th>수정페이지</th>
			</tr>
		</thead>
		<tbody>
			<%for(CategoryVo cate : cate_list){ %>
			<tr>
				<td><%=cate.getCate_num() %></td>
				<td><%=cate.getName() %></td>
				<td><%=cate.getSub() %></td>
				<td><a href="./catemodify.do?cate_num=<%=cate.getCate_num()%>">수정</a></td>
			</tr>
			<%} %>
		</tbody>
	</table>
</body>
</html>



