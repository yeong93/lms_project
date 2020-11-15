<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalCntComnGrpCod">${totalCountList}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">파일</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody id="listComnGrpCod">
							<c:if test="${totalList eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageNoticeList-1)}" />
							<c:forEach items="${noticeListModel}" var="list">
								<tr>
									<td>${totalList - nRow}</td>
									<td>${list.nt_title}</td>
									<td>${list.enr_user}</td>
									<td>${list.enr_date}</td>
									<td>${list.file_nm}</td>
									<td>${list.nt_cnt}</td>
									<td>
										<a class="btnType3 color1" href=""><span>수정</span></a>
									</td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
							