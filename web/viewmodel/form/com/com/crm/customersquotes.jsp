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
java.util.Date DTcreatedt, DTwritedt,Dquotedate;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String quotecode,quotedate,ref,comment ;
Integer customerid ;
BigDecimal totalprice,totalvatableamount,vatamount ;
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

RH.fetchRightsdata("quotes",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM CrmQuote");
formquery.append(" where quoteId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
CrmQuote crmquote = (CrmQuote) iterator.next();
id = crmquote.getQuoteId();
quotecode=crmquote.getQuoteCode();
totalprice=crmquote.getTotalPrice();
totalvatableamount=crmquote.getTotalVatableAmount();
vatamount=crmquote.getVatAmount();
ref=crmquote.getRef();
comment=crmquote.getComment();
customerid=crmquote.getCrmCustomer().getCustomerId();
/*statusid=crmquote.getAllStatus().getStatusId();
posid=crmquote.getCrmPos().getPosId();
quoteid=crmquote.getCrmQuote().getQuoteId();
posid=crmquote.getCrmPos().getPosId();
itemid=crmquote.getItem().getItemId();
itemserviceid=crmquote.getItem().getItemId();
itemsaleid=crmquote.getItemSale().getItemSaleId();
uomid=crmquote.getCrmUom().getUomId();
dimensionuomid=crmquote.getCrmUom().getUomId();*/

writebyid = crmquote.getConUserByWritebyId().getUserId();
createbyid=crmquote.getConUserByCreatebyId().getUserId();
Dquotedate=crmquote.getQuoteDate();
quotedate = DH.DatetoStrDate(Dquotedate);

createdt=DH.DatetimetoStrDatetime(crmquote.getCreatedt());
writedt=DH.DatetimetoStrDatetime(crmquote.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
quotecode="";
totalprice=new BigDecimal("0");
totalvatableamount=new BigDecimal("0");
vatamount=new BigDecimal("0");
ref="";
comment="";
customerid=0;
/*statusid=0;
posid=0;
quoteid=0;
posid=0;
itemid=0;
itemserviceid=0;
itemsaleid=0;
uomid=0;
dimensionuomid=0;*/
Dquotedate = DH.convertToUTC(Calendar.getInstance().getTime());
quotedate =DH.DatetoStrDate(Dquotedate);

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHcustomer = new ComboHelper();
/*ComboHelper CHstatus = new ComboHelper();
ComboHelper CHpos = new ComboHelper();
ComboHelper CHquote = new ComboHelper();
//ComboHelper CHpos = new ComboHelper();
ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
ComboHelper CHuom = new ComboHelper();
ComboHelper CHdimension = new ComboHelper();
*/
%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input",readonly:true, name:"quotecode",label:"Quotecode", value:"<% out.print(quotecode); %>" },
{type: "calendar",readonly:true,name:"quotedate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Quotedate", value:"<% out.print(quotedate); %>"},
{type: "input",readonly:true, name:"totalprice",label:"Totalprice", value:"<% out.print(totalprice); %>" ,   numberFormat:"0,000.00"},
{type: "input",readonly:true, name:"totalvatableamount",label:"Totalvatableamount", value:"<% out.print(totalvatableamount); %>" , numberFormat:"0,000.00"},
{type: "input",readonly:true, name:"vatamount",label:"Vatamount", value:"<% out.print(vatamount); %>" },
{type: "input", name:"ref",label:"Ref", value:"<% out.print(ref); %>" },
{type: "combo", name:"customerid",label: "Customerid", filtering:true , options:[<% out.print(CHcustomer.LoadCombo("customer", queryFilter, customerid)); %>]} ,
{type: "input", name:"comment",label:"Comment", value: "<% out.print(comment); %>",rows:3},
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type:"template",name:"printquote",value:"Print Quote",position:"label-left", format:"doLink"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}, 

{type: "block", blockOffset: 0, list: [
{type: "button",name:"processquote",value: "Sell To Order", position:"label-right"} ]}] 

