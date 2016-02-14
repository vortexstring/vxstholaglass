<%-- 
    Document   : productpurchase
    Created on : Jan 30, 2016, 12:16:14 PM
    Author     : TBL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/productpurchasecontroller.jsp" %>

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
            var productpurchaseLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmitempurchase",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting  Layouts properties

            productpurchaseLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var productpurchaseToolbar = productpurchaseLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var productpurchaseGrid = productpurchaseLayout.cells("a").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/


            productpurchaseGrid.setImagePath("config/mcsk_skin/imgs/");
            productpurchaseGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro,ro");
            productpurchaseGrid.setHeader("#,Product,UOM,Sale Price,VAT,Start Date,End Date,Min Qty,Max Qty");
            productpurchaseGrid.setColAlign("left,left,left,left,left,left,left,left,left");
            productpurchaseGrid.setInitWidthsP("3,*,10,15,10,10,10,8,8");
            productpurchaseGrid.setColumnColor(",,#d5f1ff,,,,,,,");
            productpurchaseGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
            productpurchaseGrid.setColSorting("int,str,str,str,str,str,str,str,str");
            productpurchaseGrid.enableMultiselect(false);
            productpurchaseGrid.init();
     
            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/productpurchase.jsp';
            productpurchaseToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            productpurchaseToolbar.attachEvent("onClick", function (itemId) {
           
               productpurchaseToolbarOnclick(itemId, productpurchaseGrid, loadPath);
            });
            productpurchaseGrid.attachEvent("onXLS", function () {
                productpurchaseLayout.cells("a").progressOn();
            });
            productpurchaseGrid.load(loadPath, 'json');
            productpurchaseGrid.attachEvent("onXLE", function () {
                productpurchaseLayout.cells("a").progressOff();
            });
            rId = -1;
            productpurchaseGrid.attachEvent("onRowSelect", function (rId, cInd) {
            productpurchaseGridOnselect(productpurchaseGrid, rId, loadPath);

            });
            function productpurchaseGridOnselect(productpurchaseGrid, rId, loadPath) {
                var pname = productpurchaseGrid.cells(rId, 1).getValue();
                productpurchasecreateWindow(rId, pname, productpurchaseGrid, loadPath);

            }
            /**************************END OF OBJECTS EVENTS********************************/
            function  productpurchasecreateWindow(rId, pname, productpurchaseGrid, loadPath) {
       
                var win = dhxWins.createWindow("Customers " + rId, 370, 70, 800, 585);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                   // customersGrid.clearAll();
                   // customersGrid.load(loadPath, 'json');

                });
                win.setText("<b>" + pname + "</b>");



                var productpurchaseFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false},
                    ]
                });
                var productpurchaseForm = createProductpurchaseform(productpurchaseFormLayout, productpurchaseGrid, rId);
            }
            function createProductpurchaseform(productpurchaseFormLayout, productpurchaseGrid, rId) {

                var productpurchaseForm = productpurchaseFormLayout.cells("a").attachForm();


                productpurchaseFormLayout.cells("a").progressOn();
                
                productpurchaseForm.loadStruct("./viewmodel/form/com/com/crm/productpurchase.jsp?id=" + rId, function () {

                    productpurchaseFormLayout.cells("a").progressOff();
                });
                productpurchaseForm.enableLiveValidation(true);
                
                
             
                productpurchaseForm.attachEvent("onButtonClick", function (id) {
                    productpurchaseFormOnclick(id, productpurchaseForm, productpurchaseGrid, productpurchaseFormLayout);
                });
               
                return productpurchaseForm;
            }



        </script>



        <div id="comcomcrmitempurchase"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>


