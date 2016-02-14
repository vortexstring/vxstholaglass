
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
            StringBuilder myquery = new StringBuilder("FROM ConUser");
        
            mydata = ME.getData(myquery.toString());

            if (!mydata.isEmpty()) {
                i = 1;
                 out.println("{rows:[");
                //LOOP THROUGH THE GRID
                 for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    ConUser OBJ = (ConUser) iterator.next();
                   
                    out.println("{ id:"+ OBJ.getUserId()+", data:[");
                     out.println("\""+i+"\",");
                    out.println("\""+OBJ.getOtherName()+"\",");
                     out.println("\""+OBJ.getSurname()+"\",");
                      out.println("\""+OBJ.getConProfiles().getProfileName()+"\",");
                     out.println("\""+OBJ.getAllStatus().getDescription()+"\"");

                    out.println("]},");
                    
                    i++;
                }
                 out.println("]}");  
            ME.closeListSession();

    }else{
       out.println(EGVH.displayEmptyGrid(6));      
    }
%>  
