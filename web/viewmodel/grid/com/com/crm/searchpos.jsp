<%-- 
    Document   : searchcustomer
    Created on : Dec 27, 2015, 11:00:41 AM
    Author     : pharis wambui
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>


<%!
    String myq, namedetails,param1;
    List mydata;
    Integer i;
%>

<%

     param1 = request.getParameter("param1");
    
    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM CrmPos WHERE life=1 AND (pos_code LIKE '%" + param1 + "%' OR amount LIKE '%" + param1 + "%' )");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            CrmPos OBJ = (CrmPos) iterator.next();
           // namedetails = OBJ.getOthername() + " " + OBJ.getSurname();
            out.println("{ id:" + OBJ.getPosId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getPosCode() + "\",");
          //  out.println("\"" + namedetails + "\",");
            //          out.println("\"" + OBJ.getCrmCustomerCategory().getCustomerCategoryName() + "\",");
            out.println("\"" + OBJ.getAmount() + "\"");
            
            out.println("]},");

            i++;
        }
        out.println("]}");
    }
    ME.closeListSession();
%>  
