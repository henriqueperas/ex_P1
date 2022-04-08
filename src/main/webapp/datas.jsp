<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/styles.css">
<meta charset="ISO-8859-1">
<title>Datas da Rodada</title>
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
	<br />
	<br />

	<div id="centro" align="center">
		<h1 class=texto>Campeonato Paulista</h1>
		<h3 class=tarefa>Escolha a data da rodada (23 Janeiro - 13 abril 2022)</h3>
		<div align="center">
			<form action="datas" method="post">
				<input type="date" id=data_rodada name=data_rodada
					required="required"> <input type="submit" id=pesquisar
					name=pesquisar value="Pesquisar">
			</form>
		</div>
		<div align="center">
			<c:if test="${not empty erro}">
				<h4>
					<c:out value="${erro}"></c:out>
				</h4>
			</c:if>
		</div>
		<br />
		<div align="center">
			<c:if test="${not empty saida}">
				<h4>
					<c:out value="${saida}"></c:out>
				</h4>
			</c:if>
		</div>
		<br />
		<div align="center">
			<c:if test="${not empty rodada }">
				<table class=table_home>
					<thead>
						<tr>
							<th>Time A</th>
							<th>Time B</th>
							<th>Gols A </th>
							<th>Gols B </th>
							<th>Data</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rodada}" var="r">
							<tr>
								<td align="center"><c:out value="${r.timeA } "></c:out></td>
								<td align="center"><c:out value="${r.timeB } "></c:out></td>
								<td align="center"><c:out value="${r.golsTimeA }  "></c:out></td>
								<td align="center"><c:out value="${r.golsTimeB }  "></c:out></td>
								<td align="center"><c:out value="${r.data }"></c:out></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>

</body>
</html>
