<%-- 
    Document   : products
    Created on : Nov 24, 2015, 10:53:20 AM
    Author     : Carol
--%>

<%@page import="viewmodelhelpers.EmptyDataviewVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, classdetails, productCategory;
    List mydata;
    Integer i, pc;
%>
<%
         EmptyDataviewVH  EDVH=new EmptyDataviewVH();

    productCategory = request.getParameter("productCategory");
    pc = Integer.parseInt(productCategory);

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM Item where item_level_id=3 AND parent_id=" + pc);
//alert (myquery);
    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            Item OBJ = (Item) iterator.next();
            out.println("{ id:\"" + OBJ.getItemId() + "\" ,\"productcode\":\"" + OBJ.getItemCode() + "\",\"productname\":\"" + OBJ.getItemName() + "\",\"count\":\"" + 0 + "\"");

            out.println("},");

            i++;
        }
        out.println("]");
        ME.closeListSession();
    }
    
    else{
       out.println(EDVH.displayEmptyDataview(2));      
    }
%>  

