<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Welcome</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
</head>
<body class="my-4 container">
	<h3 class="my-4">Welcome</h3>
	
	<div class="row justify-content-start">
		<div class="col-5 ">
			<h4>Register</h4>
	    
		    <p class="container"><form:errors class="text-danger" path="user.*"/></p>
		    
		    <form:form method="POST" action="/registration" modelAttribute="user" class="col">
		    	<div class="form-group row">
		    		<form:label path="firstName" class="col-sm-3 col-form-label">First Name:</form:label>
		    		<div class="col-sm-9">
		    			<form:input type="firstName" path="firstName" class="form-control"/>
		    		</div>
		    	</div>
		    	<div class="form-group row">
		    		<form:label path="lastName" class="col-sm-3 col-form-label">Last Name:</form:label>
		    		<div class="col-sm-9">
		    			<form:input type="lastName" path="lastName" class="form-control"/>
		    		</div>
		    	</div>
		    	<div class="form-group row">
		    		<form:label path="email" class="col-sm-3 col-form-label">Email:</form:label>
		    		<div class="col-sm-9">
		    			<form:input type="email" path="email" class="form-control"/>
		    		</div>
		    	</div>
		    	<div class="form-group row">
		    		<form:label path="password" class="col-sm-3 col-form-label">Password:</form:label>
		    		<div class="col-sm-9">
		    			<form:input type="password" path="password" class="form-control"/>
		    		</div>
		    	</div>
		       <div class="form-group row">
		    		<form:label path="passwordConfirmation" class="col-sm-3 col-form-label">Password Confirmation:</form:label>
		    		<div class="col-sm-9">
		    			<form:input type="password" path="passwordConfirmation" class="form-control"/>
		    		</div>
		    	</div>
		    	<div class="form-group row">
		    		<form:label path="role" class="col-sm-9 col-form-label"></form:label>
		    		<div class="col-sm-3">
		    			<form:select path="role" items="${roles}" itemValue="id" itemLabel="name" class="custom-select"/>
		    		</div>
		    	</div>
		    	<div class="text-right">
		    		<input type="submit" value="Register" class="btn btn-primary"/>
		    	</div>
		    </form:form>
		</div>
		<div class="col-5 mx-5">
			<h4>Login</h4>
		    <p class="text-danger"><c:out value="${error}"/></p>
		    <form method="post" action="/login" class="">
		        <div class="form-group row">
		        	<label class="col-sm-2 col-form-label">Email</label>
		        	<div class="col-sm-10">
		        		<input type="text" name="email" class="form-control"/>
		        	</div>
		        </div>
		        <div class="form-group row">
		        	<label class="col-sm-2 col-form-label">Password</label>
		        	<div class="col-sm-10">
		        		<input type="password" name="password" class="form-control"/>
		        	</div>
		        </div>
		        <div class="text-right">
		        	<input type="submit" value="Login" class="btn btn-primary"/>
		        </div>
		    </form>
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>