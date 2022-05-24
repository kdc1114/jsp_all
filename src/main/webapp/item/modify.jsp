<%@page import="model2_shop.com.vo.ItemVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%ItemVo item=(ItemVo)request.getAttribute("item");
%>
<body>
	<%@ include file="/header_nav.jsp" %>
	<div class="container">
		<blockquote class="blockquote">
		<h1 class="h1">아이템 수정</h1>
		</blockquote>
		<form action="./update.do" method="post" name="itemModifyForm" enctype="multipart/form-data">
			<p class="input-group">
  					<label for="itemFormModifyItemNum" class="input-group-text">상품번호</label>
  					<input name="item_num" type="text" class="form-control" id="itemFormModifyItemNum" value="<%=item.getItem_num() %>" readonly>
				</p>
				<p class="input-group">
  					<label for="itemFormModifyName" class="input-group-text">상품이름</label>
  					<input name="name" type="text" class="form-control" id="itemFormModifyName" value="<%=item.getName()%>">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyTitle" class="input-group-text">게시타이틀</label>
  					<input name="title" type="text" class="form-control" id="itemFormModifyTitle" value="<%=item.getTitle()%>">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyModelNum" class="input-group-text">상품모델</label>
  					<input name="model_num" type="text" class="form-control" id="itemFormModifyModelNum" value="<%=item.getModel_num()%>">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyMemberId" class="input-group-text">게시자</label>
  					<input name="member_id" type="text" class="form-control" id="itemFormModifyMemberId" value="<%=item.getMember_id() %>" readonly>
				</p>
				<p class="input-group">
  					<label for="itemFormModifyPrice" class="input-group-text">상품가격</label>
  					<input name="price" type="number" class="form-control" id="itemFormModifyPrice" value="<%=item.getPrice()%>">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyCateNum" class="input-group-text">카테고리</label>
  					<select name="cate_num" class="form-control form-select" id="itemFormModifyCateNum" aria-label="Default select example">
  						<option value="1" <%if(item.getCate_num()==1){out.append("selected");} %>>가전</option>
  						<option value="2" <%if(item.getCate_num()==2){out.append("selected");} %>>컴퓨터</option>
  						<option value="3" <%if(item.getCate_num()==3){out.append("selected");} %>>아웃도어</option>
  						<option value="4" <%if(item.getCate_num()==4){out.append("selected");} %>>패션</option>
  						<option value="5" <%if(item.getCate_num()==5){out.append("selected");} %>>주방</option>
  						<option value="6" <%if(item.getCate_num()==6){out.append("selected");} %>>TV</option>
  						<option value="7" <%if(item.getCate_num()==7){out.append("selected");} %>>세탁기</option>
  						<option value="8" <%if(item.getCate_num()==8){out.append("selected");} %>>냉장고</option>
  						<option value="9" <%if(item.getCate_num()==9){out.append("selected");} %>>청소기</option>
  						<option value="10" <%if(item.getCate_num()==10){out.append("selected");} %>>오븐</option>
  						<option value="11" <%if(item.getCate_num()==11){out.append("selected");} %>>올레드</option>
  						<option value="12" <%if(item.getCate_num()==12){out.append("selected");} %>>미니LED</option>
  						<option value="13" <%if(item.getCate_num()==13){out.append("selected");} %>>QLED</option>
  						<option value="14" <%if(item.getCate_num()==14){out.append("selected");} %>>여성의류</option>
  						<option value="15" <%if(item.getCate_num()==15){out.append("selected");} %>>남성의류</option>
  						<option value="16" <%if(item.getCate_num()==16){out.append("selected");} %>>가방</option>
  						<option value="17" <%if(item.getCate_num()==17){out.append("selected");} %>>신발</option>
  						<option value="18" <%if(item.getCate_num()==18){out.append("selected");} %>>운동화</option>
  						<option value="19" <%if(item.getCate_num()==19){out.append("selected");} %>>스니커즈</option>
  						<option value="20" <%if(item.getCate_num()==20){out.append("selected");} %>>남성구두</option>
  						<option value="21" <%if(item.getCate_num()==21){out.append("selected");} %>>여성구두</option>
  					</select>
				</p>
				<p class="input-group">
  					<label for="itemFormModifyMainImg" class="input-group-text">상품 메인이미지</label>
  					<input name="main_img" type="file" class="form-control" id="itemFormModifyMainImg" value="<%=item.getMain_img()%>">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyDetailImg" class="input-group-text">상품 상세이미지</label>
  					<input name="detail_img" type="file" class="form-control" id="itemFormModifyDetailImg" value="<%=item.getDetail_img()%>">
				</p>
				<p class="input-group">
  					<label for="itemFormModifyPostTime" class="input-group-text">상품 게시일</label>
  					<input name="post_time" type="text" class="form-control" id="itemFormModifyPostTime" value="" readonly>
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
					<input name="color" type="color" class="form-control form-control-color" id="itemFormModifyColor" value="<%=item.getColor()%>" title="Choose your color">
					<label for="itemFormState" class="input-group-text">상태</label>
					<select name="state" id="itemFormState" class="form-control">
						<option value="0"<%if(item.getState()==0){out.append("selected");}%>>공개</option>
						<option value="1"<%if(item.getState()==1){out.append("selected");}%>>비공개</option>
					</select>
					<label for="itemFormModifyCount" class="input-group-text">판매 수량</label>
					<input name="count" id="itemFormModifyCount" type="number" class="form-control" value="<%=item.getCount()%>">
				</p>
				<p class="float-end">
					<a class="btn btn-outline-danger" href="./delete.do?item_num=<%=item.getItem_num()%>">삭제</a>
					<button class="btn btn-outline-warning" type="reset">리셋</button>
					<button class="btn btn-outline-primary" type="submit">수정</button>
				</p>
		</form>
	</div>
</body>
</html>