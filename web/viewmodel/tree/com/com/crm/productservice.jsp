<%-- 
    Document   : productservice
    Created on : Feb 9, 2016, 3:05:16 PM
    Author     : pharis wambui
--%>

<%-- 
    Document   : stores
    Created on : Dec 15, 2015, 10:51:35 AM
    Author     : pharis wambui
--%>


<%@page import="vxsutil.TreeHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, treeData;
    List mydata;
    Integer i;
    
%>

<%
    
    treeData="";
 out.println("{id:0,text:\"Products\" , item:[");
   
   TreeHelper TH=new TreeHelper();
     DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM Item where parent_id=6");

        mydata = ME.getData(myquery.toString());

     if (!mydata.isEmpty()) {
            i = 1;

            //LOOP THROUGH THE GRID
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                Item OBJ = (Item) iterator.next();
               treeData=treeData+"{id:"+OBJ.getItemId()+",text:\""+OBJ.getItemName()+"\",item:[";
               treeData=treeData+TH.printnode(OBJ.getItemId());
               treeData=treeData+"]},";
            }
             out.println(treeData);
        }
      //  treeData=treeData+""+TH.printnode(5);
 
    out.println("]}");
    ME.closeListSession();
 
   

    

%>  
