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
	<!-- csv방식으로 값받아오기 -->
	<button onclick="fn_csv();">csv방식으로 받기</button>
	<div id="csv-container"></div>
	<script>
		//요청주소 /js/csvData
		//방식은 : get방식
		//응답데이터는 TEXT
		function fn_csv(){
			$.ajax({
				url:"<%=request.getContextPath()%>/js/csvData",
				type:"get",
				dataType:"text",
				success:function(data){
					console.log(data);
					var memberArr = data.split("\n"); //박보검,01045631234,parkBogum.jpg\n쥴리아로버츠,01045632244,juliaRoberts.jpg\n맷데이먼,01045634567,mattDamon.jpg
					var table = $("<table>");
					for(var i = 0 ; i<memberArr.length; i++){
						var member = memberArr[i].split(","); //박보검,01045631234,parkBogum.jpg
						var tr = $("<tr>");
						var td = $("<td>").html(member[0]); //이름
						var td2 = $("<td>").html(member[1]); //전화번호
						var td3 = $("<td>").html($("<img>").attr({"src":"<%=request.getContextPath()%>/images/"+member[2]}));
						tr.append(td).append(td2).append(td3);
						table.append(tr);
					}
					console.log(table);
					$("#csv-container").html(table);
				}
			});
		}
	</script>
	
	<!-- 자동검색 -->
	<input type="text" id="search" list="data">
	<list id="data">
		<option value="kim">kim</option>
	<list>
	
	<script>
	$("#search").keyup(function(){
		$.ajax({
			url:"<%=request.getContextPath()%>/search",
			type:"get",
			data:{"key":$(this).val()},
			dataType:"text",
			success:function(data){
				var ids = data.split(",");
				$("#data").html("");
				for(var i=0; i<ids.length; i++){
					var option=$("<option>").attr({"value":ids[i]}).html(ids[i]);
					$("#data").append(option);
				}
			}
		});
	});
	</script>
	
</body>
</html>