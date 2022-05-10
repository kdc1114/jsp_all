const Item_List=document.getElementById("itemList");
const Item_Clone=document.getElementById("itemClone");
const pillsInsertTab=document.getElementById("pills-insert-tab");
const pillsListTab=document.getElementById("pills-list-tab");
const pillsModifyTab=document.getElementById("pills-modify-tab");
const pillsInsertTab2 = new bootstrap.Tab(pillsInsertTab);
const pillsListTab2 = new bootstrap.Tab(pillsListTab);
const pillsModifyTab2 = new bootstrap.Tab(pillsModifyTab);
const AJAX_URL="./ajax.do";

// 폼
const itemForm=document.forms["itemForm"];
const itemModifyForm=document.forms["itemModifyForm"];
// 폼

// 모달
const InsertModal=document.getElementById("InsertModal");
const insertMsg=document.getElementById("insertMsg");
const UpdateModal=document.getElementById("UpdateModal");
const updateMsg=document.getElementById("updateMsg");
const DeleteModal=document.getElementById("DeleteModal");
const deleteMsg=document.getElementById("deleteMsg");
const listReBtn=document.getElementById("listReloadBtn");
const listReBtn2=document.getElementById("listReloadBtn2");
const listReBtn3=document.getElementById("listReloadBtn3");
const InsertModal2 = new bootstrap.Modal(InsertModal);
const UpdateModal2 = new bootstrap.Modal(UpdateModal);
const DeleteModal2 = new bootstrap.Modal(DeleteModal);
// 모달


//pillsInsertTab2.show();
//pillsListTab2.show();
//pillsModifyTab2.show();

// file을 서버에 전송하기 위해서는
// 브라우저에서 제공하는 multipart form-data를 사용해야한다.
// 아이템 등록 서브밋
itemForm.addEventListener("submit",async(e)=>{
	e.preventDefault();
	const postData=new FormData(itemForm);
	
	let res=await fetch(AJAX_URL,{
		method:"post",
		body: postData
	});
	let json=await res.json();
	insertMsg.innerText=(json.insert)?"등록 성공":"등록 실패";
	InsertModal2.show();
	
});
// 아이템 수정 서브밋
itemModifyForm.addEventListener("submit",async (e)=>{
	e.preventDefault();
	// rest api put 방식으로 통신 (Get,Post,Put,Delete)
	// 모든 Http 통신에서 사용 가능하다.
	const inputNodes=e.target.querySelectorAll("[name]");
	// {title:"dd",count:10}...
	const putData=new Object();
	for(let input of inputNodes){
		putData[input.name]=input.value;
		if(input.name=="sale_time" || input.name=="sale_end_time"){
			let v=input.value;
			if(v){ // "" , null , NaN , undefined 검사
			let v_list=v.split("T");
			let date=v_list[0];
			let time_list=v_list[1].split(":");
			v=date+" "+time_list[0]+":"+time_list[1]+":00";
			putData[input.name]=v;
			}
		}
	};
	let res=await fetch(AJAX_URL,{
		method:"put",
		body:JSON.stringify(putData)
	});
	let json=await res.json();
	updateMsg.innerText=(json.update)?"수정 성공":"수정 실패";
	UpdateModal2.show();
});
// 등록 모달 리스트복귀
listReBtn.onclick=function(){
	InsertModal2.hide();
	pillsListTab2.show();
	itemListFetch();
};
// 수정 모달 리스트복귀
listReBtn2.onclick=function(){
	UpdateModal2.hide();
	pillsListTab2.show();
	itemListFetch();
};
// 삭제 모달 리스트복귀
listReBtn3.onclick=function(){
	DeleteModal2.hide();
	pillsListTab2.show();
	itemListFetch();
};
// 리스트 출력
itemListFetch();
async function itemListFetch(){
	let res=await fetch(AJAX_URL);
	let json=await res.json();
	Item_List.innerHTML="";
	json.forEach((item)=>{
	const itemNode=Item_Clone.cloneNode(true);
		for(let key in item){
			let value=item[key];
			switch(key){
				case "item_num":
				itemNode.querySelector(".item_num").innerText=value;
				break;
				case "name":
				itemNode.querySelector(".name").innerText=value;
				break;
				case "title":
				itemNode.querySelector(".title").dataset.num=item["item_num"];
				itemNode.querySelector(".title").innerText=value;
				break;
				case "count":
				itemNode.querySelector(".count").innerText=value;
				break;
				case "price":
				itemNode.querySelector(".price").innerText=value;
				break;
				case "color":
				itemNode.querySelector(".color").innerText=value;
				break;
				case "main_img":
				itemNode.querySelector(".main_img").src="./../public/img/thumb/"+value;
				itemNode.querySelector(".main_img").innerText=value;
				break;
				case "detail_img":
				itemNode.querySelector(".detail_img").src="./../public/img/d_thumb/"+value;
				itemNode.querySelector(".detail_img").innerText=value;
				break;
				case "model_num":
				itemNode.querySelector(".model_num").innerText=value;
				break;
				case "member_id":
				itemNode.querySelector(".member_id").innerText=value;
				break;
				case "state":
				itemNode.querySelector(".state").innerText=value;
				break;
				case "cate_num":
				itemNode.querySelector(".cate_num").innerText=value;
				break;
			};
		itemNode.id="";
		/*for(let key in item){
			if(itemNode.querySelector(`.${key}`)){
				itemNode.querySelector(`.${key}`).innerText=item[key];
			};
			itemNode.id="";
		};*/
		Item_List.append(itemNode);
		};
	});
};

// 타이틀 클릭시 수정 페이지 item_num 값으로 불러오기(테이블 타이틀에 onclick)
async function modifyLoad(e){
	let item_num=e.target.dataset.num;
	pillsModifyTab2.show();
	let res=await fetch(AJAX_URL+"?item_num="+item_num);
	let json=await res.json();
	console.log(json);
	const input_list=itemModifyForm.querySelectorAll("[name]");
	input_list.forEach((input)=>{
		// console.log(input_list)
		if(input.name=="post_time" || input.name=="sale_time" || input.name=="sale_end_time"){
			let value=json[input.name];
			value=value.replace(" ","T");
			input.value=value;
		}else if(input.name=="main_img_output"){
			input.src="./../public/img/"+json.main_img;
		}else if(input.name=="detail_img_output"){
			input.src="./../public/img/"+json.detail_img;
		}else{
			input.value=json[input.name];
		};
	});
};
async function modifyDel(){
	const item_num=itemModifyForm.item_num.value;
	let res=await fetch(AJAX_URL+"?item_num="+item_num,{
		method:"delete"
	});
	let json=await res.json();
	if(json.delete){
		deleteMsg.innerText="삭제 성공"+"상품평 : "+json.comment_delete+"개 삭제";
	}else{
		deleteMsg.innerText="삭제 실패 참조된 상품평을 삭제하세요.";
		listReBtn3.style.visibility="hidden";
	};
	DeleteModal2.show();
};




