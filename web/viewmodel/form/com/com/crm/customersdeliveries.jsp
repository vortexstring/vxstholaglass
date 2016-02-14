<%-- 
    Document   : customersdeliveries
    Created on : Jan 28, 2016, 9:15:30 AM
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
java.util.Date DTcreatedt, DTwritedt;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String deliverycode,deliverydate,ref,comment,approvedate ;
Integer customerid,salesorderid,approveby ;
BigDecimal amount ;
java.util.Date DTdeliverydate,DTapprovedate ;
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

RH.fetchRightsdata("deliveries",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM CrmDelivery");
formquery.append(" where deliveryId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
CrmDelivery crmdelivery = (CrmDelivery) iterator.next();
id = crmdelivery.getDeliveryId();
deliverycode=crmdelivery.getDeliveryCode();
amount=crmdelivery.getAmount();
ref=crmdelivery.getRef();
comment=crmdelivery.getComment();
salesorderid=crmdelivery.getCrmSalesorder().getSalesorderId();
//status=crmdelivery.getAllStatus().getStatusId();
customerid=crmdelivery.getCrmCustomer().getCustomerId();
approveby=crmdelivery.getConUserByApproveby().getUserId();
/*deliveryid=crmdelivery.getCrmDelivery().getDeliveryId();
itemid=crmdelivery.getItem().getItemId();
itemserviceid=crmdelivery.getItem().getItemId();
itemsaleid=crmdelivery.getItemSale().getItemSaleId();
uomid=crmdelivery.getCrmUom().getUomId();
dimensionuomid=crmdelivery.getCrmUom().getUomId();*/

writebyid = crmdelivery.getConUserByWritebyId().getUserId();
createbyid=crmdelivery.getConUserByCreatebyId().getUserId();
DTdeliverydate=crmdelivery.getDeliveryDate();
deliverydate = DH.DatetimetoStrDatetime(DTdeliverydate);
DTapprovedate=crmdelivery.getApprovedate();
approvedate = DH.DatetimetoStrDatetime(DTapprovedate);

createdt=DH.DatetimetoStrDatetime(crmdelivery.getCreatedt());
writedt=DH.DatetimetoStrDatetime(crmdelivery.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
deliverycode="";
amount=new BigDecimal("0");
ref="";
comment="";
salesorderid=0;
//status=0;
customerid=0;
/*approveby=0;
deliveryid=0;
itemid=0;
itemserviceid=0;
itemsaleid=0;
uomid=0;
dimensionuomid=0;*/
DTdeliverydate =DH.convertToUTC(Calendar.getInstance().getTime());
deliverydate = DH.DatetimetoStrDatetime(DTdeliverydate);
DTapprovedate =DH.convertToUTC(Calendar.getInstance().getTime());
approvedate = DH.DatetimetoStrDatetime(DTapprovedate);

createbyid = CMuserid;
writebyid = CMuserid;
approveby = CMuserid;

}
ComboHelper CHsalesorder = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();
ComboHelper CHcustomer = new ComboHelper();
ComboHelper CHapproveby = new ComboHelper();
ComboHelper CHdelivery = new ComboHelper();
ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
//ComboHelper CHitem = new ComboHelper();
ComboHelper CHuom = new ComboHelper();
ComboHelper CHdimension = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"deliverycode",label:"Deliverycode", value:"<% out.print(deliverycode); %>" },
{type: "calendar",name:"deliverydate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Deliverydate", value:"<% out.print(deliverydate); %>"},
{type: "combo", name:"customerid",label: "Customerid", filtering:true , options:[<% out.print(CHcustomer.LoadCombo("customer", queryFilter, customerid)); %>]} ,
{type: "hidden", name:"amount",label:"Amount", value:"<% out.print(amount); %>" },
{type: "input", name:"ref",label:"Ref", value:"<% out.print(ref); %>" },
{type: "combo", name:"salesorderid",label: "Salesorderid", filtering:true , options:[<% out.print(CHsalesorder.LoadCombo("salesorder", queryFilter, salesorderid)); %>]} ,
{type: "input", name:"comment",label:"Comment", value: "<% out.print(comment); %>",rows:3 },
{type: "hidden", name:"approveby",label:"Approveby", value:"<% out.print(approveby); %>" },
{type: "hidden", name:"approvedate",label:"Approvedate", value:"<% out.print(approvedate); %>" },
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 