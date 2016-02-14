<%-- 
    Document   : customersquotes
    Created on : Jan 21, 2016, 10:07:12 AM
    Author     : pharis wambui
--%>



<%@page import="viewmodel.DataLoader"%>
<%--IMPORT THE JSON FILES FOR READING THE JSON DATA RECEIVED AND CONVERT IT TO A MAPPER --%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="com.google.gson.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- IMPORT FILES FOR HTTP AND BASIC UTILITIES --%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%-- IMPORT THE DATA MODEL AND CRUD OPERATIONS FILES --%>
<%@ page import="model.*,crud_crm.*" %>




<%!
String strquoteid,FormRq,myfeedback ;
Integer quoteid;
List formdata;
Map <String, Object> SaleOrderdata = new HashMap< String, Object >();
%>

<%
//GET THE DATA PASSED FROM THE CLIENT
strquoteid = request.getParameter("quoteid");
quoteid=Integer.parseInt(strquoteid);


DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM CrmQuote");
formquery.append(" where quoteId=" + quoteid);

formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
CrmQuote crmquote = (CrmQuote) iterator.next();
SaleOrderdata.put("id","-1");
SaleOrderdata.put("salesordercode", crmquote.getQuoteCode());
SaleOrderdata.put("salesorderdate", crmquote.getQuoteDate());
SaleOrderdata.put("totalprice", crmquote.getTotalPrice());
SaleOrderdata.put("vatamount", crmquote.getVatAmount());
SaleOrderdata.put("ref", crmquote.getRef());
SaleOrderdata.put("customerid", crmquote.getCrmCustomer().getCustomerId());
SaleOrderdata.put("quoteid", crmquote.getQuoteId());
SaleOrderdata.put("comment", crmquote.getComment());
SaleOrderdata.put("createbyid", crmquote.getConUserByCreatebyId());
SaleOrderdata.put("writebyid", crmquote.getConUserByWritebyId());
SaleOrderdata.put("createdt", crmquote.getCreatedt());
SaleOrderdata.put("writedt", crmquote.getWritedt());
SaleOrderdata.put("	companyid", "1");


CrmSalesorderCrud crudCrmSalesorder = new CrmSalesorderCrud();

myfeedback = new Gson().toJson(crudCrmSalesorder.cud("c", SaleOrderdata));
out.print(myfeedback);

}

}




%> 
