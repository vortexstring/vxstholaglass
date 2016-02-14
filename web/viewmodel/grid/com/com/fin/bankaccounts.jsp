
<%@page import="viewmodelhelpers.EmptyGridVH"%>
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
     EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM BankAccount WHERE life=1 Order by accountId ASC");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            BankAccount OBJ = (BankAccount) iterator.next();

            //userdetails = OBJ.getConUserByUserId().getSurname() + " " + OBJ.getConUserByUserId().getOtherName();
            out.println("{ id:" + OBJ.getAccountId() + ", data:[");
            out.println("\"" + i + "\",");
            //out.println("\"" + userdetails + "\",");
            out.println("\"" + OBJ.getAccountName() + "\",");
            out.println("\"" + OBJ.getBank().getBankName() + "\",");
            out.println("\"" + OBJ.getAccountNumber() + "\",");
            out.println("\"" + OBJ.getAllCurrency().getCurrencyName() + "\",");
            out.println("\"" + OBJ.isIsdefault()+ "\"");

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
