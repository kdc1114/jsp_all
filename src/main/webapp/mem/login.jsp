<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>샵 스프링 로그인 페이지</title>
</head>
<body>
<%
	// HttpSession session=request.getSession();
	// null => boolean 형변환 시 오류
	// boolean login=(boolean)session.getAttribute("login");
	Object login_obj=session.getAttribute("login");
	Object id=session.getAttribute("id");
	if(login_obj!=null && !((boolean)login_obj)){
		session.removeAttribute("login"); // 세션 객체 삭제
		// session.invalidate(); // 세션을 만료해서 모두 삭제
%>
<script>alert("아이디와 패스워드를 확인하세요!");</script>
<%} 
	Object login_msg=session.getAttribute("login_msg");
	Object login_item=session.getAttribute("login_item");
	if(login_msg!=null){
		session.removeAttribute("login_msg");
%>
<script>alert("<%=login_msg%>")</script>
<%} %>
<%
	if(login_item!=null){
		session.removeAttribute("login_item");
%>
<script>alert("<%=login_item%>")</script>
<%} %>
	<%@ include file="/header_nav.jsp" %>
	<h1>샵 스프링 로그인 페이지</h1>
	<div class="d-flex justify-content-center align-items-center" style="height: calc(100vh - 200px);">
		<form action="<%=request.getContextPath() %>/login.do" method="post" style="width: 600px;">
			<div class="mb-3 row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">아이디</label>
		    <div class="col-sm-10">
		      <input name="id" type="text" class="form-control" autocomplete="off" id="staticEmail" value="<%=(id!=null)?id:""%>">
		    </div>
		  	</div>
		  	<div class="mb-3 row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-10">
		      <input name="pw" type="password" autocomplete="off" class="form-control" id="inputPassword">
		    </div>
	    	</div>
		    <div class="col-12">
		    	<a href="<%=request.getContextPath()%>/mem_new/signup.do" class="btn btn-secondary">회원가입</a>
		    	<button type="submit" class="btn btn-success">로그인</button>
		    </div>
		</form>
	</div>
</body>
</html>