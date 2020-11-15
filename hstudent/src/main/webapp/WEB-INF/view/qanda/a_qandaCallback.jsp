<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalCntComnGrpCod">${totalCntComnGrpCod}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">글제목</th>
									<th scope="col">작성일</th>
									<th scope="col">작성자</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody id="listComnGrpCod">
							<c:if test="${totalCntComnGrpCod eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
							<c:forEach items="${qnaList}" var="list">
								<tr>
									<%-- <td>${totalCntComnGrpCod - nRow}</td> --%>
									<%-- <td><a href="javascript:fListComnDtlCod(1, '${list.grp_cod}', '${list.grp_cod_nm}')">${list.grp_cod}</a></td> --%>
									<td>${list.qa_id}</td>
									<%-- <td>${list.bod_tit}</td> --%>
									
									<td><a href="javascript:fPopModalComnGrpCod(${list.qa_id})">${list.bod_tit}</a></td>
									
									<%-- <fmt:formatDate value="${list.regdate}" var="regdate" pattern="yyyy-MM-dd"/> --%>
									<td>${list.regdate}</td>
									
									<td>${list.name}</td>
									<td>${list.hit}</td>
									<%-- <td>
										<a class="btnType3 color1" href="javascript:fPopModalComnGrpCod('${list.grp_cod}');"><span>수정</span></a>
									</td> --%>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
							