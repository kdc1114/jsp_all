<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/header_nav.jsp" %>
	<div class="container">
		<blockquote class="blockquote">
		<h1 class="h1">아이템 등록</h1>
		</blockquote>
		<form action="./iteminsert.do" method="post" name="itemForm">
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
</body>
</html>