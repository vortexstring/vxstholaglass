
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
String accountname,accountnumber,accounttype ;
Integer bankid,currencyid ;
boolean isdefault;
%>

<%
/************COMPULSORY VARIABLES**********/
strprofileid= session.getAttribute("profileid").toString();
struserid = session.getAttribute("userid").toString();
strid = request.getParameter("id");


//createdt = DH.DatetoStrDate(DTcreatedt);

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
StringBuilder formquery = new StringBuilder("FROM BankAccount");
formquery.append(" where accountId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
BankAccount bankaccount = (BankAccount) iterator.next();
id = bankaccount.getAccountId();
accountname=bankaccount.getAccountName();
accountnumber=bankaccount.getAccountNumber();
accounttype=bankaccount.getAccountType();
isdefault=bankaccount.isIsdefault();

currencyid=bankaccount.getAllCurrency().getCurrencyId();
bankid=bankaccount.getBank().getBankId();

writebyid = bankaccount.getConUserByWritebyId().getUserId();
createbyid=bankaccount.getConUserByCreatebyId().getUserId();
}
}
} else {

accountname="";
accountnumber="";
accounttype="";
//isdefault=0;
currencyid=0;
bankid=0;
DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);

writedt = DH.DatetimetoStrDatetime(DTwritedt);
createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHcurrency = new ComboHelper();
ComboHelper CHbank = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"accountname",label:"Accountname", value: "<% out.print(accountname); %> " },
{type: "combo", name:"bankid",label: "Bankid", filtering:true , options:[<% out.print(CHbank.LoadCombo("bank", queryFilter, bankid)); %>]} ,
{type: "combo", name:"currencyid",label: "Currencyid", filtering:true , options:[<% out.print(CHcurrency.LoadCombo("currency", queryFilter, currencyid)); %>]} ,
{type: "input", name:"accountnumber",label:"Accountnumber", value: "<% out.print(accountnumber); %> " },
{ type: "block",width:200, list:[
{type: "label", label:"Accounttype" },
{type: "radio", name: "accounttype", value: "Current" <% out.print(SH.formRadio(accounttype, "Current"));%>, label: "Current",labelWidth: "auto",offsetTop:"0",inputLeft:60},
{type: "radio", name: "accounttype", value: "Savings" <% out.print(SH.formRadio(accounttype, "Savings"));%>, label: "Savings",labelWidth: "auto",offsetTop:"0",inputLeft:60},
{type: "radio", name: "accounttype", value: "Cash" <% out.print(SH.formRadio(accounttype, "Cash"));%>, label: "Cash",labelWidth: "auto",offsetTop:"0",inputLeft:60}
]},
{type: "checkbox", name:"isdefault", label: "Isdefault" <% out.print(SH.formCheckbox(isdefault));%>},
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 