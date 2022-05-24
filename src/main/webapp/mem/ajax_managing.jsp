<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER AJAX 관리</title>
<script src="<%=request.getContextPath()%>/public/js/member_ajax_managing.js" defer="defer"></script>
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
		<h1 class="h1">멤버 에이작스 관리 페이지</h1>
	</blockquote>
	<ul class="nav nav-tabs" id="myTab" role="tablist">
  		<li class="nav-item" role="presentation">
    		<button class="nav-link active" id="memList-tab" data-bs-toggle="tab" data-bs-target="#memberList" type="button" role="tab" aria-controls="list" aria-selected="true">멤버 리스트</button>
  		</li>
  		<li class="nav-item" role="presentation">
    	<button class="nav-link" onclick="form_reset()" id="memInsert-tab" data-bs-toggle="tab" data-bs-target="#memInsert" type="button" role="tab" aria-controls="insert" aria-selected="false">멤버 등록</button>
  		</li>
  		<li class="nav-item" role="presentation">
    	<button class="nav-link" id="memUpdate-tab" data-bs-toggle="tab" data-bs-target="#memUpdate" type="button" role="tab" aria-controls="update" aria-selected="false" disabled>멤버 수정</button>
  		</li>
	</ul>
	<div class="tab-content" id="myTabContent">
	  <div class="tab-pane fade show active" id="memberList" role="tabpanel" aria-labelledby="list-tab">
	  	<h2 class="h2">멤버 리스트</h2>
	  	<table class="table table-dark table-striped">
	  		<thead>	
	  			<tr>
	  				<th>ID</th>
					<th>PW</th>
					<th>PHONE</th>
					<th>EMAIL</th>
					<th>NAME</th>
					<th>ADDRESS</th>
					<th>ADDRESS_DATAIL</th>
					<th>SIGNUP_TIME</th>
					<th>BIRTH</th>
					<th>GRADE</th>
	  			</tr>
	  		</thead>
	  		<tbody id="memList">
	  			<tr id="memClone">
	  				<td>
	  					<a class="id" href="javascript:void(0)" onclick="modifyLoad(event)" data-id=""></a>
	  				</td>
	  				<td class="pw"></td>
	  				<td class="phone" ></td>
	  				<td class="email"></td>
	  				<td class="name"></td>
	  				<td class="address"></td>
	  				<td class="address_detail"></td>
	  				<td class="signup_time"></td>
	  				<td class="birth"></td>
	  				<td class="grade"></td>
	  			</tr>
	  		</tbody>
	  	</table>
	  </div>
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
	      	  <button type="button" id="listReloadBtn" class="btn btn-primary">멤버 리스트</button>
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
	  <div class="tab-pane fade" id="memInsert" role="tabpanel" aria-labelledby="insert-tab">
	  	<h2 class="h2">멤버 등록</h2>
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
				  <option value="0">총관리자(0)</option>
				  <option value="1">관리자(1)</option>
				  <option value="2">판매자(2)</option>
				  <option value="3" selected>소비자(3)</option>
				  <option value="4">탈퇴(4)</option>
				</select>
	  		</p>
	  		<p class="float-end">
				<button class="btn btn-outline-warning" type="reset">리셋</button>
				<button class="btn btn-outline-primary" type="submit">등록</button>
			</p>
	  	</form>
	  </div>
	  <!-- Modal -->
	  <div class="modal fade" id="UpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  	<div class="modal-dialog">
		 <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="UpdateLabel">멤버 수정</h5>
	        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div id="updateMsg" class="modal-body">
		        
		   </div>
		   <div class="modal-footer">
		      	<button type="button" id="listReloadBtn2" class="btn btn-primary">멤버 리스트</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="form_reset()">확인</button>
		   </div>
		  </div>
		 </div>
	  </div>
	  <!-- Modal -->
	  <!-- Modal -->
	  <div class="modal fade" id="DeleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  	<div class="modal-dialog">
		 <div class="modal-content">
	      <div class="modal-header">
	       <h5 class="modal-title" id="DeleteLabel">멤버 삭제</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div id="deleteMsg" class="modal-body"> 
		       
		  </div>
		  <div class="modal-footer">
		      <button type="button" id="listReloadBtn3" class="btn btn-primary">멤버 리스트</button>
		      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="form_reset()">확인</button>
		  </div>
		 </div>
		</div>
	  </div>
	  <!-- Modal -->
	  <div class="tab-pane fade" id="memUpdate" role="tabpanel" aria-labelledby="update-tab">
	  	<h2 class="h2">멤버 수정</h2>
	  	<form name="memModifyForm">
	  		<p class="input-group">
	  			<label for="modifyFormId" class="input-group-text">아이디</label>
	  			<input name="id" type="text" class="form-control" id="modifyFormId" autocomplete="off" readonly value="">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormPw" class="input-group-text">비밀번호</label>
	  			<input name="pw" type="password" class="form-control" id="modifyFormPw" aria-label="First name" autocomplete="off" placeholder="영문자+숫자조합 8~16자리">
	  			<label for="memFormPwC" class="input-group-text">비밀번호 확인</label>
	  			<input name="pwC" type="password" class="form-control" id="modifyFormPwC" aria-label="Last name" autocomplete="off" placeholder="비밀번호 확인">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormPhone" class="input-group-text">핸드폰</label>
	  			<input name="phone" type="text" class="form-control" id="modifyFormPhone" aria-label="First name" maxlength="13" placeholder="-포함입력하세요">
	  			<span class="input-group-text" id="modifyPhoneCheck">핸드폰 체크</span>
	  			<input type="hidden" name="phoneDuplication">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormEmail" class="input-group-text">이메일</label>
	  			<input name="email" type="text" class="form-control" id="modifyFormEmail" autocomplete="off" aria-label="First name" placeholder="이메일 입력">
	  			<span class="input-group-text" id="modifyEmailCheck">이메일 체크</span>
	  			<input type="hidden" name="emailDuplication">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormName" class="input-group-text">이름</label>
	  			<input name="name" type="text" class="form-control" id="modifyFormName" autocomplete="off" placeholder="이름 입력">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormAddress" class="input-group-text">주소</label>
	  			<input name="address" type="text" class="form-control" id="modifyFormAddress" autocomplete="off" placeholder="주소 입력">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormAddressDetail" class="input-group-text">상세주소</label>
	  			<input name="address_detail" type="text" class="form-control" id="modifyFormAddressDetail" autocomplete="off" placeholder="상세주소 입력">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormBirth" class="input-group-text">생일</label>
	  			<input name="birth" type="date" class="form-control" id="modifyFormBirth" value="2000-01-01" pattern="yyyy-mm-dd">
	  		</p>
	  		<p class="input-group">
	  			<label for="modifyFormGrade" class="input-group-text">관리등급</label>
	  			<select name="grade" class="form-select" aria-label="Default select example" id="modifyFormGrade">
				  <option value="0">총관리자(0)</option>
				  <option value="1">관리자(1)</option>
				  <option value="2">판매자(2)</option>
				  <option value="3" selected>소비자(3)</option>
				  <option value="4">탈퇴(4)</option>
				</select>
	  		</p>
	  		<p class="float-end">
	  			<a class="btn btn-outline-danger" href="javascript:void(0)" onclick="modifyDel()">삭제</a>
				<button class="btn btn-outline-primary" type="submit">수정</button>
			</p>
	  	</form>
	  </div>
	</div>
</div>
</body>
</html>






