<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 AJAX</title>
<script src="<%=request.getContextPath()%>/public/js/signup_ajax_managing.js" defer="defer"></script>
</head>
<body>
<%@ include file="/header_nav.jsp" %>
<div class="container">
	<h1>회원가입 페이지</h1>
	<!-- Modal -->
	<div class="modal fade" id="InsertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="InsertLabel">멤버 등록</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div id="insertMsg" class="modal-body">
	        
	      </div>
	      <div class="modal-footer">
	      	<button type="button" id="listReloadBtn" class="btn btn-primary">로그인 화면이동</button>
	        <button type="button" class="btn btn-secondary" onclick="form_reset()" data-bs-dismiss="modal">확인</button>
	      </div>
	    </div>
	   </div>
	  </div>
	  <!-- Modal -->
	  <!-- Modal -->
	  <div class="modal fade" id="IdCheckModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
		<div class="modal-content">
	     <div class="modal-header">
	      <h5 class="modal-title" id="idCheckLabel">아이디 중복체크</h5>
	       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		 </div>
		 <div id="idCheckMsg" class="modal-body">
		       
		 </div>
		 <div class="modal-footer">
		   <button type="button" id="idUse" class="btn btn-primary" onclick="sendCheckValue()">사용하기</button>
		   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
		 </div>
		</div>
	  </div>
	 </div>
	<!-- Modal -->
	<form name="memForm">
  		<p class="input-group">
  			<label for="memFormId" class="input-group-text">아이디</label>
  			<input name="id" type="text" class="form-control" id="memFormId" aria-label="First name" onkeydown="inputIdCheck()" autocomplete="off" placeholder="아이디 입력">
  			<a class="btn btn-outline-secondary" href="javascript:void(0)" id="idCheck" type="button" onclick="idCheck()">중복확인</a>
			<input type="hidden" name="idDuplication" value="idUncheck">	  		
  		</p>
  		<p class="input-group">
  			<label for="memFormPw" class="input-group-text">비밀번호</label>
  			<input name="pw" type="password" class="form-control" id="memFormPw" aria-label="First name" autocomplete="off" placeholder="영문자+숫자조합 8~16자리">
  			<label for="memFormPwC" class="input-group-text">비밀번호 확인</label>
  			<input name="pwC" type="password" class="form-control" id="memFormPwC" aria-label="Last name" autocomplete="off" placeholder="비밀번호 확인">
  		</p>
  		<p class="input-group">
  			<label for="memFormPhone" class="input-group-text">핸드폰</label>
  			<input name="phone" type="text" class="form-control" id="memFormPhone" autocomplete="off" aria-label="First name" maxlength="13" placeholder="-포함입력하세요">
  			<span class="input-group-text" id="phoneCheck">핸드폰 체크</span>
  		</p>
  		<p class="input-group">
  			<label for="memFormEmail" class="input-group-text">이메일</label>
  			<input name="email" type="text" class="form-control" id="memFormEmail" autocomplete="off" aria-label="First name" placeholder="이메일 입력">
  			<span class="input-group-text" id="emailCheck">이메일 체크</span>
  		</p>
  		<p class="input-group">
  			<label for="memFormName" class="input-group-text">이름</label>
  			<input name="name" type="text" class="form-control" id="memFormName" autocomplete="off" placeholder="이름 입력">
  		</p>
  		<p class="input-group">
  			<label for="memFormAddress" class="input-group-text">주소</label>
  			<input name="address" type="text" class="form-control" id="memFormAddress" autocomplete="off" placeholder="주소 입력">
  		</p>
  		<p class="input-group">
  			<label for="memFormAddressDetail" class="input-group-text">상세주소</label>
  			<input name="address_detail" type="text" class="form-control" autocomplete="off" id="memFormAddressDetail" placeholder="상세주소 입력">
  		</p>
  		<p class="input-group">
  			<label for="memFormBirth" class="input-group-text">생일</label>
  			<input name="birth" type="date" class="form-control" id="memFormBirth" value="2000-01-01" pattern="yyyy-mm-dd">
  		</p>
  		<p class="input-group">
  			<label for="memFormGrade" class="input-group-text">관리등급</label>
  			<select name="grade" class="form-select" aria-label="Default select example" id="memFormGrade">
			  <option value="2">판매자(2)</option>
			  <option value="3" selected>소비자(3)</option>
			  <option value="4">탈퇴(4)</option>
			</select>
  		</p>
  		<p class="float-end">
			<button class="btn btn-outline-warning" type="reset">리셋</button>
			<button class="btn btn-outline-primary" type="submit">가입</button>
		</p>
  	</form>
</div>
</body>
</html>