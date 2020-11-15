<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="divEmpty">
	<div class="hiddenData">
	    <span id="totalCnt">${totalCnt}</span>
	</div>
	<table class="col">
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
	    <tbody id="teacherList">
	    <c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="9">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
	    <c:set var="nRow" value="${pageSize*(currentPageTeacher-1)}" />
	    <c:forEach items="${teacherListModel}" var="list">
				<tr>
					<td>${totalCnt - nRow}</td>
					<td>${list.th_name}</td>
					<td>${list.th_password}</td>
					<td>${list.loginID}</td>
					<td>${list.th_phone_number}</td>
					<td>${list.th_birthday}</td>
					<td>${list.th_reg_date}</td>
					<td>
					 <a class="btnType3 color1" href="javascript:fRegister('${list.loginID}');">
					 <span>수정</span></a>
					</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach> 
	    </tbody>
 </table>
</div>