<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
window.onload=function(){
	const CateInsert=document.forms.CateInsert;
	CateInsert.name.addEventListener("blur",async(e)=>{
		if(e.target.value.length>0){
			const res=await fetch("./name_check.do?name="+e.target.value);
			const json=await res.json();
			console.log(json.name_check);
			if(json.name_check){
				checkName.innerText="사용가능 이름";
				checkName.style.color="green";
			}else{
				checkName.innerText="사용불가능 이름";
				checkName.style.color="red";
			}
		}else{
			checkName.innerText="최소1글자 이상 입력해주세요";
			checkName.style.color="red";
		}
	});
}
</script>
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
	<%@ include file="/header_nav.jsp" %>
	<h1>/cate/cateinsert.jsp</h1>
	<h2>카테고리 등록 폼</h2>
	<form action="./cateinsert.do" method="post" name="CateInsert">
		<p>
			<label>
				카테고리 넘버 : <input type="text" name="cate_num" value="" placeholder="카테고리 넘버입력">
			</label>
		</p>
		<p>
			<label>
				이름 : <input type="text" name="name" value="" placeholder="카테고리 이름">
			</label>
			<span id="checkName">중복체크중</span>
		</p>
		<p>
			<label>
				카테고리 서브넘버 : <input type="text" name="sub" value="" placeholder="카테고리 서브넘버입력">
			</label>
		</p>
		<p>
			<button type="reset">리셋</button>
			<button type="submit">제출</button>
		</p>
	</form>
</body>
</html>