
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
    String purchaseordercode, purchaseorderdate, purchaseorderduedate, ref, comment, approvedate;
    Integer supplierid, approvedby;
    BigDecimal tax, amount;
    java.util.Date  Dpurchaseorderdate,Dpurchaseorderduedate,Dapprovedate;

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

    RH.fetchRightsdata("purchaseorders", CMprofileid);
    edit = RH.formRightsStmt(RH.isCanedit());
    del = RH.formRightsStmt(RH.isCandel());

    /**
     * *******FORM SPECIFIC CODE***********
     */
    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM PrcPurchaseOrder");
        formquery.append(" where purchaseorderId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                PrcPurchaseOrder prcpurchaseorder = (PrcPurchaseOrder) iterator.next();
                id = prcpurchaseorder.getPurchaseorderId();
                purchaseordercode = prcpurchaseorder.getPurchaseorderCode();
                ref = prcpurchaseorder.getRef();
                tax = prcpurchaseorder.getTax();
                amount = prcpurchaseorder.getAmount();
                comment = prcpurchaseorder.getComment();
                supplierid = prcpurchaseorder.getPrcSuppliers().getSupplierId();
               // status = prcpurchaseorder.getAllStatus().getStatusId();
                approvedby = prcpurchaseorder.getConUserByApprovedby().getUserId();
               // itemid = prcpurchaseorder.getItem().getItemId();
               // uomid = prcpurchaseorder.getCrmUom().getUomId();
               // purchaseorderid = prcpurchaseorder.getPrcPurchaseOrder().getPurchaseorderId();

                writebyid = prcpurchaseorder.getConUserByWritebyId().getUserId();
                createbyid = prcpurchaseorder.getConUserByCreatebyId().getUserId();
                Dpurchaseorderdate = prcpurchaseorder.getPurchaseorderDate();
                purchaseorderdate = DH.DatetoStrDate(Dpurchaseorderdate);
                Dpurchaseorderduedate = prcpurchaseorder.getPurchaseorderDuedate();
                purchaseorderduedate = DH.DatetoStrDate(Dpurchaseorderduedate);
                Dapprovedate = prcpurchaseorder.getApprovedate();
                approvedate = DH.DatetoStrDate(Dapprovedate);

                createdt = DH.DatetimetoStrDatetime(prcpurchaseorder.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(prcpurchaseorder.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
        createdt = DH.DatetimetoStrDatetime(DTcreatedt);
        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        purchaseordercode = "";
        ref = "";
        tax = new BigDecimal("0.00");
        amount = new BigDecimal("0.00");
        comment = "";
        supplierid = 0;
        //status = 0;
        //itemid = 0;
        //uomid = 0;
        //purchaseorderid = 0;
        Dpurchaseorderdate = DH.convertToUTC(Calendar.getInstance().getTime());
        purchaseorderdate = DH.DatetoStrDate(Dpurchaseorderdate);
        Dpurchaseorderduedate = DH.convertToUTC(Calendar.getInstance().getTime());
        purchaseorderduedate = DH.DatetoStrDate(Dpurchaseorderduedate);
        Dapprovedate = DH.convertToUTC(Calendar.getInstance().getTime());
        approvedate = DH.DatetoStrDate(Dapprovedate);

        createbyid = CMuserid;
        writebyid = CMuserid;
        approvedby = 0;

    }
    ComboHelper CHsupplier = new ComboHelper();
  /*  ComboHelper CHstatus = new ComboHelper();
    ComboHelper CHapprovedby = new ComboHelper();
    ComboHelper CHitem = new ComboHelper();
    ComboHelper CHuom = new ComboHelper();
    ComboHelper CHpurchaseorder = new ComboHelper();*/

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"purchaseordercode",label:"Purchaseordercode", value: "<% out.print(purchaseordercode); %> " },
{type: "calendar",name:"purchaseorderdate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Purchaseorderdate", value:"<% out.print(purchaseorderdate); %> "},
{type: "calendar",name:"purchaseorderduedate" , dateFormat: "%Y-%m-%d" , serverDateFormat: "%Y-%m-%d" ,label: "Purchaseorderduedate", value:"<% out.print(purchaseorderduedate); %> "},
{type: "input", name:"ref",label:"Ref", value: "<% out.print(ref); %> " },
{type: "combo", name:"supplierid",label: "Supplierid", filtering:true , options:[<% out.print(CHsupplier.LoadCombo("suppliers", queryFilter, supplierid)); %>]} ,
{type: "input", name:"tax",label:"Tax", value: "<% out.print(tax); %> " },
{type: "input", name:"amount",label:"Amount", value: "<% out.print(amount); %> " },
{type: "input", name:"comment",label:"Comment", value: "<% out.print(comment); %> " },
{type: "hidden", name:"approvedby",id:"approvedby", value: "<% out.print(approvedby); %> "},
{type: "hidden", name:"approvedate",id:"approvedate", value: "<% out.print(approvedate); %> "},
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 