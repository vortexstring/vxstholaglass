<%-- 
    Document   : productcolor
    Created on : Jan 30, 2016, 1:14:43 PM
    Author     : TBL
--%>



<%-- IMPORT THE FILES FOR HTTP AND JAVA UTILS --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.math.BigDecimal" %>
<%-- IMPORT CUSTOM FILES FOR BUSINESS LOGIC AND DATA MODELS --%>
<%@ page import="vxsutil.*" %>
<%@ page import="logic.*" %>
<%@ page import="model.*,viewmodel.*" %>


<%!
/*********Compulsory variables*********/
String strid,struserid,strprofileid,formq,queryFilter,edit,del,createdt, writedt;
Integer CMprofileid,CMcompanyid, id, CMuserid,lifeid,createbyid, writebyid;
List formdata;
java.util.Date DTcreatedt, DTwritedt;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String ralno,colourcode,colourname ;
Integer itemid ;
%>

<%
/************COMPULSORY VARIABLES**********/
strprofileid= session.getAttribute("profileid").toString();
struserid = session.getAttribute("userid").toString();
strid = request.getParameter("id");

queryFilter="";
id = Integer.valueOf(strid);
CMuserid = Integer.valueOf(struserid);
CMprofileid = Integer.valueOf(strprofileid);

RH.fetchRightsdata("products",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM ItemColour");
formquery.append(" where itemColourId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
ItemColour itemcolour = (ItemColour) iterator.next();
id = itemcolour.getItemColourId();
ralno=itemcolour.getRalNo();
colourcode=itemcolour.getColourCode();
colourname=itemcolour.getColourName();
itemid=itemcolour.getItem().getItemId();

writebyid = itemcolour.getConUserByWritebyId().getUserId();
createbyid=itemcolour.getConUserByCreatebyId().getUserId();

createdt=DH.DatetimetoStrDatetime(itemcolour.getCreatedt());
writedt=DH.DatetimetoStrDatetime(itemcolour.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetoStrDate(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
ralno="";
colourcode="";
colourname="";
itemid=0;

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHitemid = new ComboHelper();

%>




[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "hidden", name:"itemid",label:"Itemid", value:"<% out.print(itemid); %>" , validate:"ValidateLength"},
{type: "input", name:"colourcode",label:"Colourcode", value:"<% out.print(colourcode); %>", required:"true" , validate:"ValidateLength"},
{type: "colorpicker", name:"ralno",label:"Ralno", value:"<% out.print(ralno); %>" , enableCustomColors: "1", customColors: "#ff9f29,#a3ff2b,#57cdff,#fb26ff,#9f96ff" },

{type: "input", name:"colourname",label:"Colourname", value:"<% out.print(colourname); %>" , validate:"ValidateLength"},
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 