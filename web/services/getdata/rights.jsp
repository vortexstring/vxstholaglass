<%-- 
    Document   : rights
    Created on : Dec 21, 2015, 7:38:02 AM
    Author     : TBL
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="vxsutil.RightsHelper" %>

<%!
    String feedback, userprofile, object;
    RightsHelper RH;

%>


<%

    object = request.getParameter("id");
    RH = new RightsHelper();
    userprofile = session.getAttribute("profileid").toString();
    feedback = RH.getRightsdata(object, 1);
  
    out.print(feedback);


%>