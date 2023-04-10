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

#mypage-form table {
	margin: auto;
}

#mypage-form input {
	margin: 5px;
}

#changePwd,#deleteForm{
	color : black;
}

</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>
	<!-- 해당 페이지에 있는 변수 사용하려면 include가 더 위에 있어야한다. -->
	<%
		String userId = loginUser.getUserId();
		String userName = loginUser.getUserName();
		String phone = (loginUser.getPhone() == null) ? "" : loginUser.getPhone();
		String email = (loginUser.getEmail() == null) ? "" : loginUser.getEmail();
		String address = (loginUser.getAddress() == null) ? "" : loginUser.getAddress();
		String interest = (loginUser.getInterest() == null) ? "" : loginUser.getInterest();
	//운동,게임,요리
	%>

	<!-- ../ : 상위폴더로(현재 폴더벗어나기-상위로 한번) -->
	<div class="outer">

		<br>
		<h2 align="center">마이 페이지</h2>
		<!-- menubar에 선언해놓은 변수 사용 가능  -->
		<form action="<%=contextPath%>/update.me" method="post"
			id="mypage-form">

			<!-- table>(tr>td*3)*8 -->
			<table>
				<tr>
					<td>* 아이디</td>
					<!-- 수정을 막기 위해 readonly 속성부여(읽기전용) -->
					<td><input type="text" name="userId" maxlength="12"
						value="<%=userId%>" readonly required></td>
					<td></td>
				</tr>
				<tr>
					<td>* 이름</td>
					<td><input type="text" name="userName" value="<%=userName%>"
						required></td>
					<td></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="phone" value="<%=phone%>"
						placeholder="-포함해서 입력"></td>
					<td></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" value="<%=email%>"></td>
					<td></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address" value="<%=address%>"></td>
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
			<script>
				$(function(){
					var interest = "<%=interest%>";
					//해당요소 순차적으로 접근하기 
					//console.log(interest);
					$("input[type=checkbox]").each(function() {
						//로그인된 사용자의 interest에 있는 요소가 있다면 checked하기 
						//영화감상,운동,독서
						//일치하지 않으면 (찾지못하면) -1을 반환한다 찾으면 해당 인덱스 반환
						//선택한 요소를 찾아주려면 -1이 아닌경우를 찾으면 된다.
						//console.log(interest.search($(this).val()));
						//console.log($(this).val());
						if (interest.search($(this).val()) != -1) {
							//일치하는 요소 체크하기
							$(this).attr("checked", true);
						}
					});
				});
			</script>

			<br> <br>

			<div align="center">
				<button type="submit" class="btn btn-info">정보변경</button>
				<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#changePwd">비밀번호 변경</button>
				<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteForm">회원 탈퇴</button>
			</div>

		</form>

		<!-- 비밀번호 변경 모달영역 -->
		<div class="modal" id="changePwd">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">비밀 번호 변경</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body" align="center">
						<!-- 현재 비밀번호,변경할 비밀번호,변경할 비밀번호 재입력 -->
						<form action="<%=contextPath%>/updatePwd.me" method="post">
							<!-- 폼태그안에 데이터 숨겨서 보내기 -->
							<input type="hidden" name="userId" value="<%=userId%>">
							<table>
								<tr>
									<td>현재 비밀번호 </td>
									<td><input type="password" name="userPwd" required></td>
								</tr>
								<tr>
									<td>변경할 비밀번호 </td>
									<td><input type="password" name="updatePwd" required></td>
								</tr>
								<tr>
									<td>변경할 비밀번호 확인</td>
									<td><input type="password" id="chkPwd" required></td>
								</tr>
							</table>
							<br>
							
							<button type="submit" class="btn btn-info"onclick="return validate();">비밀번호 변경</button>
							
						</form>	
						
						<script>
							function validate(){
								var loginPwd = "<%=loginUser.getUserPwd()%>";
								var inputPwd = $("input[name=userPwd]").val();
								var updatePwd = $("input[name=updatePwd]").val();
								var chkPwd = $("#chkPwd").val();
								
								if(loginPwd == inputPwd){
									if(updatePwd != chkPwd){
										alert("변경할 비밀번호와 확인이 일치하지 않습니다.");
										$("input[name=updatePwd]").select();
										return false;
									}
								}else{
									alert("현재 비밀번호가 일치하지 않습니다.");
									$("input[name=userPwd]").focus();
									return false;
								}
							}
						</script>
						
					</div>


				</div>
			</div>
		</div>
		
		
		<!-- 회원 탈퇴 모달영역 -->
		<div class="modal" id="deleteForm">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">회원 탈퇴</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body" align="center">
						<b>탈퇴 후 복구가 불가능 합니다. <br>
							정말로 탈퇴하시겠습니까?
						</b>
						<form action="<%=contextPath %>/delete.me" method="post">
							<input type="hidden" name="userId" value="<%=userId%>">
						
							<table>
								<tr>
									<td>비밀번호</td>
									<td><input type="password" name="userPwd" required></td>
								</tr>
							
							</table>
							<button type="submit" class="btn btn-danger">탈퇴하기</button>
						
						</form>
						
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>


		<br> <br> <br>
	</div>
</body>
</html>