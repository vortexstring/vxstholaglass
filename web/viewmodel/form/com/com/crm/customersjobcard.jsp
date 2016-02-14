<%-- 
    Document   : customersjobcard
    Created on : Jan 28, 2016, 2:00:18 AM
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
java.util.Date DTcreatedt, DTwritedt,Djobcarddate,Dreviewdt,Dapprovedt;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String jobcardcode,jobcarddate,comment,reviewdt,approvedt ;
Integer customerid,salesorderid,reviewedby,approvedby ;
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

RH.fetchRightsdata("jobcard",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM MfcJobcard");
formquery.append(" where jobcardId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
MfcJobcard mfcjobcard = (MfcJobcard) iterator.next();
id = mfcjobcard.getJobcardId();
jobcardcode=mfcjobcard.getJobcardCode();
comment=mfcjobcard.getComment();
approvedby=mfcjobcard.getConUserByApprovedby().getUserId();
customerid=mfcjobcard.getCrmCustomer().getCustomerId();
//statusid=mfcjobcard.getAllStatus().getStatusId();
salesorderid=mfcjobcard.getCrmSalesorder().getSalesorderId();
reviewedby=mfcjobcard.getConUserByReviewedby().getUserId();
/*uomid=mfcjobcard.getCrmUom().getUomId();
dimensionuomid=mfcjobcard.getCrmUom().getUomId();
jobcardid=mfcjobcard.getMfcJobcard().getJobcardId();
salesorderid=mfcjobcard.getCrmSalesorder().getSalesorderId();
itemid=mfcjobcard.getItem().getItemId();
itemserviceid=mfcjobcard.getItem().getItemId();
itemsaleid=mfcjobcard.getItemSale().getItemSaleId();
*/
writebyid = mfcjobcard.getConUserByWritebyId().getUserId();
createbyid=mfcjobcard.getConUserByCreatebyId().getUserId();
Djobcarddate=mfcjobcard.getJobcardDate();
jobcarddate = DH.DatetoStrDate(Djobcarddate);
Dreviewdt=mfcjobcard.getReviewdt();
reviewdt = DH.DatetoStrDate(Dreviewdt);
Dapprovedt=mfcjobcard.getApprovedt();
approvedt = DH.DatetoStrDate(Dapprovedt);

createdt=DH.DatetimetoStrDatetime(mfcjobcard.getCreatedt());
writedt=DH.DatetimetoStrDatetime(mfcjobcard.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
jobcardcode="";
comment="";
//approvedby=0;
customerid=0;
//statusid=0;
salesorderid=0;
//reviewedby=0;
/*uomid=0;
dimensionuomid=0;
jobcardid=0;
salesorderid=0;
itemid=0;
itemserviceid=0;
itemsaleid=0;*/
Djobcarddate = DH.convertToUTC(Calendar.getInstance().getTime());
jobcarddate =DH.DatetoStrDate(Djobcarddate);
Dreviewdt = DH.convertToUTC(Calendar.getInstance().getTime());
reviewdt =DH.DatetoStrDate(Dreviewdt);
Dapprovedt = DH.convertToUTC(Calendar.getInstance().getTime());
approvedt =DH.DatetoStrDate(Dapprovedt);

createbyid = CMuserid;
writebyid = CMuserid;
reviewedby = CMuserid;
approvedby = CMuserid;

}
ComboHelper CHapprovedby = new ComboHelper();
ComboHelper CHcustomer = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();
ComboHelper CHsalesorder = new ComboHelper();
ComboHelper CHreviewedby = new ComboHelper();
ComboHelper CHuom = new ComboHelper();
ComboHelper CHdimension = new ComboHelper();
ComboHelper CHjobcard = new ComboHelper();
//ComboHelper CHsalesorder = new ComboHelper();
ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"jobcardcode",label:"Jobcardcode", value:"<% out.print(jobcardcode); %>" },
{type: "calendar",name:"jobcarddate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Jobcarddate", value:"<% out.print(jobcarddate); %>"},
{type: "combo", name:"customerid",label: "Customerid", filtering:true , options:[<% out.print(CHcustomer.LoadCombo("customer", queryFilter, customerid)); %>]} ,
{type: "combo", name:"salesorderid",label: "Salesorderid", filtering:true , options:[<% out.print(CHsalesorder.LoadCombo("salesorder", queryFilter, salesorderid)); %>]} ,
{type: "input", name:"comment",label:"Comment", value: "<% out.print(comment); %>",rows:3 },
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
