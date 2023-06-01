<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
div{
	margin-left: auto;
	margin-right:auto;
	text-align: center;
}
p{
	font-size: 150px;
	color: white;
}
#btg{
	border: 2px solid white;
	font-size:50px;
	color:white;
	background-color: rgba(249, 105,14, 0.4);
	transition: background-color 2s;
}
#btg:hover{
	background-color: rgba(255, 255,255, 0.4);
}
</style>
</head>
<body>
<jsp:include page="menu.jsp"></jsp:include>
<div align="center"><p>Atividade BD-03</p>
<form action="index" method="post">
<input type="submit" id="btg" name="btg" value="Gerar Valores">
</form>
</div>
</body>
</html>