


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
String configurationname ;
boolean hasColour,isPurchased,isProduction,isSold,hasDimensions,hasProductionTemplate ;
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

RH.fetchRightsdata("item",CMprofileid);
edit=RH.formRightsStmt(RH.isCanedit());
del=RH.formRightsStmt(RH.isCandel());

/*********FORM SPECIFIC CODE************/
if (!strid.equals("-1")) {

DataLoader FormRq = new DataLoader();
StringBuilder formquery = new StringBuilder("FROM ItemConfiguration");
formquery.append(" where itemConfigurationId=" + id);
formq = formquery.toString();
formdata = FormRq.getData(formquery.toString());
if (!formdata.isEmpty()) {
for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
ItemConfiguration itemconfiguration = (ItemConfiguration) iterator.next();
id = itemconfiguration.getItemConfigurationId();
configurationname=itemconfiguration.getConfigurationName();
hasColour=itemconfiguration.isHasColour();
isPurchased=itemconfiguration.isIsPurchased();
isProduction=itemconfiguration.isIsProduction();
isSold=itemconfiguration.isIsSold();
hasDimensions=itemconfiguration.isHasDimensions();
hasProductionTemplate=itemconfiguration.isHasProductionTemplate();

writebyid = itemconfiguration.getConUserByWritebyId().getUserId();
createbyid=itemconfiguration.getConUserByCreatebyId().getUserId();

createdt=DH.DatetimetoStrDatetime(itemconfiguration.getCreatedt());
writedt=DH.DatetimetoStrDatetime(itemconfiguration.getWritedt());
}
}
} else {

DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
createdt = DH.DatetoStrDate(DTcreatedt);
writedt = DH.DatetimetoStrDatetime(DTwritedt);
configurationname="";

createbyid = CMuserid;
writebyid = CMuserid;

}

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"configurationname",label:"Configurationname", value:"<% out.print(configurationname); %>", required:"true" , validate:"ValidateLength"},
{type: "checkbox", name:"hascolour", label: "Hascolour" <% out.print(SH.formCheckbox(hasColour)); %>  },
{type: "checkbox", name:"ispurchased", label: "Ispurchased" <% out.print(SH.formCheckbox(isPurchased)); %>  },
{type: "checkbox", name:"isproduction", label: "Isproduction" <% out.print(SH.formCheckbox(isProduction)); %>  },
{type: "checkbox", name:"issold", label: "Issold" <% out.print(SH.formCheckbox(isSold)); %>  },
{type: "checkbox", name:"hasdimensions", label: "Hasdimensions" <% out.print(SH.formCheckbox(hasDimensions)); %>  },
{type: "checkbox", name:"hasproductiontemplate", label: "Hasproductiontemplate" <% out.print(SH.formCheckbox(hasProductionTemplate)); %> },
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 