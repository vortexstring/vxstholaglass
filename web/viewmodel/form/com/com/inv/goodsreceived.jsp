<%-- 
    Document   : goodsreceived
    Created on : Jan 27, 2016, 12:55:51 PM
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
java.util.Date DTcreatedt, DTwritedt,Dgrndate;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String grncode,grndate,grmmemo,grnref,deliveryno,batchno ;
Integer supplierid,purchaseorderid ;
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

RH.fetchRightsdata("goodsreceived",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM InvGoodsreceived");
formquery.append(" where grnId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
InvGoodsreceived invgoodsreceived = (InvGoodsreceived) iterator.next();
id = invgoodsreceived.getGrnId();
grncode=invgoodsreceived.getGrnCode();
grmmemo=invgoodsreceived.getGrmMemo();
grnref=invgoodsreceived.getGrnRef();
deliveryno=invgoodsreceived.getDeliveryNo();
batchno=invgoodsreceived.getBatchNo();
supplierid=invgoodsreceived.getPrcSuppliers().getSupplierId();
purchaseorderid=invgoodsreceived.getPrcPurchaseOrder().getPurchaseorderId();
/*status=invgoodsreceived.getAllStatus().getStatusId();
storeid=invgoodsreceived.getInvStore().getStoreId();
grnid=invgoodsreceived.getInvGoodsreceived().getGrnId();
itemid=invgoodsreceived.getItem().getItemId();
purchaseuomid=invgoodsreceived.getCrmUom().getUomId();
receiveduomid=invgoodsreceived.getCrmUom().getUomId();
status=invgoodsreceived.getAllStatus().getStatusId();
*/
writebyid = invgoodsreceived.getConUserByWritebyId().getUserId();
createbyid=invgoodsreceived.getConUserByCreatebyId().getUserId();
Dgrndate=invgoodsreceived.getGrnDate();
grndate = DH.DatetoStrDate(Dgrndate);

createdt=DH.DatetimetoStrDatetime(invgoodsreceived.getCreatedt());
writedt=DH.DatetimetoStrDatetime(invgoodsreceived.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
grncode="";
grmmemo="";
grnref="";
deliveryno="";
batchno="";
supplierid=0;
purchaseorderid=0;
/*status=0;
storeid=0;
grnid=0;
itemid=0;
purchaseuomid=0;
receiveduomid=0;
status=0;*/
Dgrndate = DH.convertToUTC(Calendar.getInstance().getTime());
grndate =DH.DatetoStrDate(Dgrndate);

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHsupplier = new ComboHelper();
ComboHelper CHpurchaseorder = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();
ComboHelper CHstore = new ComboHelper();
ComboHelper CHgrn = new ComboHelper();
ComboHelper CHitem = new ComboHelper();
ComboHelper CHpurchaseuom = new ComboHelper();
ComboHelper CHreceiveduom = new ComboHelper();
//ComboHelper CHstatus = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"grncode",label:"Grncode", value:"<% out.print(grncode); %>" },
{type: "calendar",name:"grndate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Grndate", value:"<% out.print(grndate); %>"},
{type: "input", name:"grnref",label:"Grnref", value:"<% out.print(grnref); %>" },
{type: "input", name:"deliveryno",label:"Deliveryno", value:"<% out.print(deliveryno); %>", required:"true" },
{type: "combo", name:"supplierid",label: "Supplierid", filtering:true , options:[<% out.print(CHsupplier.LoadCombo("suppliers", queryFilter, supplierid)); %>]} ,
{type: "combo", name:"purchaseorderid",label: "Purchaseorderid", filtering:true , options:[<% out.print(CHpurchaseorder.LoadCombo("purchaseorder", queryFilter, purchaseorderid)); %>]} ,
{type: "input", name:"batchno",label:"Batchno", value:"<% out.print(batchno); %>" },
{type: "input", name:"grmmemo",label:"Grmmemo", value: "<% out.print(grmmemo); %>",rows:3 },

{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]},

{type: "block", blockOffset: 0, list: [
{type: "button",name:"processgoodsreceived",value: "Post Goods Received", position:"label-right"} ]}] 

