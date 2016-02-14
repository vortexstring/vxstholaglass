

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
    String storename, storephone, description;
    Integer storemanager;
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

    RH.fetchRightsdata("stores", CMprofileid);
    edit = RH.formRightsStmt(RH.isCanedit());
    del = RH.formRightsStmt(RH.isCandel());

    /**
     * *******FORM SPECIFIC CODE***********
     */
    if (!strid.equals("-1")) {

        DataLoader FormRq = new DataLoader();
        StringBuilder formquery = new StringBuilder("FROM InvStore");
        formquery.append(" where storeId=" + id);
        formq = formquery.toString();
        formdata = FormRq.getData(formquery.toString());
        if (!formdata.isEmpty()) {
            for (Iterator iterator = formdata.iterator(); iterator.hasNext();) {
                InvStore invstore = (InvStore) iterator.next();
                id = invstore.getStoreId();
                storename = invstore.getStoreName();
                storephone = invstore.getStorePhone();
                description = invstore.getDescription();
                storemanager = invstore.getHrmEmployee().getEmployeeId();

                writebyid = invstore.getConUserByWritebyId().getUserId();
                createbyid = invstore.getConUserByCreatebyId().getUserId();

                createdt = DH.DatetimetoStrDatetime(invstore.getCreatedt());
                writedt = DH.DatetimetoStrDatetime(invstore.getWritedt());
            }
        }
    } else {

        DTcreatedt = DH.convertToUTC(Calendar.getInstance().getTime());
        DTwritedt = DH.convertToUTC(Calendar.getInstance().getTime());
        //createdt = DH.DatetoStrDate(DTcreatedt);
                createdt = DH.DatetimetoStrDatetime(DTcreatedt);

        writedt = DH.DatetimetoStrDatetime(DTwritedt);
        storename = "";
        storephone = "";
        description = "";
        storemanager = 0;

        createbyid = CMuserid;
        writebyid = CMuserid;

    }
    ComboHelper CHstore = new ComboHelper();

%>


[{type: "settings", position: "label-left", labelWidth: "150",offsetLeft: "10", inputWidth: "200",offsetTop:"10"},

{type: "input", name:"storename",label:"Storename", value: "<% out.print(storename); %> " },
{type: "input", name:"storephone",label:"Storephone", value: "<% out.print(storephone); %> " },
{type: "combo", name:"storemanager",label: "Storemanager", filtering:true , options:[<% out.print(CHstore.LoadCombo("hrmemployee", queryFilter, storemanager)); %>]} ,
{type: "input", name:"description",label:"Description", value: "<% out.print(description); %> ",rows:3 },
{type: "hidden", name:"createdt", id:"createdt", value:"<% out.print(createdt);%>"},
{type: "hidden", name:"writedt", id:"writedt", value:"<% out.print(writedt);%>"},
{type: "hidden", name:"createbyid", id:"createbyid", value:"<% out.print(createbyid);%>"},
{type: "hidden", name:"writebyid", id:"writebyid", value:"<% out.print(writebyid);%>"},

{type: "hidden", name:"id", value:"<% out.print(id);%>"},
{type: "block", blockOffset: 0, list: [
{type: "button",name:"save", <% out.print(edit);%>,value: "Save"},
{type: "newcolumn"},
{type: "button", <% out.print(del);%>, name:"delete",value: "Delete"} ]}] 