
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

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM PrcPurchaseOrder WHERE life=1 Order by purchaseorderId DESC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            PrcPurchaseOrder OBJ = (PrcPurchaseOrder) iterator.next();

            userdetails = OBJ.getPrcSuppliers().getSupplierName()+ " " + OBJ.getPrcSuppliers().getOthername();
            out.println("{ id:" + OBJ.getPurchaseorderId()+ ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getPurchaseorderCode()+ "\",");
            out.println("\"" + userdetails + "\",");
            out.println("\"" + OBJ.getPurchaseorderDate()+ "\",");
            out.println("\"" + OBJ.getAmount()+ "\",");
            out.println("\"" + OBJ.getAllStatus().getDescription()+ "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
    }

    ME.closeListSession();
   // out.println("Factory details:" + ME.getFactoryDetails());


%>  
