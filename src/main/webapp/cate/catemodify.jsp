<%@page import="model2_shop.com.vo.CategoryVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%String login_c=request.getParameter("login");
CategoryVo cate=(CategoryVo)request.getAttribute("cate");
%>
<script>
let login=<%=login_c%>;
if(login!=null){
	alert("js 수정 : "+login);
}
</script>
<body>
	<%@ include file="/header_nav.jsp" %>
	<h1>/cate/catemodify.jsp</h1>
	<h2>카테고리 수정 폼</h2>
	<form action="./update.do" method="post">
		<p>
			<label>
				카테고리 넘버 : <input type="text" name="cate_num" value="<%=cate.getCate_num()%>">
			</label>
		</p>
		<p>
			<label>
				카테고리 이름 : <input type="text" name="name" value="<%=cate.getName()%>">
			</label>
		</p>
		<p>
			<label>
				서브넘버 : <input type="text" name="sub" value="<%=cate.getSub()%>">
			</label>
		</p>
		<p>
			<button type="reset">리셋</button>
			<button type="submit">제출</button>
			<a href="./delete.do?cate_num=<%=cate.getCate_num()%>">삭제</a>
		</p>
	</form>
</body>
</html>





