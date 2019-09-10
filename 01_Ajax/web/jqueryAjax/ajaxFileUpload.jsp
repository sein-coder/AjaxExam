<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax로 파일 업로드하기</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
	<input type="file" name="upfile" id="upfile">
	<button id="up-btn">업로드</button>
	<div id="preview">
		
	</div>
	
	<script>
		//사진 미리보기 기능
		$(function(){
			//change이벤트는 value값이 변경되면 실행되는 이벤트
			$("#upfile").change(function(){ //제이쿼리 이벤트 자체가 배열형식을 대상으로 잡혀있다.
				var reader = new FileReader();
				reader.onload = function(e){
					var img = $("<img>").attr({"src":e.target.result}).css({"width":"200px","height":"200px"});
					$("#preview").html(img); 
					//e.target.result 안에 변경된 url데이터가 저장되어있다.
				}
				reader.readAsDataURL($(this)[0].files[0]); //파일리더가 파일을 읽어들여온다.
			});
			$("#up-btn").on("click",function(){
				//ajax를 통한 파일전송을 할떄
				//FormData() 객체를 이용
				var fd = new FormData();
				fd.append("upfile",$("#upfile")[0].files[0]);
				$.ajax({
					url:"<%= request.getContextPath() %>/ajaxFile",
					data:fd,
					type:"post", //무조건 post로 전송
					processData: false,
					contentType:false,
					success : function(data){
						console.log(data);
						$("#preview").html("");
						$("#upfile").val("");
					}
				});
			});
		});
	
	</script>
	
</body>
</html>