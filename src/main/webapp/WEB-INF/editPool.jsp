<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>WaterBnB</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
</head>
<body class="container my-4">
	<div class="row justify-content-end">
		<a href="/host/dashboard">Home</a>
		<a class="mx-3" href="/logout">Logout</a>
	</div>
	
	<form:errors path="pool.*"/>
	<form:form action="/host/pools/${pool.id}" method="post" modelAttribute="pool" class="container row my-5">
		<form:input type="hidden" path="address"/>
		<div class="col-6">
			<p><c:out value="${pool.address}"/></p>
			<form:errors path="description" />
			<form:textarea path="description" rows="4" class="form-control"/>
			<button class="btn btn-primary my-2" type="submit">Save Changes</button>
		</div>
		<div class="col-6">
			<form:input type="hidden" path="user"/>
			<p>Email: <c:out value="${pool.user.email}"/></p>
			<p>Name: <c:out value="${pool.user.firstName} ${pool.user.lastName}" /></p>
			<div class="row">
	    		<form:label path="poolSize" class="col-sm-6 col-form-label">Pool Size:</form:label>
	    		<form:errors path="poolSize" class="text-danger"/>
	    		<div class="col-sm-3">
	    			<form:select path="poolSize" class="custom-select">
	    				<option value="Small">Small</option>
	    				<option value="Medium">Medium</option>
	    				<option value="Large">Large</option>
	    			</form:select>
	    		</div>
	    	</div>
			<div class="row">
				<form:label path="poolSize" class="col-sm-6 col-form-label">Cost per night:</form:label>
				<div class="col-sm-3">
					<form:input path="costPerNight" type="number" step="0.01" class="form-control"/>
				</div>
			</div>
		</div>
	</form:form>

	<h5>Reviews (<c:out value="${pool.avgRating}"/>/5.0):</h5>
	<div class="border" style="overflow-y: scroll; height:50vh;">
		<c:forEach items="${pool.reviews}" var="review">
			<p><c:out value="${review.user.firstName} ${review.user.lastName}"/></p>
			<p>Rating: <c:out value="${review.rating}"/>/5</p>
			<p class="container"><c:out value="${review.content}"/></p>	
			<hr>
		</c:forEach>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>