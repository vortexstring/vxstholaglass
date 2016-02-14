<%-- 
    Document   : productcategory
    Created on : Dec 18, 2015, 1:01:12 PM
    Author     : pharis wambui
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>


<%!
    String myq, namedetails;
    List mydata;
    Integer i;
%>

<%

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM Item where life=1 AND item_level_id=2 ORDER BY item_id ASC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            Item OBJ = (Item) iterator.next();
            // namedetails = OBJ.getItem().getItemName();
            out.println("{ id:" + OBJ.getItemId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getItemCode() + "\",");
            out.println("\"" + OBJ.getItemName() + "\",");
            out.println("\"" + OBJ.getItem().getItemName() + "\"");
            //out.println("\"" + OBJ.getItem().getItem().getItemName() + "\",");
           // out.println("\"" + OBJ.getItemName()+ "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
    }
    ME.closeListSession();
%>  


