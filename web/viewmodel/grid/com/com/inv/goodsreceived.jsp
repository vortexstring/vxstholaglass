<%-- 
    Document   : stores
    Created on : Dec 15, 2015, 10:51:35 AM
    Author     : pharis wambui
--%>


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
    StringBuilder myquery = new StringBuilder("FROM InvGoodsreceived WHERE life=1 Order by grnId DESC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            InvGoodsreceived OBJ = (InvGoodsreceived) iterator.next();

            userdetails = OBJ.getPrcSuppliers().getSupplierName()+ " " + OBJ.getPrcSuppliers().getOthername();
            out.println("{ id:" + OBJ.getGrnId()+ ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getGrnCode()+ "\",");
            out.println("\"" + OBJ.getGrnDate()+ "\",");
                    //    out.println("\"" + OBJ.getAdjustmentDate() + "\",");
            out.println("\"" + OBJ.getDeliveryNo()+ "\",");
                        out.println("\"" + OBJ.getGrnRef()+ "\",");
            out.println("\"" + userdetails+ "\",");

            out.println("\"" + OBJ.getAllStatus().getDescription()+ "\"");
           // out.println("\"" + OBJ.()+ "\",");
           // out.println("\"" + OBJ.getCommonCombo().getComboName()+ "\",");
          

            //out.println("\"" + OBJ.getCrmUomCateg().getUomCategName()+ "\"");
           // out.println("\"" + OBJ.getDescription() + "\"");
            out.println("]},");

            i++;
        }
        out.println("]}");
    }

    ME.closeListSession();
   // out.println("Factory details:" + ME.getFactoryDetails());


%>  
