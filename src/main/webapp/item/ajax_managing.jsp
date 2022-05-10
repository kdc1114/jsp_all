<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ITEM AJAX 관리</title>
<script src="<%=request.getContextPath()%>/public/js/item_ajax_managing.js" defer="defer"></script>
</head>
<body>
	<%@ include file="/header_nav.jsp" %>
	<div class="container">
		<blockquote class="blockquote">
			<h1 class="h1">아이템 에이작스 관리 페이지</h1>
		</blockquote>
		<ul class="nav nav-tabs" id="pills-tab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <button class="nav-link active" id="pills-list-tab" data-bs-toggle="tab" data-bs-target="#pills-list" type="button" role="tab" aria-controls="pills-list" aria-selected="true">아이템 리스트</button>
		  </li>
		   <li class="nav-item" role="presentation">
		    <button class="nav-link" id="pills-insert-tab" data-bs-toggle="tab" data-bs-target="#pills-insert" type="button" role="tab" aria-controls="pills-insert" aria-selected="false">아이템 등록</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="pills-modify-tab" data-bs-toggle="tab" data-bs-target="#pills-modify" type="button" role="tab" aria-controls="pills-modify" aria-selected="false" disabled>아이템 수정</button>
		  </li>
		</ul>
		<div class="tab-content" id="pills-tabContent">
		  <div class="tab-pane fade show active" id="pills-list" role="tabpanel" aria-labelledby="pills-list-tab">
		  	<h2>아이템 리스트</h2>
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
<!-- 					<th class="col-2">POST_TIME</th>
						<th class="col-2">SALE_TIME</th>
						<th class="col-2">SALE_END_TIME</th> -->
						<th class="col-1">STATE</th>
						<th class="col-1">C_NUM</th>
		  			</tr>
		  		</thead>
		  		<tbody id="itemList">
		  			<tr id="itemClone">
		  				<td class="item_num"></td>
						<td class="name"></td>
						<td>
							<a class="title" href="javascript:void(0)" onclick="modifyLoad(event)" data-num=""></a>
						</td>
						<td class="count"></td>
						<td class="price"></td>
						<td class="color"></td>
						<td>
							<img class="main_img" alt="메인썸네일" src="">
						</td>
						<td>
							<img class="detail_img" alt="디테일썸네일" src="">
						</td>					
						<td class="model_num"></td>
						<td class="member_id"></td>
<!-- 					<td class="post_time"></td>
						<td class="sale_time"></td>
						<td class="sale_end_time"></td> -->
						<td class="state"></td>
						<td class="cate_num"></td>
		  			</tr>
		  		</tbody>
		  	</table>
		  </div>
			<!-- Modal -->
			<div class="modal fade" id="InsertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="InsertLabel">아이템 등록</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div id="insertMsg" class="modal-body">
			        
			      </div>
			      <div class="modal-footer">
			      	<button type="button" id="listReloadBtn" class="btn btn-primary">ITEM 리스트</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- Modal -->
		  <div class="tab-pane fade" id="pills-insert" role="tabpanel" aria-labelledby="pills-insert-tab">
		  	<h2>아이템 등록</h2>
		  	<!-- 
		  	1.multipart는 바이너리 코드를 보내는 기술
		  	2.form-data는 js객체인 FormData를 의미하고 append된 객체를 자동으로
		  	바이너리코드로 보내준다.
		  	3.input type="file"은 files라는 필드가 존재하는데 전송하려는 파일의
		  	바이너리코드가 포함된다.
		  	4.바이너리코드로 보내는 요청정보를 서버에서 받기 위해서는 별도의
		  	라이브러리를 추가해야한다 (cos)
		  	-->
		  	<form action="" name="itemForm" enctype="multipart/form-data">
				<p class="input-group">
  					<label for="itemFormName" class="input-group-text">상품이름</label>
  					<input name="name" type="text" class="form-control" id="itemFormName" value="로지텍 G402 마우스">
				</p>
				<p class="input-group">
  					<label for="itemFormTitle" class="input-group-text">게시타이틀</label>
  					<input name="title" type="text" class="form-control" id="itemFormTitle" value="게이밍 마우스">
				</p>
				<p class="input-group">
  					<label for="itemFormModelNum" class="input-group-text">상품모델</label>
  					<input name="model_num" type="text" class="form-control" id="itemFormModelNum" value="MX1322F3">
				</p>
				<p class="input-group">
  					<label for="itemFormMemberId" class="input-group-text">게시자</label>
  					<input name="member_id" type="text" class="form-control" id="itemFormMemberId" value="admin" readonly>
				</p>
				<p class="input-group">
  					<label for="itemFormPrice" class="input-group-text">상품가격</label>
  					<input name="price" type="number" class="form-control" id="itemFormPrice" value="35000">
				</p>
				<p class="input-group">
  					<label for="itemFormCateNum" class="input-group-text">카테고리</label>
  					<select name="cate_num" class="form-control" id="itemFormCateNum">
  						<option value="1" selected>가전</option>
  						<option value="2">컴퓨터</option>
  					</select>
				</p>
				<p class="input-group">
  					<label for="itemFormMainImg" class="input-group-text">상품 메인이미지</label>
  					<input name="main_img" type="file" class="form-control" id="itemFormMainImg" value="">
				</p>
				<p class="input-group">
  					<label for="itemFormDetailImg" class="input-group-text">상품 상세이미지</label>
  					<input name="detail_img" type="file" class="form-control" id="itemFormDetailImg" value="">
				</p>
				<p class="input-group">
  					<label for="itemFormSaleTime" class="input-group-text">상품 판매시작일</label>
  					<input name="sale_time" type="datetime-local" class="form-control" id="itemFormSaleTime" value="">
				</p>
				<p class="input-group">
  					<label for="itemFormSaleEndTime" class="input-group-text">상품 판매종료일</label>
  					<input name="sale_end_time" type="datetime-local" class="form-control" id="itemFormSaleEndTime" value="">
				</p>
		  		<p class="input-group">
		  			<label for="itemFormColor" class="input-group-text">상품색</label>
					<input name="color" type="color" class="form-control form-control-color" id="itemFormColor" value="#563d7c" title="Choose your color">
					<label for="itemFormState" class="input-group-text">상태</label>
					<select name="state" id="itemFormState" class="form-control">
						<option value="0" selected>공개</option>
						<option value="1">비공개</option>
					</select>
					<label for="itemFormCount" class="input-group-text">판매 수량</label>
					<input name="count" id="itemFormCount" type="number" class="form-control" value="100">
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
		        <h5 class="modal-title" id="UpdateLabel">아이템 수정</h5>
		        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			  </div>
			  <div id="updateMsg" class="modal-body">
			        
			   </div>
			   <div class="modal-footer">
			      	<button type="button" id="listReloadBtn2" class="btn btn-primary">ITEM 리스트</button>
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
		          <h5 class="modal-title" id="DeleteLabel">아이템 삭제</h5>
		        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			    </div>
			   <div id="deleteMsg" class="modal-body"> 
			       
			   </div>
			   <div class="modal-footer">
			      	<button type="button" id="listReloadBtn3" class="btn btn-primary">ITEM 리스트</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
			   </div>
			  </div>
			 </div>
			</div>
			<!-- Modal -->
		  <div class="tab-pane fade" id="pills-modify" role="tabpanel" aria-labelledby="pills-modify-tab">
		  	<h2>아이템 수정</h2>
		  	<form action="" name="itemModifyForm">
		  		<p class="input-group">
  					<label for="itemFormModifyItemNum" class="input-group-text">상품번호</label>
  					<input name="item_num" type="text" class="form-control" id="itemFormModifyItemNum" readonly>
				</p>
				<p class="input-group">
  					<label for="itemFormModifyName" class="input-group-text">상품이름</label>
  					<input name="name" type="text" class="form-control" id="itemFormModifyName" value="로지텍 G402 마우스">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyTitle" class="input-group-text">게시타이틀</label>
  					<input name="title" type="text" class="form-control" id="itemFormModifyTitle" value="게이밍 마우스">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyModelNum" class="input-group-text">상품모델</label>
  					<input name="model_num" type="text" class="form-control" id="itemFormModifyModelNum" value="MX1322F3">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyMemberId" class="input-group-text">게시자</label>
  					<input name="member_id" type="text" class="form-control" id="itemFormModifyMemberId" value="admin" readonly>
				</p>
				<p class="input-group">
  					<label for="itemFormModifyPrice" class="input-group-text">상품가격</label>
  					<input name="price" type="number" class="form-control" id="itemFormModifyPrice" value="35000">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyCateNum" class="input-group-text">카테고리</label>
  					<select name="cate_num" class="form-control form-select" id="itemFormModifyCateNum" aria-label="Default select example">
  						<option value="1" selected>가전</option>
  						<option value="2">컴퓨터</option>
  						<option value="3">아웃도어</option>
  						<option value="4">패션</option>
  						<option value="5">주방</option>
  						<option value="6">TV</option>
  						<option value="7">세탁기</option>
  						<option value="8">냉장고</option>
  						<option value="9">청소기</option>
  						<option value="10">오븐</option>
  						<option value="11">올레드</option>
  						<option value="12">미니LED</option>
  						<option value="13">QLED</option>
  						<option value="14">여성의류</option>
  						<option value="15">남성의류</option>
  						<option value="16">가방</option>
  						<option value="17">신발</option>
  						<option value="18">운동화</option>
  						<option value="19">스니커즈</option>
  						<option value="20">남성구두</option>
  						<option value="21">여성구두</option>
  					</select>
				</p>
				<p class="input-group">
  					<label for="itemFormModifyMainImg" class="input-group-text">상품 메인이미지</label>
  					<input name="main_img" type="text" class="form-control" id="itemFormModifyMainImg">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyDetailImg" class="input-group-text">상품 상세이미지</label>
  					<input name="detail_img" type="text" class="form-control" id="itemFormModifyDetailImg">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyPostTime" class="input-group-text">상품 게시일</label>
  					<input name="post_time" type="datetime-local" class="form-control" id="itemFormModifyPostTime" value="" readonly>
				</p>
				<p class="input-group">
  					<label for="itemFormModifySaleTime" class="input-group-text">상품 판매시작일</label>
  					<input name="sale_time" type="datetime-local" class="form-control" id="itemFormModifySaleTime" value="">
				</p>
				<p class="input-group">
  					<label for="itemFormModifySaleEndTime" class="input-group-text">상품 판매종료일</label>
  					<input name="sale_end_time" type="datetime-local" class="form-control" id="itemFormModifySaleEndTime" value="">
				</p>
		  		<p class="input-group">
		  			<label for="itemFormModifyColor" class="input-group-text">상품색</label>
					<input name="color" type="color" class="form-control form-control-color" id="itemFormModifyColor" value="#563d7c" title="Choose your color">
					<label for="itemFormState" class="input-group-text">상태</label>
					<select name="state" id="itemFormState" class="form-control">
						<option value="0">공개</option>
						<option value="1">비공개</option>
					</select>
					<label for="itemFormModifyCount" class="input-group-text">판매 수량</label>
					<input name="count" id="itemFormModifyCount" type="number" class="form-control" value="100">
				</p>
				<p class="float-end">
					<a class="btn btn-outline-danger" href="javascript:void(0)" onclick="modifyDel()">삭제</a>
					<button class="btn btn-outline-warning" type="reset">리셋</button>
					<button class="btn btn-outline-primary" type="submit">수정</button>
				</p>
				<p>
					<img alt="메인이미지" height="100px" src="" name="main_img_output">
				</p>
				<p>
					<img alt="상세이미지" height="100px" src="" name="detail_img_output">
				</p>
		  	</form>
		  </div>
			<!-- 버튼의 bs-target이 div의 id를 찾는다  -->
		</div>
	</div>
</body>
</html>






