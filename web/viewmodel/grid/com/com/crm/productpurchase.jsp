<%-- 
    Document   : products
    Created on : Nov 16, 2015, 2:50:02 PM
    Author     : TBL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*,viewmodelhelpers.*" %>


<%!
    String myq, namedetails,saledetails,vatdetails,strid;
    List mydata;
    Integer i,id;
   //  ;
%>

<%
    strid = request.getParameter("id");
    id=Integer.parseInt(strid);
    ProductsVH  PVH=new ProductsVH();
         EmptyGridVH  EGVH=new EmptyGridVH();

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM ItemPurchase where life=1 AND item_purchase_id>0 AND item.itemId="+id);


    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            ItemPurchase OBJ = (ItemPurchase) iterator.next();
            saledetails = OBJ.getUnitPrice()+ " / " + OBJ.getAllCurrency().getSymbol();
            out.println("{ id:" + OBJ.getItemPurchaseId()+ ", data:[");
            out.println("\"" + i + "\",");
            out.println("\"" + OBJ.getItem().getItemName()+ "\",");
            out.println("\"" + OBJ.getCrmUom().getUomName()+ "\",");
            out.println("\"" + saledetails + "\",");
            out.println("\"" + OBJ.getFinVat().getVatName()+ "\",");
            out.println("\"" + OBJ.getEffectiveFrom()+ "\",");
            out.println("\"" + OBJ.getEffectiveTo()+ "\",");
            out.println("\"" + OBJ.getMinQty()+ "\",");
            out.println("\"" + OBJ.getMaxQty()+ "\"");

            
            
          //  out.println(PVH.getDynamicGridData(OBJ,OBJ.getItemLevel().getItemLevelId()));
           
           // out.println("\"" + OBJ.+ "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
            ME.closeListSession();

    }else{
               out.println(EGVH.displayEmptyGrid(10));      

    }
%>  

