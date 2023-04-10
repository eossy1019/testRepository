<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import= "java.util.ArrayList,com.kh.board.model.vo.Board,com.kh.common.model.vo.PageInfo"%>
<%
	
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.list-area{
		border:1px solid white;
		text-align:center;
	}
	.list-area>tbody>tr:hover{
		background-color:gray;
		cursor:pointer; 
	}

</style>

</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		<h1 align="center">일반 게시판</h1>
		<br><br>
		<%if(loginUser!=null) {%>
		<div align="center">
			<a href="<%=contextPath %>/insert.bo" class="btn btn-info">글작성</a>
		</div>
		<%} %>
		<br>
		<table align="center" class="list-area">
			<thead>
				<tr>
					<th width="70">글번호</th>
					<th width="70">카테고리</th>
					<th width="300">제목</th>
					<th width="100">작성자</th>
					<th width="50">조회수</th>
					<th width="100">작성일</th>
				</tr>	
			</thead>
			<tbody>
			<%if(list.isEmpty()){ %> <!-- 조회한 목록이 비어있다면 -->
				<tr>
					<td colspan="6">조회된 게시글이 없습니다.</td>
				</tr>
			<%}else{ %><!-- 게시글이 담겨있다면  -->
				
				<%for(Board b : list) {%>
				 	<tr>
					 	<td><%=b.getBoardNo() %></td> 
						<td><%=b.getCategory() %></td>
						<td><%=b.getBoardTitle() %></td>
						<td><%=b.getBoardWriter() %></td>
						<td><%=b.getCount() %></td>
						<td><%=b.getCreateDate() %></td>
				 	</tr>
				<%} %>
			<%} %>
<!-- 				<tr> -->
<!-- 					<td>1</td> -->
<!-- 					<td>운동</td> -->
<!-- 					<td>운동하러가실분 모집합니다.(걷기,숨쉬기)</td> -->
<!-- 					<td>user01</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>2010-05-05</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>5</td> -->
<!-- 					<td>요리</td> -->
<!-- 					<td>제가 만든 참치꽁치돼지김치찌개 드실분</td> -->
<!-- 					<td>cookingman123</td> -->
<!-- 					<td>5</td> -->
<!-- 					<td>2021-04-21</td> -->
<!-- 				</tr> -->
			</tbody>
			
		</table>
		<script>
			$(function(){
				$(".list-area>tbody>tr").click(function(){
					//글번호 추출
					//console.log($(this).children().eq(0).text());		
					var bno = $(this).children().eq(0).text();
					location.href="<%=contextPath%>/detail.bo?bno="+bno;
					
				});
			});
		
		</script>
		
		
		<br><br>
		
		<div align="center" class="paging-area">
			<%if(pi.getCurrentPage()!= 1){ %>
				<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()-1%>'">&lt;</button>
			<%} %>
			
			<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++ ){ %>
				<!-- 내가 보고있는 페이지 버튼은 비활성화 하기  -->
				<%if(i != pi.getCurrentPage()){ %>
					<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=i%>';"><%=i %></button>
				<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같다면 i와 currentPage -->
					<button disabled><%=i %></button>
				<%} %>
			<%} %>
			
			<%if(pi.getCurrentPage() != pi.getMaxPage()){ %>
				<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()+1%>'">&gt;</button>
			<%} %>
		</div>
		
		
	</div>
	
		
</body>
</html>