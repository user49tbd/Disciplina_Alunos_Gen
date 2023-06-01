<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
.sb {
  top: 50px;
  height: 100%;
  width: 0px;
  position: fixed;
  overflow-x: hidden;
  transition: 0.5s;
  background-color: gray;
  left: 0;
}
#bl{
  width: 250px;
  top: 0px;
  position: fixed;
  overflow-x: hidden;
  transition: 0.5s;
  background-color: gray;
  font-size: 50px;
  border: none;
  color: white;
  left: 0;
}
.sb a{
	display: block;
}
.sb .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}
body{
	Color:white;
	background-image: url("./resources/opt03img.jpg");
	background-repeat: repeat-y;
	background-size: 100% 700px;
}
b{
	font-size:120px;
	border-bottom: 2px solid white;
}
a{
	text-decoration:none;
	color: white;
	padding:10px;
	background-color: none;
	transition:background-color 2s;
}
a:hover{
	background-color: white;
   	color: orange;
}
</style>
</head>
<body>
<button id= "bl" onclick="openN()">MENU</button> 
<div id="SB" class="sb" align="center">
  	<a href="#" class="closebtn" onclick="closeN()">X</a>
	<a href="index">Home</a>
	<a href="statusFaltas">Status Faltas | Notas</a>
	<a href="isrNota">Inserir Nota</a>
	<a href="isrFaltas">Inserir Faltas</a>
	<a href="GenPDF">Gerar PDF</a>
</div>
<script>
function openN() {
  document.getElementById("SB").style.width = "250px";
}

function closeN() {
  document.getElementById("SB").style.width = "0";
}
</script>
</body>
</html>