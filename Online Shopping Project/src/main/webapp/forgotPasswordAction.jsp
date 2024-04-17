<%@page import="Project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<% 
String email=request.getParameter("email");
String mobileNumber=request.getParameter("mobileNumber");
String securityQuestion=request.getParameter("securityQuestion");
String answer=request.getParameter("answer");
String newPassword=request.getParameter("newPassword");

int check=0;
try
{
    // Establishing a database connection
	Connection con=ConnectionProvider.getCon();
	Statement st= con.createStatement();
	
    // Performing a select query to check user credentials
	ResultSet rs=st.executeQuery("select * from users where email='"+email+"' and mobileNumber='"+mobileNumber+"' and securityQuestion='"+securityQuestion+"' and answer='"+answer+"' ");
    
    // If user exists, update the password
    while(rs.next())
    {
    	check=1;
    	st.executeUpdate("update users set password='"+newPassword+"' where email='"+email+"' ");
        // Redirect to forgotPassword.jsp with success message
        response.sendRedirect("forgotPassword.jsp?msg=done");
    }
    
    // If no matching user found, redirect with error message
    if(check==0)
    {
        response.sendRedirect("forgotPassword.jsp?msg=invalid");
    }
}
catch(Exception e)
{
    // Print the exception stack trace if any error occurs
	System.out.println(e);
}
%>
