<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import ="com.kh.member.model.vo.Member"%>
<%
	//contextRoot 가져오기	
	String contextPath = request.getContextPath();
	
	//로그인 유저 정보 꺼내오기
	Member loginUser = (Member)session.getAttribute("loginUser");
	//로그인 되어있지 않으면 null(attribute에 loginUser라는 키값에 해당하는 데이터가 없으니까) 
	//로그인이 되어있다면 해당 유저정보가 담긴 Member객체가 반환 
	
	//알림 메세지도 꺼내주기
	String alertMsg = (String)session.getAttribute("alertMsg");
%>
	
	
<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#login-form, #user-info {
	float: right;
}

#user-info a {
	text-decoration: none;
	color: black;
	font-size: 12px;
}

.nav-area {
	background-color: black;
}

.menu {
	display: inline-block; /*인라인 요소처럼 배치*/
	height: 50px;
	width: 150px;
}

.menu a {
	text-decoration: none;
	color: white;
	font-size: 20px;
	font-weight: bold;
	display: block; /*block으로 지정후 width/height 100%하면
                        해당블럭에 꽉차게 설정 가능*/
	width: 100%;
	height: 100%;
	line-height: 50px;
}

.outer {
	background-color: black;
	color: white;
	width: 1000px;
/* 	height: 600px; */
	margin: auto;
	margin-top: 50px;
}
</style>
</head>
<body>
	<script>
		//script태그 내에서도 스크립틀릿과 같은 jsp요소를 사용할 수 있다.
		
		var msg = "<%=alertMsg%>"; //성공적으로 로그인 되었습니다 / null
		
		if(msg !="null"){
			alert(msg);
			//알람메세지 한번 띄웠으면 지워주기 지우지 않으면 매번 menubar.jsp가 열릴때마다 알림뜸
			
			<%session.removeAttribute("alertMsg");%>
			
		}
	</script>



	<h1 align="center">Welcome my web</h1>

	<div class="login-area">

		<!--로그인 전에 보여질 화면-->
		<%if(loginUser == null) {%>
		<form action="/jsp/login.me" method="post" id="login-form">
			<!-- table>(tr>th+td)*2 -->
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="userId" required></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="userPwd" required></td>
				</tr>
				<tr>
					<th colspan="2">
						<button type="submit">로그인</button>
						<button type="button" onclick="enrollPage();">회원가입</button>
					</th>
				</tr>
			</table>
		</form>
		
		<script>
			function enrollPage(){
				//location.href = "<%=contextPath%>/views/member/memberEnrollForm.jsp";
				//웹 애플리케이션의 디렉토리 구조가 그대로 url에 노출되어 보안에 취약해진다.
				//단순 페이지 이동이여도 servlet을 거쳐서 매핑값이 노출되어 갈수있도록 작업하기.
				
				location.href ="<%=contextPath%>/enrollForm.me";
				
			}
		
		</script>
		
		
		
		
		<%}else{ %>
		<!--로그인 후에 보여질 화면-->
		<div id="user-info">
			<b><%=loginUser.getUserName()%>님</b> 환영합니다. <br>
			<br>
			<div align="center">
				<a href="<%=contextPath%>/myPage.me">마이페이지</a> <a href="<%=contextPath%>/logout.me">로그아웃</a>
			</div>
		</div>
		<%} %>
	</div>


	<br clear="both">
	<!--float속성 해제-->
	<br>

	<div class="nav-area" align="center">
		<div class="menu">
			<a href="">HOME</a>
		</div>
		<div class="menu">
			<a href="<%=contextPath%>/list.no">공지사항</a>
		</div>
		<div class="menu">
			<a href="<%=contextPath%>/list.bo?currentPage=1">일반게시판</a>
		</div>
		<div class="menu">
			<a href="<%=contextPath%>/list.ph">사진게시판</a>
		</div>
	</div>
</body>
</html>