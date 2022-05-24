<%@page import="java.util.List"%>
<%@page import="model2_shop.com.vo.ItemVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item 관리</title>
<style>
table{
text-align: center;
}
</style>
</head>
<body>
	<%@ include file="/header_nav.jsp" %>
	<div class="container">
	<blockquote class="blockquote">
	<h1 class="h1">아이템 관리 페이지 입니다.</h1>
	</blockquote>
	<h2>
		<a href="iteminsert.do">아이템 등록</a>
	</h2>
	<%
	List<ItemVo> item_list=(List<ItemVo>)request.getAttribute("item_list");
	%>
	<%if(session.getAttribute("delete")!=null){ 
		boolean delete=(boolean)session.getAttribute("delete");
	%>
		<%if(delete){ %>
		<script>alert("삭제 성공");</script>
		<%}else{ %>
		<script>alert("삭제 실패");</script>
		<%} session.removeAttribute("delete");%>
	<%} %>
	<%if(session.getAttribute("insert")!=null){ 
		boolean insert=(boolean)session.getAttribute("insert");
	%>
		<%if(insert){ %>
		<script>alert("등록 성공");</script>
		<%}else{ %>
		<script>alert("등록 실패");</script>
		<%} session.removeAttribute("insert");%>
	<%} %>
	<%if(session.getAttribute("update")!=null){ 
		boolean insert=(boolean)session.getAttribute("update");
	%>
		<%if(insert){ %>
		<script>alert("수정 성공");</script>
		<%}else{ %>
		<script>alert("수정 실패");</script>
		<%} session.removeAttribute("update");%>
	<%} %>
	<table class="table table-dark table-striped">
  		<thead>
  			<tr>
  				<th class="col">NUM</th>
				<th class="col-2">NAME</th>
				<th class="col-2">TITLE</th>
				<th class="col-1">COUNT</th>
				<th class="col-1">PRICE</th>
				<th class="col-1">COLOR</th>
				<th class="col-2">MAIN_IMG</th>
				<th class="col-2">DETAIL_IMG</th>
				<th class="col-2">MODEL_NUM</th>
				<th class="col-2">MEMBER_ID</th>
				<th class="col-1">STATE</th>
				<th class="col-1">C_NUM</th>
  			</tr>
  		</thead>
  		<tbody>
  			<%for(ItemVo item : item_list){ %>
  			<tr>
  				<td><a href="./modify.do?item_num=<%=item.getItem_num()%>"><%=item.getItem_num() %></a></td>
  				<td><%=item.getName() %></td>
  				<td><%=item.getTitle() %></td>
  				<td><%=item.getCount() %></td>
  				<td><%=item.getPrice() %></td>
  				<td><%=item.getColor() %></td>
  				<td><%=item.getMain_img() %></td>
  				<td><%=item.getDetail_img() %></td>
  				<td><%=item.getModel_num() %></td>
  				<td><%=item.getMember_id() %></td>
  				<td><%=item.getState() %></td>
  				<td><%=item.getCate_num() %></td>
  			</tr>
  			<%} %>
  		</tbody>
	</table>
	</div>
</body>
</html>