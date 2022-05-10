const cateList = document.getElementById("cateList");
const cateClone = document.getElementById("cateClone");
const nameCheck = document.getElementById("nameCheck");
const modifyNameCheck = document.getElementById("modifyNameCheck");

// 부트스트랩 리스트
const cateListTab = document.getElementById("cateList-tab");
const cateListTab2 = new bootstrap.Tab(cateListTab);
const cateInsertTab = document.getElementById("cateInsert-tab");
const cateInsertTab2 = new bootstrap.Tab(cateInsertTab);
const cateUpdateTab = document.getElementById("cateUpdate-tab");
const cateUpdateTab2 = new bootstrap.Tab(cateUpdateTab);
// 부트스트랩 리스트

// 폼
const cateForm = document.forms["cateForm"];
const cateModifyForm = document.forms.cateModifyForm;
// 폼

// 모달
const InsertModal=document.getElementById("InsertModal");
const insertMsg=document.getElementById("insertMsg");
const listReBtn=document.getElementById("listReloadBtn");
const InsertModal2 = new bootstrap.Modal(InsertModal);
const UpdateModal=document.getElementById("UpdateModal");
const updateMsg=document.getElementById("updateMsg");
const listReBtn2=document.getElementById("listReloadBtn2");
const UpdateModal2 = new bootstrap.Modal(UpdateModal);
const DeleteModal=document.getElementById("DeleteModal");
const deleteMsg=document.getElementById("deleteMsg");
const listReBtn3=document.getElementById("listReloadBtn3");
const DeleteModal2 = new bootstrap.Modal(DeleteModal);
// 모달

const AJAX_URL="./ajax.do";
//리스트 출력
cateListFetch();
async function cateListFetch(){
	let res=await fetch(AJAX_URL);
	let json=await res.json();
	cateList.innerText="";
	json.forEach((cate)=>{
		const cateNode = cateClone.cloneNode(true);
		let key;
		for(key in cate){
			let value = cate[key];
			switch(key){
				case "cate_num":
				cateNode.querySelector(".cate_num").dataset.num=cate["cate_num"];
				cateNode.querySelector(".cate_num").innerText=value;
				break;
				case "name":
				cateNode.querySelector(".name").innerText=value;
				break;
				case "sub":
				cateNode.querySelector(".sub").innerText=value;
				break;
			};
		cateNode.id="";
		cateList.append(cateNode);
		};
	});
};
// 카테고리 등록 서브밋
cateForm.addEventListener("submit",async(e)=>{
	e.preventDefault();
	if(!cateForm.name.value){
		alert("카테고리 이름을 입력하세요");
		return false;
	};
	if(!cateForm.sub.value){
		alert("카테고리 서브 넘버를 입력하세요");
		return false;
	};
	const inputNodes=cateForm.querySelectorAll("[name]");
	const postDate=new Object();
	for(let input of inputNodes){
		postDate[input.name]=input.value;
	};
	let res=await fetch(AJAX_URL,{
		method:"post",
		body:JSON.stringify(postDate)
	});
	let json=await res.json();
	insertMsg.innerText=(json.insert)?"등록 성공":"등록 실패";
	InsertModal2.show();
});
// 등록 모달 리스트복귀
listReBtn.onclick=function(){
	InsertModal2.hide();
	cateListTab2.show();
	cateListFetch();
};
// 카테고리 넘버 클릭시 수정페이지 이동
async function modifyLoad(e){
	let cate_num=e.target.dataset.num;
	cateUpdateTab2.show();
	let res=await fetch(AJAX_URL+"?cate_num="+cate_num);
	let json=await res.json();
	const input_list=cateModifyForm.querySelectorAll("[name]");
	input_list.forEach((input)=>{
		input.value=json[input.name];
		if(input.name == "nameDuplication"){
			input.value=cateModifyForm.name.value;
		};
	});
};
// 카테고리 수정 서브밋
cateModifyForm.addEventListener("submit",async(e)=>{
	e.preventDefault();
	const inputNodes=e.target.querySelectorAll("[name]");
	const putDate=new Object();
	for(let input of inputNodes){
		putDate[input.name]=input.value;
	};
	let res=await fetch(AJAX_URL,{
		method:"put",
		body:JSON.stringify(putDate)
	});
	let json=await res.json();
	updateMsg.innerText=(json.update)?"수정 성공":"수정 실패";
	UpdateModal2.show();
});
// 수정 모달 리스트복귀
listReBtn2.onclick=function(){
	UpdateModal2.hide();
	cateListTab2.show();
	cateListFetch();
};
// 카테고리 넘버로 삭제
async function modifyDel(){
	const cate_num=cateModifyForm.cate_num.value;
	let res=await fetch(AJAX_URL+"?cate_num="+cate_num,{
		method : "delete"
	});
	let json=await res.json();
	deleteMsg.innerText=(json.delete)?"삭제 성공":"삭제 실패";
	DeleteModal2.show();
};
// 삭제 모달 리스트복귀
listReBtn3.onclick=function(){
	DeleteModal2.hide();
	cateListTab2.show();
	cateListFetch();
};
// 이름 중복 체크
cateForm.name.addEventListener("blur",async()=>{
	const name=cateForm.name.value;
	let res=await fetch("./name_check.do?name="+name);
	let json=await res.json();
	if(name){
		if(json.name_check){
			nameCheck.innerText="사용 가능";
			nameCheck.style.color="green";
		}else{
			nameCheck.innerText="사용 불가능";
			nameCheck.style.color="red";
		};
	}else{
		nameCheck.innerText="값을 입력해주세요";
		nameCheck.style.color="red";
	};
});
cateModifyForm.name.addEventListener("blur",async()=>{
	const name=cateModifyForm.name.value;
	const value=cateModifyForm.nameDuplication.value;
	let res=await fetch("./name_check.do?name="+name);
	let json=await res.json();
	if(json.name_check || name==value){
		modifyNameCheck.innerText="사용 가능";
		modifyNameCheck.style.color="green";
	}else{
		modifyNameCheck.innerText="사용 불가능";
		modifyNameCheck.style.color="red";
	};
});
// 폼 초기화
function form_reset(){
	cateForm.reset();
};






