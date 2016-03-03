<%-- 
    Document   : productclass
    Created on : Nov 21, 2015, 11:38:23 AM
    Author     : Carol
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, classdetails;
    List mydata;
    Integer i;
%>

<%

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM Item where item_level_id=1  and conLife.lifeId!=2 ORDER BY item_sort ASC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            Item OBJ = (Item) iterator.next();
            out.println("{ id:\"" + OBJ.getItemId()+ "\" ,\"productclass\":\"" + OBJ.getItemName()+ "\",\"producticon\":\"" + OBJ.getItemIcon()+ "\",\"Producticon\":\"" + OBJ.getItemId()+ "\"");

            out.println("},");

            i++;
        }
        out.println("]");
    }
ME.closeListSession();
%>  

