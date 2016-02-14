
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
    String myq, namedetails, strid;
    List mydata;
    Integer i, id;

    ;
%>

<%   strid = request.getParameter("id");
    id = Integer.parseInt(strid);

    DataLoader ME = new DataLoader();
    StringBuilder myquery = new StringBuilder("FROM Item where life=1 AND itemLevel>0 AND itemId=" + id);

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;

        out.println("{");
        out.println("settings: {");
        out.println("align: \"left\",");
        out.println("hrefmode:\"ajax\",");
        out.println("skin: \"dhx_terrace\",");
        out.println("},");
        out.println("tabs: [");

        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            Item OBJ = (Item) iterator.next();

            out.println(" {id: \"product\", text: \"Product\",active: 1, width: \"auto\" },");

            
         if (OBJ.getItemConfiguration().isIsSold()) {
                out.println(" {id: \"saledetails\", text: \"Sale Details\" , width: \"auto\" , href: \"./view/com/com/crm/productsale.jsp?id='"+id+"'\"},");

            }
         
         
            if (OBJ.getItemConfiguration().isIsPurchased()) {
                out.println(" {id: \"purchasedetails\", text: \"Purchase Details\" , width: \"auto\" , href: \"./view/com/com/crm/productpurchase.jsp?id="+id+"\"},");

            }
          /*  
               if (OBJ.getItemConfiguration().isIsProduction()) {
                out.println(" {id: \"production\", text: \"Production details\" , width: \"auto\" , href: \"./view/com/com/crm/productproduction.jsp\"},");

            }

       
            if (OBJ.getItemConfiguration().isHasDimensions()) {
                out.println(" {id: \"dimensions\", text: \"Dimensions\" , width: \"auto\" , href: \"./view/com/com/crm/productdimensions.jsp\" },");

            }

            if (OBJ.getItemConfiguration().isHasProductionTemplate()) {
                out.println(" {id: \"template\", text: \"Template\" , width: \"auto\" , href: \"./view/com/com/crm/productproductiontemplate.jsp\"},");

            }

            
            if (OBJ.getItemConfiguration().getHasColour()) {
                out.println(" {id: \"colour\", text: \"Colour\" , width: \"auto\" , href: \"./view/com/com/crm/productcolor.jsp?id="+id+"\"},");

            }
*/

            // out.println(" {id: \""+OBJ.getItemConfiguration().getConfigurationName()+"\", text: \""+OBJ.getItemConfiguration().getConfigurationName()+"\"}");
            i++;
        }
        out.println("]}");
    }
    ME.closeListSession();
%>  

