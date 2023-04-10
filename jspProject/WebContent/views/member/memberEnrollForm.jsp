<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.outer {
	background-color: black;
	color: white;
	width: 1000px;
	margin: auto;
	margin-top: 50px;
}

#enroll-form table {
	margin: auto;
}

#enroll-form input {
	margin: 5px;
}
</style>
</head>
<body>
	
	<%@ include file="../common/menubar.jsp" %>
	<!-- ../ : 상위폴더로(현재 폴더벗어나기-상위로 한번) -->
	<div class="outer">
	
		<br>
		<h2 align="center">회원 가입</h2>
		<!-- menubar에 선언해놓은 변수 사용 가능  -->
		<form action="<%=contextPath %>/insert.me" method="post" id="enroll-form">

			<!-- table>(tr>td*3)*8 -->
			<table>
				<tr>
					<td>* 아이디</td>
					<td><input type="text" name="userId" maxlength="12" required></td>
					<td><button>중복확인</button></td>
				</tr>
				<tr>
					<td>* 비밀번호</td>
					<td><input type="password" name="userPwd" maxlength="15"
						required></td>
					<td></td>
				</tr>
				<tr>
					<td>* 비밀번호 확인</td>
					<td><input type="password" id="chkPwd" maxlength="15" required></td>
					<td></td>
				</tr>
				<tr>
					<td>* 이름</td>
					<td><input type="text" name="userName" required></td>
					<td></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="phone" placeholder="-포함해서 입력"></td>
					<td></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email"></td>
					<td></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address"></td>
					<td></td>
				</tr>
				<tr>
					<td>관심분야</td>
					<td colspan="2">
						<!-- (input[type=checkbox name=interest id= value=]+label)*6 --> <input
						type="checkbox" name="interest" id="sports" value="운동"> <label
						for="sports">운동</label> <input type="checkbox" name="interest"
						id="movies" value="영화감상"> <label for="movies">영화감상</label>
						<input type="checkbox" name="interest" id="board" value="보드타기">
						<label for="board">보드타기</label> <br> <input type="checkbox"
						name="interest" id="cook" value="요리"> <label for="cook">요리</label>
						<input type="checkbox" name="interest" id="game" value="게임">
						<label for="game">게임</label> <input type="checkbox"
						name="interest" id="book" value="독서"> <label for="book">독서</label>
					</td>
				</tr>
			</table>

			<br>
			<br>

			<div align="center">
				<button type="submit">회원가입</button>
				<button type="reset">초기화</button>
			</div>

		</form>


		<br>
		<br>
		<br>
	</div>
</body>
</html>