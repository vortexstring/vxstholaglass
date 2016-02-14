<%-- 
    Document   : salesorder
    Created on : Nov 17, 2015, 5:33:45 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/quotescontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title> Sales Quote</title>
    </head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var quotesLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmquotes",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
            //1.Setting Layouts properties
            quotesLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var quotesToolbar = quotesLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var quotesGrid = quotesLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            quotesGrid.setImagePath("config/mcsk_skin/imgs/");
            quotesGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
            quotesGrid.setHeader("#,Quote Number,Pos Number,Date,Quote Amount,Customer Name,Status,Raised By");
            quotesGrid.setColAlign("left,left,left,left,left,left,left,left");
            quotesGrid.setInitWidthsP("3,10,10,10,10,20,10,20");
            quotesGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
            quotesGrid.setColSorting("int,str,str,str,str,str,str,str");
            quotesGrid.init();

            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/quotes.jsp';
            quotesToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            quotesToolbar.attachEvent("onClick", function (itemId) {
                quotesToolbarOnclick(itemId, quotesGrid);
            });
            quotesGrid.attachEvent("onXLS", function () {
                quotesLayout.cells("a").progressOn();
            });
            quotesGrid.load(loadPath, "json");
            quotesGrid.attachEvent("onXLE", function () {
                quotesLayout.cells("a").progressOff();
            });
            quotesGrid.attachEvent("onRowSelect", function (rId, cInd) {
                var salesQuoteid = rId;

                quotesGridOnselect(quotesGrid, salesQuoteid, salesQuoteid);
            });

            function quotesGridOnselect(mygrid, salesQuoteid, loadPath) {
                var pname = mygrid.cells(salesQuoteid, 1).getValue();
                quotescreateWindow(salesQuoteid, pname, mygrid, loadPath);
            }
            /**************************END OF OBJECTS EVENTS********************************/
            function quotescreateWindow(salesQuoteid, pname, mygrid) {
                var win = dhxWins.createWindow("salesquote" + salesQuoteid, 140, 100, 1200, 550);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load('viewmodel/grid/com/com/crm/quotes.jsp', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var quoteslineLayout = win.attachLayout({
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

                /*  var salesorderlineToolbar = salesorderlineLayout.cells("b").attachToolbar({
                 icons_path: "./icons/all/",
                 xml: "out/toolbars/mfc/com/salesorder_toolbar.php",
                 skin: "dhx_terrace"
                 });*/

                quoteslineGrid = quoteslineLayout.cells("b").attachGrid();
                quoteslineGrid.setColTypes("ro,ro,ro,ro,ro,ro");
                quoteslineGrid.setHeader("#,Product Name,Quantity,Sale Units,Unit Price,Amount");
                quoteslineGrid.setColAlign("left,left,left,left,left,left");
                quoteslineGrid.setInitWidthsP("3,*,10,15,10,15");
                quoteslineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                quoteslineGrid.setColSorting("int,str,str,str,str,str");
                quoteslineGrid.init();
                // quoteslineGrid.load(loadPath1, 'json');

                //salesorderlineToolbar.attachEvent("onXLE", function () {
                //     window.lastvisit = 'new';
                // });
                //  salesorderlineToolbar.attachEvent("onClick", function (itemId) {
                //       salesorderlineToolbarOnclick(itemId, salesorderlineGrid, loadPath);
                //   });
                quoteslineGrid.attachEvent("onXLS", function () {
                    quoteslineLayout.cells("b").progressOn();
                });
                quoteslineGrid.load("viewmodel/grid/com/com/crm/customersquote.jsp?salesQuoteid=" + salesQuoteid, "json");
//alert("viewmodel/grid/com/com/crm/customersquote.jsp?salesQuoteid=" + salesQuoteid);
                quoteslineGrid.attachEvent("onXLE", function () {
                    quoteslineLayout.cells("b").progressOff();
                });
                quoteslineGrid.attachEvent("onRowSelect", function (rId, cInd) {
                    quoteslineGridOnselect(quoteslineGrid, rId, loadPath);
                });
                customersQuotesForm = createQuotesform(quoteslineLayout, quoteslineGrid, salesQuoteid);

            }
            function createQuotesform(quoteslineLayout, quoteslineGrid, salesQuoteid) {

                var customersQuotesForm = quoteslineLayout.cells("a").attachForm();
                // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                quoteslineLayout.cells("a").progressOn();
                customersQuotesForm.loadStruct("viewmodel/form/com/com/crm/customersquotes.jsp?id=" + salesQuoteid, function () {
                    quoteslineLayout.cells("a").progressOff();
                });
                customersQuotesForm.enableLiveValidation(true);
                customersQuotesForm.attachEvent("onButtonClick", function (id) {
                    customersQuotesFormOnclick(id, customersQuotesForm, quoteslineGrid, quoteslineLayout,salesQuoteid);
                });

                //doLink(printquote, salesQuoteid)
                return customersQuotesForm;

            }

            function doLink(printquote, salesQuoteid) {
                var f = this.getForm();
                return '<a target="_blank" href="viewmodel/report/com/com/crm/customersquotes.jsp?id=' + salesQuoteid + '&t=abc">Print Quote</a>';
            }
        </script>
        
        
        <div id="comcomcrmquotes"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
