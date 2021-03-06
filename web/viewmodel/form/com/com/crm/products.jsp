

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
    /**
     * *******Compulsory variables********
     */
    String strid, struserid, strprofileid, formq, queryFilter, edit, del, createdt, writedt;
    Integer CMprofileid, CMcompanyid, id, CMuserid, lifeid, createbyid, writebyid;
    List formdata;
   
    java.util.Date DTcreatedt, DTwritedt;
    RightsHelper RH = new RightsHelper();
    DateHelper DH = new DateHelper();
    StringHelper SH = new StringHelper();
    /**
     * ********Form specific fields***********
     */
    String itemcode, itemname, itemicon,strparentid;
    Integer itemconfigurationid, itemlevelid,  itemsort,parentid,paramparentid, status;
%>

<%
    /**
     * **********COMPULSORY VARIABLES*********
     */
    strprofileid = session.getAttribute("profileid").toString();
    struserid = session.getAttribute("userid").toString();
    strid = request.getParameter("id");
    if(!request.getParameter("parentid").isEmpty()){
    strparentid = request.getParameter("parentid");
    }

    queryFilter = "";
    id = Integer.valueOf(strid);
    CMuserid = Integer.valueOf(struserid);
    CMprofileid = Integer.valueOf(strprofileid);
    paramparentid = Integer.valueOf(strparentid);
    
    RH.fetchRightsdata("products", CMprofileid);
    edit = RH.formRightsStmt(RH.isCanedit());
    del = RH.formRightsStmt(RH.isCandel());

    /**
     * *******FORM SPECIFIC CODE***********
     */
    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM Item");
        formquery.append(" where itemId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                Item item = (Item) iterator.next();
                id = item.getItemId();
                itemcode = item.getItemCode();
                itemname = item.getItemName();
                itemicon = item.getItemIcon();
                itemsort = item.getItemSort();
                itemconfigurationid = item.getItemConfiguration().getItemConfigurationId();
                status = item.getAllStatus().getStatusId();
                parentid = item.getItem().getItemId();
                itemlevelid = item.getItemLevel().getItemLevelId();

                writebyid = item.getConUserByWritebyId().getUserId();
                createbyid = item.getConUserByCreatebyId().getUserId();

                createdt = DH.DatetimetoStrDatetime(item.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(item.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
        createdt = DH.DatetoStrDate(DTcreatedt);
        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        itemcode = "";
        itemname = "";
        itemicon = "";
        itemsort = 0;
        itemconfigurationid = 1;
        status = 1;
          parentid = 0;
        if(!strparentid.isEmpty()){parentid=paramparentid;}
        itemlevelid = 1;

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHitemconfigurationid = new ComboHelper();
    ComboHelper CHstatus = new ComboHelper();
    ComboHelper CHparentid = new ComboHelper();
    ComboHelper CHitemlevelid = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "15", inputWidth: "250",offsetTop:"15"},

{type: "input", name:"itemcode",label:"Item Code", value:"<% out.print(itemcode); %>" , validate:"ValidateLength"},
{type: "input", name:"itemname",label:"Item Name", value:"<% out.print(itemname); %>" , validate:"ValidateLength"},
{type: "hidden", name:"itemicon",label:"Item Icon", value:"<% out.print(itemicon); %>" , validate:"ValidateLength"},
{type: "combo", name:"itemconfigurationid",label: "Item Configuration", filtering:true , options:[<% out.print(CHitemconfigurationid.LoadCombo("itemconfigurationid", queryFilter, itemconfigurationid)); %>]} ,
{type: "combo", name:"itemlevelid",label: "Item Level", filtering:true , options:[<% out.print(CHitemlevelid.LoadCombo("itemlevelid", queryFilter, itemlevelid)); %>]} ,
{type: "combo", name:"parentid",label: "Parent Item", filtering:true , options:[<% out.print(CHparentid.LoadCombo("itemid", queryFilter, parentid)); %>]} ,
{type: "hidden", name:"itemsort",label:"Itemsort", value:"<% out.print(itemsort); %>" , validate:"ValidateLength"},
{type: "combo", name:"status",label: "Status", filtering:true , options:[<% out.print(CHstatus.LoadCombo("statusid", queryFilter, status)); %>]} ,
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 