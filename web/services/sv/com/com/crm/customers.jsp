
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
String admn_date,customer_code,surname,othername,title,id_no,vat_no,pin_no,memo,country_id,customer_category_id,agent_id,credit,credit_limit,payterm_id,contact_person,primary_mobile_no,primary_landline,primary_email,box_address,box_address_code,box_address_town,physical_address ;
String id,inputJsonString, myfeedback, actiontype;
Map jsonData;
Array reponseMsg;
Type type = new TypeToken<Map<String, String>>(){}.getType();
Map<String, Object> data = new HashMap< String, Object >();
%>

<%

//GET THE DATA PASSED FROM THE CLIENT
inputJsonString = request.getParameter("data");
actiontype = request.getParameter("actiontype");
//PARSE FORM JSON DATA
try {
Gson gson = new Gson();
jsonData = gson.fromJson(inputJsonString, type);
id = (String) jsonData.get("id");
// DETERMINE THE ACTION TYPE AND CALL THE APPROPRIATE METHOD THAT RETURNS A RESPONSE
CrmCustomerCrud crudCrmCustomer = new CrmCustomerCrud();
if (actiontype.equals("0")) {
if (id.equals("-1")) {
myfeedback = new Gson().toJson(crudCrmCustomer.cud("c", jsonData));
out.print(myfeedback);
} else {
myfeedback = new Gson().toJson(crudCrmCustomer.cud("u", jsonData));
out.print(myfeedback);
}
} else if (actiontype.equals("-5")) {
myfeedback = new Gson().toJson(crudCrmCustomer.cud("d", jsonData));
out.print(myfeedback);
}
} catch (Exception e) {
data.put("msgtype", "fail");
data.put("msg", "Error in JSON Parsing"+e.getMessage());
myfeedback = new Gson().toJson(data);
out.print(myfeedback);
}

%> 