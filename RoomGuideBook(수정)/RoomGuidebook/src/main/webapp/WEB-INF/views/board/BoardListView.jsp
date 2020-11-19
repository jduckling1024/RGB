<%@page import="dto.BoardDTO"%>
<%@page import="dto.LikeDTO"%>
<%@page import="dto.ImageDTO"%>
<%@page import="dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@include file="../main/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

<link rel="stylesheet" href="/resources/css/boardList.css">

<script>

ra.addFlashAttribute("boardRegisterResult", "succeeded");
	var result = '${boardRegisterResult}';
	
	if(result == "succeed"){
		alert("게시물 등록이 완료되었습니다.");
	}else if(result = "fail"){
		alert("게시물 등록 중 오류가 발생했습니다.");
	}
</script>
</head>
<body>

	<%-- 	<c:forEach var="list" items="${boardList}">
		<a href = "/getBoard?no=${list.boardId}"><c:out value="${list.boardId} ${list.memberId} ${list.title}"/></a>
	</c:forEach> --%>

	<div class="wrap">
		<div class="top">
			<!-- 			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book</strong>
				</p>

				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a>
						<li class="menu2"><a href="">Community</a>
						<li class="menu3"><a href="">Login</a>
						<li class="menu4"><a href="">Join</a></li>
					</ul>
				</div>
			</div> -->
		</div>


		<div class="middle"></div>
		<div class="container">
		<button onclick="location.href='http://localhost:8080/registerBoardView';">등록</button> <!-- 위치 조정(밑이든 위든)이랑 css 적용 필요할 것 같습니다 -->
			<Table>
				<tr>
					<td class="category">
						<ul>
							<li><input type="text">
							<li><input type="button" class="searchBtn" value="검색">
							<li>
								<form class="box">
									<select>
										<option>최신순</option>
										<option>좋아요많은순</option>
										<option>B</option>
										<option>C</option>
									</select>
								</form>
							</li>

						</ul>
					</td>
				</tr>
			</table>

			<br>
			<div class="board">
				<%
					ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("boardList");

				for (int i = 0; i < list.size(); i++) {
					pageContext.setAttribute("board", (BoardDTO) list.get(i)[0]);
					pageContext.setAttribute("image", (ImageDTO) list.get(i)[1]);
					pageContext.setAttribute("like", (LikeDTO) list.get(i)[2]);
				%>
				<div class="boardThumb">
					<a href="/getBoard?no=${board.boardId}"><ul>
							<li class="userID">${board.memberId}</li>
							<li class="date">${board.date}</li>
							<li><img class="image" src="${image.path}"></li>
							<li class="likeIt">Like it: ${board.likeCnt}</li>
						</ul> </a>
				</div>
				<%
					}
				%>
			</div>
		</div>
		<br>
		<div class="page">
			<%
				int nowPage = (Integer) request.getAttribute("nowPage"); // 현재 페이지 번호
			int boardCnt = (Integer) request.getAttribute("boardCnt"); // 게시물 개수
			int lastId = (Integer) request.getAttribute("lastId"); // 마지막 게시물 번호
			int pages = (lastId - 1) / boardCnt;

			if (pages > 3) {
				pages = 3;
			}
			%>

			<%
				if (nowPage > 1) {
			%>
			<a href="/getBoardList?page=${nowPage-1}">&#60</a>
			<%
				}
			%>

			<%
				for (int i = nowPage; i < nowPage + boardCnt; i++) {
				pageContext.setAttribute("p", i);
				if (lastId >= 1) {
			%>
			<a href="/getBoardList?page=${p}">${p}</a>

			<%
				lastId = lastId - boardCnt;
			} else {
			break;
			}

			}
			%>

			<%
				if (pages > 0) {
			%>
			<a href="/getBoardList?page=${nowPage+1}">&#62</a>
			<%
				}
			%>
		</div>
	</div>

	<br>

	<div class="bottom"></div>



</body>
</html>