<%-- 
    Document   : adjustments
    Created on : Jan 25, 2016, 2:30:05 PM
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
    /**
     * *******Compulsory variables********
     */
    String strid, struserid, strprofileid, formq, queryFilter, edit, del, createdt, writedt;
    Integer CMprofileid, CMcompanyid, id, CMuserid, lifeid, createbyid, writebyid;
    List formdata;
    java.util.Date DTcreatedt, DTwritedt, Dadjustmentdate;
    RightsHelper RH = new RightsHelper();
    DateHelper DH = new DateHelper();
    StringHelper SH = new StringHelper();
    /**
     * ********Form specific fields***********
     */
    String adjustmentcode, adjustmenttype, memo, adjustmentdate;
    Integer itemid, storeid, uomid, qty, units, reason;
%>

<%
    /**
     * **********COMPULSORY VARIABLES*********
     */
    strprofileid = session.getAttribute("profileid").toString();
    struserid = session.getAttribute("userid").toString();
    strid = request.getParameter("id");

    queryFilter = "";
    id = Integer.valueOf(strid);
    CMuserid = Integer.valueOf(struserid);
    CMprofileid = Integer.valueOf(strprofileid);

    RH.fetchRightsdata("adjustments", CMprofileid);
    edit = RH.formRightsStmt(RH.isCanedit());
    del = RH.formRightsStmt(RH.isCandel());

    /**
     * *******FORM SPECIFIC CODE***********
     */
    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM InvAdjustments");
        formquery.append(" where adjustmentId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                InvAdjustments invadjustments = (InvAdjustments) iterator.next();
                id = invadjustments.getAdjustmentId();
                adjustmentcode = invadjustments.getAdjustmentCode();
                qty = invadjustments.getQty();
                units = invadjustments.getUnits();
                adjustmenttype = invadjustments.getAdjustmentType();
                memo = invadjustments.getMemo();
                itemid = invadjustments.getItem().getItemId();
                storeid = invadjustments.getInvStore().getStoreId();
                uomid = invadjustments.getCrmUom().getUomId();
//status=invadjustments.getAllStatus().getStatusId();
                reason = invadjustments.getCommonCombo().getComboId();

                writebyid = invadjustments.getConUserByWritebyId().getUserId();
                createbyid = invadjustments.getConUserByCreatebyId().getUserId();
                Dadjustmentdate = invadjustments.getAdjustmentDate();
                adjustmentdate = DH.DatetoStrDate(Dadjustmentdate);

                createdt = DH.DatetimetoStrDatetime(invadjustments.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(invadjustments.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
        createdt = DH.DatetimetoStrDatetime(DTcreatedt);
        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        adjustmentcode = "";
        qty = 0;
        units = 0;
        adjustmenttype = "";
        memo = "";
        itemid = 0;
        storeid = 0;
        uomid = 0;
//status=0;
        reason = 0;
        Dadjustmentdate = DH.convertToUTC(Calendar.getInstance().getTime());
        adjustmentdate = DH.DatetoStrDate(Dadjustmentdate);

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHitem = new ComboHelper();
    ComboHelper CHstore = new ComboHelper();
    ComboHelper CHuom = new ComboHelper();
    ComboHelper CHstatus = new ComboHelper();
    ComboHelper CHreason = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"adjustmentcode",label:"Adjustmentcode", value:"<% out.print(adjustmentcode); %>" },
{type: "combo", name:"itemid",label: "Itemid", filtering:true , required:"true", options:[<% out.print(CHitem.LoadCombo("item", queryFilter, itemid)); %>]} ,
{type: "combo", name:"storeid",label: "Storeid", filtering:true , required:"true", options:[<% out.print(CHstore.LoadCombo("store", queryFilter, storeid)); %>]} ,
{type: "combo", name:"uomid",label: "Uomid", filtering:true , options:[<% out.print(CHuom.LoadCombo("uom", queryFilter, uomid)); %>]} ,
{type: "input", name:"qty",label:"Qty", value:"<% out.print(qty); %>" },
{type: "input", name:"units",label:"Units", value:"<% out.print(units); %>" },
{ type: "block",width:200, list:[
{type: "label", label:"Adjustmenttype", required:"true"},
{type: "radio", name: "adjustmenttype", value: "Increase" <% out.print(SH.formRadio(adjustmenttype, "Increase")); %>, label: "Increase",labelWidth: "auto",offsetTop:"0",inputLeft:60},
{type: "radio", name: "adjustmenttype", value: "Decrease" <% out.print(SH.formRadio(adjustmenttype, "Decrease")); %>, label: "Decrease",labelWidth: "auto",offsetTop:"0",inputLeft:60}
]},
{type: "combo", name:"reason",label: "Reason", filtering:true , options:[<% out.print(CHreason.LoadCombo("reason", queryFilter, reason)); %>]} ,
{type: "input", name:"memo",label:"Memo", value: "<% out.print(memo); %>",rows:3 },
{type: "calendar",name:"adjustmentdate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Adjustmentdate", value:"<% out.print(adjustmentdate); %>"},
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 