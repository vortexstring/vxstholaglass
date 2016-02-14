<%-- 
    Document   : salesorder
    Created on : Nov 17, 2015, 5:33:45 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/salesordercontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title> Sales Order</title>
    </head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var salesorderLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmsalesorder",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
            //1.Setting Layouts properties
            salesorderLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var salesorderToolbar = salesorderLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var salesorderGrid = salesorderLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            salesorderGrid.setImagePath("config/mcsk_skin/imgs/");
            salesorderGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
            salesorderGrid.setHeader("#,Sales Number,Pos Number,Date,Sales Amount,Customer Name,Status,Raised By");
            salesorderGrid.setColAlign("left,left,left,left,left,left,left,left");
            salesorderGrid.setInitWidthsP("3,10,10,10,10,20,10,20");
            salesorderGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
            salesorderGrid.setColSorting("int,str,str,str,str,str,str,str");
            salesorderGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/salesorder.jsp';
            salesorderToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            salesorderToolbar.attachEvent("onClick", function (itemId) {
                salesorderToolbarOnclick(itemId, salesorderGrid);
            });
            salesorderGrid.attachEvent("onXLS", function () {
                salesorderLayout.cells("a").progressOn();
            });
            salesorderGrid.load(loadPath, "json");
            salesorderGrid.attachEvent("onXLE", function () {
                salesorderLayout.cells("a").progressOff();
            });
            salesorderGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var salesOrderid = rId;

                salesorderGridOnselect(salesorderGrid, salesOrderid, salesOrderid);
            });

            function salesorderGridOnselect(mygrid, salesOrderid, loadPath) {
                var pname = mygrid.cells(salesOrderid, 1).getValue();
                salesordercreateWindow(salesOrderid, pname, mygrid, loadPath);
            }
            /**************************END OF OBJECTS EVENTS********************************/
            function salesordercreateWindow(salesOrderid, pname, mygrid) {
                var win = dhxWins.createWindow("salesorder" + salesOrderid, 140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/crm/salesorder.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var salesorderlineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 400},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                /**************************ATTACHING THE FORM URL******************************/
                //  salesorderlineLayout.cells("a").attachURL("./in/forms/mfc/com/customersorders.php", null, {salesorderkey: rId});
                //      var loadPath1 = 'viewmodel/grid/com/com/crm/customersorder.jsp?salesOrderid=' + rId;
//alert (loadPath1);
                /*
                 var salesorderlineToolbar = salesorderlineLayout.cells("b").attachToolbar({
                 icons_path: "./icons/all/",
                 xml: "out/toolbars/mfc/com/salesorder_toolbar.php",
                 skin: "dhx_terrace"
                 });
                 */
                salesorderlineGrid = salesorderlineLayout.cells("b").attachGrid();
                salesorderlineGrid.setColTypes("ro,ro,ro,ro,ro,ro");
                salesorderlineGrid.setHeader("#,Product Name,Quantity,Sale Units,Unit Price,Amount");
                salesorderlineGrid.setColAlign("left,left,left,left,left,left");
                salesorderlineGrid.setInitWidthsP("3,*,10,15,10,15");
                salesorderlineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                salesorderlineGrid.setColSorting("int,str,str,str,str,str");
                salesorderlineGrid.init();
                // salesorderlineGrid.load(loadPath1, 'json');

                /* salesorderlineToolbar.attachEvent("onXLE", function () {
                 window.lastvisit = 'new';
                 });
                 salesorderlineToolbar.attachEvent("onClick", function (itemId) {
                 salesorderlineToolbarOnclick(itemId, salesorderlineGrid, loadPath);
                 });*/
                salesorderlineGrid.attachEvent("onXLS", function () {
                    salesorderlineLayout.cells("b").progressOn();
                });
                salesorderlineGrid.load("viewmodel/grid/com/com/crm/customersorder.jsp?salesOrderid=" + salesOrderid, "json");
                alert("viewmodel/grid/com/com/crm/customersorder.jsp?salesOrderid=" + salesOrderid);
                salesorderlineGrid.attachEvent("onXLE", function () {
                    salesorderlineLayout.cells("b").progressOff();
                });
                salesorderlineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    salesorderlineGridOnselect(salesorderlineGrid, rId, loadPath);
                });
                var customersOrdersForm = createOrdersform(salesorderlineLayout, salesorderlineGrid, salesOrderid);

            }
            function createOrdersform(salesorderlineLayout, salesorderlineGrid, salesOrderid) {

                var customersOrdersForm = salesorderlineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                salesorderlineLayout.cells("a").progressOn();
                customersOrdersForm.loadStruct("./viewmodel/form/com/com/crm/customersorders.jsp?id=" + salesOrderid, function () {
                    salesorderlineLayout.cells("a").progressOff();
                });
                customersOrdersForm.enableLiveValidation(true);
                customersOrdersForm.attachEvent("onButtonClick", function (id) {
                    customersOrdersFormOnclick(id, customersOrdersForm, salesorderlineGrid, salesorderlineLayout);
                });

                return customersOrdersForm;
            }

        </script>
        <div id="comcomcrmsalesorder"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
