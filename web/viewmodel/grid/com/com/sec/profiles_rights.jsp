
<%@page import="viewmodelhelpers.EmptyGridVH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>

<%!
    String myq, userdetails, id, Modq, moduleid, modulecapt, modulecode, objectdetail;
    List mydata, Moddata;
    Integer i, pp;
%>

<%
    //id = request.getParameter("id");
    //pp = Integer.parseInt(id);
    EmptyGridVH EGVH = new EmptyGridVH();

    DataLoader ME = new DataLoader();
    /*
     StringBuilder Modquery = new StringBuilder(" FROM ConObjects WHERE level=1 ");

    Modq = Modquery.toString();
    Moddata = ME.getData(Modq);

    //START PRINTING THE RIBON
    out.println("{ \"module\" : [ ");

    if (!Moddata.isEmpty()) {

        for (Iterator iteratorA = Moddata.iterator(); iteratorA.hasNext();) {
            ConObjects MVM = (ConObjects) iteratorA.next();
            moduleid = MVM.getObjectId().toString();
            modulecapt = MVM.getObjectName();
            modulecode=MVM.getObjectCode();
            //PRINT THE TABS
            out.println("  {");
            out.println(" \"id\" : \"" + moduleid + "\",");
            out.println("\"text\" : \"" + modulecapt + "\",");
            out.println("\"active\" : true,");
            out.println("\"items\" : [");
    
    
    
    
     */

    StringBuilder myquery = new StringBuilder("FROM ConObjectrights WHERE life=1");

    mydata = ME.getData(myquery.toString());

    if (!mydata.isEmpty()) {
        i = 1;
        out.println("{rows:[");
        //LOOP THROUGH THE GRID
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            ConObjectrights OBJ = (ConObjectrights) iterator.next();
            objectdetail = OBJ.getConObjects().getObjectName();
            // userdetails = OBJ.getConUserByUserId().getSurname() + " " + OBJ.getConUserByUserId().getOtherName();
            out.println("{ id:" + OBJ.getObjectRightsId() + ", data:[");
            //   out.println("\"" + OBJ.getConObjects().+ "\",");
            out.println("\"" + objectdetail + "\",");
            out.println("\"" + OBJ.getConObjects().getObjectName() + "\",");
            out.println("\"" + OBJ.isCanview() + "\",");
            out.println("\"" + OBJ.isCanadd() + "\",");
            out.println("\"" + OBJ.isCanedit() + "\",");
            out.println("\"" + OBJ.isCandel() + "\",");
            out.println("\"" + OBJ.isCanexport() + "\",");
            out.println("\"" + OBJ.isCanauthorize() + "\",");
            out.println("\"" + OBJ.isCanapprove() + "\"");

            out.println("]},");

            i++;
        }
        out.println("]}");
        ME.closeListSession();

    } else {
        out.println(EGVH.displayEmptyGrid(10));
    }
    // out.println("Factory details:" + ME.getFactoryDetails());


%>  
