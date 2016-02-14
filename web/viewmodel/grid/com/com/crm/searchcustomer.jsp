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
    String myq, namedetails,param;
    List mydata;
    Integer i;
%>

<%

     param = request.getParameter("param");
    
    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM CrmCustomer WHERE life=1 AND (surname LIKE '%" + param + "%' OR othername LIKE '%" + param + "%' OR primary_mobile_no LIKE '%" + param + "%')");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            CrmCustomer OBJ = (CrmCustomer) iterator.next();
            namedetails = OBJ.getOthername() + " " + OBJ.getSurname();
            out.println("{ id:" + OBJ.getCustomerId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getCustomerCode() + "\",");
            out.println("\"" + namedetails + "\",");
            //          out.println("\"" + OBJ.getCrmCustomerCategory().getCustomerCategoryName() + "\",");
            out.println("\"" + OBJ.getPrimaryMobileNo() + "\",");
            out.println("\"" + OBJ.getContactPerson() + "\",");
            out.println("\"" + OBJ.getCrmCustomerCategory().getCustomerCategoryName() + "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
    }
    ME.closeListSession();
%>  
