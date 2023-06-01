<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
<div align="center"><p>Inserir Notas</p></div>
<form action="isrNota" method="get">
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
</tr>
</table>




</div>



<div align="center">
<c:if test="${not empty dsc }">
<table border="1">
<thead>
<c:forEach items="${ldt}" var="vr">
<c:if test="${vr.nome eq dsc }">
<c:set var="tipo" value="${ vr.tpav}"></c:set>
</c:if>
</c:forEach>
<c:forEach items="${alunoNotasM}" var="alnm">
<c:if test="${alnm.nome eq dsc and alnm.ra eq gselec }">
<c:set var="situation" value="${alnm.situacao}"></c:set>
<c:set var="finalm" value="${alnm.fnt}"></c:set>
<c:set var="alexm" value="${alnm.exm}"></c:set>
</c:if>
</c:forEach>
<c:set var="v1" value="1"></c:set>
<c:set var="v2" value="2"></c:set>
<c:set var="v3" value="3"></c:set>
<c:set var="v4" value="4"></c:set>
<c:if test="${tipo == v1 || tipo == v2 || tipo == v3}">
<th>P1</th>
<th>P2</th>
<c:if test="${tipo eq v3}">
<th>P3</th>
</c:if>
<c:if test="${tipo ne v3}">
<th>T</th>
</c:if>
</c:if>
<c:if test="${tipo eq v4}">
<th>Monografia Resumida</th>
<th>Monografia Completa</th>
</c:if>
<c:if test="${situation ne 'EM CURSO' and
(fn:contains(situation,'REPROVADO') and finalm ge 4) or 
(fn:contains(situation,'APROVADO') and alexm gt 0)
or situation eq 'EXAME'}">
<th>Exame</th>
</c:if>
<c:if test="${situation eq 'EM CURSO' and
(fn:contains(situation,'REPROVADO') and finalm lt 4) or 
(fn:contains(situation,'APROVADO') and alexm eq 0)
or ant.situacao eq 'EXAME'}">
<th hidden>Exame</th>
</c:if>
<th>Media</th>
<th>Situacao</th>
</thead>
<tbody>
<c:forEach items="${alunoNotasM}" var="ant">
<c:if test="${ant.ra == gselec and ant.nome == dsc }">
<c:if test="${fn:contains(ant.situacao,'REPROVADO')}">
<tr id="v1">
</c:if>
<c:if test="${ant.situacao eq 'EXAME'}">
<tr id="ye">
</c:if>
<c:if test="${fn:contains(ant.situacao,'APROVADO') or ant.situacao eq 'EM CURSO'}">
<tr id="">
</c:if>



<td><input id="ntt1" name="ntt1" type="number" min="0" step="0.0001" value="${ant.nt1}"></td>
<td><input id="ntt2" name="ntt2" type="number" min="0" step="0.0001" value="${ant.nt2}"></td>
<c:if test="${tipo ne 4}">
	<td><input id="ntt3" name="ntt3" type="number" min="0" step="0.0001" value="${ant.nt3}"></td>
</c:if>
<c:if test="${tipo eq 4}">
	<td hidden><input id="ntt3" name="ntt3" type="number" min="0" step="0.0001" value="${ant.nt3}" hidden></td>
</c:if>
<c:if test="${




ant.situacao ne 'EM CURSO' 
and (fn:contains(ant.situacao,'REPROVADO') and ant.fnt ge 4)
or (fn:contains(ant.situacao,'APROVADO') and ant.exm gt 0)
or ant.situacao eq 'EXAME'}">
<td><input id="ntt4" name="ntt4" 
type="number" min="0" step="0.0001" value="${ant.exm}"></td>
</c:if>
<c:if test="${ant.situacao eq 'EM CURSO' 
or (fn:contains(ant.situacao,'REPROVADO') and ant.fnt lt 4)
or (fn:contains(ant.situacao,'APROVADO') and ant.exm eq 0)}">
<td hidden><input id="ntt4" name="ntt4" 
type="number" min="0" step="0.0001" value="${ant.exm}" hidden></td>
</c:if>
<td><c:out value="${ant.fnt}"></c:out></td>
<td><c:out value="${ant.situacao}"></c:out></td>
</c:if>
</tr>
</c:forEach>
</tbody>
</table>
</c:if>
</div>

<c:if test="${not empty dsc and not empty gselec}">
<div align="center">
<table>
<tr>
<td><input type="submit" id="bt1" name="bt1" value="Clear"></td>
<td><input type="submit" id="bt1" name="bt1" value="Inserir Nota"></td>


<c:if test="${situation ne 'EM CURSO' and
(fn:contains(situation,'REPROVADO') and finalm ge 4 and alexm eq 0)
or situation eq 'EXAME'}">
<td><input type="submit" id="bt1" name="bt1" value="Inserir Exame"></td>
</c:if>
<c:if test="${situation eq 'EM CURSO' or 
(fn:contains(situation,'REPROVADO') and finalm lt 6) or 
(fn:contains(situation,'APROVADO') and alexm ge 0 and finalm gt 6)}">
<td hiddden><input type="submit" id="bt1" name="bt1" value="Inserir Exame" hidden></td>
</c:if>

<td><input type="submit" id="bt1" name="bt1" value="Calcular Media"></td>
</tr>
</table>
</div>
</c:if>





</form>
</body>
</html>