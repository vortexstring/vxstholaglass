<%-- 
    Document   : productservice
    Created on : Feb 9, 2016, 2:03:07 PM
    Author     : pharis wambui
--%>

<%-- 
    Document   : products
    Created on : Nov 16, 2015, 2:50:02 PM
    Author     : TBL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*,viewmodelhelpers.*" %>


<%!
    String myq, namedetails;
    List mydata;
    Integer i;
    // ;
%>

<%
    EmptyGridVH EGVH = new EmptyGridVH();

    //ProductsVH  PVH=new ProductsVH();
    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM Item where life=1 AND parent_id=6 ORDER BY itemId ASC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            Item OBJ = (Item) iterator.next();
            namedetails = OBJ.getItemCode() + " -- " + OBJ.getItemName();
            out.println("{ id:" + OBJ.getItemId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + namedetails + "\"");
            //out.println("\"" + OBJ.getItemName() + "\"");
          //  out.println(PVH.getDynamicGridData(OBJ,OBJ.getItemLevel().getItemLevelId()));

            // out.println("\"" + OBJ.+ "\"");
            out.println("]},");

            i++;
        }
        out.println("]}");
        ME.closeListSession();

    } else {
        out.println(EGVH.displayEmptyGrid(4));
    }
%>  


