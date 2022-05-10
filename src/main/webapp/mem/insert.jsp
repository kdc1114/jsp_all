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
	const MemInsert=document.forms.MemInsert;
	MemInsert.id.addEventListener("input",async(e)=>{
		if(e.target.value.length>3){
			const res=await fetch("./id_check.do?id="+e.target.value); // MemberIdCheck.java
			const json=await res.json();
			console.log(json.id_check);
			if(json.id_check){
				checkId.innerText="사용가능 아이디";
				checkId.style.color="green";
			}else{
				checkId.innerText="사용불가능 아이디";
				checkId.style.color="red";
			}
		}else{
			checkId.innerText="4글자 이상 입력하세요";
			checkId.style.color="red";
		}
	});
	MemInsert.email.addEventListener("blur",async(e)=>{
		if(e.target.value.length>4){
			const res=await fetch("./email_check.do?email="+e.target.value);
			const json=await res.json();
			console.log(json.email_check);
			if(json.email_check){
				checkEmail.innerText="사용가능 이메일";
				checkEmail.style.color="green";
			}else{
				checkEmail.innerText="사용불가능 이메일";
				checkEmail.style.color="red";
			}
		}else{
			checkEmail.innerText="5글자 이상 입력하세요.";
			checkEmail.style.color="red";
		}
	});
	MemInsert.phone.addEventListener("blur",async(e)=>{
		if(e.target.value.length>12){
			const res=await fetch("./phone_check.do?phone="+e.target.value);
			const json=await res.json();
			console.log(json.phone_check);
			if(json.phone_check){
				checkPhone.innerText="사용가능 번호";
				checkPhone.style.color="green";
			}else{
				checkPhone.innerText="사용불가능 번호";
				checkPhone.style.color="red";
			}
		}else{
			checkPhone.innerText="-포함 13자리 번호입력하세요";
			checkPhone.style.color="red";
		}
	});
}
</script>
	<%@ include file="/header_nav.jsp" %>
	<h1>/mem/insert.jsp</h1>
	<h2>멤버 등록 폼</h2>
	<form action="./insert.do" method="post" name="MemInsert">
		<p>
			<label>
				아이디 : <input type="text" name="id" value="" placeholder="아이디 입력">
			</label>
			<span id="checkId">중복체크중입니다.</span>
		</p>
		<p>
			<label>
				이메일 : <input type="text" name="email" value="" placeholder="이메일 입력">
			</label>
			<span id="checkEmail">중복체크중입니다.</span>
		</p>
		<p>
			<label>
				폰 : <input type="text" name="phone" value="" placeholder="핸드폰 입력">
			</label>
			<span id="checkPhone">중복체크중입니다.</span>
		</p>
		<p>
			<label>
				pw : <input type="text" name="pw" value="1234">
			</label>
			<span id="checkPw">길이가 4이상</span>
		</p>
			<p>
			<label>
				pw : <input type="text" name="pw_check" value="">
			</label>
			<span id="checkPwCheck">중복체크중입니다.</span>
		</p>
		
		<p>
			<label>
				이름 : <input type="text" name="name" value="길동">
			</label>
		</p>
		<p>
			<label>
				주소 : <input type="text" name="address" value="서울">
			</label>
		</p>
		<p>
			<label>
				주소상세 : <input type="text" name="address_detail" value="종로구">
			</label>
		</p>
	
		<p>
			<label>
				등급 : <select size="1" name="grade">
					<option value="0">총관리자(0)</option>
					<option value="1">관리자(1)</option>
					<option value="2">판매자(2)</option>
					<option value="3" selected>소비자(3)</option>
					<option value="4">탈퇴(4)</option>
				</select>
			</label>
		</p>
		<p>
			<label>
				생일 : <input type="date" name="birth" value="1900-01-01"
					pattern="yyyy-mm-dd">
			</label>
		</p>
		
		<p>
			<button type="reset">리셋</button>
			<button type="submit">제출</button>
		</p>
	</form>
</body>
</html>