<%-- 
    Document   : productpurchase
    Created on : Jan 30, 2016, 1:08:19 PM
    Author     : TBL
--%>



<%@page import="java.time.*"%>
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
java.util.Date DTcreatedt, DTwritedt,Deffectivefrom,Deffectiveto;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String effectivefrom,effectiveto,stritemid ;
Integer itemid,uomid,supplierid,currencyid,vatid,paramitemid ;
BigDecimal unitprice,minqty,maxqty ;
%>

<%
/************COMPULSORY VARIABLES**********/
strprofileid= session.getAttribute("profileid").toString();
struserid = session.getAttribute("userid").toString();
strid = request.getParameter("id");
stritemid = request.getParameter("itemid");


queryFilter="";
id = Integer.valueOf(strid);
paramitemid = Integer.valueOf(stritemid);

CMuserid = Integer.valueOf(struserid);
CMprofileid = Integer.valueOf(strprofileid);

RH.fetchRightsdata("products",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM ItemPurchase");
formquery.append(" where itemPurchaseId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
ItemPurchase itempurchase = (ItemPurchase) iterator.next();
id = itempurchase.getItemPurchaseId();
unitprice=itempurchase.getUnitPrice();
minqty=itempurchase.getMinQty();
maxqty=itempurchase.getMaxQty();
itemid=itempurchase.getItem().getItemId();
supplierid=itempurchase.getPrcSuppliers().getSupplierId();
uomid=itempurchase.getCrmUom().getUomId();
vatid=itempurchase.getFinVat().getVatId();
currencyid=itempurchase.getAllCurrency().getCurrencyId();

writebyid = itempurchase.getConUserByWritebyId().getUserId();
createbyid=itempurchase.getConUserByCreatebyId().getUserId();
Deffectivefrom=itempurchase.getEffectiveFrom();
effectivefrom = DH.DatetoStrDate(Deffectivefrom);
Deffectiveto=itempurchase.getEffectiveTo();
effectiveto = DH.DatetoStrDate(Deffectiveto);

createdt=DH.DatetimetoStrDatetime(itempurchase.getCreatedt());
writedt=DH.DatetimetoStrDatetime(itempurchase.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetoStrDate(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
unitprice=new BigDecimal("0");
minqty=new BigDecimal("1");
maxqty=new BigDecimal("0");
if(paramitemid!=null){itemid=paramitemid;}else{itemid=0;}
supplierid=0;
uomid=0;
vatid=0;
currencyid=0;
Deffectivefrom = DH.convertToUTC(Calendar.getInstance().getTime());
effectivefrom =DH.DatetoStrDate(Deffectivefrom);
Deffectiveto = DH.convertToUTCTwo(Calendar.getInstance().getTime());
effectiveto =DH.DatetoStrDate(Deffectiveto);



createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHitemid = new ComboHelper();
ComboHelper CHsupplierid = new ComboHelper();
ComboHelper CHuomid = new ComboHelper();
ComboHelper CHvatid = new ComboHelper();
ComboHelper CHcurrencyid = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "hidden", name:"itemid",label:"Itemid", value:"<% out.print(itemid); %>" , validate:"ValidateLength"},
{type: "combo", name:"uomid",label: "Uom Name", filtering:true , required:"true", options:[<% out.print(CHuomid.LoadCombo("uom", queryFilter, uomid)); %>]} ,
{type: "input", name:"unitprice",label:"Unit Price", value:"<% out.print(unitprice); %>", required:"true" , validate:"ValidateLength"},
{type: "combo", name:"supplierid",label: "Supplier Name", filtering:true , options:[<% out.print(CHsupplierid.LoadCombo("suppliers", queryFilter, supplierid)); %>]} ,
{type: "combo", name:"currencyid",label: "Currency Name", filtering:true , options:[<% out.print(CHcurrencyid.LoadCombo("currency", queryFilter, currencyid)); %>]} ,
{type: "combo", name:"vatid",label: "Vat Name", filtering:true , options:[<% out.print(CHvatid.LoadCombo("vatid", queryFilter, vatid)); %>]} ,
{type: "calendar",name:"effectivefrom" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Effective From", value:"<% out.print(effectivefrom); %>"},
{type: "calendar",name:"effectiveto" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Effective To", value:"<% out.print(effectiveto); %>"},
{type: "input", name:"minqty",label:"Min Qty", value:"<% out.print(minqty); %>" , validate:"ValidateLength"},
{type: "input", name:"maxqty",label:"Max Qty", value:"<% out.print(maxqty); %>" , validate:"ValidateLength"},
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 
