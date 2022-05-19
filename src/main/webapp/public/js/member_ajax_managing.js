const memList = document.getElementById("memList");
const memClone = document.getElementById("memClone");
const phoneCheck = document.getElementById("phoneCheck");
const emailCheck = document.getElementById("emailCheck");
const modifyPhoneCheck = document.getElementById("modifyPhoneCheck");
const modifyEmailCheck = document.getElementById("modifyEmailCheck");
const memInsert_tab = document.getElementById("memInsert-tab");

// 부트스트랩 리스트
const memListTab = document.getElementById("memList-tab");
const memListTab2 = new bootstrap.Tab(memListTab);
const memInsertTab = document.getElementById("memInsert-tab");
const memInsertTab2 = new bootstrap.Tab(memInsertTab);
const memUpdateTab = document.getElementById("memUpdate-tab");
const memUpdateTab2 = new bootstrap.Tab(memUpdateTab);
// 부트스트랩 리스트

// 폼
const memForm = document.forms["memForm"];
const memModifyForm = document.forms.memModifyForm;
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
const IdCheckModal=document.getElementById("IdCheckModal");
const idCheckMsg=document.getElementById("idCheckMsg");
const idUse=document.getElementById("idUse");
const IdCheckModal2 = new bootstrap.Modal(IdCheckModal);
// 모달

const AJAX_URL="./ajax.do";
// 리스트 출력
memListFetch();
async function memListFetch(){
	let res = await fetch(AJAX_URL);
	let json = await res.json();
	memList.innerHTML="";
	json.forEach((mem)=>{
	const memNode = memClone.cloneNode(true);
		let key;
		for(key in mem){
			let value=mem[key];
			if(key == "id"){
				memNode.querySelector(".id").dataset.id=mem["id"];
				memNode.querySelector(".id").innerText=value;
			}else if(key == "pw"){
				memNode.querySelector(".pw").innerText=value;
			}else if(key == "phone"){
				memNode.querySelector(".phone").innerText=value;
			}else if(key == "email"){
				memNode.querySelector(".email").innerText=value;
			}else if(key == "name"){
				memNode.querySelector(".name").innerText=value;
			}else if(key == "address"){
				memNode.querySelector(".address").innerText=value;
			}else if(key == "address_detail"){
				memNode.querySelector(".address_detail").innerText=value;
			}else if(key == "signup_time"){
				memNode.querySelector(".signup_time").innerText=value;
			}else if(key == "birth"){
				memNode.querySelector(".birth").innerText=value;
			}else if(key == "grade"){
				memNode.querySelector(".grade").innerText=value;
			}
		memNode.id="";
		memList.append(memNode);
		};
	});
};
// 리스트 아이디 중복체크
async function idCheck(){
	const id=memForm.id.value;
	const idReg=/^[a-zA-Z]+[a-z0-9A-Z]{4,19}$/g;
	const res=await fetch("./id_check.do?id="+id);
	const json=await res.json();
	if(!id){
		alert("아이디를 입력하세요.");
		return false;
	}else if(!idReg.test(id)){
		alert("아이디는 영대소문자로 시작하는 4~20자여야합니다.");
		return false;
	}else{
		if(json.id_check){
			idCheckMsg.innerText="사용 가능";
			idUse.style.visibility="visible";
			IdCheckModal2.show();
		}else{
			idCheckMsg.innerText="사용 불가능";
			idUse.style.visibility="hidden";
			IdCheckModal2.show();
		};
	};
};
// 아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
// 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
// 다시 중복체크를 하도록 한다.
function inputIdCheck(){
	memForm.idDuplication.value="idUncheck";
};
// 사용하기시 hidden값이 idCheck값으로 바뀌며
// 등록 서브밋에 if(memForm.idDuplication.value != "idCheck")가 풀림
function sendCheckValue(){
	memForm.idDuplication.value="idCheck";
	IdCheckModal2.hide();
};
// 리스트 등록 서브밋
memForm.addEventListener("submit",async(e)=>{
	e.preventDefault();
	const pwform=/^[a-zA-z0-9]{8,16}$/;
	if(!memForm.id.value){
		alert("아이디를 입력하세요.");
		return false;
	};
	if(memForm.idDuplication.value != "idCheck"){
		alert("아이디 중복체크를 해주세요.");
		return false;
	};
	if(!pwform.test(memForm.pw.value)){
		alert("비밀번호는 영문자와 숫자 조합으로 8~16자리를 사용해야 합니다.");
	};
	if(!memForm.pw.value){
		alert("비밀번호를 입력하세요.");
		return false;
	};
	if(memForm.pw.value != memForm.pwC.value){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	};
	if(!memForm.phone.value){
		alert("핸드폰을 입력하세요.");
		return false;
	};
	if(!memForm.email.value){
		alert("이메일을 입력하세요.");
		return false;
	};
	if(!memForm.name.value){
		alert("이름을 입력하세요.");
		return false;
	};
	if(!memForm.address.value){
		alert("주소를 입력하세요.");
		return false;
	};
	if(!memForm.address_detail.value){
		alert("상세주소를 입력하세요.");
		return false;
	};
	const inputNodes=memForm.querySelectorAll("[name]");
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
	memListTab2.show();
	memListFetch();
};
// 아이디 클릭시 수정 페이지이동
async function modifyLoad(e){
	let memId=e.target.dataset.id;
	memUpdateTab2.show();
	let res=await fetch(AJAX_URL+"?id="+memId);
	let json=await res.json();
	const input_list=memModifyForm.querySelectorAll("[name]");
	input_list.forEach((input)=>{
		input.value=json[input.name];
		if(input.name == "pw" || input.name=="pwC"){
			input.value="";
		};
		if(input.name == "phoneDuplication"){
			input.value=memModifyForm.phone.value;
		};
		if(input.name == "emailDuplication"){
			input.value=memModifyForm.email.value;
		};
	});
};
// 멤버 수정 서브밋
memModifyForm.addEventListener("submit",async(e)=>{
	e.preventDefault();
	const pwform=/^[a-zA-z0-9]{8,16}$/;
	// rest api put 방식으로 통신 (Get,Post,Put,Delete)
	// 모든 Http 통신에서 사용 가능하다.
	const inputNodes=e.target.querySelectorAll("[name]");
	// {id:"admin",date:"2000-01-01"}...
	if(!pwform.test(memModify.pw.value)){
		alert("비밀번호는 영문자와 숫자 조합으로 8~16자리를 사용해야 합니다.");
		return false;
	};
	if(!memModifyForm.pw.value){
		alert("비밀번호를 입력하세요.");
		return false;
	};
	if(memModifyForm.pw.value != memModifyForm.pwC.value){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	};
	if(!memModifyForm.phone.value){
		alert("핸드폰을 입력하세요.");
		return false;
	};
	if(!memModifyForm.name.value){
		alert("이름을 입력하세요.");
		return false;
	};
	if(!memModifyForm.address.value){
		alert("주소를 입력하세요.");
		return false;
	};
	if(!memModifyForm.address_detail.value){
		alert("상세주소를 입력하세요.");
		return false;
	};
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
	memListTab2.show();
	memListFetch();
};
// 멤버 ID값으로 삭제
async function modifyDel(){
	const id=memModifyForm.id.value;
	let res=await fetch(AJAX_URL+"?id="+id,{
		method:"delete"
	});
	let json=await res.json();
	deleteMsg.innerText=(json.delete)?"삭제 성공":"삭제 실패";
	DeleteModal2.show();
};
// 삭제 모달 리스트복귀
listReBtn3.onclick=function(){
	DeleteModal2.hide();
	memListTab2.show();
	memListFetch();
};
// 핸드폰 중복 및 형식체크
memForm.phone.addEventListener("blur",async()=>{
	const phone=memForm.phone.value;
	const pform=/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/g;
	let res=await fetch("./phone_check.do?phone="+phone);
	let json=await res.json();
	if(pform.test(phone)){
		if(json.phone_check){
			phoneCheck.innerText="사용 가능";
			phoneCheck.style.color="green";
		}else{
			phoneCheck.innerText="사용 불가능";
			phoneCheck.style.color="red";
		};
	}else{
		phoneCheck.innerText="숫자로형식을맞춰주세요";
		phoneCheck.style.color="red";
	};
});
memModifyForm.phone.addEventListener("blur",async()=>{
	const phone=memModifyForm.phone.value;
	const value=memModifyForm.phoneDuplication.value;
	const pform=/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
	let res=await fetch("./phone_check.do?phone="+phone);
	let json=await res.json();
	if(pform.test(phone)){
		if(json.phone_check || phone==value){
			modifyPhoneCheck.innerText="사용 가능";
			modifyPhoneCheck.style.color="green";
		}else{
			modifyPhoneCheck.innerText="사용 불가능";
			modifyPhoneCheck.style.color="red";
		};
	}else{
		modifyPhoneCheck.innerText="숫자로형식을맞춰주세요";
		modifyPhoneCheck.style.color="red";
	};
});
// 이메일 중복 및 형식체크
memForm.email.addEventListener("blur",async()=>{
	const email=memForm.email.value;
	const eform=/^[0-9a-zA-Z]*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[0-9a-zA-Z]{2,3}$/ig;
	let res=await fetch("./email_check.do?email="+email);
	let json=await res.json();
	if(eform.test(email)){
		if(json.email_check){
			emailCheck.innerText="사용 가능";
			emailCheck.style.color="green";
		}else{
			emailCheck.innerText="사용 불가능";
			emailCheck.style.color="red";
		};
	}else{
		emailCheck.innerText="이메일 형식을 맞춰주세요";
		emailCheck.style.color="red";
	};
});
memModifyForm.email.addEventListener("blur",async()=>{
	const email=memModifyForm.email.value;
	const value=memModifyForm.emailDuplication.value;
	const eform=/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]/ig;
	let res=await fetch("./email_check.do?email="+email);
	let json=await res.json();
	if(eform.test(email)){
		if(json.email_check || email==value){
			modifyEmailCheck.innerText="사용 가능";
			modifyEmailCheck.style.color="green";
		}else{
			modifyEmailCheck.innerText="사용 불가능";
			modifyEmailCheck.style.color="red";
		};
	}else{
		modifyEmailCheck.innerText="이메일 형식을 맞춰주세요";
		modifyEmailCheck.style.color="red";
	};
});
// 폼 초기화
function form_reset(){
	memForm.reset();
};
// 수정 폼 리셋
const formReset=document.getElementById("formReset");
memForm.addEventListener("reset",()=>{
	
});




