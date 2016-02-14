<%-- 
    Document   : salesorder
    Created on : Nov 17, 2015, 5:33:45 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/prc/purchaseorderscontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title> Purchase Orders</title>
    </head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var purchaseordersLayout = new dhtmlXLayoutObject({
                parent: "comcomprcpurchaseorders",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
            //1.Setting Layouts properties
            purchaseordersLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var purchaseordersToolbar = purchaseordersLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var purchaseordersGrid = purchaseordersLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            purchaseordersGrid.setImagePath("config/mcsk_skin/imgs/");
            purchaseordersGrid.setColTypes("ro,ro,ro,ro,ro,ro");
            purchaseordersGrid.setHeader("#,Order Number,Supplier,Order Date,Amount,Status");
            purchaseordersGrid.setColAlign("left,left,left,left,left,left");
            purchaseordersGrid.setInitWidthsP("3,20,20,20,15,20");
            purchaseordersGrid.attachHeader(",#text_filter,#combo_filter,#combo_filter,#text_filter,#combo_filter");
            purchaseordersGrid.setColSorting("int,str,str,str,str,str");
            purchaseordersGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/prc/purchaseorders.jsp';
            purchaseordersToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            purchaseordersToolbar.attachEvent("onClick", function (itemId) {
                purchaseordersToolbarOnclick(itemId, purchaseordersGrid);
            });
            //            salesorderGrid.attachEvent("onXLS", function () {
            //                salesorderLayout.cells("a").progressOn();
            //            });
            purchaseordersGrid.load(loadPath, "json");
            purchaseordersGrid.attachEvent("onXLE", function () {
                purchaseordersLayout.cells("a").progressOff();
            });
            purchaseordersGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var purchaseOrderId = rId;

                purchaseordersGridOnselect(purchaseordersGrid, purchaseOrderId, purchaseOrderId);
            });

            function purchaseordersGridOnselect(mygrid, purchaseOrderId, loadPath) {
                var pname = mygrid.cells(purchaseOrderId, 1).getValue();
                purchaseorderscreateWindow(purchaseOrderId, pname, mygrid, loadPath);
            }
            /**************************END OF OBJECTS EVENTS********************************/
            function purchaseorderscreateWindow(purchaseOrderId, pname, mygrid, loadPath) {
                var win = dhxWins.createWindow("Purchaseorders" + purchaseOrderId, 140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/prc/purchaseorders.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var purchaseorderslineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 385},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                /**************************ATTACHING THE FORM URL******************************/
//                salesorderlineLayout.cells("a").attachURL("./in/forms/mfc/com/customersorders.php", null, {salesorderkey: rId});
//                var loadPath1 = 'out/grid/mfc/com/customersorder.php?salesorderkey=' + rId;


                var purchaseorderslineToolbar = purchaseorderslineLayout.cells("b").attachToolbar({
                    icons_path: "./icons/toolbar/icons_terrace/",
                    xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                    skin: "dhx_terrace"
                });
              //  var loadPath1 = 'viewmodel/grid/com/com/prc/supplierspurchaseorders.jsp?purchaseOrderId=' + purchaseOrderId;
                alert(purchaseOrderId);
                purchaseorderslineGrid = purchaseorderslineLayout.cells("b").attachGrid();
                purchaseorderslineGrid.setColTypes("ro,ro,ro");
                purchaseorderslineGrid.setHeader("#,Product Name,Quantity,Unit Price,Amount,Purchase Units");
                purchaseorderslineGrid.setColAlign("left,left,left,left,left,left");
                purchaseorderslineGrid.setInitWidthsP("5,*,10,25,15,10");
                purchaseorderslineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                purchaseorderslineGrid.setColSorting("int,str,str,str,str,str");
                purchaseorderslineGrid.init();

                purchaseorderslineToolbar.attachEvent("onXLE", function () {
                    window.lastvisit = 'new';
                });
                purchaseorderslineToolbar.attachEvent("onClick", function (itemId) {
                    purchaseorderslineToolbarOnclick(itemId, purchaseorderslineGrid, purchaseOrderId);
                });
                //alert(rId);
                purchaseorderslineGrid.attachEvent("onXLS", function () {
                    purchaseorderslineLayout.cells("b").progressOn();
                });
                purchaseorderslineGrid.load("viewmodel/grid/com/com/prc/supplierspurchaseorders.jsp?purchaseOrderId=" + purchaseOrderId, "json");

                // purchaseorderslineGrid.load("out/grid/mfc/com/customersorder.php", "json");
                purchaseorderslineGrid.attachEvent("onXLE", function () {
                    purchaseorderslineLayout.cells("b").progressOff();
                });
                purchaseorderslineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    purchaseorderslineGridOnselect(purchaseorderslineGrid, rId);
                });
                
                var supplierPurchaseorderForm = createPurchaseorderform(purchaseorderslineLayout, purchaseordersGrid, purchaseOrderId);

            }
            
            function purchaseorderslineGridOnselect(mygrid, rId) {
                var pname = mygrid.cells(rId, 1).getValue();
                itempurchasecreateWindow(rId, pname, mygrid);
            }
            function  itempurchasecreateWindow(purchaseOrderId, pname, purchaseorderslineGrid) {

                var win = dhxWins.createWindow("Suppliers " + purchaseOrderId, 600, 140, 450, 450);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    purchaseorderslineGrid.clearAll();
                    purchaseorderslineGrid.load('viewmodel/grid/com/com/prc/supplierspurchaseorders.jsp', 'json');

                });
                win.setText("<b>" + pname + "</b>");

                var itemPurchaseorderFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false, height: 300},
                    ]
                });

                var itemPurchaseorderForm = createItemPurchaseform(itemPurchaseorderFormLayout, purchaseorderslineGrid, purchaseOrderId);

            }
            function createPurchaseorderform(purchaseorderslineLayout, purchaseordersGrid, purchaseOrderId) {

                var supplierPurchaseorderForm = purchaseorderslineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                purchaseorderslineLayout.cells("a").progressOn();
                supplierPurchaseorderForm.loadStruct("./viewmodel/form/com/com/prc/supplierspurchaseorders.jsp?id=" + purchaseOrderId, function () {
                    purchaseorderslineLayout.cells("a").progressOff();
                });
                supplierPurchaseorderForm.enableLiveValidation(true);
                supplierPurchaseorderForm.attachEvent("onButtonClick", function (id) {
                    supplierPurchaseorderFormOnclick(id, supplierPurchaseorderForm, purchaseordersGrid, purchaseorderslineLayout);
                });

                return supplierPurchaseorderForm;
            }
            function createItemPurchaseform(itemPurchaseorderFormLayout, purchaseorderslineGrid, purchaseOrderId) {

                var itemPurchaseorderForm = itemPurchaseorderFormLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                itemPurchaseorderFormLayout.cells("a").progressOn();
                itemPurchaseorderForm.loadStruct("./viewmodel/form/com/com/prc/itempurchaseorder.jsp?id=" + purchaseOrderId, function () {
                    itemPurchaseorderFormLayout.cells("a").progressOff();
                });
                itemPurchaseorderForm.enableLiveValidation(true);
                itemPurchaseorderForm.attachEvent("onButtonClick", function (id) {
                    supplierPurchaseorderFormOnclick(id, itemPurchaseorderForm, purchaseorderslineGrid, itemPurchaseorderFormLayout);
                });

                return itemPurchaseorderForm;
            }

        </script>
        <div id="comcomprcpurchaseorders"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
