<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Search Results</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
</head>
<body class="container my-4">
	<div class="row justify-content-end">
		<a href="/host/dashboard">Home</a>
		<a class="mx-3" href="/logout">Logout</a>
	</div>	
	<h3>Find your pool!</h3>
	<form action="/search" class="form-inline mt-4">
		<input class="form-control" type="text" name="location" placeholder="new search">
		<button class="btn btn-primary mx-3" type="submit">Search</button>
	</form>
	<table class="table my-4">
		<thead>
			<tr>
				<th>Address</th>
				<th>Pool Size</th>
				<th>Cost per night</th>
				<th>Details</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${pools}" var="pool">
				<tr>
					<td><c:out value="${pool.address}"/></td>
					<td><c:out value="${pool.poolSize}"/></td>
					<td>$<c:out value="${pool.costPerNight}"/></td>
					<td>
						<a href="/pools/${pool.id}">
							<c:out value="${pool.avgRating}"/>/5 - See more
						</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>