<%-- 
    Document   : salesorder
    Created on : Nov 17, 2015, 5:33:45 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/salesinvoicecontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title> Sales Invoice</title>
    </head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var salesinvoiceLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmsalesinvoice",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
            //1.Setting Layouts properties
            salesinvoiceLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var salesinvoiceToolbar = salesinvoiceLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var salesinvoiceGrid = salesinvoiceLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            salesinvoiceGrid.setImagePath("config/mcsk_skin/imgs/");
            salesinvoiceGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
            salesinvoiceGrid.setHeader("#,Invoice Number,Sales Number,Date,Invoice Amount,Customer Name,Status,Raised By");
            salesinvoiceGrid.setColAlign("left,left,left,left,left,left,left,left");
            salesinvoiceGrid.setInitWidthsP("3,10,10,10,10,20,10,20");
            salesinvoiceGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
            salesinvoiceGrid.setColSorting("int,str,str,str,str,str,str,str");
            salesinvoiceGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/salesinvoice.jsp';
            //            salesorderToolbar.attachEvent("onXLE", function () {
            //                window.lastvisit = 'new';
            //            });
            //salesinvoiceToolbar.attachEvent("onClick", function (itemId) {
            //    salesinviceToolbarOnclick(itemId, salesinvoiceGrid);
            //  });
            salesinvoiceGrid.attachEvent("onXLS", function () {
                salesinvoiceLayout.cells("a").progressOn();
            });
            salesinvoiceGrid.load(loadPath, "json");
            salesinvoiceGrid.attachEvent("onXLE", function () {
                salesinvoiceLayout.cells("a").progressOff();
            });
            salesinvoiceGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var salesInvoiceid = rId;
//alert(salesInvoiceid);

                salesinvoiceGridOnselect(salesinvoiceGrid, salesInvoiceid, salesInvoiceid);
            });
function salesinvoiceGridOnselect(mygrid, salesInvoiceid, loadPath) {
                var pname = mygrid.cells(salesInvoiceid, 1).getValue();
                salesinvoicecreateWindow(salesInvoiceid, pname, mygrid, loadPath);
         //       alert(salesInvoiceid);

            }
            /**************************END OF OBJECTS EVENTS********************************/
            function salesinvoicecreateWindow(salesInvoiceid, pname, mygrid) {
                var win = dhxWins.createWindow("salesinvoice" + salesInvoiceid,  140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/crm/salesinvoice.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var salesinvoicelineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [{id: "a", text: "FORM", header: false, width: 400},
                        {id: "b", text: "GRID", header: false},]
                });

                /**************************ATTACHING THE FORM URL******************************/
               // salesorderlineLayout.cells("a").attachURL("./in/forms/mfc/com/customersorders.php", null, {salesorderkey: rId});
              //  var loadPath1 = 'viewmodel/grid/com/com/crm/customersinvoice.jsp?salesInvoiceid=' + salesInvoiceid;

//alert(loadPath1);
               /* var salesorderlineToolbar = salesorderlineLayout.cells("b").attachToolbar({
                    icons_path: "./icons/all/",
                    xml: "out/toolbars/mfc/com/salesorder_toolbar.php",
                    skin: "dhx_terrace"
                });
*/
                salesinvoicelineGrid = salesinvoicelineLayout.cells("b").attachGrid();
                 salesinvoicelineGrid.setColTypes("ro,ro,ro,ro,ro,ro");
                salesinvoicelineGrid.setHeader("#,Product Name,Quantity,Sale Units,Unit Price,Amount");
                salesinvoicelineGrid.setColAlign("left,left,left,left,left,left");
                salesinvoicelineGrid.setInitWidthsP("3,*,10,15,10,15");
                salesinvoicelineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                salesinvoicelineGrid.setColSorting("int,str,str,str,str,str");
                salesinvoicelineGrid.init();
                //salesinvoicelineGrid.load(loadPath1, 'json');

              /*  salesorderlineToolbar.attachEvent("onXLE", function () {
                    window.lastvisit = 'new';
                });
                salesorderlineToolbar.attachEvent("onClick", function (itemId) {
                    salesorderlineToolbarOnclick(itemId, salesorderlineGrid, loadPath);
                });*/
                salesinvoicelineGrid.attachEvent("onXLS", function () {
                    salesinvoicelineLayout.cells("b").progressOn();
                });
                salesinvoicelineGrid.load("viewmodel/grid/com/com/crm/customersinvoice.jsp?salesInvoiceid=" + salesInvoiceid, "json");
                salesinvoicelineGrid.attachEvent("onXLE", function () {
                    salesinvoicelineLayout.cells("b").progressOff();
                });
                salesinvoicelineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    salesinvoicelineGridOnselect(salesinvoicelineGrid, rId, loadPath);
                });
                customersInvoiceForm = createInvoiceform(salesinvoicelineLayout, salesinvoicelineGrid, salesInvoiceid);

            }
            function createInvoiceform(salesinvoicelineLayout, salesinvoicelineGrid, salesInvoiceid) {

                var customersInvoiceForm = salesinvoicelineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                salesinvoicelineLayout.cells("a").progressOn();
                customersInvoiceForm.loadStruct("./viewmodel/form/com/com/crm/customersinvoices.jsp?id=" + salesInvoiceid, function () {
                    salesinvoicelineLayout.cells("a").progressOff();
                });
                customersInvoiceForm.enableLiveValidation(true);
                customersInvoiceForm.attachEvent("onButtonClick", function (id) {
                    customersInvoiceFormOnclick(id, customersInvoiceForm, salesinvoicelineGrid, salesinvoicelineLayout);
                });

                return customersInvoiceForm;
            }

        </script>
        <div id="comcomcrmsalesinvoice"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
