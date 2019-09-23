<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Dashboard</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
</head>
<body class="container my-4">
	<div class="row justify-content-between">
		<h3>Current Listings</h3>
		<a href="/logout">Logout</a>
	</div>
	<table class="table col-10 my-4">
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
					<td><a href="/host/pools/${pool.id}"><c:out value="${pool.avgRating}/5.0"/> - edit</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<h5 class="mt-5">New Listing</h5>
	<form:form action="/host/pools" method="post" modelAttribute="pool" class="col-8">
		<div class="form-group row">
    		<form:label path="address" class="col-sm-3 col-form-label">Address:</form:label>
    		<form:errors path="address" class="text-danger"/>
    		<div class="col-sm-9">
    			<form:input type="text" path="address" class="form-control"/>
    		</div>
    	</div>
    	<div class="form-group row">
    		<form:label path="description" class="col-sm-3 col-form-label">Description:</form:label>
    		<form:errors path="description" class="text-danger"/>
    		<div class="col-sm-9">
    			<form:textarea type="text" path="description" rows="4" class="form-control"/>
    		</div>
    	</div>
    	<div class="form-group row">
    		<form:label path="costPerNight" class="col-sm-9 col-form-label">Cost per night:</form:label>
    		<form:errors path="costPerNight" class="text-danger"/>
    		<div class="col-sm-3">
    			<form:input type="number" path="costPerNight" class="form-control" value="0.00" step="0.01"/>
    		</div>
    	</div>
    	<div class="form-group row">
    		<form:label path="poolSize" class="col-sm-9 col-form-label">Pool Size:</form:label>
    		<form:errors path="poolSize" class="text-danger"/>
    		<div class="col-sm-3">
    			<form:select path="poolSize" class="custom-select">
    				<option value="Small">Small</option>
    				<option value="Medium">Medium</option>
    				<option value="Large">Large</option>
    			</form:select>
    		</div>
    	</div>
    	<div class="text-right">
    		<button class="btn btn-primary">Add Listing</button>
    	</div>
    	
	</form:form>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>