<%-- 
    Document   : posmain
    Created on : Dec 27, 2015, 12:46:17 PM
    Author     : pharis wambui
--%>


<%@page import="viewmodelhelpers.EmptyGridVH"%>
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
     EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM CrmPos");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            CrmPos OBJ = (CrmPos) iterator.next();
            //  namedetails = OBJ.getOthername() + " " + OBJ.getSurname();
            out.println("{ id:" + OBJ.getPosId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getPosCode() + "\",");
            out.println("\"" + OBJ.getAmount() + "\",");
            out.println("\"" + OBJ.getRef() + "\",");
            out.println("\"" + OBJ.getPosDate() + "\",");
            out.println("\"" + OBJ.getAllStatus().getDescription() + "\",");
            out.println("\"" + OBJ.getPosDate() + "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
            ME.closeListSession();

    }else{
       out.println(EGVH.displayEmptyGrid(8));      
    }
%>  
