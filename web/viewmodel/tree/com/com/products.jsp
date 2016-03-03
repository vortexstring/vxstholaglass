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
    String myq, treeData,stritemlevel,stritemconfiguration,param;
    List mydata;
    Integer i,itemlevel,itemconfiguration;
    
%>

<%
    
    
    
    stritemlevel = request.getParameter("itemlevel");
    stritemconfiguration = request.getParameter("itemconfiguration");
    
    itemlevel=Integer.valueOf(stritemlevel);
    itemconfiguration=Integer.valueOf(stritemconfiguration);
    
    //WHERE itemLevel=1 AND  itemConfiguration=4
    treeData="";
 out.println("{id:0,text:\"Products\" , item:[");
   
   TreeHelper TH=new TreeHelper();
     DataLoader ME = new DataLoader();
     if(!stritemlevel.equals("-1")){  param=" WHERE itemLevel="+itemlevel; }else{ param="";}
   
     if(!stritemconfiguration.equals("-1")){ 
         if(param.isEmpty()){ param=" WHERE  itemConfiguration="+itemconfiguration;} else {param=param+" AND  itemConfiguration="+itemconfiguration;}
     
     }
     
    if(param.isEmpty()){param="FROM Item where itemLevel=1"; }
     StringBuilder myquery = new StringBuilder(" FROM Item "+param);

        mydata = ME.getData(myquery.toString());

     if (!mydata.isEmpty()) {
            i = 1;

            //LOOP THROUGH THE GRID
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                Item OBJ = (Item) iterator.next();
               treeData=treeData+"{id:"+OBJ.getItemId()+",text:\""+OBJ.getItemName()+"\", open:1, item:[";
               treeData=treeData+TH.printnode(OBJ.getItemId());
               treeData=treeData+"]},";
            }
             out.println(treeData);
        }
      //  treeData=treeData+""+TH.printnode(5);
 
    out.println("]}");
    ME.closeListSession();
 
   

    

%>  
