<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge" />
<title>과제관리리스트</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>

	// 과제관리 페이지 설정
	var lsmPageSize = 5;
	var lsmPageBlockSize = 5;
	
	$(function(){ 
		
		
		
		
		
		
		
		
	});
	
	
	function selectLsmList(currentPage){
		
			currentPage = currentpage || 1;
		
			var param = {
					currentPage : currentPage,
					pageSize : lsmPageSize
			}
			
			var resultCallback = function(data){
				lsmListResult(data, currentPage);
			}
		
			callAjax("/","post","text",true,param,resultCallback);
			
			// async 응답이 올때까지 기다리지 않는다.
			// sync 응답이 올때까지 기다린다.
			
		
	}
	


</script>
</head>
<body>






</body>
</html>