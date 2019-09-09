<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
	img{
		width: 100px;
		
	}
	table {
	border: 1px solid;
	border-collapse: collapse;
	}
	th,td{
		border: 1px solid;
		padding: 10px;
	}
</style>
</head>
<body>
	<button id="btn-text">문서내용 불러오기</button>
	<div id="result"></div>
	<script>
		$(function(){
			$("#btn-text").click(function(){
				$.ajax({
					url:"sampleData.txt",
					dataType:"text", //text,html,script,xml,json
					type:"get",  //get,post
					success:function(data){ //매개변수에 응답값이 대입됨
						$("#result").html(data); //필요한 속성값만 적으면 된다.
					}
				});
			});
		});
	</script>
	
	<button id="btn-html">html불러오기</button>
	<div id="html-container"></div>
	<script>
		$(function(){
			$("#btn-html").click(function(){
				$.ajax({
					url:"<%=request.getContextPath()%>/js/html",
					type:"get",
					dataType:"html",
					success:function(data){
						$("#html-container").html(data);
					}
				});
			});
		});
	</script>
	
	
</body>
</html>