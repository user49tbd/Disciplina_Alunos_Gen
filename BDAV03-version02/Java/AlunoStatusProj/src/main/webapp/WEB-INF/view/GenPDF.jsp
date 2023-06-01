<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="menu.jsp"></jsp:include>
<div align="center"><p>Gerar PDF</p></div>
<div align="center">
<form action="GenPDF" method="post" target="_blank">
<table>
<tr>
<td>DISCIPLINA</td>
<td>
<select name="discL" id="discL" required>
<option value="Arquitetura e Organizacao de Computadores">
<c:out value="Arquitetura e Organizacao de Computadores"></c:out></option>
<option value="Laboratorio de Hardware">
<c:out value="Laboratorio de Hardware"></c:out></option>
<option value="Banco de Dados">
<c:out value="Banco de Dados"></c:out></option>
<option value="Sistemas Operacionais I">
<c:out value="Sistemas Operacionais I"></c:out></option>
<option value="Laboratorio de Banco de Dados">
<c:out value="Laboratorio de Banco de Dados"></c:out></option>
<option value="Metodos Para a Producao do Conhecimento">
<c:out value="Metodos Para a Producao do Conhecimento"></c:out></option>
</select>
</td>
<td>TURNO</td>
<td>
<select name="sdt" id="sdt" required>
<option value="T">
<c:out value="T"></c:out></option>
<option value="N">
<c:out value="N"></c:out></option>
</select>
</td>
</tr>
</table>
<br>
<table>
<tr>
<td><input type="submit" id="bt" name="bt" value="Gerar Relatorio Notas"></td>
<td><input type="submit" id="bt" name="bt" value="Gerar Relatorio Faltas"></td>
</tr>
</table>
</form>
</div>
</body>
</html>