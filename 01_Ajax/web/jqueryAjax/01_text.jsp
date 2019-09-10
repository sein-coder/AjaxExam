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
	
	<!-- XML파일 불러오기 -->
	
	<button id="xml-btn">xml파일 불러오기</button>
	<div id="fiction">
		<h3>소설</h3>
		<table id="fictionInfo"></table>
	</div>
	<div id="it">
		<h3>프로그래밍</h3>
		<table id="itInfo"></table>
	</div>
	
	<script>
		$(function(){
			$("#xml-btn").click(function(){
				$.ajax({
					url:"books.xml",
					type:"get",
					dataType:"xml",
					success:function(data){
						console.log(data);
						//1. root element받아오기
						var root = $(data).find(":root");
						console.log(root);
						//2. 하위 태그 찾기
						var bookArr = root.find("book");
						console.log(bookArr);
						var fic="<tr><th>제목</th><th>저자</th></tr>"
						var it="<tr><th>제목</th><th>저자</th></tr>"		
						
						/* 앞에 그룹이나와 주체가되는 객체가 그룹인애 (배열,리스트,객체배열)*/
						/* [1,2,3,4,5] each(함수,어떤 명령) */
						bookArr.each(function(){
							var info = "<tr><td>"+$(this).find("title").text()+"</td>"
							info+="<td>"+$(this).find("author").text()+"</td></tr>";
							if($(this).find("subject").text()=="소설"){
								fic+=info;
								
							}else{
								it+=info;
							}							
						});
						
						$("#fictionInfo").html(fic);
						$("#itInfo").html(it);
					}
				});
			});
		});
	</script>
	
	<h1>JSON으로 자바객체 가져오기</h1>
	<button onclick="ajaxJson();">데이터가져오기!</button>
	
	<div id="json-container"></div>
	
	<script>
		function ajaxJson(){
			$.ajax({
				url:"<%=request.getContextPath()%>/jsonData",
				type:"get", //get이든 post든 무상관
				dataType:"json",
				success:function(data){
					console.log(data);
					
					/*1.번 console.log(data['userNo']);
					console.log(data['userId']);
					console.log(data['userName']);*/
					
					/*2.번 var table = $("<table>");
					var th = "<tr><th>번호</th><th>아이디</th><th>이름</th><th>주소</th><th>키</th><th>flag</th></tr>";
					var tr = "<tr><td>"+data["userNo"]+"</td>"
					+"<td>"+data["userId"]+"</td>"
					+"<td>"+data["userName"]+"</td>"
					+"<td>"+data["userAddr"]+"</td>"
					+"<td>"+data["height"]+"</td>"
					+"<td>"+data["flag"]+"</td></tr>";
					table.append(th).append(tr);
					$("#json-container").html(table); */
					
					var table = $("<table>");
					
					for(var i=0; i<data.length; i++){
						var td = $("<td>").html(data[i]['name']);
						var td2 = $("<td>").html(data[i]['phone']);
						var td3 = $("<td>").html(data[i]['profile']);
						table.append($("<tr>")).append(td).append(td2).append(td3);
					}
					$("#json-container").html(table);
					
				},
				error:function(r,e,m){
					console.log(e);
				}
			});
		}
	
	
	</script>
	
</body>
</html>