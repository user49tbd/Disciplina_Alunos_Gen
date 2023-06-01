<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
#v1{
	background-color: red;
}
#ye{
	background-color: yellow;
}
</style>
</head>
<body>
<jsp:include page="menu.jsp"></jsp:include>
<div align="center"><p>Status Faltas/Notas</p></div>
<br>
<div align="center">
<form action="statusFaltas" method="get">
<table>
<tr>
<td>Disciplina</td>
<td>
<select name="sd" id="sd" required onchange="this.form.submit()">
<option value=""><c:out value=""></c:out></option>
<c:forEach items="${ld}" var="l">
<c:if test="${not empty ldslc}">
<c:if test="${l.nome eq ldslc }">
<option value="${l.nome}" selected="selected">
<c:set var="vl" value="${l.tpav}"></c:set>
<c:out value="${l.nome}"></c:out></option>
</c:if>
<c:if test="${l.nome ne ldslc}">
<option value="${l.nome}"><c:out value="${l.nome}"></c:out></option>
</c:if>
</c:if>
<c:if test="${empty ldslc }">
<option value="${l.nome}"><c:out value="${l.nome}"></c:out></option>
</c:if>
</c:forEach>
</select>
</td>
<td>Turno</td>
<td>
<select name="sdt" id="sdt" required>
<option value=""><c:out value=""></c:out></option>
<c:forEach items="${ldt}" var="l">
<c:if test="${not empty ldslc}">
<c:if test="${l.nome eq ldslc }">
<option value="${l.turno}" selected="selected"><c:out value="${l.turno}"></c:out></option>
</c:if>
</c:if>
</c:forEach>
</select>
</td>
<td>
<input id="btBusc" name="btBusc" type="submit" value="Buscar Faltas">
</td>
<td>
<input id="btBuscN" name="btBuscN" type="submit" value="Buscar Notas">
</td>
</tr>
</table>
</form>
</div>
<br>
<div align="center">
<c:if test="${not empty ldf }">
<table border="1">
<thead>
<tr><th>RA</th>
<th>Nome</th>
<c:forEach items="${datad}" var="data">
<th><c:out value="${data }"></c:out>
</th>
</c:forEach>
<th>Total Faltas</th>
</tr>
</thead>
<tbody>
<c:forEach items="${ldf}" var="lstdf">

<c:if test="${lstdf.lmtF lt lstdf.totalF}">
<tr id="v1">
</c:if>
<c:if test="${lstdf.lmtF ge lstdf.totalF}">
<tr id="">
</c:if>
<td><c:out value="${lstdf.ra }"></c:out></td>
<td><c:out value="${lstdf.nome }"></c:out></td>
<c:forEach items="${lstdf.faltas}" var="fts">
<td><c:out value="${fts}"></c:out></td>
</c:forEach>
<td><c:out value="${lstdf.totalF}"></c:out></td>
</c:forEach>
</tbody>
</table>
</c:if>
</div>
<br>

<div align="center">
<c:if test="${not empty notas }">
<table border="1">
<thead>
<tr><th>RA</th>
<th>Nome</th>
<c:set var="v1" value="1"></c:set>
<c:set var="v2" value="2"></c:set>
<c:set var="v3" value="3"></c:set>
<c:set var="v4" value="4"></c:set>
<c:if test="${vl == v1 || vl == v2 || vl == v3}">
<th>P1</th>
<th>P2</th>
<c:if test="${vl eq v3}">
<th>P3</th>
</c:if>
<c:if test="${vl ne v3}">
<th>T</th>
</c:if>
</c:if>
<c:if test="${vl eq v4}">
<th>Monografia Resumida</th>
<th>Monografia Completa</th>
</c:if>
<th>Exame</th>
<th>Media</th>
<th>Situacao</th>
</thead>
<tbody>
<c:forEach items="${notas}" var="lstnt">

<c:if test="${lstnt.situacao eq 'REPROVADO'}">
<tr id="v1">
</c:if>
<c:if test="${lstnt.situacao eq 'EXAME'}">
<tr id="ye">
</c:if>
<c:if test="${lstnt.situacao eq 'APROVADO' or lstnt.situacao eq 'EM CURSO'}">
<tr>
</c:if>
<td><c:out value="${lstnt.ra }"></c:out></td>
<td><c:out value="${lstnt.nome }"></c:out></td>
<td><c:out value="${lstnt.nt1}"></c:out></td>
<td><c:out value="${lstnt.nt2}"></c:out></td>

<c:if test="${vl ne 4}">
	<td><c:out value="${lstnt.nt3}"></c:out></td>
</c:if>
<td><c:out value="${lstnt.exm}"></c:out></td>
<td><c:out value="${lstnt.fnt}"></c:out></td>
<td><c:out value="${lstnt.situacao}"></c:out></td>
</c:forEach>
</tbody>
</table>
</c:if>
</div>











</body>
</html>