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
    String myq, userdetails, goodsReceivedId;
    List mydata;
    Integer i, pp;
%>

<%
    goodsReceivedId = request.getParameter("goodsReceivedId");
    pp = Integer.parseInt(goodsReceivedId);

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM InvGoodsreceivedLine WHERE  grn_id=" + pp);

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            InvGoodsreceivedLine OBJ = (InvGoodsreceivedLine) iterator.next();

            // userdetails = OBJ.getHrmEmployee().getFirstName() + " " + OBJ.getHrmEmployee().getLastName();
            out.println("{ id:" + OBJ.getGrnLineId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getItem().getItemName() + "\",");
            out.println("\"" + OBJ.getPurchaseqty() + "\",");
            out.println("\"" + OBJ.getReceivedqty() + "\",");
            out.println("\"" + OBJ.getBatchNo()+ "\",");
            out.println("\"" + OBJ.getInvStore().getStoreName() + "\"");
          //  out.println("\"" + OBJ.getDeliveryNo()+ "\",");

           // out.println("\"" + OBJ.getGrnRef()+ "\"");
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
