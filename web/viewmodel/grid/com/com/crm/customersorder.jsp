
<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, userdetails, salesOrderid, uomdetails;
    List mydata;
    Integer i, pp;
    DecimalFormat dec = new DecimalFormat("0.00");

%>

<%
    salesOrderid = request.getParameter("salesOrderid");
    pp = Integer.parseInt(salesOrderid);
// Order by purchaseorderLineId ASC
         EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM CrmSalesorderLine WHERE  salesorder_id=" + pp);

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            CrmSalesorderLine OBJ = (CrmSalesorderLine) iterator.next();
            uomdetails = OBJ.getUomQty() + " " + OBJ.getCrmUomByDimensionUomId().getUomName();

            //userdetails = OBJ.getPrcSuppliers().getSupplierName()+ " " + OBJ.getPrcSuppliers().getOthername();
            out.println("{ id:" + OBJ.getSalesorderLineId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getItemByItemId().getItemName() + "\",");
            out.println("\"" + OBJ.getQty() + "\",");
            out.println("\"" + uomdetails + "\",");

            out.println("\"" + dec.format(OBJ.getPrice()) + "\",");
            out.println("\"" + dec.format(OBJ.getAmount()) + "\"");
            // out.println("\"" + OBJ.getCrmUom().getUomName() + "\"");

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
