<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>vue.js 시자아악</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<body>
	<div id="app">
		<ul>
		
		<li v-for="product in products"><h2>
			{{ product.quantity }} {{product.name}}
			<span v-if="product.quantity === 0">
				-재고없음.
			</span>
			</h2></li>
		</ul>
	</div>

	<script>
const app = new Vue({
		  el: '#app',
		data: {
	products: []
		},
	created(){
		fetch('https://api.myjson.com/bins/74l63')
			.then(response => response.json())
			.then(json => {
				this.products = json.products
			})
	}
})	
</script>
</body>
</html>