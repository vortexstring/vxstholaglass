<%-- 
    Document   : suppliersgoodsreceived
    Created on : Jan 27, 2016, 1:20:31 PM
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
java.util.Date DTcreatedt, DTwritedt,Drecieveddate;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String recieveddate,ref,batchno,purchaseqty ;
Integer grnid,itemid,purchaseuomid,purchaseunits,receiveduomid,receivedqty,receivedunits,storeid ;
BigDecimal purchaseuomqty,purchaseprice,receivedprice,receiveduomqty ;
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
StringBuilder formquery = new StringBuilder("FROM InvGoodsreceivedLine");
formquery.append(" where grnLineId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
InvGoodsreceivedLine invgoodsreceivedline = (InvGoodsreceivedLine) iterator.next();
id = invgoodsreceivedline.getGrnLineId();
ref=invgoodsreceivedline.getRef();
batchno=invgoodsreceivedline.getBatchNo();
purchaseqty=invgoodsreceivedline.getPurchaseqty();
purchaseuomqty=invgoodsreceivedline.getPurchaseuomQty();
purchaseunits=invgoodsreceivedline.getPurchaseunits();
purchaseprice=invgoodsreceivedline.getPurchasePrice();
receivedqty=invgoodsreceivedline.getReceivedqty();
receivedunits=invgoodsreceivedline.getReceivedunits();
receivedprice=invgoodsreceivedline.getReceivedprice();
receiveduomqty=invgoodsreceivedline.getReceiveduomQty();
storeid=invgoodsreceivedline.getInvStore().getStoreId();
grnid=invgoodsreceivedline.getInvGoodsreceived().getGrnId();
itemid=invgoodsreceivedline.getItem().getItemId();
purchaseuomid=invgoodsreceivedline.getCrmUomByPurchaseuomId().getUomId();
receiveduomid=invgoodsreceivedline.getCrmUomByReceiveduomId().getUomId();
//status=invgoodsreceivedline.getAllStatus().getStatusId();

writebyid = invgoodsreceivedline.getConUserByWritebyId().getUserId();
createbyid=invgoodsreceivedline.getConUserByCreatebyId().getUserId();
Drecieveddate=invgoodsreceivedline.getRecievedDate();
recieveddate = DH.DatetoStrDate(Drecieveddate);

createdt=DH.DatetimetoStrDatetime(invgoodsreceivedline.getCreatedt());
writedt=DH.DatetimetoStrDatetime(invgoodsreceivedline.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
ref="";
batchno="";
purchaseqty="";
purchaseuomqty=new BigDecimal("0");
purchaseunits=0;
purchaseprice=new BigDecimal("0");
receivedqty=0;
receivedunits=0;
receivedprice=new BigDecimal("0");
receiveduomqty=new BigDecimal("0");
storeid=0;
grnid=0;
itemid=0;
purchaseuomid=0;
receiveduomid=0;
//status=0;
Drecieveddate = DH.convertToUTC(Calendar.getInstance().getTime());
recieveddate =DH.DatetoStrDate(Drecieveddate);

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHstore = new ComboHelper();
ComboHelper CHgrn = new ComboHelper();
ComboHelper CHitem = new ComboHelper();
ComboHelper CHpurchaseuom = new ComboHelper();
ComboHelper CHreceiveduom = new ComboHelper();
ComboHelper CHstatus = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "hidden", name:"grnid",label:"Grnid", value:"<% out.print(grnid); %>" },
{type: "calendar",name:"recieveddate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Recieveddate", value:"<% out.print(recieveddate); %>"},
{type: "input", name:"ref",label:"Ref", value:"<% out.print(ref); %>" },
{type: "combo", name:"itemid",label: "Itemid", filtering:true , options:[<% out.print(CHitem.LoadCombo("item", queryFilter, itemid)); %>]} ,
{type: "input", name:"batchno",label:"Batchno", value:"<% out.print(batchno); %>" },
{type: "input", name:"purchaseqty",label:"Purchaseqty", value:"<% out.print(purchaseqty); %>" },
{type: "input", name:"purchaseuomqty",label:"Purchaseuomqty", value:"<% out.print(purchaseuomqty); %>" },
{type: "combo", name:"purchaseuomid",label: "Purchaseuomid", filtering:true , options:[<% out.print(CHpurchaseuom.LoadCombo("uom", queryFilter, purchaseuomid)); %>]} ,
{type: "newcolumn"},
{type: "input", name:"purchaseunits",label:"Purchaseunits", value:"<% out.print(purchaseunits); %>" },
{type: "input", name:"purchaseprice",label:"Purchaseprice", value:"<% out.print(purchaseprice); %>" },
{type: "combo", name:"receiveduomid",label: "Receiveduomid", filtering:true , options:[<% out.print(CHreceiveduom.LoadCombo("uom", queryFilter, receiveduomid)); %>]} ,
{type: "input", name:"receivedqty",label:"Receivedqty", value:"<% out.print(receivedqty); %>" },
{type: "input", name:"receivedunits",label:"Receivedunits", value:"<% out.print(receivedunits); %>" },
{type: "input", name:"receivedprice",label:"Receivedprice", value:"<% out.print(receivedprice); %>" },
{type: "input", name:"receiveduomqty",label:"Receiveduomqty", value:"<% out.print(receiveduomqty); %>" },
{type: "combo", name:"storeid",label: "Storeid", filtering:true , options:[<% out.print(CHstore.LoadCombo("store", queryFilter, storeid)); %>]} ,
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 