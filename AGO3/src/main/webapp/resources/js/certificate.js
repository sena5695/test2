/**
 * 
 */

// <!-- 제목, 내용, 대표자 정규식 / 데베 등록 -->
function certificate_regist() {
	var certificate_regx = /^[ㄱ-ㅎ가-힣a-zA-Z0-9 \*]+$/;

	let form = document.querySelector('form[name="registForm"]');

	var retName = document.getElementById('retName');
	var ctfTitle = document.getElementById('ctfTitle');
	var ctfContent = document.getElementById('ctfContent');

	console.log("retName: " + retName.value + " ctfTitle: " + ctfTitle.value
			+ " ctfContent:" + ctfContent.value);

	var titleCheck = regxTest(ctfTitle, certificate_regx);
	if (titleCheck == 0) {
		alert("제목은 한글,영문,숫자로 필수 항목입니다.");
		titleCheck.focus();
		return;
	}
	var retName = regxTest(retName, certificate_regx);
	if (retName == 0) {
		alert("대표자명은 한글,영문,숫자로 필수 항목입니다.");
		retName.focus();
		return;
	}

	form.submit();

}

function regxTest(object, regx) {
	var isCheck = 1;
	if (!regx.test(object.value)) {
		object.focus();
		object.style.border = "1px solid #dc3545";
		object.style.backgroundColor = "#FFE4E1";
		isCheck = 0;
	} else {
		object.style.border = "1px solid #ced4da";
		object.style.backgroundColor = "white";
	}

	return isCheck;
}

// <!-- 수료증 디자인 -->
let ctfDesignFormData = "";
function ctfDesign_go() {
	ctfDesignFormData = new FormData($('form[role="ctfDesignForm"]')[0]);
	let form = $('form[role="ctfDesignForm"]');
	let picture = form.find('[name=pictureFile]')[0];

	console.log(picture.value); // 전체경로
	console.log(picture.files[0].name); // 파일명

	// 이미지 확장자 jpg 확인
	let fileFormat = picture.value.substr(picture.value.lastIndexOf('.') + 1).toUpperCase();
	if (!(fileFormat == "JPG" || fileFormat == "JPEG")) {
		alert("이미지는 jpg/jpeg 형식만 가능합니다.");
		picture.value = "";
		return;
	}

	// 이미지 파일 용량 체크
	if (picture.files[0].size > 1024 * 1024 * 1) {
		alert("사진 용량은 1MB 이하만 가능합니다.");
		picture.value = "";
		return;
	}

	// 업로드 확인변수 초기화(사진 변경)
	form.find('[name="ctfDesignCheckUpload"]').val(0);

	document.getElementById('ctfDesignFileName').value = picture.files[0].name;

	if (picture.files && picture.files[0]) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$('div#ctfDesignView').css({
				'background-image' : 'url(' + e.target.result + ')',
				'background-position' : 'center',
				'background-size' : 'cover',
				'background-repeat' : 'no-repeat'
			});
		}
		reader.readAsDataURL(picture.files[0]);
	}
}

function ctfDesign_upload_go() {
	if (!$('form[role="ctfDesignForm"] input[name="pictureFile"]').val()) {
		alert("사진을 선택하세요");
		$('input[name="pictureFile"]').click();
		return;
	}
	if ($('input[name="ctfDesignCheckUpload"]').val() == 1) {
		alert("이미 업로드 된 사진입니다.");
		return;
	}

	$.ajax({
		url : 'picture',
		data : ctfDesignFormData,
		type : 'post',
		processData : false,
		contentType : false,
		success : function(data) {
			// 업로드 확인 변수 세팅
			$('input[name="ctfDesignCheckUpload"]').val(1);

			// 저장된 파일명 저장
			$('input#oldCtfDesignFile').val(data); // 변경시 삭제될 파일명
			$('form[role="form"] input[name="ctfDesign"]').val(data);
			alert("사진이 업로드 되었습니다.");
		},
		error : function(error) {
			// alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
			AjaxErrorSecurityRedirectHandler(error.status);
			console.log(error.status);
		}
	})
}

// <!-- 직인디자인 -->
let ctfSealFormData = "";
function ctfSeal_go() {
	ctfSealFormData = new FormData($('form[role="ctfSealForm"]')[0]);
	let form = $('form[role="ctfSealForm"]');
	let picture = form.find('[name=pictureFile]')[0];

	console.log(picture.value); // 전체경로
	console.log(picture.files[0].name); // 파일명

	// 이미지 확장자 jpg 확인
	let fileFormat = picture.value.substr(picture.value.lastIndexOf('.') + 1)
			.toUpperCase();
	if (!(fileFormat == "JPG" || fileFormat == "JPEG")) {
		alert("이미지는 jpg/jpeg 형식만 가능합니다.");
		picture.value = "";
		return;
	}

	// 이미지 파일 용량 체크
	if (picture.files[0].size > 1024 * 1024 * 1) {
		alert("사진 용량은 1MB 이하만 가능합니다.");
		picture.value = "";
		return;
	}

	// 업로드 확인변수 초기화(사진 변경)
	form.find('[name="ctfSealCheckUpload"]').val(0);

	document.getElementById('ctfSealFileName').value = picture.files[0].name;

	if (picture.files && picture.files[0]) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$('div#ctfSealView').css({
				'background-image' : 'url(' + e.target.result + ')',
				'background-position' : 'center',
				'background-size' : 'cover',
				'background-repeat' : 'no-repeat'
			});
		}
		reader.readAsDataURL(picture.files[0]);
	}
}

function ctfSeal_upload_go() {
	if (!$('form[role="ctfSealForm"] input[name="pictureFile"]').val()) {
		alert("사진을 선택하세요");
		$('input[name="pictureFile"]').click();
		return;
	}
	if ($('input[name="ctfSealCheckUpload"]').val() == 1) {
		alert("이미 업로드 된 사진입니다.");
		return;
	}

	$.ajax({
		url : 'picture',
		data : ctfSealFormData,
		type : 'post',
		processData : false,
		contentType : false,
		success : function(data) {
			// 업로드 확인 변수 세팅
			$('input[name="ctfSealCheckUpload"]').val(1);

			// 저장된 파일명 저장
			$('input#oldCtfSealFile').val(data); // 변경시 삭제될 파일명
			$('form[role="form"] input[name="ctfSeal"]').val(data);
			alert("사진이 업로드 되었습니다.");
		},
		error : function(error) {
			// alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
			AjaxErrorSecurityRedirectHandler(error.status);
			console.log(error.status);
		}
	})
}
