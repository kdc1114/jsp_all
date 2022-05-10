const AJAX_URL="./ajax.do";
const phoneCheck = document.getElementById("phoneCheck");
const emailCheck = document.getElementById("emailCheck");
const memForm = document.forms["memForm"];
const InsertModal=document.getElementById("InsertModal");
const insertMsg=document.getElementById("insertMsg");
const listReBtn=document.getElementById("listReloadBtn");
const InsertModal2 = new bootstrap.Modal(InsertModal);
const IdCheckModal=document.getElementById("IdCheckModal");
const idCheckMsg=document.getElementById("idCheckMsg");
const idUse=document.getElementById("idUse");
const IdCheckModal2 = new bootstrap.Modal(IdCheckModal);

// 리스트 아이디 중복체크
async function idCheck(){
	const id=memForm.id.value;
	const idReg=/^[a-zA-Z]+[a-z0-9A-Z]{3,19}$/g;
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
// 등록 모달 메인페이지 복귀
listReBtn.onclick=function(){
	InsertModal2.hide();
	location.href="/model2_shop/login.do";
};
// 핸드폰 중복 및 형식체크
memForm.phone.addEventListener("blur",async()=>{
	const phone=memForm.phone.value;
	const pform=/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
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
// 이메일 중복 및 형식체크
memForm.email.addEventListener("blur",async()=>{
	const email=memForm.email.value;
	const eform=/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]/ig;
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








