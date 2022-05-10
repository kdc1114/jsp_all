<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category AJAX 관리</title>
<script src="<%=request.getContextPath()%>/public/js/category_ajax_managing.js" defer="defer"></script>
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
		<h1 class="h1">카테고리 에이작스 관리 페이지</h1>
	</blockquote>
	<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="cateList-tab" data-bs-toggle="tab" data-bs-target="#categoryList" type="button" role="tab" aria-controls="list" aria-selected="true">카테고리 리스트</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="cateInsert-tab" data-bs-toggle="tab" data-bs-target="#cateInsert" type="button" role="tab" aria-controls="insert" aria-selected="false">카테고리 등록</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="cateUpdate-tab" data-bs-toggle="tab" data-bs-target="#cateUpdate" type="button" role="tab" aria-controls="update" aria-selected="false" disabled>카테고리 수정</button>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="categoryList" role="tabpanel" aria-labelledby="list-tab">
  	<h2 class="h2">카테고리 리스트</h2>
  	<table class="table table-dark table-striped">
  		<thead>
  			<tr>
  				<th class="col-1">CATE_NUM</th>
  				<th class="col-2">NAME</th>
  				<th class="col-2">SUB</th>
  			</tr>
  		</thead>
  		<tbody id="cateList">
  			<tr id="cateClone">
  				<td>
  					<a class="cate_num" href="javascript:void(0)" onclick="modifyLoad(event)" data-num=""></a>
  				</td>
  				<td class="name"></td>
  				<td class="sub"></td>
  			</tr>
  		</tbody>
  	</table>
  </div>
  <!-- Modal -->
  <div class="modal fade" id="InsertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="InsertLabel">카테고리 등록</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div id="insertMsg" class="modal-body">
        
        </div>
        <div class="modal-footer">
      	  <button type="button" id="listReloadBtn" class="btn btn-primary">카테고리 리스트</button>
          <button type="button" class="btn btn-secondary" onclick="form_reset()" data-bs-dismiss="modal">확인</button>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal -->
  <div class="tab-pane fade" id="cateInsert" role="tabpanel" aria-labelledby="insert-tab">
  	<h2 class="h2">카테고리 등록</h2>
  	<form name="cateForm">
  		<p class="input-group">
  			<label for="cateFormName" class="input-group-text">카테고리 이름</label>
  			<input name="name" type="text" maxlength="20" aria-label="First name" class="form-control" id="cateFormName" autocomplete="off" placeholder="카테고리 이름 입력">
  			<span class="input-group-text" id="nameCheck">이름 체크</span>
  		</p>
  		<p class="input-group">
  			<label for="cateFormSub" class="input-group-text">카테고리 서브 넘버</label>
  			<input name="sub" type="number" class="form-control" id="cateFormSub" autocomplete="off" placeholder="0">
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
        <h5 class="modal-title" id="UpdateLabel">카테고리 수정</h5>
        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  </div>
	  <div id="updateMsg" class="modal-body">
	        
	   </div>
	   <div class="modal-footer">
	      	<button type="button" id="listReloadBtn2" class="btn btn-primary">카테고리 리스트</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
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
       <h5 class="modal-title" id="DeleteLabel">카테고리 삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  </div>
	  <div id="deleteMsg" class="modal-body"> 
	       
	  </div>
	  <div class="modal-footer">
	      <button type="button" id="listReloadBtn3" class="btn btn-primary">카테고리 리스트</button>
	      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="form_reset()">확인</button>
	  </div>
	 </div>
	</div>
  </div>
  <!-- Modal -->
  <div class="tab-pane fade" id="cateUpdate" role="tabpanel" aria-labelledby="update-tab">
  	<h2 class="h2">카테고리 수정</h2>
  	<form name="cateModifyForm">
  		<p class="input-group">
  			<label for="cateModifyFormCate_num" class="input-group-text">카테고리 넘버</label>
  			<input name="cate_num" type="text" class="form-control" id="modifyFormCate_num" autocomplete="off" readonly>
  		</p>
  		<p class="input-group">
  			<label for="cateModifyFormName" class="input-group-text">카테고리 이름</label>
  			<input name="name" type="text" class="form-control" id="modifyFormName" autocomplete="off">
  			<span class="input-group-text" id="modifyNameCheck">이름 체크</span>
  			<input type="hidden" name="nameDuplication">
  		</p>
  		<p class="input-group">
  			<label for="cateModifyFormSub" class="input-group-text">카테고리 서브넘버</label>
  			<input name="sub" type="number" class="form-control" id="modifyFormSub" autocomplete="off">
  		</p>
  		<p class="float-end">
  			<a class="btn btn-outline-danger" href="javascript:void(0)" onclick="modifyDel()">삭제</a>
			<button class="btn btn-outline-warning" type="reset">리셋</button>
			<button class="btn btn-outline-primary" type="submit">수정</button>
		</p>
  	</form>
  </div>
</div>
</div>
</body>
</html>







