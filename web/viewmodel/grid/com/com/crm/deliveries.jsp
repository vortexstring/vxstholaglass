
<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>


<%!
    String myq, namedetails, userdetails;
    List mydata;
    Integer i;
%>

<%
     EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM CrmDelivery");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            CrmDelivery OBJ = (CrmDelivery) iterator.next();
            namedetails = OBJ.getCrmCustomer().getOthername() + " " + OBJ.getCrmCustomer().getSurname();
            //userdetails=OBJ.getConUserByCreatebyId().getOtherName()+" "+ OBJ.getConUserByCreatebyId().getSurname();
            out.println("{ id:" + OBJ.getDeliveryId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getDeliveryCode() + "\",");
            out.println("\"" + OBJ.getCrmSalesorder().getSalesorderCode() + "\",");
            out.println("\"" + OBJ.getCrmSalesorder().getSalesorderDate() + "\",");
            out.println("\"" + OBJ.getDeliveryDate()+ "\",");
            //out.println("\"" + OBJ.getDeliveryCode() + "\",");
            out.println("\"" + namedetails + "\",");

  //          out.println("\"" + OBJ.getCrmCustomerCategory().getCustomerCategoryName() + "\",");
            //  out.println("\"" + OBJ.getCrmPos().getPosCode()+ "\",");
            //  out.println("\"" + OBJ.getQuoteDate()+ "\",");
         //   out.println("\"" + OBJ.getAmount() + "\",");

            out.println("\"" + OBJ.getAllStatus().getDescription()+ "\",");
                        out.println("\"" + OBJ.getAllStatus().getDescription()+ "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
        ME.closeListSession();

    }else{
       out.println(EGVH.displayEmptyGrid(9));      
    }
%>  
