<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Projects</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
      <p><a href="#">Link</a></p>
      <p><a href="#">Link</a></p>
      <p><a href="#">Link</a></p>
    </div>
    <div class="col-sm-8 text-left"> 
      <h1>Welcome</h1>
      
      <%
       String table = "<ol type=\"1\">";
       String output = "";
       if(request.getParameter("min")==null || request.getParameter("min").isEmpty()){
          output += "Devi inserire una data minima<br>"; 
       }
       
       if(request.getParameter("max")==null || request.getParameter("max").isEmpty()){
          output += "Devi inserire una data massima<br>"; 
       }
        
       if(output.isEmpty()){
           String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=XFactor;user=zuliani.nicolo;password=xxx123#";

           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

           Connection connection = DriverManager.getConnection(connectionUrl);
           
           String sql = "SELECT * FROM CANTANTE WHERE DataDiNascita BETWEEN ? AND ? ORDER BY DataDiNascita;";
		
	       PreparedStatement stmt = connection.prepareStatement(sql);
			
           stmt.setDate(1, java.sql.Date.valueOf(request.getParameter("min")));
           stmt.setDate(2, java.sql.Date.valueOf(request.getParameter("max")));
	   
	       ResultSet rs = stmt.executeQuery();
	   
	       while(rs.next()){
	          table+="<li>"+rs.getString("Nome")+" "+rs.getString("Cognome")+"</li>";
	          output = table;
	       }
           if(output.isEmpty()){
             output = "Nessun risultato";
           }else{
             output+="</ol>";  
           }

	       
      }

	   
      %>
      
      <%= output %>
      
      <hr>
      <h3>Test</h3>
      <p>Lorem ipsum...</p>
    </div>
    <div class="col-sm-2 sidenav">
      <div class="well">
        <p>ADS</p>
      </div>
      <div class="well">
        <p>ADS</p>
      </div>
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p>Footer Text</p>
</footer>

</body>
</html>