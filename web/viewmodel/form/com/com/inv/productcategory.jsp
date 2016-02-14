

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
    String itemcode, itemname;
    Integer itemconfigurationid, itemlevelid, parentid;
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
                /*itemid=item.getItem().getItemId();
                 itemid=item.getItem().getItemId();
                 customerid=item.getCrmCustomer().getCustomerId();
                 itemid=item.getItem().getItemId();
                 uomid=item.getCrmUom().getUomId();*/
                itemconfigurationid = item.getItemConfiguration().getItemConfigurationId();
//status=item.getAllStatus().getStatusId();
                parentid = item.getItem().getItemId();
                itemlevelid = item.getItemLevel().getItemLevelId();
                /*itemid=item.getItem().getItemId();
                 supplierid=item.getPrcSuppliers().getSupplierId();
                 uomid=item.getCrmUom().getUomId();
                 vatid=item.getFinVat().getVatId();
                 currencyid=item.getAllCurrency().getCurrencyId();
                 itemid=item.getItem().getItemId();
                 itemid=item.getItem().getItemId();
                 uomid=item.getCrmUom().getUomId();
                 currencyid=item.getAllCurrency().getCurrencyId();
                 vatid=item.getFinVat().getVatId();*/

                writebyid = item.getConUserByWritebyId().getUserId();
                createbyid = item.getConUserByCreatebyId().getUserId();

                createdt = DH.DatetimetoStrDatetime(item.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(item.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
//createdt = DH.DatetoStrDate(DTcreatedt);
        createdt = DH.DatetimetoStrDatetime(DTcreatedt);

        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        itemcode = "";
        itemname = "";

        itemconfigurationid = 0;

        parentid = 0;
        itemlevelid = 0;

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHitemlevel = new ComboHelper();
    ComboHelper CHproductclass = new ComboHelper();
    ComboHelper CHitemconfiguration = new ComboHelper();


%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"itemcode",label:"Itemcode", value: "<% out.print(itemcode); %> " },
{type: "input", name:"itemname",label:"Itemname", value: "<% out.print(itemname); %> " },
{type: "combo", name:"itemconfigurationid",label: "Itemconfigurationid", filtering:true , options:[<% out.print(CHitemconfiguration.LoadCombo("itemconfiguration", queryFilter, itemconfigurationid)); %>]} ,
{type: "combo", name:"itemlevelid",label: "Itemlevelid", filtering:true , options:[<% out.print(CHitemlevel.LoadCombo("itemlevel", queryFilter, itemlevelid)); %>]} ,
{type: "combo", name:"parentid",label: "Parentid", filtering:true , options:[<% out.print(CHproductclass.LoadCombo("productclass", queryFilter, parentid)); %>]} ,
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 