<%-- 
    Document   : itempurchaseorder
    Created on : Jan 7, 2016, 12:26:21 PM
    Author     : pharis wambui
--%>


<%@page import="java.text.DecimalFormat"%>
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
    String memo;
    Integer purchaseorderid, itemid, qty, uomid;
    BigDecimal price, amount;
        DecimalFormat dec = new DecimalFormat("0.00");

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
        StringBuilder formquery = new StringBuilder("FROM PrcPurchaseOrderLine");
        formquery.append(" where purchaseorderLineId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                PrcPurchaseOrderLine prcpurchaseorderline = (PrcPurchaseOrderLine) iterator.next();
                id = prcpurchaseorderline.getPurchaseorderLineId();
                qty = prcpurchaseorderline.getQty();
                price = prcpurchaseorderline.getPrice();
                amount = prcpurchaseorderline.getAmount();
                memo = prcpurchaseorderline.getMemo();
                itemid = prcpurchaseorderline.getItem().getItemId();
                uomid = prcpurchaseorderline.getCrmUom().getUomId();
                purchaseorderid = prcpurchaseorderline.getPrcPurchaseOrder().getPurchaseorderId();

                writebyid = prcpurchaseorderline.getConUserByWritebyId().getUserId();
                createbyid = prcpurchaseorderline.getConUserByCreatebyId().getUserId();

                createdt = DH.DatetimetoStrDatetime(prcpurchaseorderline.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(prcpurchaseorderline.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
        createdt = DH.DatetimetoStrDatetime(DTcreatedt);
        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        qty = 0;
        price = new BigDecimal("0.00");
        amount = new BigDecimal("0.00");
        memo = "";
        itemid = 0;
        uomid = 0;
        purchaseorderid = 0;

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHitem = new ComboHelper();
    ComboHelper CHuom = new ComboHelper();
    ComboHelper CHpurchaseorder = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"purchaseorderid",id:"purchaseorderid", value: "<% out.print(purchaseorderid); %>"},
{type: "combo", name:"itemid",label: "Itemid", filtering:true , options:[<% out.print(CHitem.LoadCombo("item", queryFilter, itemid)); %>]} ,
{type: "input", name:"qty",label:"Qty", value: "<% out.print(qty); %> " },
{type: "input", name:"price",label:"Price", value: "<% out.print (dec.format(price)); %> " },
{type: "input", name:"amount",label:"Amount", value: "<% out.print(dec.format(amount)); %> " },
{type: "combo", name:"uomid",label: "Uomid", filtering:true , options:[<% out.print(CHuom.LoadCombo("uom", queryFilter, uomid)); %>]} ,
{type: "input", name:"memo",label:"Memo", value: "<% out.print(memo); %> ",rows:3 },
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 
