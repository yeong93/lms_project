<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/admin/login.css" />

<!-- 우편번호 조회 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>

<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script type="text/javascript">
 
$(document).ready(function() { 
	
	$("#btn_prelogin").click(function() {
		$("#EMP_ID").val("admin");
		$("#EMP_PWD").val("admin");
		fLoginProc();
	});
	
	$("#btn_prelogin1").click(function() {
		$("#EMP_ID").val("1234");
		$("#EMP_PWD").val("1234");
		fLoginProc();
	});
	
	$("#btn_prelogin2").click(function() {
		$("#EMP_ID").val("DigitalOne");
		$("#EMP_PWD").val("DigitalOne");
		fLoginProc();
	});
	

	
});
	/* OnLoad Event */
	$(function() {
		// 쿠키값을 가져온다.
		var cookie_user_id = getCookie('EMP_ID');
		if(cookie_user_id != "") {
			$("#EMP_ID").val(cookie_user_id);
			$("#cb_saveId").attr("checked", true);
		}
		
		$("#EMP_ID").focus();
});
	
	/** 로그인 ID  체크 */
	function fCheckLgnId() {
		
		// validation 체크
		var lgn_id = $("#signForm").find("#lgn_id").val();
		if (lgn_id == "") {
			alert("아이디를 입력하세요.");
			$("#signForm").find("#lgn_id").focus();
			return;
		}
		
		if(!fChkId(lgn_id)){ //아이디 정규식 체크
			alert("아이디는 영문, 숫자를 포함한 7자리 이상 20자리 미만 입니다.");
			return;
		}
		
		// 로그인 아이디 조회
		var param = { lgn_id : lgn_id };
		var resultCallback = function(data) {
			fCheckLgnIdResult(data);
		};
		callAjax("/system/selectUsrMgr.do", "post", "json", true, param, resultCallback);
	}

	
	/** 로그인 ID 중복 체크 콜백 함수 */
	function fCheckLgnIdResult(data) {
		if (data.result == "SUCCESS") {
			$("#signForm").find("#idCheckFlag").val(data.isPossible);
			$("#signForm").find("#pwd").focus();
		}
	}
	
		
	/* 로그인 validation */
	function fValidateLogin() {

		var chk = checkNotEmpty(
				[
					[ "EMP_ID", "아이디를 입력해 주세요." ],
					[ "EMP_PWD", "비밀번호를 입력해 주세요." ] 
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/* 로그인 */
	function fLoginProc() {
		if($("#cb_saveId").is(":checked")){ // 저장 체크시
			saveCookie('EMP_ID',$("#EMP_ID").val(),7);
		}else{ // 체크 해제시는 공백
			saveCookie('EMP_ID',"",7);
		}
		
		// vaildation 체크
		if ( ! fValidateLogin() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fLoginProcResult(data);
		};
		
		callAjax("/loginProc.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	
	
	/* 로그인 결과 */
	function fLoginProcResult(data) {
		
		var lhost = data.serverName;
		
		if (data.result == "SUCCESS") {
			location.href = "${CTX_PATH}/dashboard/dashboard.do";
		} else {
			
			$("<div style='text-align:center;'>" + data.resultMsg + "</div>").dialog({
				modal : true,
				resizable : false,
				buttons : [ {
					text : "확인",
					click : function() {
						$(this).dialog("close");
						$("#EMP_ID").val("");
						$("#EMP_PWD").val("");
						$("#EMP_ID").focus();
					}
				} ]
			});
			$(".ui-dialog-titlebar").hide();
		}		
	}
	
	
	/** ID 조회 */
	function fSelectData() {
		var resultCallback = function(data) {
			fSelectDataResult(data);
		};
		callAjax("/selectFindInfo.do", "post", "json", true, $("#modalForm").serialize(), resultCallback);
	}


	/** PW 조회 */
	function fSelectDataPw() {
		var resultCallback = function(data) {
			fSelectDataResultPw(data);
		};
		
		callAjax("/selectFindInfo.do", "post", "json", true, $("#modalForm2").serialize(), resultCallback);
	}


	
	/** pw 저장 */
	function fSaveData() {
		
		var resultCallback = function(data) {
			fSaveDataResult(data);
		};
		
		callAjax("/updateFindPw.do", "post", "json", true, $("#modalForm2").serialize(), resultCallback);
	}

	/** 데이터 저장 콜백 함수 */
	function fSaveDataResult(data) {
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);
			location.href = "/login.do";
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}
	

</script>
</head>
<body>

	<div id="background_board" >		
			<div class="login_form"  align="center">
				<form id="myForm" action=""  method="post"  >
					<fieldset>
						<legend>로그인</legend>
						<p class="id">
							<label for="user_id" >아이디</label> 
							<input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" />
						</p>
						<p class="pw">
							<label for="user_pwd" >비밀번호</label> 
							<input type="password" id="EMP_PWD" name="pwd" placeholder="비밀번호"
								onfocus="this.placeholder=''; return true" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" />
						</p>
						<p class="member_info" style="font-size:15px"  >
							<input type="checkbox" id="cb_saveId" name="" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"> <span class="id_save">ID저장</span>			
				            <br>
						</p>	
						<a class="btn_login" href="javascript:fLoginProc();" id="btn_login" ><strong>Login</strong></a>
						<br>
						  <!--  <button type="" id="btn_copjoin" onclick="location.href='/cop/officeReg.do' " style="background: none;font-size:110%;border: 0px;color: gray "><strong>[기업회원가입]</strong></button> -->
				          <!--   <a class="btn_copjoin" href="#" ><strong>[기업회원가입]</strong></a>	 -->
				            <a href="javascript:fLoginProc();" id="btn_prelogin" ><strong>[관리자로그인]</strong></a>	
 							<a href="javascript:fLoginProc();" id="btn_prelogin1" ><strong>[강사로그인]</strong></a>	
 							<a href="javascript:fLoginProc();" id="btn_prelogin2" ><strong>[학생로그인]</strong></a>	
					</fieldset>
				</form>
			</div>		
	</div>

</body>
</html>