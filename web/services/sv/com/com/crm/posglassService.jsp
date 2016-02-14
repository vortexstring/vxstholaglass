
<%@page import="logic.ProcessDimension"%>
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
String pos_id,item_id,item_service_id,item_sale_id,price,qty,discount,interest,percent_disc,percent_int,amount,vatable_amount,vat_amount,uom_id,uom_qty,qdate,memo,dimension_uom_id,dimension_length,dimension_width,dimension_thickness,dimension_thickness_num,dimension_thickness_denom,dimension_length_num,dimension_length_denom,dimension_width_num,dimension_width_denom,ral_no,status ;
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
CrmPosLineCrud crudCrmPosLine = new CrmPosLineCrud();
ProcessDimension PD =new ProcessDimension();

if (actiontype.equals("0")) {
if (id.equals("-1")) {  
myfeedback = new Gson().toJson(crudCrmPosLine.cud("c", jsonData));
out.print(myfeedback);
} else {
myfeedback = new Gson().toJson(crudCrmPosLine.cud("u", jsonData));
out.print(myfeedback);
}
} else if (actiontype.equals("-5")) {
myfeedback = new Gson().toJson(crudCrmPosLine.cud("d", jsonData));
out.print(myfeedback);
}else if(actiontype.equals("-10")) {
    
 myfeedback = new Gson().toJson(PD.calculate(jsonData)); 
out.print(myfeedback);
   
}


} catch (Exception e) {
data.put("msgtype", "fail");
data.put("msg", "Error in JSON Parsing"+e.getMessage());
myfeedback = new Gson().toJson(data);
out.print(myfeedback);
}

%> 