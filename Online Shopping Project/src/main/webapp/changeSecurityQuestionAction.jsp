<%@page import="Project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
String email=session.getAttribute("email").toString();
String securityQuestion=request.getParameter("securityQuestion");
String newAnswer=request.getParameter("newAnswer");
String password=request.getParameter("password");
int check=0;
try{
    Connection con=ConnectionProvider.getCon();
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select * from users where email='"+email+"' and password='"+password+"' ");
    while(rs.next())
    {
        check=1;
        st.executeUpdate("update users set securityQuestion='"+securityQuestion+"', answer='"+newAnswer+"' where email='"+email+"' ");
    }
    if(check==1) {
        response.sendRedirect("changeSecurityqeustion.jsp?msg=done");
    } else {
        response.sendRedirect("changeSecurityquestion.jsp?msg=wrong");
    }
}
catch(Exception e)
{
    System.out.println(e);
}
%>
