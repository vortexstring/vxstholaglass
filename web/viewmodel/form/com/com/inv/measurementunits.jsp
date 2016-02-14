

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
    String uomname;
    Integer uomcategoryid;
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

    RH.fetchRightsdata("measurementunits", CMprofileid);
    edit = RH.formRightsStmt(RH.isCanedit());
    del = RH.formRightsStmt(RH.isCandel());

    /**
     * *******FORM SPECIFIC CODE***********
     */
    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM CrmUom");
        formquery.append(" where uomId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                CrmUom crmuom = (CrmUom) iterator.next();
                id = crmuom.getUomId();
                uomname = crmuom.getUomName();
                uomcategoryid = crmuom.getCrmUomCateg().getUomCategId();

                writebyid = crmuom.getConUserByWritebyId().getUserId();
                createbyid = crmuom.getConUserByCreatebyId().getUserId();

                createdt = DH.DatetimetoStrDatetime(crmuom.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(crmuom.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
//createdt = DH.DatetoStrDate(DTcreatedt);
        createdt = DH.DatetimetoStrDatetime(DTcreatedt);

        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        uomname = "";
        uomcategoryid = 0;

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHuom = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"uomname",label:"Uomname", value: "<% out.print(uomname); %> " },
{type: "combo", name:"uomcategoryid",label: "Uomcategoryid", filtering:true , options:[<% out.print(CHuom.LoadCombo("uomcategory", queryFilter, uomcategoryid)); %>]} ,
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 