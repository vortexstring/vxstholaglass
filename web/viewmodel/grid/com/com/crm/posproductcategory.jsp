<%-- 
    Document   : posproductcategory
    Created on : Nov 24, 2015, 10:06:43 AM
    Author     : Carol
--%>


<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, productsCount,productClass;
    List mydata;
    Integer i,pc;
%>

<%
 productClass=request.getParameter("productClassId");
     pc=Integer.parseInt(productClass);
     EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM Item where item_level_id=2 and item.itemId="+pc);

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            Item OBJ = (Item) iterator.next();
           // productsCount=("SELECT count (*) AS productsCount FROM Item where level=2");

            //userdetails = OBJ.getConUserByUserId().getSurname() + " " + OBJ.getConUserByUserId().getOtherName();
            out.println("{ id:" + OBJ.getItemId()+ ", data:[");
            out.println("\"" + i + "\",");
           // out.println("\"" + userdetails + "\",");
            out.println("\"" + OBJ.getItemName()+ "\",");
            out.println("\"" + OBJ.getItem().getItemName()+ "\",");
            out.println("\"" + productsCount + "\"");

          //  out.println("\"" + OBJ.getConProfiles().getProfileName() + "\",");
          //  out.println("\"" + OBJ.getAllStatus().getDescription() + "\"");
            out.println("]},");

            i++;
        }
        out.println("]}");
        ME.closeListSession();

    }else{
       out.println(EGVH.displayEmptyGrid(5));      
    }
%>  

