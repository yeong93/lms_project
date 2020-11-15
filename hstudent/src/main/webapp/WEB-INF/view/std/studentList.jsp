<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 과정 페이징 설정
	var pageSizeStudent = 15;
	var pageBlockSizeStudent = 5;
	
	var svm;
	var vm;
	var cvm;
	var unstsearch = true;;
	
	/** OnLoad event */ 
	$(document).ready(function() {
	    
		init();
		
		// 강의목록 조회
		fListstudent();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveCourse' :
					fSaveCourse();
					break;
				case 'btnDeleteCourse' :
					fcourseformdel();
					break;
				case 'btnCloseCourse' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function init() {
		
		//변수에 넣어서 가져다 쓰기 위해서 변수를 사용한거다.
		svm = new Vue({
		                           el: '#searcharea',  
		                         data: {
		                        	      searchKey : 'all'
		                        	     ,searchWord : ''		                        	    
		                               }
		            });
	    
		vm = new Vue({
			  el: '#divStudentList',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: []
			   ,loginid: ''
			  },
			  methods:{					
				  rowClicked:function(row){
					  
					  var tdArr = new Array(); // 배열
						
					  //현재 클릭된 Row(<tr>)
					  var tr = $(row);
					  var td = tr.children();
					
					  td.each(function(i){
						tdArr.push(td.eq(i).text());
					  });
					
					  console.log(tdArr);
					  
					  //console.log("tdArr[0] : " + tdArr[0]);
					  
					  this.loginid = tdArr[0];
					  
					  fselectstudent();
					  
					  
	                  //console.log(" 값 : "+this.loginid);	 
				  },  			  
				  coursemod:function(no){					  
					  fcoursesel(no);	
				  },
				  coursedel:function(no,scnt){					  
					  if(scnt > 0 || stvm.items.length > 0) {
						  alert("수강중인 학생이 있어  삭제 불가 합니다.");
					  } else {
						  // fcoursedel(no); 
					  }
				  }
			  }
			});	  		
		
		cvm = new Vue({
			  el: '#layer1',
			  data: {
		        no: '' 
		       ,title: ''
			   ,teacher: '' 
			   ,room: '' 
			   ,startdate: '' 
			   ,enddate: ''
			  }
			});	
		
		//$("#startdate").datepicker({defaultDate: $.datepicker.formatDate('yyyy.mm.dd', new Date())});
		$("#enddate").datepicker({defaultDate: $.datepicker.formatDate('yyyy.mm.dd', new Date())});
		$("#startdate").datepicker({ dateFormat: 'yyyy.mm.dd' }).bind("change",function(){
            var minValue = $(this).val();
            minValue = $.datepicker.parseDate("yyyy.mm.dd", minValue);
            minValue.setDate(minValue.getDate()+1);
            $("#enddate").datepicker( "option", "minDate", minValue );
        });
		
		
	};	
	
	
	/** 학생 조회 */
	function fListstudent(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage + " svm.searchKey : " + svm.searchKey + " svm.searchWord : " + svm.searchWord);
		
		var param = {
					currentPage : currentPage
				,	pageSize : pageSizeStudent
				,   searchKey : svm.searchKey
				,   searchWord : svm.searchWord
		}
		
		var resultCallback = function(data) {
			flistStudentResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/std/liststudent.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 학생 조회 콜백 함수 */
	function flistStudentResult(data, currentPage) {
		
		//alert(data);
		console.log(data);
		
		vm.items=[];
		vm.items=data.listStudent;		
		
		// 총 개수 추출
		var totalCntCourse = data.totalCount;

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntCourse, pageSizeStudent, pageBlockSizeStudent, 'fListstudent');
		
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#studentPagination").empty().append( paginationHtml );
		
		$("#currentPagestudent").val(currentPage);
		
	}
	
	/** 과정 한건  조회 */
	function fselectstudent() {		
		
		var param = {
					loginid : vm.loginid
		}
		
		var resultCallback = function(data) {
			fstudentselResult(data);
		};
		//Ajax실행 방식
		callAjax("/cur/studentsel.do", "post", "json", true, param, resultCallback);
	}
	
	/** 과정 한건  조회 콜백 함수 */
	function fstudentselResult(data) {
		
		console.log("11111111111111 : " + JSON.stringify(data));
		//console.log("22222222222222 : " + JSON.stringify(data.courseinfo));
		//fInitFormCourse(data.studentinfo);
	}	
	
	
	/** 과정 폼 초기화 */
	function fInitFormCourse(object) {
		$("#title").focus();
		
		if( object == "" || object == null || object == undefined) {
			cvm.no = "";
			cvm.title = "";
			cvm.teacher = ""; 
			cvm.room = ""; 
			cvm.startdate = ""; 
			cvm.enddate = "";
			
			$("#title").css("background", "#FFFFFF");
			$("#title").focus();
			$("#btnDeleteCourse").hide();
			
			$("#delCourseno").val("");
			$("#Coursestudent").val("");
			$("#action").val("I");
			
		} else {
			
			cvm.no = object.no;
			cvm.title = object.title;
			cvm.teacher = object.teacher; 
			cvm.room = object.room; 
			cvm.startdate = object.startdate; 
			cvm.enddate = object.enddate;
			
			$("#title").css("background", "#F5F5F5");
			$("#title").focus();
			$("#btnDeleteCourse").show();
			
			$("#delCourseno").val(object.no);
			$("#Coursestudent").val(object.scnt);
			
			$("#action").val("U");
			
			
		}		
		// 모달 팝업
		gfModalPop("#layer1");
	}
	
	function fPopModalcourse() {
		fInitFormCourse();		
	}
	
	/** 과정 저장 */
	function fSaveCourse() {

		// vaildation 체크
		if ( ! fValidateCourse() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveCourseResult(data);
		};
		
		callAjax("/cur/saveCourse.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	

	/** 과정 삭제, 저장 콜백 함수 */
	function fSaveCourseResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageCourse").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
			
			// 입력폼 초기화
			fInitFormCourse();			
			
			// 모달 닫기
			gfCloseModal();
			
			stvm.items=[];
			
			// 목록 조회
			fListcourse(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}	
	
	/** 과정 한건  삭제 */
	function fcoursedel(no) {
		
		console.log("fcoursesel  no : " + no);
		
		var param = {
					no : no
		}
		
		var resultCallback = function(data) {
			fSaveCourseResult(data);
		};
		//Ajax실행 방식
		callAjax("/cur/coursedel.do", "post", "json", true, param, resultCallback);
	}
	
	/** 과정 폼 한건  삭제 */
	function fcourseformdel(no) {
		
		var delno = $("#delCourseno").val();
		var scnt = $("#Coursestudent").val();
		
		//console.log("delno " + delno + "scnt " + scnt)
		
		//if(scnt > 0) {
		if(scnt > 0 || stvm.items.length > 0) {
		   alert("수강중인 학생이 있어  삭제 불가 합니다.");
		} else {
		    fcoursedel(delno); 
		}	
		
	}


	/** 과정 저장 validation */
	function fValidateCourse() {

		var chk = checkNotEmpty(
				[
						[ "title", "제목를 입력해 주세요." ]
					,	[ "teacher", "강사를 입력해 주세요" ]
					,	[ "startdate", "시작일자를 입력해 주세요." ]
					,	[ "enddate", "종료일자를 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/** 학생 추가 */
	function fstudentadd(loginid) {
		var no = $("#delCourseno").val();	
		
		var param = {
				no : no
			   ,loginid : loginid	
	    }
	
	    var resultCallback = function(data) {
		    	faddStudentResult(data);
		        };
		        //Ajax실행 방식
	    callAjax("/cur/addstudent.do", "post", "json", true, param, resultCallback);
		
	}

	/** 학생 추가 Callback */
	function faddStudentResult(data) {
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
            
			unstsearch = true;
			
			// 목록 조회
			//fListstudent();
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}		
	
	/** 학생 삭제 */
	function fstudentdel(loginid) {
		var no = $("#delCourseno").val();	
		
		var param = {
				no : no
			   ,loginid : loginid	
	    }
	
	    var resultCallback = function(data) {
		    	fdelStudentResult(data);
		        };
		        //Ajax실행 방식
	    callAjax("/cur/delstudent.do", "post", "json", true, param, resultCallback);
		
	}

	/** 학생 추가 Callback */
	function fdelStudentResult(data) {
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
            
			unstsearch = true;
			
			// 목록 조회
			//fListstudent();
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}		
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentPagestudent" id="currentPageCourse" value="">
	<input type="hidden" name="delCourseno" id="delCourseno" value="">
	<input type="hidden" name="Coursestudent" id="Coursestudent" value="">
	
	
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
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">정보관리</a> <span class="btn_nav bold">이력서 관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="search">

						</p>
						<p class="conTitle" id="searcharea">
							<span>이력서 관리</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
								    <option value="all" id="option1" selected="selected">전체</option>
									<option value="lec_nm" id="option1">과정명</option>
									<option value="stuent_nm" id="option2">학생명</option>
								</select> 
								<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fListstudent()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
								 
							    <a	class="btnType blue" href="javascript:fPopModalstudent();" name="modal"><span>이력서 등록</span></a>
							</span>
						</p>
						
						<div class="divStudentList" id="divStudentList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="20%">
									<col width="15%">
									<col width="40%">
									<col width="5%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">ID</th>
										<th scope="col">성명</th>
										<th scope="col">참여과정명</th>
										<th scope="col">나이</th>										
										<th scope="col">지역</th>
									</tr>
								</thead>
								<tbody id="listCourse">
									<template v-for="(row, index) in items" v-if="items.length">
									<tr onclick="vm.rowClicked(this)">
									    <td>{{ row.loginID }}</td>
										<td>{{ row.name }}</td>
										<td>{{ row.course }}</td>
										<td>{{ row.age }}</td>
										<td>{{ row.addr }}</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="studentPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>강의 관리</strong>
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
							<th scope="row">제목<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="title" name="title" id="title" /></td>
						</tr>
						
						<tr>
							<th scope="row">강사명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="teacher" name="teacher" id="teacher" /></td>
							<th scope="row">강의실 </th>
							<td><input type="text" class="inputTxt p100" v-model="room" name="room" id="room" /></td>							
						</tr>
						<tr>
							<th scope="row">시작일자<span class="font_red">*</span></th>
							<td>
							     <input type="text" class="inputTxt p100" data-date-format='yyyy.mm.dd' v-model="startdate" name="startdate" id="startdate" />
							</td>
							<th scope="row">종료일자 <span class="font_red">*</span></th>
							<td>
							     <input type="text" class="inputTxt p100" data-date-format='yyyy.mm.dd' v-model="enddate" name="enddate" id="enddate" />
							</td>							
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveCourse" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteCourse" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseCourse" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>