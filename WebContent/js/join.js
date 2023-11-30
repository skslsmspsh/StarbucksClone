function EPcheck(){
    var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var regExpPhone = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/ ;

    var frm1 = document.frm1;

    var phone = frm1.userPhone.value;
    var email = frm1.userEmail.value;

	if(!regExpPhone.test(phone)){
        alert("xxx-xxxx-xxxx형식으로 입력해주세요.");
        frm1.userPhone.focus();
        return false;
    }
    if(!regExpEmail.test(email)){
        alert("이메일형식을 확인해주세요.");
		frm1.userEmail.focus();
        return false;
    }
};