const checkResultList = [true, true, true]; // 0 - 닉네임 중복, 1,2 - 비밀번호 변경 시 결과 확인

// 수정하기 버튼 누르면 수정 모드로 전환하기
document.getElementById('submit_button').onclick = e => {
    const $form = document.getElementById('modify-info');
    const $submit = document.getElementById('submit_button'); // 수정하기 버튼
    const $before = document.querySelector('.inner-before'); // 수정하기 전 사용자 정보 화면
    const $modify = document.querySelector('.inner-change'); // 사용자가 수정할 수 있는 화면

    if ($submit.textContent === "수정하기") {
        $submit.textContent = "수정 저장";
        $before.setAttribute("style", "display:none");
        $modify.removeAttribute("style");
        return;
    }
    console.log($submit.textContent);

    if (e.textContent !== "수정 저장") {
        if (checkResultList.includes(false)) {
            alert('입력란을 다시 확인해주세요');
        } else {
            $form.submit();
            alert('정보 수정이 완료되었습니다! 다시 로그인해주세요.');
        }
    }
}

// 프로필 사진 변경 버튼
const $proflieImage = document.getElementById('image-preview');
const $profile_btn = document.querySelector('.btn_image')
const $fileInput = document.getElementById('profileImage');

$profile_btn.onclick = e => {
    $fileInput.click();
}

$fileInput.onchange = e => {
    const fileData = $fileInput.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(fileData);

    reader.onloadend = e => {
        $profileImage.setAttribute('src', reader.result);
    }
}

// 수정 모드에서 닉네임 수정하고 중복확인 처리
    const $nickInput = document.getElementById('nick');
    const $duplicationCheck = document.getElementById('nickname-check');
    const nickPattern = /^[a-zA-Z가-힣]{2,}$/;
    const originNick = $nickInput.value.trim();

    $duplicationCheck.addEventListener('click', () => {
        const nickValue = $nickInput.value.trim();
        checkResultList[0] = false;

        if(originNick === nickValue){
            alert('기존 닉네임을 그대로 사용합니다')
            checkResultList[0] = true;
        } else if (nickValue === '' || !nickPattern.test(nickValue)) {
            alert('닉네임은 2글자 이상의 영문, 한글로 입력해주세요');
            checkResultList[0] = false;
        } else {
            fetch(`/members/check/nickname/` + nickValue)
                .then(res => res.json())
                .then(flag => {
                    if (flag) {
                        alert('닉네임이 중복되었습니다');
                        checkResultList[0] = false;
                    } else {
                        alert('사용 가능한 닉네임입니다');
                        checkResultList[0] = true;
                    }
                })
                .catch(error => {
                    console.error('Error checking nickname:', error);
                });
        }
    });

// 수정 모드에서 비밀번호 변경 버튼 누르면 비밀번호 변경 창 생성
document.getElementById('modify-pw').onclick = () => {
    checkResultList[1] = false;
    document.querySelector('.form-list').setAttribute("style", "display:block");
    document.getElementById('pw-inform').setAttribute("style","display:none");
    document.getElementById('modify-pw').setAttribute("style", "display:none");
};

// 비밀번호 입력 검증
const $pwInput = document.getElementById('pw');
const $reChkPw = document.getElementById('pw2');

const passwordPattern =/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~@#$!%*?&])[a-zA-Z\d~@#$!%*?&]{8,}$/;

$pwInput.addEventListener('keyup', () => {
    const pwValue = $pwInput.value.trim();

    if (pwValue === '') {
        $pwInput.style.borderColor = 'red';
        document.getElementById('pwChk').innerHTML = '<b style="color: red;">비밀번호는 필수값입니다</b>';
        checkResultList[1] = false;
        return;
    } else if (!passwordPattern.test(pwValue)) {
        $pwInput.style.borderColor = 'red';
        document.getElementById('pwChk').innerHTML = '<b style="color: red;">영문+숫자+특수문자 8자 이상 입력하세요</b>';
        checkResultList[1] = false;
        return;
    } else {
        $pwInput.style.borderColor = 'black';
        document.getElementById('pwChk').innerHTML = '<b style="color: #0a0064;">[사용가능한 비밀번호입니다]</b>';
        checkResultList[1] = true;
    }
});

$reChkPw.addEventListener('keyup', () => {
    const reChkPwVal = $reChkPw.value.trim();
    const pwValue = $pwInput.value.trim();

    if (reChkPwVal === '') {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호 확인은 필수입니다.</b>';
        checkResultList[2] = false;
        return;
    } else if (reChkPwVal !== pwValue) {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호와 일치하지 않습니다.</b>';
        checkResultList[2] = false;
        return;
    } else {
        $reChkPw.style.borderColor = 'black';
        document.getElementById('reChkPw').innerHTML = '<b style="color: #0a0064;">[비밀번호와 일치합니다.]</b>';
        checkResultList[2] = true;
    }
});


// 주소 찾기 API
function sample6_execDaumPostcode() {
    // 수정 모드에서 주소 변경 버튼 누르면 input 태그 생성
    document.getElementById('origin-address').setAttribute("style", "display:none");
    document.getElementById('sample6_address').removeAttribute("style");
    document.getElementById('sample6_detailAddress').removeAttribute("style");


    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();

            document.getElementById('sample6_address').readOnly = true;

            document.getElementById('address').setAttribute("value", addr);
        }
    }).open();
}