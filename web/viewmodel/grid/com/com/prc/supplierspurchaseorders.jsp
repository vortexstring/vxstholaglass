
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, userdetails, purchaseOrderId;
    List mydata;
    Integer i, pp;
    DecimalFormat dec = new DecimalFormat("0.00");

%>

<%
    purchaseOrderId = request.getParameter("purchaseOrderId");
    pp = Integer.parseInt(purchaseOrderId);
// Order by purchaseorderLineId ASC
    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM PrcPurchaseOrderLine  WHERE life=1  AND purchaseorder_id=" + pp );

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            PrcPurchaseOrderLine OBJ = (PrcPurchaseOrderLine) iterator.next();

            //userdetails = OBJ.getPrcSuppliers().getSupplierName()+ " " + OBJ.getPrcSuppliers().getOthername();
            out.println("{ id:" + OBJ.getPurchaseorderLineId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getItem().getItemName() + "\",");
            out.println("\"" + OBJ.getQty() + "\",");
            out.println("\"" + dec.format(OBJ.getPrice()) + "\",");
            out.println("\"" + dec.format(OBJ.getAmount()) + "\",");
            out.println("\"" + OBJ.getCrmUom().getUomName() + "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
    }

    ME.closeListSession();
   // out.println("Factory details:" + ME.getFactoryDetails());


%>  
