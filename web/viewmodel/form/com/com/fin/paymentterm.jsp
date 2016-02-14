<%-- 
    Document   : users
    Created on : Nov 16, 2015, 8:44:48 AM
    Author     : TBL
--%>

<%@page import="vxsutil.DateHelper"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="logic.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String strid, struserid, emptyString, formq,paytermname,comments;
    Integer id, userid;
    List formdata;
    DateFormat SimpleFormat;
    Date Createdt, Writedt;
    DateHelper DH = new DateHelper();
%>


<%
   
    emptyString = "";
    struserid = session.getAttribute("userid").toString();
    strid = request.getParameter("id");
    id = Integer.valueOf(strid);
    userid = Integer.valueOf(struserid);

    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM Payterm ");
        formquery.append(" where paytermId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());

        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                Payterm OBJ = (Payterm) iterator.next();
                id = OBJ.getPaytermId();
                paytermname = OBJ.getPaytermName();
                comments = OBJ.getComments();
               

            }
        }
    } else {
        id = -1;

    }
%>

[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"paytermname",label:"Paytermname", value: "<% out.print(paytermname);%>" },
{type: "input", name:"comments",label:"Comments", value: "<% out.print(comments);%>" ,rows:5 },

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "hidden", name:"userid", value:"<% out.print(userid);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save",value: "Save"},
{type: "newcolumn"},
{type: "button",name:"delete",value: "Delete"} ]}]

