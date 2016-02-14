<%-- 
    Document   : receipts
    Created on : Dec 18, 2015, 3:01:51 PM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/fin/receiptscontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Vortexstring|Receipts</title></head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var receiptsLayout = new dhtmlXLayoutObject({
                parent: "comcomfinreceipts",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });
            //1.Setting Layouts properties
            receiptsLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var receiptsToolbar = receiptsLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/fin/basic.jsp",
                skin: "dhx_terrace"
            });
            var receiptsGrid = receiptsLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            receiptsGrid.setImagePath("config/mcsk_skin/imgs/");
            receiptsGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro");
            receiptsGrid.setHeader("#,Receipt No,Date,Received From,Invoice No,Ref/Cheque,Status");
            receiptsGrid.setColAlign("left,left,left,left,left,left,left");
            receiptsGrid.setInitWidthsP("3,12,12,*,15,20,15");
            receiptsGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#text_filter,#text_filter,#combo_filter");
            receiptsGrid.setColSorting("int,str,str,str,str,str,str,str");
            receiptsGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/
            var loadPath = 'viewmodel/grid/com/com/fin/receipts.jsp';
            receiptsToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            receiptsToolbar.attachEvent("onClick", function (itemId) {
                receiptsToolbarOnclick(itemId, receiptsGrid);
            });
            receiptsGrid.attachEvent("onXLS", function () {
                receiptsLayout.cells("a").progressOn();
            });
            receiptsGrid.load(loadPath, "json");
            receiptsGrid.attachEvent("onXLE", function () {
                receiptsLayout.cells("a").progressOff();
            });
            receiptsGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var receiptsId = rId;

                receiptsGridOnselect(receiptsGrid, receiptsId, receiptsId);
            });

            function receiptsGridOnselect(mygrid, receiptsId, loadPath) {
                var pname = mygrid.cells(receiptsId, 2).getValue();
                receiptscreateWindow(receiptsId, pname, mygrid, loadPath);
            }
            /**************************END OF OBJECTS EVENTS********************************/

            function receiptscreateWindow(receiptsId, pname, mygrid) {
                var win = dhxWins.createWindow("receipts" + receiptsId,  140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/fin/receipts.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var receiptslineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 385},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                var receiptslineToolbar = receiptslineLayout.cells("b").attachToolbar({
                    icons_path: "./icons/toolbar/icons_terrace/",
                    xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                    skin: "dhx_terrace"
                });

                /**********LAYOUT PROPERTIES************/
                receiptslineGrid = receiptslineLayout.cells("b").attachGrid("dhx_web");
                receiptslineGrid.setColTypes("ro,ro,ro");
                receiptslineGrid.setHeader("#,Invoices,Amount Due,Amount Paid,Balance");
                receiptslineGrid.setColAlign("left,left,left,left,left");
                receiptslineGrid.setInitWidthsP("5,*,20,20,20");
                receiptslineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter");
                receiptslineGrid.setColSorting("int,str,str,str,str");
                receiptslineGrid.init();
                // receiptslineGrid.load(loadPath, 'json');
                /****************OBJECT EVENTS*********************/
                receiptslineToolbar.attachEvent("onXLE", function () {
                    window.lastvisit = 'new';
                });
                receiptslineToolbar.attachEvent("onClick", function (itemId) {
                    receiptslineToolbarOnclick(itemId, receiptslineGrid, loadPath);
                });
//                receiptslineGrid.attachEvent("onXLS", function () {
//                    receiptslineLayout.cells("b").progressOn();
//                });
                receiptslineGrid.load("viewmodel/grid/com/com/customersreceipts.php", "json");
//                receiptslineGrid.attachEvent("onXLE", function () {
//                    receiptslineLayout.cells("b").progressOff();
//                });
                receiptslineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    receiptslineGridOnselect(receiptslineGrid, rId, loadPath);
                    
            
                });
                function receiptslineGridOnselect(mygrid, rId, loadPath) {
                var pname = mygrid.cells(rId, 2).getValue();
                receiptsLineCreateWindow(rId, pname, mygrid, loadPath);
            }
                customersReceiptsForm = createReceiptsform(receiptslineLayout, receiptsGrid, -1);

            }
            function createReceiptsform(receiptslineLayout, receiptsGrid, rId) {

                var customersReceiptsForm = receiptslineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                receiptslineLayout.cells("a").progressOn();
                customersReceiptsForm.loadStruct("./viewmodel/form/com/com/inv/stores.jsp?id=" + rId, function () {
                    receiptslineLayout.cells("a").progressOff();
                });
                customersReceiptsForm.enableLiveValidation(true);
                customersReceiptsForm.attachEvent("onButtonClick", function (id) {
                    storesFormOnclick(id, customersReceiptsForm, receiptsGrid, receiptslineLayout);
                });

                return customersReceiptsForm;
            }
            function receiptsLineCreateWindow(rId, pname, mygrid, loadPath) {
                var win = dhxWins.createWindow("receipts" + rId, 450, 100, 600, 500);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load(loadPath, 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var receiptsFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false},
                    ]
                });
                receiptsDetailsForm = createReceiptsDetailsform(receiptsFormLayout, receiptslineGrid, -1);

            }
            function createReceiptsDetailsform(receiptsFormLayout, receiptslineGrid, rId) {

                var receiptsDetailsForm = receiptslineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                receiptsFormLayout.cells("a").progressOn();
                receiptsDetailsForm.loadStruct("./viewmodel/form/com/com/inv/stores.jsp?id=" + rId, function () {
                    receiptsFormLayout.cells("a").progressOff();
                });
                receiptsDetailsForm.enableLiveValidation(true);
                receiptsDetailsForm.attachEvent("onButtonClick", function (id) {
                    storesFormOnclick(id, receiptsDetailsForm, receiptslineGrid, receiptslineLayout);
                });

                return receiptsDetailsForm;
            }
        </script>
        <div id="comcomfinreceipts"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">
        </div>
    </body>
</html>