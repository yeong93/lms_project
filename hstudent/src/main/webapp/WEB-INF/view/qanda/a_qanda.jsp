<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">
/* 	#listComnGrpCod td{
		cursor: pointer;
	} */
</style>

<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;
	
	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	var qnaList;
	
	/** OnLoad event */ 
	$(function() {
	
		// 그룹코드 조회
		fListComnGrpCod();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	 function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'insertBtn' :
					// 글 등록, 수정 
					fSaveGrpCod();
					break;
					
				case 'btnSaveQnACod' :
					break; 
					
				case 'btnSaveDtlCod' :
					// 댓글 등록
					fSaveDtlCod();
					break;
					
				case 'btnDeleteDtlCod' :
					// 글 삭제
					fDeleteDtlCod();
					break;
					
 				case 'btnDeleteRvCod' :
					// 댓글 삭제
					fDeleteDtlCod(re_id);
					break; 
					
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
					
				case 'btnInsertDtlCod' :
					// qna글 등록
					fPopModalComnDtlCod();
					break;
					
					// qna 글 수정
				case 'btnUpdate' :
					fPopModalComnDtlCod2();
					break;
			}
		});
	} 
	
	
	/** 그룹코드 폼 초기화 */
	function fInitFormGrpCod(data) {
		if( data == "" || data == null || data == undefined) {
			$("#qa_num").val("");
			$("#bod_tit").val("");
			$("#bod_con").val("");
			$("#regdate").val("");
		    $("#bod_name").val("");

		} else {
			//console.log(JSON.stringify(data.qnaRvList));
			//<fmt:formatDate value="${data.qnaListRv}" var="regdate" pattern="yyyy-MM-dd"/>
			
			var qnaList = data.qnaList;
			var qnaListRv = data.qnaRvList;
			
			// 작성자 본인일때만 수정,삭제영역 보임
		 	if(qnaList.login_id!="${loginId}"){
				$("#changeArea").css("display","none");
			} 
			
			// qna 글
			$("#qa_num").val(qnaList.qa_id);
			$("#bod_tit").text(qnaList.bod_tit);
 			$("#bod_con").text(qnaList.bod_con);
			$("#regdate").text(qnaList.regdate);
		    $("#bod_name").text(qnaList.name);
		    
		    // qna 댓글
		   for(var i=0; i<qnaListRv.length; i++){
				var $td1 = $("<td>");                                      
				var $td2 = $("<td>").css("word-break","break-all");                                      
				var $td3 = $("<td>");                                      
				var $tr = $("<tr>");
				
				// 댓글 삭제 버튼
				var $closeBtn = $("<button>").html("delete").attr("onclick", "fDeleteGrpCod("+qnaListRv[i].rv_id+")");
				
				// 댓글 작성자일시 삭제 버튼 생성
				if(qnaListRv[i].login_id == "${loginId}"){
		    		$td2.append(qnaListRv[i].rv_con).append($closeBtn);
				}else{
					$td2.append(qnaListRv[i].rv_con);
				}
					
		    	$td1.append(qnaListRv[i].name);
		    	$td3.append(qnaListRv[i].regdate);
		    	$tr.append($td1).append($td2).append($td3);
		    	$(".re_body").append($tr);
		    	
		    } 
			
		}
	}
	
	
	/** 상세코드 폼 초기화 */
	function fInitFormDtlCod(object) {

		var grpCod = $("#tmpGrpCod").val();
		var grpCodNm = $("#tmpGrpCodNm").val();

		if( object == "" || object == null || object == undefined) {
/* 			$("#dtl_grp_cod").focus();
			
			$("#dtl_grp_cod").val("");
			$("#dtl_cod").val(""); */
			
 			$("#qa_bod_tit").focus();
			$("#qa_bod_con").val("");
			$("#qa_bod_tit").val(""); 
			
		} else {
			$("#qa_bod_tit").val(object.bod_tit);
			$("#qa_bod_con").val(object.bod_con);
		}
	}
	
	
	/** 그룹코드 저장 validation */
	function fValidateGrpCod() {
		
		var chk = checkNotEmpty(
				[
						[ "qa_bod_tit", "그룹 코드를 입력해 주세요." ]
					,	[ "qa_bod_con", "그룹 코드 명을 입력해 주세요" ]
					,	[ "grp_cod_eplti", "그룹 코드 설명을 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}
		return true;
	}
	
	
	/** 상세코드 저장 validation */
	function fValidateDtlCod() {

		var chk = checkNotEmpty(
				[
						[ "dtl_grp_cod", "그룹 코드를 선택해 주세요." ]
					,	[ "dtl_cod", "상세 코드를 입력해 주세요." ]
					,	[ "dtl_cod_nm", "상세 코드 명을 입력해 주세요" ]
					,	[ "dtl_cod_eplti", "상세 코드 설명을 입력해 주세요." ]
					,	[ "dtl_odr", "상세 코드 설명을 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	/** 그룹코드 모달 실행 */
	function fPopModalComnGrpCod(qa_id) {
		
		// 신규 저장
		if (qa_id == null || qa_id=="") {
		
			// Tranjection type 설정
			$("#action").val("I");
			
			// 그룹코드 폼 초기화
			fInitFormGrpCod();
			
			// 모달 팝업
			gfModalPop("#layer1");

		// 수정 저장
		} else {
			
			// Tranjection type 설정
			$("#action").val("U");
			
			// 그룹코드 단건 조회
			fSelectGrpCod(qa_id);
		}
	}
	
	
	/** QnA 목록 조회 */
	function fListComnGrpCod(currentPage) {
		
		currentPage = currentPage || 1;
		
		//console.log("currentPage : " + currentPage);
		
		var param = {
					currentPage : currentPage
				,	pageSize : pageSizeComnGrpCod
		}
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		
		callAjax("/qanda/exchangeQnaList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 그룹코드 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		//alert(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listComnGrpCod').empty();
		//$('#listComnGrpCod').find("tr").remove() 
		
		var $data = $( $(data).html() );
		
		// 신규 목록 생성
		var $listComnGrpCod = $data.find("#listComnGrpCod");		
		$("#listComnGrpCod").append($listComnGrpCod.children());
		
		// 총 개수 추출
		var $totalCntComnGrpCod = $data.find("#totalCntComnGrpCod");
		var totalCntComnGrpCod = $totalCntComnGrpCod.text();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}
	
	
	/** 그룹코드 단건 조회 */
	function fSelectGrpCod(qa_id) {
		
		var param = { qa_id : qa_id };
		
		var resultCallback = function(data) {
			fSelectGrpCodResult(data);
		};
		
		callAjax("/qanda/detailList.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 그룹코드 단건 조회 콜백 함수*/
	function fSelectGrpCodResult(data) {

		if (data.result == "SUCCESS") {
			
			// 모달 팝업
			gfModalPop("#layer1");
			
			// 그룹코드 폼 데이터 설정
			fInitFormGrpCod(data);
			
		} else {
			alert(data.resultMsg);
		}	
	}
	
	
	/** qna 글 등록 */
	function fSaveGrpCod() {

		// vaildation 체크
/* 		if ( ! fValidateGrpCod() ) {
			return;
		} */
		
		var bod_con = $("#qa_bod_con").val();
		var bod_tit = $("#qa_bod_tit").val();
		
		var param = { bod_tit : bod_tit 
							,bod_con : bod_con}; 
		
		var resultCallback = function(data) {
			fSaveGrpCodResult(data);
		};

		callAjax("/qanda/saveQna.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 그룹코드 저장 콜백 함수 */
	function fSaveGrpCodResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageComnGrpCod").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListComnGrpCod(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormGrpCod();
	}

	
	/** 댓글 삭제 */
  	function fDeleteGrpCod(rv_id) {
		var qa_id = $(".qa_num").val(); 

		var param = { rv_id : rv_id 
							,qa_id : qa_id}; // 댓글번호, 글번호
		
		var resultCallback = function(data) {
			fDeleteGrpCodResult(data);
		};
		
		callAjax("/qanda/deleteRv.do", "post", "json", true, param, resultCallback);
	}  
	
	
	/** 그룹코드 삭제 콜백 함수 */
 	function fDeleteGrpCodResult(data) {

		var currentPage = $("#currentPageComnGrpCod").val();
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
			
			// 모달 닫기
			//gfCloseModal();
			
			// 여기까지 성공!
			// 그룹코드 목록 조회
			//fListComnGrpCod(currentPage);
			
		} else {
			alert(data.resultMsg);
		}	
	} 
	
	
	/** 입력폼 모달 실행 */
	function fPopModalComnDtlCod() {
		$("#updateBtn").css("display","none");

		// 모달 팝업
		gfModalPop("#layer2");
		
		/* if ($("#tmpGrpCod").val() == "") {
			alert("그룹 코드를 선택해 주세요.");
			return;
		}  */

		// Tranjection type 설정
		$("#action").val("I");
		
		// 상세코드 폼 초기화
		fInitFormDtlCod();
	}
	
	
	/** 수정폼 모달 실행 */
	function fPopModalComnDtlCod2() {
		$("#insertBtn").css("display","none");
        // 수정시 내용들 들고감!
        var title = $("#bod_tit").text();
        var content = $("#bod_con").text();
        
        gfModalPop("#layer2");
        
        $("#qa_bod_tit").val(title);
        $("#qa_bod_con").val(content);
		
        $("#updateBtn").attr("onclick","fUpdateDtlCod();");
        
		// Tranjection type 설정
		$("#action").val("I");
		
		// 상세코드 폼 초기화
		//fInitFormDtlCod();
	}
	
	
   /** qna 수정 */
   function fUpdateDtlCod() {

	  var qa_id = $(".qa_num").val();
	  var bod_tit = $("#qa_bod_tit").val();
	  var bod_con = $("#qa_bod_con").val();

	  var param = { bod_tit : bod_tit
			  			, bod_con : bod_con
			  			, qa_id : qa_id};
		
      var resultCallback = function(data) {
    	  fUpdateDtlCodResult(data);
      }; 
      callAjax("/qanda/updateQna.do", "post", "json", true, param, resultCallback);
   }
   
   /** qna 수정 콜백 */
   function fUpdateDtlCodResult(data) {
      var currentPage = $("#currentPageComnDtlCod").val();
      
      if (data.result == "SUCCESS") {
         alert(data.resultMsg);
         //gfCloseModal();
      } else {
         alert(data.resultMsg);
      }   
   }
	   
	
   /** 상세코드 삭제 */
   function fDeleteDtlCod() {
		
	  var qa_id = $(".qa_num").val();
	  var param = { qa_id : qa_id }; // 글 번호
		
      var resultCallback = function(data) {
         fDeleteDtlCodResult(data);
      };
     
      callAjax("/qanda/deleteQna.do", "post", "json", true, param, resultCallback);
   }
   
   
   /** 상세코드 삭제 콜백 함수 */
   function fDeleteDtlCodResult(data) {
      
      var currentPage = $("#currentPageComnDtlCod").val();
      
      if (data.result == "SUCCESS") {
         
         // 응답 메시지 출력
         alert(data.resultMsg);
         
         // 모달 닫기
         gfCloseModal();
         
         // 그룹코드 목록 조회
         var grp_cod = $("#tmpGrpCod").val();
         var grp_cod_nm = $("#tmpGrpCodNm").val();
         fListComnDtlCod(currentPage, grp_cod, grp_cod_nm);
         
      } else {
         alert(data.resultMsg);
      }   
   }
   
   /** 댓글 등록 */
   function fSaveDtlCod() {

      var qna_rv = $("#qnaRv").val(); // 댓글 내용
      var qa_num = $("#qa_num").val(); // 글 번호
      
      var param = { qna_rv : qna_rv
    		 		    ,qa_num : qa_num };
      
      var resultCallback = function(data) {
         fSaveDtlCodResult(data);
      };
      
      callAjax("/qanda/insertQnaRv.do", "post", "json", true, param , resultCallback);
      
   }
   
   
   /** 댓글 등록 콜백 */
   function fSaveDtlCodResult(data) {
      
      // 목록 조회 페이지 번호
      var currentPage = "1";
      if ($("#action").val() != "I") {
         currentPage = $("#currentPageComnDtlCod").val();
      }
      
      if (data.result == "SUCCESS") {
         // 응답 메시지 출력
         alert(data.resultMsg);
         
         //location.reload();
         // 모달 닫기
         gfCloseModal();
         
         // 목록 조회
         var grp_cod = $("#tmpGrpCod").val();
         var grp_cod_nm = $("#tmpGrpCodNm").val();
         //fListComnDtlCod(currentPage, grp_cod, grp_cod_nm);
         
       	 var qa_id = $(".qa_num").val();
         fSelectGrpCod(qa_id);
         
      } else {
         // 오류 응답 메시지 출력
         alert(data.resultMsg);
      }
      
      // 입력폼 초기화
      fInitFormDtlCod();
   }
   
   /** 상세코드 목록 조회 */
   function fListComnDtlCod(currentPage, grp_cod, grp_cod_nm) {
      
      currentPage = currentPage || 1;
      
      // 그룹코드 정보 설정
      $("#tmpGrpCod").val(grp_cod);
      $("#tmpGrpCodNm").val(grp_cod_nm);
      
      var param = {
               grp_cod : grp_cod
            ,   currentPage : currentPage
            ,   pageSize : pageSizeComnDtlCod
      }
      
      var resultCallback = function(data) {
         flistDtlCodResult(data, currentPage);
      };
      
      callAjax("/qanda/exchangeQnaList.do", "post", "text", true, param, resultCallback);
   }
   
   
   /** 상세코드 조회 콜백 함수 */
   function flistDtlCodResult(data, currentPage) {
      
      // 기존 목록 삭제
      $('#listComnDtlCod').empty(); 
      
      var $data = $( $(data).html() );

      // 신규 목록 생성
      var $listComnDtlCod = $data.find("#listComnDtlCod");      
      $("#listComnDtlCod").append($listComnDtlCod.children());
      
      // 총 개수 추출
      var $totalCntComnDtlCod = $data.find("#totalCntComnDtlCod");
      var totalCntComnDtlCod = $totalCntComnDtlCod.text(); 
      
      // 페이지 네비게이션 생성
      var grp_cod = $("#tmpGrpCod").val();
      var grp_cod_nm = $("#tmpGrpCodNm").val();
      var paginationHtml = getPaginationHtml(currentPage, totalCntComnDtlCod, pageSizeComnDtlCod, pageBlockSizeComnDtlCod, 'fListComnDtlCod', [grp_cod]);
      $("#comnDtlCodPagination").empty().append( paginationHtml );
      
      // 현재 페이지 설정
      $("#currentPageComnDtlCod").val(currentPage);
   }
   
   /* 	$(document).on("click", "#deleteQna2", function(){
	var qa_id = $("#qanum").val();
	console.log("넘넘"+$qa_id);
	
	alert(qa_id);
	location.href="/qanda/deleteQna.do";
	});  */

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">
	<!-- 글번호 저장 HIDDEN -->
	<input type="hidden" id="qa_num" class="qa_num" value="">
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3>
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">시스템 관리</a>
							<span class="btn_nav bold">공통코드 관리</span>
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>QnA</span> <span class="fr">
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
								    <option value="all" id="option1" selected="selected">전체</option>
									<option value="lec_nm" id="option1">글제목</option>
									<option value="stuent_nm" id="option2">작성자</option>
								</select> 
								<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fListstudent()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="3%">
									<col width="20%">
									<col width="10%">
									<col width="5%">
									<col width="3%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">글제목</th>
										<th scope="col">작성일</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
					
						<!-- qna 글 작성 버튼 영역 -->
						<a href="" class="btnType blue insertBtn" id="btnInsertDtlCod" name="btn" style="float: right; margin: 10px 24px;">
							<span>작성</span>
						</a> 
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		
		<div class="hidden"></div>
		<dl>
			<dt>
				<strong>Q&A</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">글제목</th>
							<td colspan="3"><span  class="inputTxt p100 qa_bod_tit" id="bod_tit" ></span></td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td><span  class="inputTxt p100" id="bod_name" ></span></td>
							<th scope="row">등록일</th>
							<td><span  class="inputTxt p100" id="regdate" ></span></td>
						</tr>
						<tr>
							<td colspan="4">
								<div  class="inputTxt p100 qa_bod_con" id="bod_con"></div>
							</td>
						</tr>
						
						<!-- 글 작성자 일때 버튼 생성 -->
						<tr id="changeArea">
							<td colspan="4" align="center" >
								<a href="" class="btnType blue"  id="btnUpdate" name="btn"><span>수정</span></a> 
								<a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a>
							</td>
						</tr>
					</tbody>
				</table>
				
				<br><br>
				
				<!-- 댓글 테이블 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
					</colgroup>

					<tbody class="re_body">
						<tr>
							<th scope="row">댓글작성자</th>
							<th scope="row">댓글내용</th>
							<th scope="row">댓글작성일</th>
						</tr>
						<tr><!-- 댓글 부분--></tr>
					</tbody>
				</table>
				
				<input type="text"  id="qnaRv" style="height: 28px; width: 430px;">
				<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn" ><span>작성</span></a>
				
				<!-- e : 여기에 내용입력 -->
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	

	<!-- QNA 입력폼(등록,수정) -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>Q&A 작성</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="80px">
						<col width="*">
						<col width="80px">
						<col width="*">
					</colgroup>
				
					<tbody>
						<tr>
							<th scope="row">글제목</th>
							<td><input type="text" class="inputTxt p100 qa_bod_tit" id="qa_bod_tit" name="qa_bod_tit" /></td>
							<th scope="row">글작성자</th>
							<td>${userNm}</td>
						</tr>
						<tr>
							<th scope="row">글내용</th>
							<td colspan="3">
								<textarea class="inputTxt qa_bod_con" id="qa_bod_con" name="qa_bod_con" style="resize: none; height: 200px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>


				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="updateBtn"><span id="">수정</span></a>
					<a href="" class="btnType blue" id="insertBtn"  name="btn"><span id="">저장</span></a>
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업(qna등록폼) -->
	
</form>
</body>
</html>