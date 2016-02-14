<%-- 
    Document   : salesorder
    Created on : Nov 17, 2015, 5:33:45 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/inv/goodsreceivedcontroller.jsp" %>

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
            var goodsreceivedLayout = new dhtmlXLayoutObject({
                parent: "comcominvgoodsreceived",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
            //1.Setting Layouts properties
            goodsreceivedLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var goodsreceivedToolbar = goodsreceivedLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var goodsreceivedGrid = goodsreceivedLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            goodsreceivedGrid.setImagePath("config/mcsk_skin/imgs/");
            goodsreceivedGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
            goodsreceivedGrid.setHeader("#,GR Number,Received Date,Delivery Number,Invoice Number,Supplier Name,Status");
            goodsreceivedGrid.setColAlign("left,left,left,left,left,left,left,left");
            goodsreceivedGrid.setInitWidthsP("3,10,15,20,15,*,15");
            goodsreceivedGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#combo_filter,#combo_filter,#combo_filter");
            goodsreceivedGrid.setColSorting("int,str,str,str,str,str,str,str");
            goodsreceivedGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/inv/goodsreceived.jsp';
            goodsreceivedToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            goodsreceivedToolbar.attachEvent("onClick", function (itemId) {
                goodsreceivedToolbarOnclick(itemId, goodsreceivedGrid);
            });
           // goodsreceivedGrid.attachEvent("onXLS", function () {
            //    goodsreceivedLayout.cells("a").progressOn();
           // });
            goodsreceivedGrid.load(loadPath, "json");
            goodsreceivedGrid.attachEvent("onXLE", function () {
                goodsreceivedLayout.cells("a").progressOff();
            });
            goodsreceivedGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var goodsReceivedId = rId;

                goodsreceivedGridOnselect(goodsreceivedGrid, goodsReceivedId, loadPath);
            });

            function goodsreceivedGridOnselect(mygrid, goodsReceivedId, loadPath) {
                var pname = mygrid.cells(goodsReceivedId, 1).getValue();
                goodsreceivedcreateWindow(goodsReceivedId, pname, mygrid, loadPath);
            }
            /**************************END OF OBJECTS EVENTS********************************/
            function goodsreceivedcreateWindow(goodsReceivedId, pname, mygrid) {
                var win = dhxWins.createWindow("Goodsreceived" + goodsReceivedId, 140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/inv/goodsreceived.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var goodsreceivedlineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 400},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                /**************************ATTACHING THE FORM URL******************************/
                // salesorderlineLayout.cells("a").attachURL("./in/forms/mfc/com/customersorders.php", null, {salesorderkey: rId});
                //var loadPath1 = 'out/grid/mfc/com/customersorder.php?salesorderkey=' + rId;
                //var loadPath1 = 'viewmodel/grid/com/com/crm/customersquote.jsp?salesQuoteid=' + salesQuoteid;

                var goodsreceivedlineToolbar = goodsreceivedlineLayout.cells("b").attachToolbar({
                    icons_path: "./icons/toolbar/icons_terrace/",
                    xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                    skin: "dhx_terrace"
                });

                goodsreceivedlineGrid = goodsreceivedlineLayout.cells("b").attachGrid();
                goodsreceivedlineGrid.setColTypes("ro,ro,ro,ro,ro,ro");
                goodsreceivedlineGrid.setHeader("#,Product Name,Qty Ordered,Qty Received,Balance,Store");
                goodsreceivedlineGrid.setColAlign("left,left,left,left,left,left");
                goodsreceivedlineGrid.setInitWidthsP("3,*,10,15,10,15");
                goodsreceivedlineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                goodsreceivedlineGrid.setColSorting("int,str,str,str,str,str");
                goodsreceivedlineGrid.init();
                // quoteslineGrid.load(loadPath1, 'json');

                goodsreceivedlineToolbar.attachEvent("onXLE", function () {
                    window.lastvisit = 'new';
                });
                goodsreceivedlineToolbar.attachEvent("onClick", function (itemId) {
                    goodsreceivedlineToolbarOnclick(itemId, goodsreceivedlineGrid);
                });
                goodsreceivedlineGrid.attachEvent("onXLS", function () {
                    goodsreceivedlineLayout.cells("b").progressOn();
                });
                goodsreceivedlineGrid.load("viewmodel/grid/com/com/inv/suppliersgoodsreceived.jsp?goodsReceivedId=" + goodsReceivedId, "json");
//alert("viewmodel/grid/com/com/inv/suppliersgoodsreceived.jsp?goodsReceivedId=" + goodsReceivedId);
                goodsreceivedlineGrid.attachEvent("onXLE", function () {
                    goodsreceivedlineLayout.cells("b").progressOff();
                });
                goodsreceivedlineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                                  var goodsReceivedLineId = rId;
  
                    goodsreceivedlineGridOnselect(goodsreceivedlineGrid, goodsReceivedLineId, loadPath);
                });
                
                 function goodsreceivedlineGridOnselect(mygrid, goodsReceivedLineId, loadPath) {
                var pname = mygrid.cells(goodsReceivedLineId, 1).getValue();
                goodsreceivedlinecreateWindow(goodsReceivedLineId, pname, mygrid, loadPath);
            }
                
                
                suppliersGoodsreceivedForm = createGoodsreceivedform(goodsreceivedlineLayout, goodsreceivedlineGrid, goodsReceivedId);

            }
              function  goodsreceivedlinecreateWindow(rId, pname, goodsreceivedlineGrid) {

                var win = dhxWins.createWindow("Suppliers " + rId, 360, 110, 800, 500);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                  //  goodsreceivedlineGrid.clearAll();
                  //  goodsreceivedlineGrid.load('viewmodel/grid/com/com/inv/suppliersgoodsreceived.jsp', 'json');

                });
                win.setText("<b>" + pname + "</b>");

                var goodsreceivedLineFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false, height: 300},
                    ]
                });

                var suppliersgoodsreceivedLineForm = createSuppliersGoodsreceivedLineform(goodsreceivedLineFormLayout, goodsreceivedlineGrid, rId);

            }
            function createSuppliersGoodsreceivedLineform(goodsreceivedLineFormLayout, goodsreceivedlineGrid, rId) {

                var suppliersgoodsreceivedLineForm = goodsreceivedLineFormLayout.cells("a").attachForm();


                goodsreceivedLineFormLayout.cells("a").progressOn();
                suppliersgoodsreceivedLineForm.loadStruct("./viewmodel/form/com/com/inv/suppliersgoodsreceived.jsp?id=" + rId, function () {
                    goodsreceivedLineFormLayout.cells("a").progressOff();
                });
                suppliersgoodsreceivedLineForm.enableLiveValidation(true);
                suppliersgoodsreceivedLineForm.attachEvent("onButtonClick", function (id) {
                    
                    dhtmlx.message({
                        text: "Saving method called",
                        expire: 2000
                     });
                    suppliersgoodsreceivedLineFormOnclick(id, suppliersgoodsreceivedLineForm, goodsreceivedlineGrid, goodsreceivedLineFormLayout);
                });

                return suppliersgoodsreceivedLineForm;
            }
            
         
            function createGoodsreceivedform(goodsreceivedlineLayout, goodsreceivedlineGrid, goodsReceivedId) {

                var suppliersGoodsreceivedForm = goodsreceivedlineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                goodsreceivedlineLayout.cells("a").progressOn();
                suppliersGoodsreceivedForm.loadStruct("viewmodel/form/com/com/inv/goodsreceived.jsp?id=" + goodsReceivedId, function () {
                    goodsreceivedlineLayout.cells("a").progressOff();
                });
                suppliersGoodsreceivedForm.enableLiveValidation(true);
                suppliersGoodsreceivedForm.attachEvent("onButtonClick", function (id) {
                    suppliersGoodsreceivedFormOnclick(id, suppliersGoodsreceivedForm, goodsreceivedlineGrid, goodsreceivedlineLayout, goodsReceivedId);
                });

                //doLink(printquote, salesQuoteid)
                return suppliersGoodsreceivedForm;

            }

        </script>
        <div id="comcominvgoodsreceived"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
