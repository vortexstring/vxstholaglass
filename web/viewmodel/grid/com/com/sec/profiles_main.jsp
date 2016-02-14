
<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>


<%!
    String myq;
    List mydata;
    Integer i;
%>

<%
     EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM ConProfiles");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            ConProfiles OBJ = (ConProfiles) iterator.next();

          //  userdetails = OBJ.getConUserByUserId().getSurname() + " " + OBJ.getConUserByUserId().getOtherName();
            out.println("{ id:" + OBJ.getProfileId()+ ", data:[");
           // out.println("\"" + i + "\",");
           // out.println("\"" + userdetails + "\",");
            out.println("\"" + OBJ.getProfileName()+ "\"");
           
            out.println("]},");

            i++;
        }
        out.println("]}");
   ME.closeListSession();

    }else{
       out.println(EGVH.displayEmptyGrid(2));      
    }
%>  
