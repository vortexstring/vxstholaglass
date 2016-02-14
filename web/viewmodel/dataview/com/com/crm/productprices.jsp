<%-- 
    Document   : productprices
    Created on : Nov 24, 2015, 11:32:51 AM
    Author     : Carol
--%>


<%@page import="java.lang.reflect.Array"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>
<%@ page import="java.text.*" %>
<%@ page import="logic.POSUnits" %>
<%!
    String myq, pricedetails, productPrices;
    List mydata;
    Integer i, pp, myno;
    DecimalFormat dec = new DecimalFormat("0.00");
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
%>      

<%
    productPrices = request.getParameter("productPrices");
    pp = Integer.parseInt(productPrices);

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("SELECT DISTINCT crmUom.uomId , crmUom.uomName,COUNT(itemSaleId) FROM ItemSale   WHERE item.itemId=" + pp);
//SELECT DISTINCT crmUom.uomId , crmUom.uomName 
    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        myno = 7;
        out.println("[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            Object[] OBJ = (Object[]) iterator.next();
            //pricedetails = (dec.format(OBJ.getCrmUom().getUomId())) + " " + "/=";

            Integer uomId = (Integer) OBJ[0];
            String uomName = (String) OBJ[1];
            Long uomCount = (Long) OBJ[2];
            out.println("{ id:\"" + uomId  + "\" ,\"uomname\":\"" + uomName + "\", \"uomcount\":\"" + uomCount + "\"");
           

            out.println("},");
            
            i++;
        }
        out.println("]");
    }
   
    ME.closeListSession();
%>  

