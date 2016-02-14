<%-- 
    Document   : salesorder
    Created on : Nov 17, 2015, 5:33:45 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>

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
                parent: "comcominvissues",
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
            salesinvoiceGrid.setHeader("#,Issue Number,Requested By,Date Requested,Status,Customer Project,Customer");
            salesinvoiceGrid.setColAlign("left,left,left,left,left,left,left,left");
            salesinvoiceGrid.setInitWidthsP("3,10,25,10,10,*,25");
            salesinvoiceGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#combo_filter,#combo_filter,#combo_filter");
            salesinvoiceGrid.setColSorting("int,str,str,str,str,str,str,str");
            salesinvoiceGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/salesinvoice.jsp';
            //            salesorderToolbar.attachEvent("onXLE", function () {
            //                window.lastvisit = 'new';
            //            });
            salesinvoiceToolbar.attachEvent("onClick", function (itemId) {
                salesinviceToolbarOnclick(itemId, salesinvoiceGrid);
            });
            //            salesorderGrid.attachEvent("onXLS", function () {
            //                salesorderLayout.cells("a").progressOn();
            //            });
            salesinvoiceGrid.load(loadPath, "json");
            //            salesorderGrid.attachEvent("onXLE", function () {
            //                salesorderLayout.cells("a").progressOff();
            //            });
            salesinvoiceGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var salesOrderId = rId;

                salesinvoiceGridOnselect(salesinvoiceGrid, salesOrderId, rId);
            });

 function salesinvoiceGridOnselect(mygrid, rId, loadPath) {
                var pname = mygrid.cells(rId, 1).getValue();
                salesinvoicecreateWindow(rId, pname, mygrid, loadPath);
            }
            /**************************END OF OBJECTS EVENTS********************************/
            function salesinvoicecreateWindow(rId, pname, mygrid) {
                var win = dhxWins.createWindow("salesinvoice" + rId, 140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('out/grid/mfc/com/salesorder.php', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var salesinvoicelineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 350},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                /**************************ATTACHING THE FORM URL******************************/
//                salesorderlineLayout.cells("a").attachURL("./in/forms/mfc/com/customersorders.php", null, {salesorderkey: rId});
//                var loadPath1 = 'out/grid/mfc/com/customersorder.php?salesorderkey=' + rId;


                var salesinvoicelineToolbar = salesinvoicelineLayout.cells("b").attachToolbar({
                     icons_path: "./icons/toolbar/icons_terrace/",
                    xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                    skin: "dhx_terrace"
                });

                salesinvoicelineGrid = salesinvoicelineLayout.cells("b").attachGrid();
                salesinvoicelineGrid.setColTypes("ro,ro,ro");
                salesinvoicelineGrid.setHeader("#,Product Name,Quantity,Sale Units,Unit Price,Discount,Amount");
                salesinvoicelineGrid.setColAlign("left,left,left,left,left,left,left");
                salesinvoicelineGrid.setInitWidthsP("5,*,8,18,10,10,15");
                salesinvoicelineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                salesinvoicelineGrid.setColSorting("int,str,str,str,str,str,str");
                salesinvoicelineGrid.init();
               // salesorderlineGrid.load(loadPath1, 'json');

                salesinvoicelineToolbar.attachEvent("onXLE", function () {
                    window.lastvisit = 'new';
                });
                salesinvoicelineToolbar.attachEvent("onClick", function (itemId) {
                    salesinvoicelineToolbarOnclick(itemId, salesinvoicelineGrid, loadPath);
                });
//                salesorderlineGrid.attachEvent("onXLS", function () {
//                    salesorderlineLayout.cells("b").progressOn();
//                });
                salesinvoicelineGrid.load("out/grid/mfc/com/customersorder.php", "json");
                salesinvoicelineGrid.attachEvent("onXLE", function () {
                    salesinvoicelineLayout.cells("b").progressOff();
                });
                salesinvoicelineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    salesinvoicelineGridOnselect(salesinvoicelineGrid, rId, loadPath);
                });
                customersSalesinvoiceForm = createSalesinvoiceform(salesinvoicelineLayout, salesinvoiceGrid, -1);

            }
            function createSalesinvoiceform(salesinvoicelineLayout, salesinvoiceGrid, rId) {

                var customersSalesinvoiceForm = salesinvoicelineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                salesinvoicelineLayout.cells("a").progressOn();
                customersSalesinvoiceForm.loadStruct("./viewmodel/form/com/com/crm/customersorders.jsp?id=" + rId, function () {
                    salesinvoicelineLayout.cells("a").progressOff();
                });
                customersSalesinvoiceForm.enableLiveValidation(true);
                customersSalesinvoiceForm.attachEvent("onButtonClick", function (id) {
                    customersSalesinvoiceFormOnclick(id, customersSalesinvoiceForm, salesinvoiceGrid, salesinvoicelineLayout);
                });

                return customersSalesinvoiceForm;
            }
            
        </script>
        <div id="comcominvissues"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
