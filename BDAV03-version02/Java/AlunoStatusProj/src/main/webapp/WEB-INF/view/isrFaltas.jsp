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
<div align="center"><p>Inserir Faltas</p></div>
<form action="isrFaltas" method="get">
<div align="center">
<table>
<tr>
<td>
<select name="sd" id="sd" required onchange="this.form.submit()">
<c:forEach items="${alunoM}" var="l">
<c:if test="${not empty gselec}">
<c:if test="${l.ra eq gselec }">
<option value="${l.ra}" selected="selected">
<c:out value="${l.ra}"></c:out></option>
<c:set var="vl" value="${l.nome}"></c:set>
</c:if>
<c:if test="${l.ra ne gselec}">
<option value="${l.ra}"><c:out value="${l.ra}"></c:out></option>
</c:if>
</c:if>
</c:forEach>
</select>
</td>
<td>
<c:if test="${not empty vl}">
<c:out value="${vl}"></c:out>
</c:if>
</td>
<td>
<select name="d" id="d" required onchange="this.form.submit()">
<option value=""></option>
<c:forEach items="${alunoM}" var="l">
<c:if test="${not empty gselec}">
<c:if test="${l.ra eq gselec }">
<c:forEach items="${l.disciplinas}" var="l2">
<c:if test="${l2 eq dsc }">
<option value="${l2}" selected="selected"><c:out value="${l2}"></c:out></option>
</c:if>
<c:if test="${l2 ne dsc }">
<option value="${l2}"><c:out value="${l2}"></c:out></option>
</c:if>
</c:forEach>
</c:if>
</c:if>
</c:forEach>
</select>
</td>
<td><input id="dt" name="dt" type="date" value="${ld}" onchange="this.form.submit()"></td>
<c:out value="${dsc }"></c:out>
<c:if test="${dsc eq 'Laboratorio de Hardware' }">
op1
<td><input id="ipn" name="ipn" min="0" max="2" type="number"></td>
</c:if>
<c:if test="${dsc ne 'Laboratorio de Hardware' }">
op2
<td><input id="ipn" name="ipn" min="0" max="4" type="number"></td>
</c:if>
<td><input id="bt" name="bt" type="submit" value="Inserir"></td>
</tr>
</table>
</div>
<div align="center">
<c:if test="${not empty ldf }">
<table border="1">
<thead>
<tr>
<c:forEach items="${datad}" var="data">
<c:if test="${not empty ld }">
<c:if test="${data eq ld }">
<th id ="v1">
</c:if>
<c:if test="${data ne ld }">
<th>
</c:if>
</c:if>
<c:out value="${data }"></c:out>
</th>
</c:forEach>
<th>Total Faltas</th>
</tr>
</thead>
<tbody>
<c:forEach items="${ldf}" var="lstdf">
<c:if test="${lstdf.ra eq gselec }">
<c:if test="${lstdf.lmtF lt lstdf.totalF}">
<tr id="v1">
</c:if>
<c:if test="${lstdf.lmtF ge lstdf.totalF}">
<tr id="">
</c:if>
<c:forEach items="${lstdf.faltas}" var="fts">
<td><c:out value="${fts}"></c:out></td>
</c:forEach>
<td><c:out value="${lstdf.totalF}"></c:out></td>
</c:if>
</c:forEach>
</tbody>
</table>
</c:if>
</div>
</form>
</body>
</html>