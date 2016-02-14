<%-- 
    Document   : salesorder
    Created on : Nov 17, 2015, 5:33:45 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/deliveriescontroller.jsp" %>

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
            var deliveriesLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmdeliveries",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
            //1.Setting Layouts properties
            deliveriesLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var deliveriesToolbar = deliveriesLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var deliveriesGrid = deliveriesLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            deliveriesGrid.setImagePath("config/mcsk_skin/imgs/");
            deliveriesGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
            deliveriesGrid.setHeader("#,Delivery Number,Order Number,Expected Delivery,Actual Delivery,Customer Name,Status,Delivered?");
            deliveriesGrid.setColAlign("left,left,left,left,left,left,left,left");
            deliveriesGrid.setInitWidthsP("3,10,15,15,15,*,10,15");
            deliveriesGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#combo_filter,#combo_filter,#combo_filter");
            deliveriesGrid.setColSorting("int,str,str,str,str,str,str,str");
            deliveriesGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/deliveries.jsp';
            deliveriesToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            deliveriesToolbar.attachEvent("onClick", function (itemId) {
                deliveriesToolbarOnclick(itemId, deliveriesGrid);
            });
            //            salesorderGrid.attachEvent("onXLS", function () {
            //                salesorderLayout.cells("a").progressOn();
            //            });
            deliveriesGrid.load(loadPath, "json");
            deliveriesGrid.attachEvent("onXLE", function () {
                deliveriesLayout.cells("a").progressOff();
            });
            deliveriesGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var deliveriesId = rId;

                deliveriesGridOnselect(deliveriesGrid, deliveriesId, deliveriesId);
            });

            function deliveriesGridOnselect(mygrid, deliveriesId, loadPath) {
                var pname = mygrid.cells(deliveriesId, 1).getValue();
                deliveriescreateWindow(deliveriesId, pname, mygrid, loadPath);
            }
            /**************************END OF OBJECTS EVENTS********************************/
            function deliveriescreateWindow(deliveriesId, pname, mygrid) {
                var win = dhxWins.createWindow("deliveries" + deliveriesId, 140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/crm/deliveries.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var deliverieslineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 400},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                /**************************ATTACHING THE FORM URL******************************/
//                salesorderlineLayout.cells("a").attachURL("./in/forms/mfc/com/customersorders.php", null, {salesorderkey: rId});
//                var loadPath1 = 'out/grid/mfc/com/customersorder.php?salesorderkey=' + rId;


                var deliverieslineToolbar = deliverieslineLayout.cells("b").attachToolbar({
                    icons_path: "./icons/toolbar/icons_terrace/",
                    xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                    skin: "dhx_terrace"
                });

                deliverieslineGrid = deliverieslineLayout.cells("b").attachGrid();
                deliverieslineGrid.setColTypes("ro,ro,ro");
                deliverieslineGrid.setHeader("#,Product Name,Quantity,Sale Units,Unit Price,Discount,Amount");
                deliverieslineGrid.setColAlign("left,left,left,left,left,left,left");
                deliverieslineGrid.setInitWidthsP("5,*,8,18,10,10,15");
                deliverieslineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                deliverieslineGrid.setColSorting("int,str,str,str,str,str,str");
                deliverieslineGrid.init();
                // salesorderlineGrid.load(loadPath1, 'json');

                deliverieslineToolbar.attachEvent("onXLE", function () {
                    window.lastvisit = 'new';
                });
                deliverieslineToolbar.attachEvent("onClick", function (itemId) {
                    deliverieslineToolbarOnclick(itemId, deliverieslineGrid, loadPath);
                });
                deliverieslineGrid.attachEvent("onXLS", function () {
                   deliverieslineLayout.cells("b").progressOn();
               });
                deliverieslineGrid.load("viewmodel/grid/com/com/crm/customersdeliveries.jsp?deliveriesId=" + deliveriesId, "json");
                deliverieslineGrid.attachEvent("onXLE", function () {
                    deliverieslineLayout.cells("b").progressOff();
                });
                deliverieslineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    deliverieslineGridOnselect(deliverieslineGrid, rId, loadPath);
                });
                customersDeliveriesForm = createDeliveriesform(deliverieslineLayout, deliverieslineGrid, deliveriesId);

            }
            function createDeliveriesform(deliverieslineLayout, deliverieslineGrid, deliveriesId) {

                var customersDeliveriesForm = deliverieslineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                deliverieslineLayout.cells("a").progressOn();
                customersDeliveriesForm.loadStruct("./viewmodel/form/com/com/crm/customersdeliveries.jsp?id=" + deliveriesId, function () {
                    deliverieslineLayout.cells("a").progressOff();
                });
                customersDeliveriesForm.enableLiveValidation(true);
                customersDeliveriesForm.attachEvent("onButtonClick", function (id) {
                    customersDeliveriesFormOnclick(id, customersDeliveriesForm, deliverieslineGrid, deliverieslineLayout);
                });

                return customersDeliveriesForm;
            }

        </script>
        <div id="comcomcrmdeliveries"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
