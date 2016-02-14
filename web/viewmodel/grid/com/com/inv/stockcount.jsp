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
    StringBuilder myquery = new StringBuilder("FROM InvStockcount WHERE life=1 Order by stockcountId DESC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            InvStockcount OBJ = (InvStockcount) iterator.next();

           // userdetails = OBJ.getHrmEmployee().getFirstName() + " " + OBJ.getHrmEmployee().getLastName();
            out.println("{ id:" + OBJ.getStockcountId()+ ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getStockcountCode()+ "\",");

            out.println("\"" + OBJ.getStockcountDate()+ "\",");
            out.println("\"" + OBJ.getAllStatus().getDescription()+ "\"");
                    //    out.println("\"" + OBJ.getAdjustmentDate() + "\",");
            

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
