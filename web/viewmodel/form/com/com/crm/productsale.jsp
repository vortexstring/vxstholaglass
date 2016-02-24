<%-- 
    Document   : productsale
    Created on : Jan 30, 2016, 12:55:49 PM
    Author     : TBL
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
java.util.Date DTcreatedt, DTwritedt,Deffectivefrom,Deffectiveto;
RightsHelper RH= new RightsHelper();
DateHelper DH = new DateHelper();
StringHelper SH=new StringHelper();
/**********Form specific fields************/
String effectivefrom,effectiveto,stritemid ;
Integer itemid,uomid,currencyid,vatid,paramitemid ;
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
StringBuilder formquery = new StringBuilder("FROM ItemSale");
formquery.append(" where itemSaleId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
ItemSale itemsale = (ItemSale) iterator.next();
id = itemsale.getItemSaleId();
unitprice=itemsale.getUnitPrice();
minqty=itemsale.getMinQty();
maxqty=itemsale.getMaxQty();
itemid=itemsale.getItem().getItemId();
uomid=itemsale.getCrmUom().getUomId();
currencyid=itemsale.getAllCurrency().getCurrencyId();
vatid=itemsale.getFinVat().getVatId();

writebyid = itemsale.getConUserByWritebyId().getUserId();
createbyid=itemsale.getConUserByCreatebyId().getUserId();
Deffectivefrom=itemsale.getEffectiveFrom();
effectivefrom = DH.DatetoStrDate(Deffectivefrom);
Deffectiveto=itemsale.getEffectiveTo();
effectiveto = DH.DatetoStrDate(Deffectiveto);

createdt=DH.DatetimetoStrDatetime(itemsale.getCreatedt());
writedt=DH.DatetimetoStrDatetime(itemsale.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetoStrDate(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
unitprice=new BigDecimal("0");
minqty=new BigDecimal("1"); //Default Miqty of one
maxqty=new BigDecimal("0");
if(paramitemid!=null){itemid=paramitemid;}else{itemid=0;}
uomid=4; //Default Sqft fo glass
currencyid=1; //Kenya shillings
vatid=1; //16% Vat Inclusive
Deffectivefrom = DH.convertToUTC(Calendar.getInstance().getTime());
effectivefrom =DH.DatetoStrDate(Deffectivefrom);
Deffectiveto = DH.convertToUTCTwo(Calendar.getInstance().getTime());
         //effectiveto.add(Calendar.YEAR, 5);
effectiveto =DH.DatetoStrDate(Deffectiveto);

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHitemid = new ComboHelper();
ComboHelper CHuomid = new ComboHelper();
ComboHelper CHcurrencyid = new ComboHelper();
ComboHelper CHvatid = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "hidden", name:"itemid",label:"Itemid", value:"<% out.print(itemid); %>" , validate:"ValidateLength"},
{type: "combo", name:"uomid",label: "Uom Name", filterinuomidg:true , required:"true", options:[<% out.print(CHuomid.LoadCombo("uom", queryFilter, uomid)); %>]} ,
{type: "input", name:"unitprice",label:"Unit Price", value:"<% out.print(unitprice); %>", required:"true" , validate:"ValidateLength"},
{type: "combo", name:"currencyid",label: "Currency Name", filtering:true , required:"true", options:[<% out.print(CHcurrencyid.LoadCombo("currency", queryFilter, currencyid)); %>]} ,
{type: "combo", name:"vatid",label: "Vat Name", filtering:true , options:[<% out.print(CHvatid.LoadCombo("vatid", queryFilter, vatid)); %>]} ,
{type: "calendar",name:"effectivefrom" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" , required:"true" ,label: "Effective From", value:"<% out.print(effectivefrom); %>"},
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

