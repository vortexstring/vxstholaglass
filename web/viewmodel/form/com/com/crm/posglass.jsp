

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
    java.util.Date DTcreatedt, DTwritedt, Dqdate;
    RightsHelper RH = new RightsHelper();
    DateHelper DH = new DateHelper();
    StringHelper SH = new StringHelper();
    /**
     * ********Form specific fields***********
     */
    String qdate, memo, ralno,strunitsid;
    Integer posid,unitsid, itemid, itemserviceid, itemsaleid, qty, uomid, dimensionuomid, status,vatid;
    BigDecimal vatrate,price, discount, interest, percentdisc, percentint, amount, vatableamount, vatamount, uomqty, dimensionlength, dimensionwidth, dimensionthickness, dimensionthicknessnum, dimensionthicknessdenom, dimensionlengthnum, dimensionlengthdenom, dimensionwidthnum, dimensionwidthdenom;
%>

<%
    /**
     * **********COMPULSORY VARIABLES*********
     */
    strprofileid = session.getAttribute("profileid").toString();
    struserid = session.getAttribute("userid").toString();
    strid = request.getParameter("id");
    strunitsid = request.getParameter("itemsaleunitsid");

    queryFilter = "";
    id = Integer.valueOf(strid);
    unitsid = Integer.valueOf(strunitsid);
    CMuserid = Integer.valueOf(struserid);
    CMprofileid = Integer.valueOf(strprofileid);

    RH.fetchRightsdata("pos", CMprofileid);
    edit = RH.formRightsStmt(RH.isCanedit());
    del = RH.formRightsStmt(RH.isCandel());

    /**
     * *******FORM SPECIFIC CODE***********
     */
    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM CrmPosLine");
        formquery.append(" where posLineId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                CrmPosLine crmposline = (CrmPosLine) iterator.next();
                id = crmposline.getPosLineId();
                price = crmposline.getPrice();
                qty = crmposline.getQty();
                discount = crmposline.getDiscount();
                interest = crmposline.getInterest();
                percentdisc = crmposline.getPercentDisc();
                percentint = crmposline.getPercentInt();
                amount = crmposline.getAmount();
                vatableamount = crmposline.getVatableAmount();
                vatamount = crmposline.getVatAmount();
                uomqty = crmposline.getUomQty();
                memo = crmposline.getMemo();
                dimensionlength = crmposline.getDimensionLength();
                dimensionwidth = crmposline.getDimensionWidth();
                dimensionthickness = crmposline.getDimensionThickness();
                dimensionthicknessnum = crmposline.getDimensionThicknessNum();
                dimensionthicknessdenom = crmposline.getDimensionThicknessDenom();
                dimensionlengthnum = crmposline.getDimensionLengthNum();
                dimensionlengthdenom = crmposline.getDimensionLengthDenom();
                dimensionwidthnum = crmposline.getDimensionWidthNum();
                dimensionwidthdenom = crmposline.getDimensionWidthDenom();
                ralno = crmposline.getRalNo();
                posid = crmposline.getCrmPos().getPosId();
                itemid = crmposline.getItemByItemId().getItemId();
                itemserviceid = crmposline.getItemByItemServiceId().getItemId();
                itemsaleid = crmposline.getItemSale().getItemSaleId();
                status = crmposline.getAllStatus().getStatusId();
                uomid = crmposline.getCrmUomByUomId().getUomId();
                dimensionuomid = crmposline.getCrmUomByDimensionUomId().getUomId();
                vatid=crmposline.getItemSale().getFinVat().getVatId();
                vatrate=crmposline.getItemSale().getFinVat().getVatRate();
                writebyid = crmposline.getConUserByWritebyId().getUserId();
                createbyid = crmposline.getConUserByCreatebyId().getUserId();
                Dqdate = crmposline.getQdate();
                qdate = DH.DatetoStrDate(Dqdate);

                createdt = DH.DatetimetoStrDatetime(crmposline.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(crmposline.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
        createdt = DH.DatetimetoStrDatetime(DTcreatedt);
        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        price = new BigDecimal("0");
        qty = 1;
        discount = new BigDecimal("0");
        interest = new BigDecimal("0");
        percentdisc = new BigDecimal("0");
        percentint = new BigDecimal("0");
        amount = new BigDecimal("0");
        vatableamount = new BigDecimal("0");
        vatamount = new BigDecimal("0");
        uomqty = new BigDecimal("0");
        memo = "";
        dimensionlength = new BigDecimal("305");
        dimensionwidth = new BigDecimal("610");
        dimensionthickness = new BigDecimal("1");
        dimensionthicknessnum = new BigDecimal("1");
        dimensionthicknessdenom = new BigDecimal("1");
        dimensionlengthnum = new BigDecimal("1");
        dimensionlengthdenom = new BigDecimal("1");
        dimensionwidthnum = new BigDecimal("1");
        dimensionwidthdenom = new BigDecimal("1");
        vatrate= new BigDecimal("0");
        ralno = "";
        posid = 0;
        itemid = 0;
         vatid = 0;

        itemserviceid = 0;
        itemsaleid = 0;
        status = 3;
        uomid = 0;
        dimensionuomid = 0;
        Dqdate = DH.convertToUTC(Calendar.getInstance().getTime());
        qdate = DH.DatetimetoStrDatetime(Dqdate);

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHposid = new ComboHelper();
    ComboHelper CHitemid = new ComboHelper();
    ComboHelper CHitemserviceid = new ComboHelper();
    ComboHelper CHitemsaleid = new ComboHelper();
    ComboHelper CHstatus = new ComboHelper();
    ComboHelper CHvatid = new ComboHelper();
    ComboHelper CHdimensionuomid = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "fieldset", name: "dimension", label: "Dimensions and Sale Parameters", inputWidth: "auto", list:[
{type: "combo", name:"dimensionuomid",label: "Dimensionuomid", filtering:true , required:"true", options:[<% out.print(CHdimensionuomid.LoadCombo("uom", queryFilter, dimensionuomid)); %>]} ,

{type: "fieldset", name: "length", label: "Length", inputWidth: "auto", list:[
{type: "input", name:"dimensionlength",label:"Dimensionlength", value:"<% out.print(dimensionlength); %>" , validate:"ValidateLength"},
{type: "input", name:"dimensionlengthnum",label:"Dimensionlengthnum", value:"<% out.print(dimensionlengthnum); %>" , validate:"ValidateLength"},
{type: "input", name:"dimensionlengthdenom",label:"Dimensionlengthdenom", value:"<% out.print(dimensionlengthdenom); %>" , validate:"ValidateLength"}
]},
{type: "combo", name:"uomid",label: "Sale UOM", filtering:true , required:"true", options:[<% out.print(CHdimensionuomid.LoadCombo("uom", queryFilter, unitsid)); %>]} ,
{type: "input", name:"percentdisc",label:"Discount (%)", value:"<% out.print(percentdisc); %>" , validate:"ValidateLength"},
{type: "input", name:"discount",label:"Discount Amount", disabled:true, value:"<% out.print(discount); %>" , validate:"ValidateLength"},
{type: "combo", name:"vatid",label: "Sale VAT", filtering:true , required:"true",disabled:true, options:[<% out.print(CHvatid.LoadCombo("vatid", queryFilter, vatid)); %>]} ,

{type: "newcolumn"},
{type: "input", name:"qty",label:"Qty", value:"<% out.print(qty); %>" , validate:"ValidateLength"},
{type: "fieldset", name: "width", label: "Width", inputWidth: "auto", list:[
{type: "input", name:"dimensionwidth",label:"Dimensionwidth", value:"<% out.print(dimensionwidth); %>" , validate:"ValidateLength"},
{type: "input", name:"dimensionwidthnum",label:"Dimensionwidthnum", value:"<% out.print(dimensionwidthnum); %>" , validate:"ValidateLength"},
{type: "input", name:"dimensionwidthdenom",label:"Dimensionwidthdenom", value:"<% out.print(dimensionwidthdenom); %>" , validate:"ValidateLength"},
]},

{type: "combo", name:"itemsaleid",label: "Price ", filtering:true , required:"true", disabled:true, options:[<% out.print(CHdimensionuomid.LoadCombo("itemsaleid", "WHERE crmUom.uomId=4", itemsaleid)); %>]} ,
{type: "input", name:"percentint",label:"Interest (%)", value:"<% out.print(percentint); %>" ,validate:"ValidateLength"},
{type: "input", name:"interest",label:"Interest Amount", disabled:true, value:"<% out.print(interest); %>" , validate:"ValidateLength"},
{type: "input", name:"vatrate",label:"vatrate", value:"<% out.print(vatrate); %>" , validate:"ValidateLength"},
]},

{type: "fieldset", name: "salesDetails", label: "Sales Details", inputWidth: "auto", list:[

{type: "input", name:"amount",label:"Amount",  value:"<% out.print(amount); %>" ,readonly:"true", validate:"ValidateLength"},
{type: "input", name:"vatamount",label:"Vatamount", value:"<% out.print(vatamount); %>" ,readonly:"true", validate:"ValidateLength"},
{type: "calendar",name:"qdate" ,enableTime:true ,dateFormat:"%d-%m-%Y %H:%i:%s", serverDateFormat: "%Y-%m-%d %H:%i:%s" ,label: "Qdate",readonly:"true", value:"<% out.print(qdate); %>"},
{type: "newcolumn"},

{type: "combo", name:"status",label: "Status", filtering:true , options:[<% out.print(CHstatus.LoadCombo("statusid", queryFilter, status)); %>]} ,

{type: "input", name:"vatableamount",label:"Vatableamount", value:"<% out.print(vatableamount); %>" ,readonly:"true", validate:"ValidateLength"},
{type: "input", name:"uomqty",label:"Uomqty", value:"<% out.print(uomqty); %>" ,readonly:"true", validate:"ValidateLength"},
{type: "input", name:"memo",label:"Memo", value: "<% out.print(memo); %>",rows:3 , validate:"ValidateLength"},
]},

{type: "hidden", name:"dimensionthickness",label:"Dimensionthickness", value:"<% out.print(dimensionthickness); %>" , validate:"ValidateLength"},
{type: "hidden", name:"dimensionthicknessnum",label:"Dimensionthicknessnum", value:"<% out.print(dimensionthicknessnum); %>" , validate:"ValidateLength"},
{type: "hidden", name:"dimensionthicknessdenom",label:"Dimensionthicknessdenom", value:"<% out.print(dimensionthicknessdenom); %>" , validate:"ValidateLength"},
{type: "hidden", name:"ralno",label:"Ralno", value:"<% out.print(ralno); %>" , validate:"ValidateLength"},
{type: "hidden", name:"posid",label:"Posid", value:"<% out.print(posid); %>" , validate:"ValidateLength"},

{type: "input", name:"itemid",label:"Itemid", value:"<% out.print(itemid); %>" , validate:"ValidateLength"},
{type: "hidden", name:"itemserviceid",label:"Itemserviceid", value:"<% out.print(itemserviceid); %>" , validate:"ValidateLength"},
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "newcolumn"},

{type: "fieldset", name: "controls", label: "Process Controls", inputWidth: "", list:[

{type: "block", blockOffset: 0, list: [
{type: "button",name:"process", <% out.print(edit);%>,value: "Process Sale"},

{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},

{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]},
]},
]