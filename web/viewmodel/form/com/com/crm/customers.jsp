
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
String admndate,customercode,surname,othername,vatno,pinno,memo,contactperson,primarymobileno,primarylandline,primaryemail,boxaddress,boxaddresscode,boxaddresstown,physicaladdress ;
Integer title,idno,countryid,customercategoryid,agentid,paytermid ;
BigDecimal creditlimit ;
boolean credit ;
java.util.Date DTadmndate ;
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

RH.fetchRightsdata("customers",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM CrmCustomer");
formquery.append(" where customerId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
CrmCustomer crmcustomer = (CrmCustomer) iterator.next();
id = crmcustomer.getCustomerId();
customercode=crmcustomer.getCustomerCode();
surname=crmcustomer.getSurname();
othername=crmcustomer.getOthername();
idno=crmcustomer.getIdNo();
vatno=crmcustomer.getVatNo();
pinno=crmcustomer.getPinNo();
memo=crmcustomer.getMemo();
creditlimit=crmcustomer.getCreditLimit();
contactperson=crmcustomer.getContactPerson();
primarymobileno=crmcustomer.getPrimaryMobileNo();
primarylandline=crmcustomer.getPrimaryLandline();
primaryemail=crmcustomer.getPrimaryEmail();
boxaddress=crmcustomer.getBoxAddress();
boxaddresscode=crmcustomer.getBoxAddressCode();
boxaddresstown=crmcustomer.getBoxAddressTown();
physicaladdress=crmcustomer.getPhysicalAddress();
credit=crmcustomer.getCredit();
customercategoryid=crmcustomer.getCrmCustomerCategory().getCustomerCategoryId();
agentid=crmcustomer.getHrmEmployee().getEmployeeId();
paytermid=crmcustomer.getPayterm().getPaytermId();
countryid=crmcustomer.getAllCountry().getCountryId();
title=crmcustomer.getCommonCombo().getComboId();

writebyid = crmcustomer.getConUserByWritebyId().getUserId();
createbyid=crmcustomer.getConUserByCreatebyId().getUserId();
DTadmndate=crmcustomer.getAdmnDate();
admndate = DH.DatetimetoStrDatetime(DTadmndate);

createdt=DH.DatetimetoStrDatetime(crmcustomer.getCreatedt());
writedt=DH.DatetimetoStrDatetime(crmcustomer.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetimetoStrDatetime(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
customercode="";
surname="";
othername="";
idno=0;
vatno="";
pinno="";
memo="";
creditlimit=new BigDecimal("0");
contactperson="";
primarymobileno="";
primarylandline="";
primaryemail="";
boxaddress="";
boxaddresscode="";
boxaddresstown="";
physicaladdress="";
customercategoryid=0;
agentid=0;
paytermid=0;
countryid=0;
title=0;
DTadmndate =DH.convertToUTC(Calendar.getInstance().getTime());
admndate = DH.DatetimetoStrDatetime(DTadmndate);

createbyid = CMuserid;
writebyid = CMuserid;

}
ComboHelper CHcustomer = new ComboHelper();
ComboHelper CHagent = new ComboHelper();
ComboHelper CHpayterm = new ComboHelper();
ComboHelper CHcountry = new ComboHelper();
ComboHelper CHtitle = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "calendar",name:"admndate" , dateFormat: "%Y-%m-%d %H:%i:%s" , serverDateFormat: "%Y-%m-%d %H:%i:%s" ,label: "Admndate", value:"<% out.print(admndate); %> "},
{type: "input", name:"customercode",label:"Customercode", value: "<% out.print(customercode); %> " },
{type: "input", name:"surname",label:"Surname", value: "<% out.print(surname); %> " },
{type: "input", name:"othername",label:"Othername", value: "<% out.print(othername); %> " },
{type: "combo", name:"title",label: "Title", filtering:true , options:[<% out.print(CHtitle.LoadCombo("salutation", queryFilter, title)); %>]} ,
{type: "input", name:"idno",label:"Idno", value: "<% out.print(idno); %> " },
{type: "input", name:"vatno",label:"Vatno", value: "<% out.print(vatno); %> " },
{type: "input", name:"pinno",label:"Pinno", value: "<% out.print(pinno); %> " },
{type: "input", name:"memo",label:"Memo", value: "<% out.print(memo); %> " },
{type: "combo", name:"countryid",label: "Countryid", filtering:true , options:[<% out.print(CHcountry.LoadCombo("country", queryFilter, countryid)); %>]} ,
{type: "combo", name:"customercategoryid",label: "Customercategoryid", filtering:true , options:[<% out.print(CHcustomer.LoadCombo("customercategory", queryFilter, customercategoryid)); %>]} ,
{type: "combo", name:"agentid",label: "Agentid", filtering:true , options:[<% out.print(CHagent.LoadCombo("hrmemployee", queryFilter, agentid)); %>]} ,
{type: "newcolumn"},
{type: "checkbox", name:"credit", label: "Credit" <% out.print(SH.formCheckbox(credit)); %> , checked: true },
{type: "input", name:"creditlimit",label:"Creditlimit", value: "<% out.print(creditlimit); %> " },
{type: "combo", name:"paytermid",label: "Paytermid", filtering:true , options:[<% out.print(CHpayterm.LoadCombo("payterm", queryFilter, paytermid)); %>]} ,
{type: "input", name:"contactperson",label:"Contactperson", value: "<% out.print(contactperson); %> " },
{type: "input", name:"primarymobileno",label:"Primarymobileno", value: "<% out.print(primarymobileno); %> " },
{type: "input", name:"primarylandline",label:"Primarylandline", value: "<% out.print(primarylandline); %> " },
{type: "input", name:"primaryemail",label:"Primaryemail", value: "<% out.print(primaryemail); %> " },
{type: "input", name:"boxaddress",label:"Boxaddress", value: "<% out.print(boxaddress); %> " },
{type: "input", name:"boxaddresscode",label:"Boxaddresscode", value: "<% out.print(boxaddresscode); %> " },
{type: "input", name:"boxaddresstown",label:"Boxaddresstown", value: "<% out.print(boxaddresstown); %> " },
{type: "input", name:"physicaladdress",label:"Physicaladdress", value: "<% out.print(physicaladdress); %> " },
,
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 