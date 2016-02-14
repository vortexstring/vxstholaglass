
<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>


<%!
    String myq, namedetails,userdetails;
    List mydata;
    Integer i;
%>

<%
     EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM CrmSalesorder");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            CrmSalesorder OBJ = (CrmSalesorder) iterator.next();
            namedetails = OBJ.getCrmCustomer().getOthername() + " " + OBJ.getCrmCustomer().getSurname();
            userdetails=OBJ.getConUserByCreatebyId().getOtherName()+" "+ OBJ.getConUserByCreatebyId().getSurname();
            out.println("{ id:" + OBJ.getSalesorderId()+ ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getSalesorderCode()+ "\",");
                        out.println("\"" + OBJ.getCrmPos().getPosCode()+ "\",");
            out.println("\"" + OBJ.getSalesorderDate()+ "\",");
            out.println("\"" + OBJ.getAmount()+ "\",");

            out.println("\"" + namedetails + "\",");
  //          out.println("\"" + OBJ.getCrmCustomerCategory().getCustomerCategoryName() + "\",");
      //      out.println("\"" + OBJ.getCrmQuote().getQuoteCode()+ "\",");
            out.println("\"" + OBJ.getAllStatus().getDescription()+ "\",");
            out.println("\"" + userdetails+ "\"");


            out.println("]},");

            i++;
        }
        out.println("]}");
        ME.closeListSession();

    }else{
       out.println(EGVH.displayEmptyGrid(9));      
    }
%>  
