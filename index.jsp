<%-- 
    Document   : index
    Created on : 07-Oct-2021, 10:31:41 am
    Author     : khushiagrawal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset = 'UTF-8'>
		<meta name = 'viewport' content = 'width = device-width, initial-scale = 1.0'>
		<meta http-equiv = 'X-UA-Compatible' content = 'ie = edge'>

		<link rel="stylesheet" type="text/css" href="./isaa_style.css">

		<link rel = "stylesheet" href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

		<title>Information Security</title>
	</head>

	<body>
		<div id = 'title_id'>
			<h1>Encryption and Decryption</h1>
		</div>

		<form action="login.jsp" method="post" id = 'form_id'>
			<div id = 'form_title'>
				<h2>Register Form</h2>
			</div>
                        <div class="input-container">
				<i class="fa fa-envelope icon"></i>
				<input class="input-field" type="text" placeholder="ID" name="uid">
			</div>
                    
			<div class="input-container">
				<i class = "fa fa-user icon"></i>

				<input class = "input-field" type="text" placeholder = "Username" name="user">
			</div>
		
			<div class="input-container">
				<i class="fa fa-key icon"></i>
				<input class="input-field" type="password" placeholder="Password" name="pass">
			</div>
                        <div class="btn-group">
			<input type="submit" value="Add" name="btn" id = 'add_id' class = 'btns'>
			<input type="submit" value="Modify and Change" name="btn" id = 'add_id' class = 'btns'>
			<input type="submit" value="View" name="btn" id = 'add_id' class = 'btns'>
			<input type="submit" value="Delete" name="btn" id = 'add_id' class = 'btns'>
		</div>
		</form>

		<br>

		

	</body>
</html>
