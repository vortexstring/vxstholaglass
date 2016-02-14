
<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>


<%!
    String myq, namedetails, userdetails, uomdetails;
    List mydata;
    Integer i;
%>

<%
    EmptyGridVH EGVH = new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM CrmPosLine ");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            CrmPosLine OBJ = (CrmPosLine) iterator.next();
            //namedetails = OBJ.getCrmSalesorder().getCrmCustomer().getOthername()+ " " + OBJ.getCrmSalesorder().getCrmCustomer().getSurname();
            // userdetails=OBJ.getConUserByCreatebyId().getOtherName()+" "+ OBJ.getConUserByCreatebyId().getSurname();
            uomdetails = OBJ.getUomQty() + " " + OBJ.getCrmUomByDimensionUomId().getUomName();
            out.println("{ id:" + OBJ.getPosLineId() + ", data:[");
            out.println("\"" + i + "\",");
//            out.println("\"" + OBJ.getCrmSalesorder().getSalesorderCode()+ "\",");
            out.println("\"" + OBJ.getItemByItemId().getItemName() + "\",");
//            out.println("\"" + OBJ.getCrmSalesorder().getSalesorderCode()+ "\",");
//            out.println("\"" + OBJ.getCrmPos().getPosCode()+ "\",");
//            out.println("\"" + OBJ.getCrmSalesorder().getSalesorderDate()+ "\",");
//            out.println("\"" + OBJ.getCrmQuote().getQuoteCode()+ "\",");
            out.println("\"" + OBJ.getQty() + "\",");
            out.println("\"" + uomdetails + "\",");
            out.println("\"" + OBJ.getPrice() + "\",");
            //  out.println("\"" + OBJ.getDiscount() + "\",");
            out.println("\"" + OBJ.getAmount() + "\"");

//            out.println("\"" + OBJ.getComment()+ "\",");
//            out.println("\"" + OBJ.getAllStatus().getDescription()+ "\",");
//            out.println("\"" + userdetails+ "\"");
//
            out.println("]},");

            i++;
        }
        out.println("]}");
        ME.closeListSession();

    } else {
        out.println(EGVH.displayEmptyGrid(7));
    }
%>  
