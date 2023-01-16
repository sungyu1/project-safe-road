<%@page import="com.smhrd.model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Dimension by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
		<script src="https://kit.fontawesome.com/b163195086.js" crossorigin="anonymous"></script>
	</head>
<body>
	<%
		Member loginMember = (Member)session.getAttribute("loginMember");
	%>

	<!-- Wrapper -->
			<!-- Menu -->
				<nav id="Update">	
						<h2 style="text-align:center">회원정보수정</h2>
							<form action="UpdateCon" method="post">
							<table style="margin: auto; width: 500px;">
								<caption>현재 접속 ID : <%=loginMember.getM_id() %></caption>
								<tr><td><input name="pw" type="password" placeholder="PW를 입력하세요" style="width: 500px; margin: 0 auto;"></td></tr>
								<tr><td><input name="name" type="text" value="<%=loginMember.getM_name() %>" placeholder="전화번호를 입력하세요" style="width: 500px; margin: 0 auto;"></td></tr>
								<tr><td><input name="nickname" type="text" value="<%=loginMember.getM_nick() %>" placeholder="집주소를 입력하세요" style="width: 500px; margin: 0 auto;"></td></tr>
								<tr><td><input type="text" value="<%=loginMember.getM_gender() %>" readonly="readonly"></td></tr>
								<tr><td><input type="text" value="<%=loginMember.getM_age() %>" readonly="readonly"></td></tr>
								<tr><td><input type="submit" value="Edit" class="button fit" style="width: 500px; margin: 0 auto;"></td></tr>
								<tr><td><a href="main.jsp"><input type="button" value="Main" class="button fit" style="width: 500px; margin: 0 auto;"></a></td></tr>
							</table>
							</form>
				</nav>		
						<!-- Footer -->
			<footer id="footer">
				<p class="copyright">&copy; 안.길</p>
			</footer>	
		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
</body>
</html>