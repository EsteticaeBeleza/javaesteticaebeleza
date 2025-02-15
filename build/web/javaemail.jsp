
<%@page import="classes.Cliente"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>

<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page import = "java.util.Properties, javax.mail.*, 
javax.mail.internet.*, javax.activation.*, 
java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "javax.mail.Authenticator.*" %>
<%@ page import = "javax.mail.PasswordAuthentication.*" %>
<%@ page import = "javax.mail.Authenticator .*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.Connection.*"%>
<%@ page import="java.sql.PreparedStatement.*"%>
<%@ page import="java.sql.ResultSet.*"%>
<%@ page import="java.util.ArrayList.*"%>
<%@ page import="java.util.List.*"%>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/epiz_32123626_esteticaebelezabd"
         user = "root" password = ""/><!--mail-->
         <sql:query dataSource = "${snapshot}" var = "result">
         SELECT * from cliente;
      </sql:query>
       <table border = "1" width = "100%">
         <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Status</th>
         </tr>
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td> <c:out value = "${row.iD_Cliente}"/></td>
               <td> <c:out value = "${row.email}"/></td>
               <td> Email enviado</td>
            </tr>
         </c:forEach>
      </table>
         
    
<%
    
    Cliente cliente = null;   
         try{
        Connection con = con=DriverManager.getConnection("jdbc:mysql://localhost:3306/epiz_32123626_esteticaebelezabd","root","");//mail
        PreparedStatement ps = (PreparedStatement) con.prepareStatement("select * from cliente");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
    
     final String fromEmail = "salao.estetica.beleza10@gmail.com"; //requires valid gmail id
		  final String password = "jgvykbangnfolply"; // correct password for gmail id
    
 Authenticator auth = new Authenticator() {
				//override the getPasswordAuthentication method
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, password);
				}
		  };
    
Properties props = new Properties();
		  props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
		  props.put("mail.smtp.port", "587"); //TLS Port
	      props.put("mail.smtp.auth", "true"); //enable authentication
		  props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
			
		  Session sessao = Session.getInstance(props, auth); 
		  MimeMessage msg = new MimeMessage(sessao);
		  
	      //set message headers
	      msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
	      msg.addHeader("format", "flowed");
	      msg.addHeader("Content-Transfer-Encoding", "8bit");

	      msg.setFrom(new InternetAddress("salao.estetica.beleza10@gmail.com", "Est�tica & Beleza"));//tixtesteenvio2@gmail.com

	      msg.setReplyTo(InternetAddress.parse("salao.estetica.beleza10@gmail.com", false));

	      msg.setSubject(request.getParameter("assunto"), "UTF-8");

	      msg.setText(request.getParameter("comenta"), "UTF-8");


	      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse((rs.getString("email")), false));
    	  Transport.send(msg);  
 
System.out.println("Email promocional enviado!!!");
	    }
		
         }catch (Exception e) {
	      e.printStackTrace();
	    }

%>