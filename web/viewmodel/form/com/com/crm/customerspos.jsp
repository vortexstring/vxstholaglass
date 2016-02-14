<%-- 
    Document   : customerspos
    Created on : Dec 10, 2015, 10:21:06 PM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="logic.*" %>
<%@ page import="model.*,viewmodel.*" %>
<%!
    String strid,  struserid, emptyString, formq,ref,poscode,comment,strstatusid;
    Integer  id, userid,statusid;
    List formdata;
    Date posdate;
%>


[{type: "settings", position: "label-left", labelWidth: "100",offsetLeft: "10", inputWidth: "130",offsetTop:"10"},

{type: "input", name:"poscode",label:"Poscode", value: "" },
{type: "calendar",name:"posdate" , dateFormat: "%d/%m/%Y" ,label: "Posdate", value:""},
{type: "input", name:"totalprice",label:"Totalprice", value: "" },
{type: "input", name:"amount",label:"Amount", value: "" },
{type: "input", name:"totalvatableamount",label:"Totalvatable", value: "" },
{type: "input", name:"ref",label:"Ref", value: "" },
{type: "combo", name:"statusid",label: "Statusid", filtering:true , options:[]},
{type: "input", name:"comment",label:"Comment", value: "" ,rows:3 },

{type: "hidden", name:"id", value:""},
{type: "hidden", name:"userid", value:""},


{type: "block", blockOffset: 0, list: [
{type: "button",name:"save",value: "Save"},
{type: "newcolumn"},
{type: "button",name:"delete",value: "Delete"} ]}] 
