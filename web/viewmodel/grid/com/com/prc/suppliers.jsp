
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
    StringBuilder myquery = new StringBuilder("FROM PrcSuppliers WHERE life=1 Order by supplierId DESC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            PrcSuppliers OBJ = (PrcSuppliers) iterator.next();

            userdetails = OBJ.getOthername() + " " + OBJ.getSupplierName();
            out.println("{ id:" + OBJ.getSupplierId() + ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getSupplierCode() + "\",");
            out.println("\"" + userdetails + "\",");
            out.println("\"" + OBJ.getPrimaryMobileNo() + "\",");
            out.println("\"" + OBJ.getPrimaryEmail() + "\",");
            out.println("\"" + OBJ.getContactPerson() + "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
    }

    ME.closeListSession();
   // out.println("Factory details:" + ME.getFactoryDetails());


%>  
