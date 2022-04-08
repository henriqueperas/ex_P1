<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/styles.css">
<meta charset="ISO-8859-1">
<title>Tabelas dos grupos</title>
</head>
<body>
	<div align="center">
	<nav id=menu>
		<ul>
			<li><a href="index.jsp">In�cio</a></li>
			<li><a href="grupos.jsp">Grupos</a><li>
			<li><a href="jogos.jsp">Jogos</a></li>
			<li><a href="tabela.jsp">Tabelas</a></li>
			<li><a href="datas.jsp">Datas</a></li>
		</ul>
	</nav>
	</div>
	<br/><br/>
	<div align="center">
		<h1 class=texto>Campeonato Paulista</h1>
		<h3>Tabelas dos grupos</h3>
	</div>
	<div align="center">
		<form action="tabela" method="post">
			<input type="submit" id=tabelas name=tabelas value="Mostrar Grupos">
		</form>
	</div>
	<div align="center">
		<c:if test="${not empty erro}">
			<h4><c:out value="${erro}"></c:out></h4>
		</c:if>
	</div>
	<br />
	<div class = "container grid">
		<c:if test="${not empty grupoA }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo A</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoA}" var="g">
					<tr>
						<td><c:out value="${g.time.nomeTime }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty grupoB }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo B</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoB}" var="g">
					<tr>
						<td><c:out value="${g.time.nomeTime }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		</div>
		<div class="container grid">
		<c:if test="${not empty grupoC }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo C</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoC}" var="g">
					<tr>
						<td><c:out value="${g.time.nomeTime }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty grupoD }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo D</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoD}" var="g">
					<tr>
						<td><c:out value="${g.time.nomeTime }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>