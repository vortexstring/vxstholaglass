<%-- 
    Document   : users
    Created on : Nov 16, 2015, 8:44:48 AM
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
String surname,othername ;
Integer profileid,status ;
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

RH.fetchRightsdata("users",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM ConUser");
formquery.append(" where userId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
ConUser conuser = (ConUser) iterator.next();
id = conuser.getUserId();
surname=conuser.getSurname();
othername=conuser.getOtherName();
profileid=conuser.getConProfiles().getProfileId();
status=conuser.getAllStatus().getStatusId();

writebyid = conuser.getConUserByWritebyId().getUserId();
createbyid=conuser.getConUserByCreatebyId().getUserId();

createdt=DH.DatetimetoStrDatetime(conuser.getCreatedt());
writedt=DH.DatetimetoStrDatetime(conuser.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
surname="";
othername="";
profileid=0;
status=0;

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHprofile = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"surname",label:"Surname", value:"<% out.print(surname); %>", required:"true" },
{type: "input", name:"othername",label:"Othername", value:"<% out.print(othername); %>", required:"true" },
{type: "combo", name:"profileid",label: "Profileid", filtering:true , required:"true", options:[<% out.print(CHprofile.LoadCombo("profile", queryFilter, profileid)); %>]} ,
{type: "combo", name:"status",label: "Status", filtering:true , options:[<% out.print(CHstatus.LoadCombo("status", queryFilter, status)); %>]} ,
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 
        
  