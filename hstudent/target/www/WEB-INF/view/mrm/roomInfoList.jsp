<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<body>
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">


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
							<a href="#" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">강의실 관리</span> 
							<a href="#"class="btn_set refresh">새로고침</a>
						</p>
					</div>
					<h3 class="hidden">강의실 검색 영역</h3>
					<div class="room_searchbox">
						<div class="Rserch_input">
						
						</div>
						<div class="Rserch_btn">
						
						</div>
						<div class="Room_register_btn">
						
						</div>
					</div>
					
					<h3 class="hidden">강의실 목록 조회 영역</h3>
					<div class="room_listbox">
						<div class="Rinfo_area">
							<div class="Room_pic">
							
							</div>
							<div class="Room_info">
								<div class="Room_name">
								
								</div>
								<div class="Room_size">
								
								</div>
								<div class="Room_chair">
								
								</div>
							</div>
						</div>
						<!-- /.Rinfo_area -->
						<div class="Rinfo_btn_area">
							<div class="RoomInfor_revise_btn">
							
							</div>
							<div class="Room_delete_btn">
							
							</div>
						</div>
						<!-- /.Rinfo_btn_area -->
						<div class="equipment_listbox">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>품명</th>
										<th>수량</th>
										<th>비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>컴퓨터 본채</td>
										<td>30</td>
										<td></td>
									</tr>
									<tr>
										<td>2</td>
										<td>의자</td>
										<td>35</td>
										<td></td>
									</tr>
									<tr>
										<td>3</td>
										<td>공기청정기</td>
										<td>1</td>
										<td></td>
									</tr>
								</tbody>
							</table>
							<hr>
						</div>
						<!-- /.equipment_listbox -->
						<div class="RList_pagingbox">
						
						</div>
					</div>				
					<!-- /.room_listbox -->
				</li>
			</ul>
		</div>
	</div>


</body>
</html>