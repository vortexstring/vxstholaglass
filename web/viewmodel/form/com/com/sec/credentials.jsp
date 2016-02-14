

<%-- IMPORT THE FILES FOR HTTP AND JAVA UTILS --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
String username,password,loginkey ;
Integer userid,profileid,statusid,branchid ;
%>

<%
/************COMPULSORY VARIABLES**********/
strprofileid= session.getAttribute("profileid").toString();
struserid = session.getAttribute("userid").toString();
strid = request.getParameter("id");

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
queryFilter="";
id = Integer.valueOf(strid);
CMuserid = Integer.valueOf(struserid);
CMprofileid = Integer.valueOf(strprofileid);

RH.fetchRightsdata("credentials",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM ConAuth");
formquery.append(" where authId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
ConAuth conauth = (ConAuth) iterator.next();
id = conauth.getAuthId();
username=conauth.getUsername();
password=conauth.getPassword();
loginkey=conauth.getLoginKey();
branchid=conauth.getBranchId();
userid=conauth.getConUserByUserId().getUserId();
profileid=conauth.getConProfiles().getProfileId();
statusid=conauth.getAllStatus().getStatusId();

writebyid = conauth.getConUserByWritebyId().getUserId();
createbyid=conauth.getConUserByCreatebyId().getUserId();
}
}
} else {

username="";
password="";
loginkey="";
branchid=0;
userid=0;
profileid=0;
statusid=0;

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHuser = new ComboHelper();
ComboHelper CHprofile = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"username",label:"Username", value: "<% out.print(username); %> " },
{type: "input", name:"password",label:"Password", value: "<% out.print(password); %> " },
{type: "input", name:"loginkey",label:"Loginkey", value: "<% out.print(loginkey); %> " },
{type: "combo", name:"userid",label: "Userid", filtering:true , options:[<% out.print(CHuser.LoadCombo("user", queryFilter, userid)); %>]} ,
{type: "combo", name:"profileid",label: "Profileid", filtering:true , options:[<% out.print(CHprofile.LoadCombo("profile", queryFilter, profileid)); %>]} ,
{type: "select", name:"statusid",label: "Statusid" , options:[<% out.print(CHstatus.LoadCombo("status", queryFilter, statusid)); %>]} ,
{type: "input", name:"branchid",label:"Branchid", value: "<% out.print(branchid); %>" },
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 