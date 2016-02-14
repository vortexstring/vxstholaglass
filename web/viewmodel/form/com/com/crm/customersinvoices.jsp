<%-- 
    Document   : customersinvoices
    Created on : Jan 28, 2016, 12:08:57 AM
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
java.util.Date DTcreatedt, DTwritedt,Dreviewdt,Dapprovedt,Dsalesinvoicedate;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String salesinvoicecode,salesinvoicedate,ref,comment,reviewdt,approvedt ;
Integer customerid,reviewedby,approvedby ;
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

RH.fetchRightsdata("salesinvoice",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM CrmSalesinvoice");
formquery.append(" where salesinvoiceId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
CrmSalesinvoice crmsalesinvoice = (CrmSalesinvoice) iterator.next();
id = crmsalesinvoice.getSalesinvoiceId();
salesinvoicecode=crmsalesinvoice.getSalesinvoiceCode();
totalprice=crmsalesinvoice.getTotalPrice();
vatamount=crmsalesinvoice.getVatAmount();
ref=crmsalesinvoice.getRef();
comment=crmsalesinvoice.getComment();
customerid=crmsalesinvoice.getCrmCustomer().getCustomerId();
//salesorderid=crmsalesinvoice.getCrmSalesorder().getSalesorderId();
//statusid=crmsalesinvoice.getAllStatus().getStatusId();
reviewedby=crmsalesinvoice.getConUserByApprovedby().getUserId();
approvedby=crmsalesinvoice.getConUserByReviewedby().getUserId();
/*itemserviceid=crmsalesinvoice.getItem().getItemId();
itemsaleid=crmsalesinvoice.getItemSale().getItemSaleId();
uomid=crmsalesinvoice.getCrmUom().getUomId();
dimensionuomid=crmsalesinvoice.getCrmUom().getUomId();
salesorderid=crmsalesinvoice.getCrmSalesorder().getSalesorderId();
salesinvoiceid=crmsalesinvoice.getCrmSalesinvoice().getSalesinvoiceId();
itemid=crmsalesinvoice.getItem().getItemId();
*/
writebyid = crmsalesinvoice.getConUserByWritebyId().getUserId();
createbyid=crmsalesinvoice.getConUserByCreatebyId().getUserId();
Dsalesinvoicedate=crmsalesinvoice.getSalesinvoiceDate();
salesinvoicedate = DH.DatetoStrDate(Dsalesinvoicedate);
Dreviewdt=crmsalesinvoice.getReviewdt();
reviewdt = DH.DatetoStrDate(Dreviewdt);
Dapprovedt=crmsalesinvoice.getApprovedt();
approvedt = DH.DatetoStrDate(Dapprovedt);

createdt=DH.DatetimetoStrDatetime(crmsalesinvoice.getCreatedt());
writedt=DH.DatetimetoStrDatetime(crmsalesinvoice.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
salesinvoicecode="";
totalprice=new BigDecimal("0");
vatamount=new BigDecimal("0");
ref="";
comment="";
customerid=0;
//salesorderid=0;
//statusid=0;
reviewedby=0;
approvedby=0;
/*itemserviceid=0;
itemsaleid=0;
uomid=0;
dimensionuomid=0;
salesorderid=0;
salesinvoiceid=0;
itemid=0;*/
Dsalesinvoicedate = DH.convertToUTC(Calendar.getInstance().getTime());
salesinvoicedate =DH.DatetoStrDate(Dsalesinvoicedate);
Dreviewdt = DH.convertToUTC(Calendar.getInstance().getTime());
reviewdt =DH.DatetoStrDate(Dreviewdt);
Dapprovedt = DH.convertToUTC(Calendar.getInstance().getTime());
approvedt =DH.DatetoStrDate(Dapprovedt);

createbyid = CMuserid;
writebyid = CMuserid;
reviewedby = CMuserid;
approvedby = CMuserid;

}
ComboHelper CHcustomer = new ComboHelper();
ComboHelper CHsalesorder = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();
ComboHelper CHreviewedby = new ComboHelper();
ComboHelper CHapprovedby = new ComboHelper();
ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
ComboHelper CHuom = new ComboHelper();
ComboHelper CHdimension = new ComboHelper();
//ComboHelper CHsalesorder = new ComboHelper();
ComboHelper CHsalesinvoice = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"salesinvoicecode",label:"Salesinvoicecode", value:"<% out.print(salesinvoicecode); %>" },
{type: "calendar",name:"salesinvoicedate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Salesinvoicedate", value:"<% out.print(salesinvoicedate); %>"},
{type: "input", name:"totalprice",label:"Totalprice", value:"<% out.print(totalprice); %>" },
{type: "input", name:"vatamount",label:"Vatamount", value:"<% out.print(vatamount); %>" },
{type: "input", name:"ref",label:"Ref", value:"<% out.print(ref); %>" },
{type: "combo", name:"customerid",label: "Customerid", filtering:true , options:[<% out.print(CHcustomer.LoadCombo("customer", queryFilter, customerid)); %>]} ,{type: "input", name:"comment",label:"Comment", value: "<% out.print(comment); %>",rows:3 },
{type: "hidden", name:"reviewedby",label:"Reviewedby", value:"<% out.print(reviewedby); %>" },
{type: "hidden", name:"reviewdt", id:"reviewdt", value:"<% out.print(reviewdt);%>"},

{type: "hidden", name:"approvedby",label:"Approvedby", value:"<% out.print(approvedby); %>" },

{type: "hidden", name:"approvedt", id:"approvedt", value:"<% out.print(approvedt);%>"},

{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 