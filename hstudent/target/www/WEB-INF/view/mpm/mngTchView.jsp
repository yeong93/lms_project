<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge" />
<title>강사관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

     //강사관리 페이지 설정
     var teacherPageSize = 5;
     var teacherPageBlockSize =5;

     /* onload 이벤트  */
     $(function(){

	    //날짜 지정형식 	
		var dateFormat = "mm/dd/yy",
		//시작일
		from = $("#from").datepicker({defaultDate : "+1w", //1개월씩 증가
			changeMonth : true,     numberOfMonths : 3//최대 보여지는 개월수
		}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this));
		}),
		//끝
		to = $("#to").datepicker({defaultDate : "+1w", //1개월씩 증가
			changeMonth : true,  numberOfMonths : 3//최대 보여지는 개월수
		}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this));
		});

		// 날짜 가져오는 함수
		function getDate(element) {
		  var date;
		  try {
			date = $.datepicker.parseDate(dateFormat, element.value);
		  } catch (error) {
				date = null;
		  }
			return date;
		}
		selectTeacherList();
	});//date 지정 시작일과 끝

	/*강사관리 폼 초기화*/
	function initFormTeacher(object) {
		$("#th_name").focus();
		//console.log("initFormTeacher1 : " + object);
		//console.log("initFormTeacher2 : " + JSON.stringify(object));

		if (object == "" || object == null || object == undefined) {
			//alert("new");
			$("#th_name").val("");
			$("#loginID").val("");
			$("#th_birthday").val("");
			$("#th_reg_date").val("");
			$("#th_phone_number").val("");
			$("#th_password").val("");
			$("#th_name").attr("readonly", false);
			$("#th_name").css("background", "FFFFFF");
			$("#th_name").focus();
			$("#btnDelete").hide();
			$("#th_reg_date").hide();
		} else {
			$("#th_name").val(object.th_name);
			$("#loginID").val(object.loginID);
			$("#th_birthday").val(object.th_birthday);
			//$('#th_reg_date').val(object.th_reg_date);
			$("#th_phone_number").val(object.th_phone_number);
			$("#th_password").val(object.th_password);
			$("#loginID").attr("readonly", true);
			$("#loginID").css("background", "FFFFFF");
			$("#th_name").focus();
			$("#th_reg_date").hide();
			$("#btnDelete").show();
		}

	}//initFormTeacher
	
	 /*유효성 체크 함수*/
    function fValidateCheck(){
  	  
  	  var chk = checkNotEmpty(
  			  [
  				  ["th_name1","강사명을 입력해주세요."]
  			  ]
  	  );  
  	  
  	  if(!chk){
  		  return;
  	  }
  	  
  	  return true;
    }//유효성 체크 함수
    

	/*강사관리 리스트 불러오기*/
	function selectTeacherList(currentPage) {

		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : teacherPageSize
		}

		var resultCallback = function(data) {
			teacherListResult(data, currentPage);
		}

		callAjax("/peopleA/teacherList.do", "post", "text", true, param,resultCallback);
	}

	/*강사관리 리스트 불러오기*/
	function teacherListResult(data, currentPage) {

		// 기존 목록 삭제
		$('#teacherList').empty();

		var $data = $($(data).html());

		// 신규 목록 생성
		var $teacherList = $data.find("#teacherList");
		$("#teacherList").append($teacherList.children());

		//총 개수 추출
		var $totalCntTeacher = $data.find("#totalCnt");
		var totalCntTeacher = $totalCntTeacher.text();

		//페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntTeacher,
				teacherPageSize, teacherPageBlockSize, 'selectTeacherList');

		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageTeacher").val(currentPage);
	}//강사관리 리스트 불러오기 

	/*강사관리 삭제*/
	function fDelete() {

		var resultCallback = function(data) {
			fDeleteResult(data);
		};

		callAjax("/peopleA/deleteTeacher.do", "post", "json", true, $(
				"#myTeacher").serialize(), resultCallback);
	}//강사관리 삭제

	/*강사관리 삭제 콜백 함수*/
	function fDeleteResult(data) {

		var currentPage = $("#currentPageTeacher").val();

		if (data.result == "SUCCESS") {

			//응답 메시지 출력
			alert(data.resultMsg);

			//모달닫기
			gfCloseModal();

			//강사관리 목록 출력
			selectTeacherList(currentPage);

		} else {
			alert(data.resultMsg);
		}
	}

	/*강사관리 신규등록*/
	function fRegister(loginID) {

		//신규 저장
		if (loginID == null || loginID == "") {

			// Tranjection type 설정
			$('#action').val("I");

			//강사관리 폼 초기화
			initFormTeacher();

			//모달 팝업
			gfModalPop("#layer1");

			//수정 저장	  
		} else {

			// Tranjection type 설정
			$("#action").val("U");

			//강사관리 단건 조회
			fSelectTeacher(loginID);
		}
		//강사목록 다시불러오기
		selectTeacherList(currentPage);

	}//강사관리 신규등록

	/*강사관리 단건조회*/
	function fSelectTeacher(loginID) {

		var param = {
			loginID : loginID
		};

		var resultCallback = function(data) {
			fSelectTeacherResult(data);
		}

		callAjax("/peopleA/selectTeacher.do", "post", "json", true, param,
				resultCallback);
	}

	/*강사관리 단건조회 콜백함수*/
	function fSelectTeacherResult(data) {

		console.log(JSON.stringify(data));
		console.log(JSON.stringify(data.teacherJYOModel));
		if (data.result == "SUCCESS") {

			//모달 팝업
			gfModalPop("#layer1");

			//강사관리 폼 데이터 설정
			initFormTeacher(data.teacherJYOModel);
		}

		else {
			alert(data.resultMsg);
		}
	}

	/*강사관리 저장*/
	function fSaveTeacher() {

		var resultCallback = function(data) {
			fSaveTeacherResult(data);
		};

		callAjax("/peopleA/saveTeacher.do", "post", "json", true, $("#myTeacher").serialize(), resultCallback);

	}//강사관리 저장

	/*강사관리 저장 콜백함수*/
	function fSaveTeacherResult(data) {

		//목록 조뢰 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageTeacher").val();
		}

		if (data.result == "SUCCESS") {

			//응답 메시지 출력
			alert(data.resultMsg);

			gfCloseModal();

			//목록조회
			selectTeacherList(currentPage);

		} else {
			//오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		//입력폼 초기화
		initFormTeacher();

	}//강사관리 저장 콜백함수
	
	/*강사관리 검색*/
    function fSeacrchTeacher(currentPage){
 	   
       //유효성 체크함수 불러오기
 	   if( ! fValidateCheck() ){
 		   return;
 	   }
 	   
 	   //var from = $('#from');//시작일
  	   //var to = $('#to');//끝
  	   var th_name1 = $('#th_name1');//학생명
 	   
 	   currentPage = currentPage || 1;
 	   
 	   var param = {
 			        currentPage : currentPage,
 			        pageSize : teacherPageSize,
 			        th_name1 : th_name1.val()
 			        //from : from.val(),
 			        //to : to.val()
 			   
 	   }
 	   
 	   var resultCallback = function(data){
 		   teacherListResult(data, currentPage);
 	   };
 	   
 	   alert("검색되었습니다.");
 	   
 	   callAjax("/peopleA/teacherList.do", "post", "text", true, param, resultCallback);
 	   
    }
	
</script>

</head>
<body>
	<form id="myTeacher" action="" method="">
		<input type="hidden" id="currentPageTeacher" value="1"> 
		<input type="hidden" id="action" name="action" value="">

		<!-- 모달 배경 -->
		<div id="mask"></div>

		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>

					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3>
						<div class="content">

							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">인원 관리</a> <span class="btn_nav bold">강사
									관리</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>강사관리</span> <span class="fr"><a
									class="btnType blue" href="javascript:fRegister();"
									name="modal"> <span>신규등록</span></a> </span>
							</p>

							<span>가입일자: <input type="text" id="from" name="from" height="25"></span> 
							<span> ~ <input type="text" id="to" name="to" height="25"></span> 
							<span style="padding: 100px">강사명:<input type="text"
								id="th_name1" name="th_name1"></span> <span
								style="font-size: 120%"></span> <span width="110" height="60"
								style="font-size: 120%"> <a
								href="javascript:fSeacrchTeacher();" class="btnType gray"
								id="btnSearch" name="btn"><span>검색</span></a>
							</span>

							<div class="divTeacherList">
								<table class="col">
									<caption>caption</caption>

									<colgroup>
										<col width="20px">
										<col width="40px">
										<col width="40px">
										<col width="40px">
										<col width="40px">
										<col width="40px">
										<col width="40px">
										<col width="40px">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">강사명</th>
											<th scope="col">비밀번호</th>
											<th scope="col">아이디</th>
											<th scope="col">휴대전화</th>
											<th scope="col">생년월일</th>
											<th scope="col">가입일자</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="teacherList"></tbody>
								</table>



								<!-- 페이징 처리  -->
								<div class="paging_area" id="Pagination"></div>
								<!-- 페이징 처리  -->

							</div>


						</div> <!-- content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>

					</li>
					<!-- content -->
				</ul>
			</div>
			<!-- container -->
		</div>
		<!-- wrap_area -->

		<!-- 신규등록 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강사관리</strong>
				</dt>
				<dd class="content">
					<table class="row">
						<caption>안보이지롱</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">강사명</th>
								<td><input type="text" class="inputTxt p100" name="th_name"
									id="th_name" /></td>
								<th scope="row">아이디</th>
								<td><input type="text" class="inputTxt p100" name="loginID"
									id="loginID" /></td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td><input type="text" class="inputTxt p100"
									name="th_birthday" id="th_birthday" /></td>
								<th scope="row">가입일자</th>
								<td><input type="text" class="inputTxt p100"
									name="th_reg_date" id="th_reg_date" /></td>
							</tr>
							<tr>
								<th scope="row">휴대전화</th>
								<td colspan="1"><input type="text" class="inputTxt p100"
									name="th_phone_number" id="th_phone_number" /></td>
								<th scope="row">비밀번호</th>
								<td><input type="text" class="inputTxt p100"
									name="th_password" id="th_password" /></td>
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="javascript:fSaveTeacher();" class="btnType blue"
							id="btnSave"><span>저장</span></a> <a href="javascript:fDelete();"
							class="btnType blue" id="btnDelete"><span>삭제</span></a> <a
							href="" class="btnType" id=""><span>취소</span></a>
					</div>
				</dd>
			</dl>
		</div>
	</form>
</body>
</html>