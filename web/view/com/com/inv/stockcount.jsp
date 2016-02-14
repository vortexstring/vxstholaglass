<%-- 
    Document   : customer
    Created on : Nov 17, 2015, 5:34:39 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/inv/stockcountcontroller.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
    </head>
    <body>
        <script>


            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var stockcountLayout = new dhtmlXLayoutObject({
                parent: "comcominvstockcount",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting  Layouts properties

            stockcountLayout.cells("a").hideHeader();



            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var stockcountToolbar = stockcountLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var stockcountGrid = stockcountLayout.cells("a").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/


            stockcountGrid.setImagePath("config/mcsk_skin/imgs/");
            stockcountGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro");
            stockcountGrid.setHeader("#,Stock Count Code,Stock Count Date,Status");
            stockcountGrid.setColAlign("left,left,left,left");
            stockcountGrid.setInitWidthsP("3,12,20,20");
            stockcountGrid.setColumnColor(",,#d5f1ff,,,,,,,");
            stockcountGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#text_filter,#text_filter,#text_filter");
            stockcountGrid.setColSorting("int,str,str,str,str,str,str");
            stockcountGrid.enableMultiselect(false);
            stockcountGrid.init();
            //  var customersForm = createCustomersform(customerLayout, customersGrid, rId);







            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/inv/stockcount.jsp';
            stockcountToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            stockcountToolbar.attachEvent("onClick", function (itemId) {
                stockcountToolbarOnclick(itemId, stockcountGrid);
            });
            stockcountGrid.attachEvent("onXLS", function () {
                stockcountLayout.cells("a").progressOn();
            });
            stockcountGrid.load(loadPath, 'json');
            stockcountGrid.attachEvent("onXLE", function () {
                stockcountLayout.cells("a").progressOff();
            });
            rId = -1;
            stockcountGrid.attachEvent("onRowSelect", function (rId, cInd) {
                stockcountGridOnselect(stockcountGrid, rId, loadPath);
//alert(rId);

            });
            function stockcountGridOnselect(stockcountGrid, rId, loadPath) {
                var pname = stockcountGrid.cells(rId, 1).getValue();
                stockcountcreateWindow(rId, pname, stockcountGrid, loadPath);

            }
            /**************************END OF OBJECTS EVENTS********************************/
            function  stockcountcreateWindow(rId, pname, stockcountGrid, loadPath) {
                // var loadPath = 'viewmodel/grid/com/com/crm/customers.jsp';
                //     var customersForm=createCustomersform(customerLayout,customersGrid,rId);

                var win = dhxWins.createWindow("Stockcount " + rId, 330, 75, 800, 570);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    stockcountGrid.clearAll();
                    stockcountGrid.load(loadPath, 'json');

                });
                win.setText("<b>" + pname + "</b>");
                var stockcountGridLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "GRID", header: false},
                    ]
                });

                var stockcountGridToolbar = stockcountGridLayout.cells("a").attachToolbar({
                    icons_path: "./icons/toolbar/icons_terrace/",
                    xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                    skin: "dhx_terrace"
                });


                //var stockcountForm = createStockcountform(stockcountFormLayout, stockcountGrid, rId);
                mygrid = stockcountGridLayout.cells("a").attachGrid();
                mygrid.setColTypes("ro,ro,ro,ed");
                mygrid.setHeader("Item,Store,System qty,Actual qty");
                mygrid.setColAlign("left,left,left,left");
                mygrid.setInitWidths("350,180,100,*,");
                mygrid.attachHeader("#text_filter,#combo_filter,,");
                mygrid.setColSorting("str,str,int,str");
                mygrid.init();



                stockcountGridToolbar.attachEvent("onXLE", function () {
                    window.lastvisit = 'new';
                });
                stockcountGridToolbar.attachEvent("onClick", function (itemId) {
                    stockcountGridToolbarOnclick(itemId, mygrid);
                });
             /*   mygrid.attachEvent("onXLS", function () {
                    stockcountGridLayout.cells("a").progressOn();
                });*/
                mygrid.load("viewmodel/grid/com/com/inv/stockcountgrid.jsp", "json");
                mygrid.attachEvent("onXLE", function () {
                    stockcountGridLayout.cells("b").progressOff();
                });
                mygrid.attachEvent("onRowSelect", function (rId, cInd) {
                    mygridOnselect(mygrid, rId, loadPath);
                });
            }


            /*  function createStockcountform(stockcountFormLayout, stockcountGrid, rId) {
             
             var stockcountForm = stockcountFormLayout.cells("a").attachForm();
             
             
             stockcountFormLayout.cells("a").progressOn();
             stockcountForm.loadStruct("./viewmodel/form/com/com/crm/customers.jsp?id=" + rId, function () {
             stockcountFormLayout.cells("a").progressOff();
             });
             stockcountForm.enableLiveValidation(true);
             stockcountForm.attachEvent("onButtonClick", function (id) {
             customersFormOnclick(id, stockcountForm, stockcountGrid, stockcountFormLayout);
             });
             
             return stockcountForm;
             }
             
             */

        </script>



        <div id="comcominvstockcount"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
