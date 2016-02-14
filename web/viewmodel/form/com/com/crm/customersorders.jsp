<%-- 
    Document   : customerspos
    Created on : Dec 10, 2015, 10:21:06 PM
    Author     : pharis wambui
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
java.util.Date DTcreatedt, DTwritedt,Dsalesorderdate;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String salesordercode,salesorderdate,ref,comment ;
Integer customerid,quoteid ;
BigDecimal totalprice,vatamount ;
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

RH.fetchRightsdata("salesorder",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM CrmSalesorder");
formquery.append(" where salesorderId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
CrmSalesorder crmsalesorder = (CrmSalesorder) iterator.next();
id = crmsalesorder.getSalesorderId();
salesordercode=crmsalesorder.getSalesorderCode();
totalprice=crmsalesorder.getTotalPrice();
vatamount=crmsalesorder.getVatAmount();
ref=crmsalesorder.getRef();
comment=crmsalesorder.getComment();
//approvedby=crmsalesorder.getConUser().getUserId();
customerid=crmsalesorder.getCrmCustomer().getCustomerId();
quoteid=crmsalesorder.getCrmQuote().getQuoteId();
/*statusid=crmsalesorder.getAllStatus().getStatusId();
posid=crmsalesorder.getCrmPos().getPosId();
reviewedby=crmsalesorder.getConUser().getUserId();
salesorderid=crmsalesorder.getCrmSalesorder().getSalesorderId();*/
quoteid=crmsalesorder.getCrmQuote().getQuoteId();
/*posid=crmsalesorder.getCrmPos().getPosId();
itemid=crmsalesorder.getItem().getItemId();
itemserviceid=crmsalesorder.getItem().getItemId();
itemsaleid=crmsalesorder.getItemSale().getItemSaleId();
uomid=crmsalesorder.getCrmUom().getUomId();
dimensionuomid=crmsalesorder.getCrmUom().getUomId();*/

writebyid = crmsalesorder.getConUserByWritebyId().getUserId();
createbyid=crmsalesorder.getConUserByCreatebyId().getUserId();
Dsalesorderdate=crmsalesorder.getSalesorderDate();
salesorderdate = DH.DatetoStrDate(Dsalesorderdate);

createdt=DH.DatetimetoStrDatetime(crmsalesorder.getCreatedt());
writedt=DH.DatetimetoStrDatetime(crmsalesorder.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
salesordercode="";
totalprice=new BigDecimal("0");
vatamount=new BigDecimal("0");
ref="";
comment="";
//approvedby=0;
customerid=0;
quoteid=0;
/*statusid=0;
posid=0;
reviewedby=0;
salesorderid=0;*/
quoteid=0;
/*posid=0;
itemid=0;
itemserviceid=0;
itemsaleid=0;
uomid=0;
dimensionuomid=0;*/
Dsalesorderdate = DH.convertToUTC(Calendar.getInstance().getTime());
salesorderdate =DH.DatetoStrDate(Dsalesorderdate);

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHapprovedby = new ComboHelper();
ComboHelper CHcustomer = new ComboHelper();
ComboHelper CHquote = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();
ComboHelper CHpos = new ComboHelper();
ComboHelper CHreviewedby = new ComboHelper();
ComboHelper CHsalesorder = new ComboHelper();
//ComboHelper CHquote = new ComboHelper();
//ComboHelper CHpos = new ComboHelper();
ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
ComboHelper CHuom = new ComboHelper();
ComboHelper CHdimension = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"salesordercode",label:"Salesordercode", value:"<% out.print(salesordercode); %>" },
{type: "input", name:"salesorderdate",label:"Salesorderdate", value:"<% out.print(salesorderdate); %>" },
{type: "input", name:"totalprice",label:"Totalprice", value:"<% out.print(totalprice); %>" },
{type: "input", name:"vatamount",label:"Vatamount", value:"<% out.print(vatamount); %>" },
{type: "input", name:"ref",label:"Ref", value:"<% out.print(ref); %>" },
{type: "combo", name:"customerid",label: "Customerid", filtering:true , options:[<% out.print(CHcustomer.LoadCombo("customer", queryFilter, customerid)); %>]} ,
<!--{type: "combo", name:"quoteid",label: "Quoteid", filtering:true , options:[<% out.print(CHquote.LoadCombo("quote", queryFilter, quoteid)); %>]} ,-->
{type: "input", name:"quoteid",label:"quoteid", value:"1" },
{type: "input", name:"comment",label:"Comment", value: "<% out.print(comment); %>",rows:3 },
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 