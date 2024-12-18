<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<h1>Spring에서 Ajax 사용하기</h1>
	
	<h3>1.요청시 전달값, 응답 결과 받아보기</h3>
	이름 : <input type="text" id="name"> <br>
	나이 : <input type="number" id="age"> <br>
	
	<button onclick="test1();">전송</button>
	
	<div id="result1"></div>
	
	<script>
		function test1(){
			$.ajax({
				url : "ajax.do",
				data : {
					name : $("#name").val(),
					age : $("#age").val()
				},
				success : function(resultStr){
					$("#result1").text(resultStr);
				},
				error : function(){
					console.log("통신오류");
				}
			});
			
		}
	</script>
	
	
	<h3>2.조회 요청 후 조회된 회원 객체를 받아 출력해보기</h3>
	조회할 회원 번호 : <input type="number" id="userNo">
	<button id="btn">JSONArray 조회</button>
	<button id="btn2">JSONObject 조회</button>
	<br>
	<button id="btn3">JSONObject 테스트</button>
	
	<div id="result2"></div>
	
	<script>
		$("#btn").click(function(){
			
			$.ajax({
				url : "ajax2.do",
				data : {
					userNo : $("#userNo").val()
				},
				success : function(result){
					console.log(result);
					var resultStr = "<ul>"
								  + "<li>이름 : "+result[0]+"</li>"
								  + "<li>나이 : "+result[1]+"</li>"
								  + "<li>아이디 : "+result[2]+"</li>"
								  + "<li>주소 : "+result[3]+"</li>"
								  +"</ul>";
					
				$("#result2").html(resultStr);
					
				},
				error : function(){
					console.log("통신 오류");
				}
				
			});
		});
		
		
		$("#btn2").click(function(){
			
			$.ajax({
				url : "ajax3.do",
				data : {
					userNo : $("#userNo").val()
				},
				success : function(result){
						
					console.log(result);
					
					var resultStr = "<ul>"
								  + "<li>이름 : "+result.name+"</li>"
								  + "<li>나이 : "+result.age+"</li>"
								  + "<li>성별 : "+result.gender+"</li>"
								  + "<li>이메일주소 : "+result.email+"</li>"
								  +"</ul>";
					
				$("#result2").html(resultStr);
					
				},
				error : function(){
					console.log("통신 오류");
				}
				
			});
		});
		
		
		$("#btn3").click(function(){
			
			$.ajax({
				url : "ajax4.do",
				data : {
					userNo : $("#userNo").val()
				},
				success : function(result){
						
					console.log(result);
					
					var resultStr = "<ul>"
								  + "<li>이름 : "+result.name+"</li>"
								  + "<li>나이 : "+result.age+"</li>"
								  + "<li>성별 : "+result.gender+"</li>"
								  + "<li>이메일주소 : "+result.email+"</li>"
								  +"</ul>";
					
				$("#result2").html(resultStr);
					
				},
				error : function(){
					console.log("통신 오류");
				}
				
			});
		});
		
	
	</script>
	
	
	<h3>3.조회 요청 후 조회된 회원 리스트 응답 받아 출력해보기</h3>
	<button id="listBtn">회원 리스트 버튼</button>
	<button id="listBtn2">회원 리스트 버튼2</button>
	<button id="listBtn3">회원 리스트 버튼3</button>
	<br><br>
	
	<table border="1" id="result3">
		<thead>
			<tr>
				<td>이름</td>
				<td>나이</td>
				<td>성별</td>
				<td>이메일주소</td>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
	<script>
		$("#listBtn").click(function(){
			
			$.ajax({
				url : "selectList",
				success : function(result){
					//반환받은 리스트를 tbody에 넣어주기 
					
					var resultStr = "";
					
					for(var i=0; i<result.length;i++){
						resultStr += "<tr>"
									  +"<td>"+ result[i].name + "</td>"
									  +"<td>"+ result[i].age + "</td>"
									  +"<td>"+ result[i].gender +"</td>"
									  +"<td>"+ result[i].email +"</td>"
								  	+"</tr>";
						
					}
					
					//만들어준 tr 넣어주기
					$("#result3 tbody").html(resultStr);
					
					
					
				},
				error : function(){
					console.log("통신 오류");
				}
			});
			
		});
		
		//gson 이용하여 문자열 반환 버튼 
		$("#listBtn2").click(function(){
			
			$.ajax({
				url : "selectList2",
				success : function(result){
					//반환받은 리스트를 tbody에 넣어주기 
					
					var resultStr = "";
					
					for(var i=0; i<result.length;i++){
						resultStr += "<tr>"
									  +"<td>"+ result[i].name + "</td>"
									  +"<td>"+ result[i].age + "</td>"
									  +"<td>"+ result[i].gender +"</td>"
									  +"<td>"+ result[i].email +"</td>"
								  	+"</tr>";
						
					}
					
					//만들어준 tr 넣어주기
					$("#result3 tbody").html(resultStr);
					
				},
				error : function(){
					console.log("통신 오류");
				}
			});
			
		});
		
		
		//gson 이용하여 데이터 타입 그대로 반환 버튼 
		$("#listBtn3").click(function(){
			
			$.ajax({
				url : "selectList3",
				success : function(result){
					//반환받은 리스트를 tbody에 넣어주기 
					
					var resultStr = "";
					
					for(var i=0; i<result.length;i++){
						resultStr += "<tr>"
									  +"<td>"+ result[i].name + "</td>"
									  +"<td>"+ result[i].age + "</td>"
									  +"<td>"+ result[i].gender +"</td>"
									  +"<td>"+ result[i].email +"</td>"
								  	+"</tr>";
						
					}
					
					//만들어준 tr 넣어주기
					$("#result3 tbody").html(resultStr);
					
				},
				error : function(){
					console.log("통신 오류");
				}
			});
			
		});
		
	</script>
	
	
	<h3>ㅎㅎ</h3>
	<button onclick="test1();">눌러</button>
	
	<script type="text/javascript">
		
		function test1(){
			$.ajax({
				url : "test1",
				type : "post",
				data : {
					name : "이름",
					age : 15
				},
				success : function(result){
					
					console.log(result);
				}
			})
		}
	
	</script>
	
	
	
	
	

</body>
</html>