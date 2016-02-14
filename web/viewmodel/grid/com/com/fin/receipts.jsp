<%-- 
    Document   : receipts
    Created on : Jan 29, 2016, 12:17:19 PM
    Author     : pharis wambui
--%>


<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, userdetails;
    List mydata;
    Integer i;
%>

<%
     EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM FinReceipt WHERE life=1 Order by receiptId DESC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            FinReceipt OBJ = (FinReceipt) iterator.next();

            userdetails = OBJ.getCrmCustomer().getSurname() + " " + OBJ.getCrmCustomer().getSurname();
            out.println("{ id:" + OBJ.getReceiptId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getReceiptNo() + "\",");
            out.println("\"" + OBJ.getReceiptDate() + "\",");
            out.println("\"" + userdetails + "\",");

            out.println("\"" + OBJ.getPayer() + "\",");
            out.println("\"" + OBJ.getRef() + "\",");
            // out.println("\"" + OBJ.getAllStatus().getDescription+ "\"");
            out.println("\"" + OBJ.getReceiptDate() + "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
    ME.closeListSession();

    }else{
       out.println(EGVH.displayEmptyGrid(7));      
    }

   // out.println("Factory details:" + ME.getFactoryDetails());


%>  

