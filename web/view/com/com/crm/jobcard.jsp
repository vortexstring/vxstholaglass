<%-- 
    Document   : jobcard
    Created on : Nov 17, 2015, 5:34:24 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/jobcardcontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <script>
            id = 'view/mfc/com/jobcard|Job Cards';
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts

            var jobcardLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmjobcard",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting Layouts properties
            jobcardLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var jobcardToolbar = jobcardLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var jobcardGrid = jobcardLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            jobcardGrid.setImagePath("config/mcsk_skin/imgs/");
            jobcardGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro");
            jobcardGrid.setHeader("#,Jobcard Code,Salesorder Code,Date,Customer,Status,Raised By.");
            jobcardGrid.setColAlign("left,left,left,left,left,left,left");
            jobcardGrid.setInitWidthsP("5,15,12,*,15,10,20");
            jobcardGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
            jobcardGrid.setColSorting("int,str,str,str,str,str,str");
            jobcardGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/jobcard.jsp';

            jobcardToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            jobcardToolbar.attachEvent("onClick", function (itemId) {
                jobcardToolbarOnclick(itemId, jobcardGrid);
            });
            jobcardGrid.attachEvent("onXLS", function () {
                jobcardLayout.cells("a").progressOn();
            });
            jobcardGrid.load(loadPath, "json");
            jobcardGrid.attachEvent("onXLE", function () {
                jobcardLayout.cells("a").progressOff();
            })
            jobcardGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var jobCardid = rId;

                jobcardGridOnselect(jobcardGrid, jobCardid, jobCardid);
            });
            function jobcardGridOnselect(mygrid, jobCardid, loadPath) {
                var pname = mygrid.cells(jobCardid, 1).getValue();
                jobcardcreateWindow(jobCardid, pname, mygrid, loadPath);
                //alert(jobCardid);

            }

            /**************************END OF OBJECTS EVENTS********************************/
            function jobcardcreateWindow(jobCardid, pname, mygrid) {
                var win = dhxWins.createWindow("jobcard" + jobCardid, 140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/crm/jobcard.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var jobcardlineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 400},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                /**************************ATTACHING THE FORM URL******************************/
                //  jobcardlineLayout.cells("a").attachURL("./in/forms/mfc/com/customersjobcard.php?key", null, {jobcardkey: rId});
            //    var loadPath1 = 'viewmodel/grid/com/com/crm/customersjobcard.jsp?jobCardid=' + jobCardid;

                /*
                 var jobcardlineToolbar = jobcardlineLayout.cells("b").attachToolbar({
                 icons_path: "./icons/all/",
                 xml: "out/toolbars/mfc/com/jobcard_toolbar.php",
                 skin: "dhx_terrace"
                 });*/

                jobcardlineGrid = jobcardlineLayout.cells("b").attachGrid();
                jobcardlineGrid.setColTypes("ro,ro,ro,ro,ro");
                jobcardlineGrid.setHeader("#,Product Name,Quantity,Sale Units,Comments ");
                jobcardlineGrid.setColAlign("left,left,left,left,left");
                jobcardlineGrid.setInitWidthsP("3,*,10,15,30");
                jobcardlineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter");
                jobcardlineGrid.setColSorting("int,str,str,str,str");
                jobcardlineGrid.init();
                //jobcardlineGrid.load(loadPath1, 'json');
                /*
                 jobcardlineToolbar.attachEvent("onXLE", function () {
                 window.lastvisit = 'new';
                 });
                 jobcardlineToolbar.attachEvent("onClick", function (itemId) {
                 jobcardlineToolbarOnclick(itemId, jobcardlineGrid);
                 });*/
                jobcardlineGrid.attachEvent("onXLS", function () {
                    jobcardlineLayout.cells("b").progressOn();
                });
                jobcardlineGrid.load("viewmodel/grid/com/com/crm/customersjobcard.jsp?jobCardid=" + jobCardid, "json");
              alert  ("viewmodel/grid/com/com/crm/customersjobcard.jsp?jobCardid=" + jobCardid);
        jobcardlineGrid.attachEvent("onXLE", function () {
                    jobcardlineLayout.cells("b").progressOff();
                });
                jobcardlineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    jobcardlineGridOnselect(jobcardlineGrid, rId, loadPath);
                });
                customersJobcardForm = createJobcardform(jobcardlineLayout, jobcardlineGrid, jobCardid);

            }
            function createJobcardform(jobcardlineLayout, jobcardlineGrid, jobCardid) {

                var customersJobcardForm = jobcardlineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                jobcardlineLayout.cells("a").progressOn();
                customersJobcardForm.loadStruct("./viewmodel/form/com/com/crm/customersjobcard.jsp?id=" + jobCardid, function () {
                    jobcardlineLayout.cells("a").progressOff();
                });
                customersJobcardForm.enableLiveValidation(true);
                customersJobcardForm.attachEvent("onButtonClick", function (id) {
                    customersJobcardFormOnclick(id, customersJobcardForm, jobcardlineGrid, jobcardlineLayout);
                });

                return customersJobcardForm;
            }
        </script>

        <div id="comcomcrmjobcard"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
