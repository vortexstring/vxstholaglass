<%-- 
    Document   : login
    Created on : May 2, 2015, 3:22:23 PM
    Author     : JFX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>
<!DOCTYPE html>


 <%! String key,uname,pwd,rp,ru,rk,authq; 
   Integer rowCount;
 String userkey,companykey,industrykey,loginkey,profilekey;
 String myq;
 List mydata;
 %>

 <%     
    key=request.getParameter("userkey");
    uname=request.getParameter("username");
    pwd=request.getParameter("password");
  
    if(key.isEmpty()==true){  rk="empty";  }else{rk="ok"; }
    if(uname.isEmpty()==true){ ru="empty"; }else{ru="ok"; }
    if(pwd.isEmpty()==true){ rp="empty"; }else{rp="ok"; }
    
    if(rk=="empty" || ru=="empty"  || rp=="empty" ){
     String site = "../index.jsp?k="+rk+"&u="+ru+"&p="+rp;
     response.setStatus(response.SC_MOVED_TEMPORARILY);
     response.setHeader("Location", site); 
    }else{
    session.setAttribute( "username",uname );
    
    DataLoader dataObj = new DataLoader();   
  
      StringBuilder myquery = new StringBuilder(" FROM ConAuth");
      myquery.append(" Where username LIKE '" + uname + "' AND password LIKE '" + pwd + "' AND login_key LIKE '" + key + "'");
      myq=myquery.toString();
      mydata=dataObj.getData(myq);
 if(!mydata.isEmpty()){
           
  for (Iterator iterator = mydata.iterator(); iterator.hasNext();){
    ConAuth ConAuth = (ConAuth) iterator.next(); 
  
       
     session.setAttribute("companyid",ConAuth.getConProfiles().getConCompany().getCompanyId());
     session.setAttribute("industryid",ConAuth.getConProfiles().getConCompany().getConIndustry().getIndustryId()); 
     session.setAttribute("profileid",ConAuth.getConProfiles().getProfileId()); 
     session.setAttribute("userid",ConAuth.getConUserByUserId().getUserId()); 
     
     String site = "../home.jsp";
     response.setStatus(response.SC_MOVED_TEMPORARILY);
     response.setHeader("Location", site); 
     
    }
    }else
   {
       String site = "../index.jsp?c=invalid";
       response.setStatus(response.SC_MOVED_TEMPORARILY);
       response.setHeader("Location", site);    
   }
    
        
   
    }
 %>