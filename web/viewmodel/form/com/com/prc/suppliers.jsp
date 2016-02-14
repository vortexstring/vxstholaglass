
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
    String admndate, suppliercode, suppliername, othername, taxcode, pinno, location, contactperson, primarymobileno, primarylandline, primaryemail, boxaddress, boxaddresscode, boxaddresstown, physicaladdress, website;
    Integer currencyid, paytermid, paymodeid;
    BigDecimal creditlimit;
    boolean credit;
    java.util.Date DTadmndate;
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

    RH.fetchRightsdata("suppliers", CMprofileid);
    edit = RH.formRightsStmt(RH.isCanedit());
    del = RH.formRightsStmt(RH.isCandel());

    /**
     * *******FORM SPECIFIC CODE***********
     */
    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM PrcSuppliers");
        formquery.append(" where supplierId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                PrcSuppliers prcsuppliers = (PrcSuppliers) iterator.next();
                id = prcsuppliers.getSupplierId();
                suppliercode = prcsuppliers.getSupplierCode();
                suppliername = prcsuppliers.getSupplierName();
                othername = prcsuppliers.getOthername();
                taxcode = prcsuppliers.getTaxcode();
                pinno = prcsuppliers.getPinno();
                creditlimit = prcsuppliers.getCreditLimit();
                location = prcsuppliers.getLocation();
                contactperson = prcsuppliers.getContactPerson();
                primarymobileno = prcsuppliers.getPrimaryMobileNo();
                primarylandline = prcsuppliers.getPrimaryLandline();
                primaryemail = prcsuppliers.getPrimaryEmail();
                boxaddress = prcsuppliers.getBoxAddress();
                boxaddresscode = prcsuppliers.getBoxAddressCode();
                boxaddresstown = prcsuppliers.getBoxAddressTown();
                physicaladdress = prcsuppliers.getPhysicalAddress();
                website = prcsuppliers.getWebsite();
                credit = prcsuppliers.getCredit();
                currencyid = prcsuppliers.getAllCurrency().getCurrencyId();
                paytermid = prcsuppliers.getPayterm().getPaytermId();
                paymodeid = prcsuppliers.getPaymode().getPaymodeId();

                writebyid = prcsuppliers.getConUserByWritebyId().getUserId();
                createbyid = prcsuppliers.getConUserByCreatebyId().getUserId();
                DTadmndate = prcsuppliers.getAdmnDate();
                admndate = DH.DatetimetoStrDatetime(DTadmndate);

                createdt = DH.DatetimetoStrDatetime(prcsuppliers.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(prcsuppliers.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
        createdt = DH.DatetoStrDate(DTcreatedt);
        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        suppliercode = "";
        suppliername = "";
        othername = "";
        taxcode = "";
        pinno = "";
        creditlimit = new BigDecimal("0");
        location = "";
        contactperson = "";
        primarymobileno = "";
        primarylandline = "";
        primaryemail = "";
        boxaddress = "";
        boxaddresscode = "";
        boxaddresstown = "";
        physicaladdress = "";
        website = "";
        currencyid = 0;
        paytermid = 0;
        paymodeid = 0;
        DTadmndate = DH.convertToUTC(Calendar.getInstance().getTime());
        admndate = DH.DatetimetoStrDatetime(DTadmndate);

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHcurrency = new ComboHelper();
    ComboHelper CHpayterm = new ComboHelper();
    ComboHelper CHpaymode = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "calendar",name:"admndate" , dateFormat: "%Y-%m-%d %H:%i:%s" , serverDateFormat: "%Y-%m-%d %H:%i:%s" ,label: "Admndate", value:"<% out.print(admndate); %> "},
{type: "input", name:"suppliercode",label:"Suppliercode", value: "<% out.print(suppliercode); %> " },
{type: "input", name:"suppliername",label:"Suppliername", value: "<% out.print(suppliername); %> " },
{type: "input", name:"othername",label:"Othername", value: "<% out.print(othername); %> " },
{type: "input", name:"taxcode",label:"Taxcode", value: "<% out.print(taxcode); %> " },
{type: "input", name:"pinno",label:"Pinno", value: "<% out.print(pinno); %> " },
{type: "checkbox", name:"credit", label: "Credit" <% out.print(SH.formCheckbox(credit)); %> , checked: true },
{type: "input", name:"creditlimit",label:"Creditlimit", value: "<% out.print(creditlimit); %> " },
{type: "combo", name:"currencyid",label: "Currencyid", filtering:true , options:[<% out.print(CHcurrency.LoadCombo("currency", queryFilter, currencyid)); %>]} ,
{type: "combo", name:"paytermid",label: "Paytermid", filtering:true , options:[<% out.print(CHpayterm.LoadCombo("payterm", queryFilter, paytermid)); %>]} ,
{type: "combo", name:"paymodeid",label: "Paymodeid", filtering:true , options:[<% out.print(CHpaymode.LoadCombo("paymode", queryFilter, paymodeid)); %>]} ,
{type: "newcolumn"},
{type: "input", name:"location",label:"Location", value: "<% out.print(location); %> " },
{type: "input", name:"contactperson",label:"Contactperson", value: "<% out.print(contactperson); %> " },
{type: "input", name:"primarymobileno",label:"Primarymobileno", value: "<% out.print(primarymobileno); %> " },
{type: "input", name:"primarylandline",label:"Primarylandline", value: "<% out.print(primarylandline); %> " },
{type: "input", name:"primaryemail",label:"Primaryemail", value: "<% out.print(primaryemail); %> " },
{type: "input", name:"boxaddress",label:"Boxaddress", value: "<% out.print(boxaddress); %> " },
{type: "input", name:"boxaddresscode",label:"Boxaddresscode", value: "<% out.print(boxaddresscode); %> " },
{type: "input", name:"boxaddresstown",label:"Boxaddresstown", value: "<% out.print(boxaddresstown); %> " },
{type: "input", name:"physicaladdress",label:"Physicaladdress", value: "<% out.print(physicaladdress); %> " },
{type: "input", name:"website",label:"Website", value: "<% out.print(website); %> " },
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