<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/styles.css">
<meta charset="ISO-8859-1">
<title>Separa Grupos</title>
</head>
<body>
		<div align="center">
	<nav id=menu>
		<ul>
			<li><a href="index.jsp">Início</a></li>
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
		<h3 class=tarefa>Separa os times em 4 grupos com 4 times cada</h3>
	</div>
	<div align="center">
		<form action="grupo" method="post">
			<input type="submit" id=separa_grupo name=separa_grupo value="Separa Grupos">
		</form>
	</div>
	<div align="center">
		<c:if test="${not empty erro}">
			<h4><c:out value="${erro}"></c:out></h4>
		</c:if>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty grupos}">
			<table class=table_home>
				<thead>
					<tr>
						<th>#ID</th>
						<th>Nome</th>
						<th>Grupos</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupos}" var="grupo">
					<tr>
						<td align="center"><c:out value="${grupo.time.codTime}   "></c:out></td>
						<td align="center"><c:out value="${grupo.time.nomeTime}  "></c:out></td>
						<td align="center"><c:out value="${grupo.grupo}"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida}">
			<h4><c:out value="${saida}"></c:out></h4>
		</c:if>
	</div>
</body>
</html>
