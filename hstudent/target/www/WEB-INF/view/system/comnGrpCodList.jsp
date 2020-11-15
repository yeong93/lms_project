<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalCntComnGrpCod">${totalCntComnGrpCod}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">그룹 코드 ID</th>
									<th scope="col">그룹 코드 명</th>
									<th scope="col">사용</th>
									<th scope="col">임시 필드 01</th>
									<th scope="col">임시 필드 01</th>
									<th scope="col">임시 필드 03</th>
									<th scope="col">코드 설명</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody id="listComnGrpCod">
							<c:if test="${totalCntComnGrpCod eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
							<c:forEach items="${listComnGrpCodModel}" var="list">
								<tr>
									<td>${totalCntComnGrpCod - nRow}</td>
									<td><a href="javascript:fListComnDtlCod(1, '${list.grp_cod}', '${list.grp_cod_nm}')">${list.grp_cod}</a></td>
									<td>${list.grp_cod_nm}</td>
									<td>${list.use_poa}</td>
									<td>${list.tmp_fld_01}</td>
									<td>${list.tmp_fld_02}</td>
									<td>${list.tmp_fld_03}</td>
									<td>${list.grp_cod_eplti}</td>
									<td>
										<a class="btnType3 color1" href="javascript:fPopModalComnGrpCod('${list.grp_cod}');"><span>수정</span></a>
									</td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
							