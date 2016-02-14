<%-- 
    Document   : menu
    Created on : Nov 6, 2015, 5:23:15 AM
    Author     : TBL
--%>

<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelv.*,viewmodel.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<%! String json, uname, industryid, profileid,userid, companyid, module;
    String tabquery, blockquery, itemquery, generalquery, generalitem;
    String moduleid, modulecapt, blockid, blockcapt, itemid, itemcapt, Modq, Blockq, Objectq;
    String itemicon, itemislarge, setpath, itemname,modulecode;
    List Moddata, Blockdata, Objectdata;

%>

<%
//GET SESSION VARIABLES
     industryid=session.getAttribute("industryid").toString();
     profileid=session.getAttribute("profileid").toString();
     companyid=session.getAttribute("companyid").toString();
     userid=session.getAttribute("userid").toString();
 
    //QUERY FOR FETCHING TAB DATA
    DataLoader dataObj = new DataLoader();
    //
    StringBuilder Modquery = new StringBuilder("FROM ViewMenu WHERE childobjectlevel=1 AND canview=1  ORDER BY childcaptobjectcaptionsort ASC");

    Modq = Modquery.toString();
    Moddata = dataObj.getData(Modq);

    //START PRINTING THE RIBON
    out.println("{ \"tabs\" : [ ");

    if (!Moddata.isEmpty()) {

        for (Iterator iterator = Moddata.iterator(); iterator.hasNext();) {
            ViewMenu MVM = (ViewMenu) iterator.next();
            moduleid = MVM.getChildobjectid().toString();
            modulecapt = MVM.getChildcaptname();
            modulecode=MVM.getChildobjectcode();
            //PRINT THE TABS
            out.println("  {");
            out.println(" \"id\" : \"" + moduleid + "\",");
            out.println("\"text\" : \"" + modulecapt + "\",");
            out.println("\"active\" : true,");
            out.println("\"items\" : [");

            //CONTAINER/BLOCK SELECTION
            StringBuilder Blockquery = new StringBuilder(" FROM ViewMenu WHERE childobjectlevel=2 AND childparentid=" + moduleid + "    ");

            // DataLoader dataObj1 = new DataLoader();   
            Blockq = Blockquery.toString();
            Blockdata = dataObj.getData(Blockq);

            if (!Blockdata.isEmpty()) {

                for (Iterator iteratorB = Blockdata.iterator(); iteratorB.hasNext();) {
                    // ConObjectscaption ORB= (ConObjectscaption) iteratorB.next(); FROM ConObjectscaption where available=1
                    //  blockid=ORB.getConObjects().getObjectId().toString();
                    //    blockcapt=ORB.getObjectCaptionName();
                    ViewMenu BVM = (ViewMenu) iteratorB.next();

                    blockid = BVM.getChildobjectid().toString();
                    blockcapt = BVM.getChildcaptname();

                    out.println("{ ");
                    out.println("\"type\":\"block\", \"id\" : \"" + blockid + "\", \"text\":\"" + blockcapt + "\", \"list\":[");

                    StringBuilder Objectquery = new StringBuilder(" FROM ViewMenu WHERE childobjectlevel=3 AND childparentid=" + blockid + " AND canview=1 ORDER BY childcaptobjectcaptionsort ASC ");
                    Objectq = Objectquery.toString();
                    Objectdata = dataObj.getData(Objectq);
                    for (Iterator iteratorC = Objectdata.iterator(); iteratorC.hasNext();) {

                        ViewMenu OVM = (ViewMenu) iteratorC.next();
                        setpath = OVM.getChildcaptsetpath()+"/"+modulecode;
                        itemname = OVM.getChildobjectname();
                        itemcapt = OVM.getChildcaptname();
                        itemislarge = OVM.getChildcaptislarge();
                        itemicon = OVM.getChildcapticon();
                        out.println(" {\"id\" : \"" + setpath + "/" + itemname + "|" + itemcapt + "\", \"type\":\"button\", \"text\":\"" + itemcapt + "\", \"isbig\" : " + itemislarge + ", \"img\" : \"" + itemicon + "\"},");
                    }

                    out.println("] }, ");

                }
            }
            out.println("] }, ");

        }
    }

    out.println("]}");
%>








