<%-- 
    Document   : productcolor
    Created on : Jan 30, 2016, 12:29:47 PM
    Author     : TBL
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/productcolorcontroller.jsp" %>

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
            var productcolorLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmitemcolor",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting  Layouts properties

            productcolorLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var productcolorToolbar = productcolorLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var productcolorGrid = productcolorLayout.cells("a").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/


            productcolorGrid.setImagePath("config/mcsk_skin/imgs/");
            productcolorGrid.setColTypes("ro,ro,ro,ro,ro");
            productcolorGrid.setHeader("#,Product,Color Code,Color Picker Code,Color Name");
            productcolorGrid.setColAlign("left,left,left,left,left,left,left,left,left");
            productcolorGrid.setInitWidthsP("3,*,20,20,20");
            productcolorGrid.setColumnColor(",,#d5f1ff,,,,,,,");
            productcolorGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#text_filter");
            productcolorGrid.setColSorting("int,str,str,str,str");
            productcolorGrid.enableMultiselect(false);
            productcolorGrid.init();
     
            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/productcolor.jsp';
            productcolorToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            productcolorToolbar.attachEvent("onClick", function (itemId) {
           
               productcolorToolbarOnclick(itemId, productcolorGrid, loadPath);
            });
            productcolorGrid.attachEvent("onXLS", function () {
                productcolorLayout.cells("a").progressOn();
            });
            productcolorGrid.load(loadPath, 'json');
            productcolorGrid.attachEvent("onXLE", function () {
                productcolorLayout.cells("a").progressOff();
            });
            rId = -1;
            productcolorGrid.attachEvent("onRowSelect", function (rId, cInd) {
            productcolorGridGridOnselect(productcolorGrid, rId, loadPath);

            });
            function productcolorGridGridOnselect(productcolorGrid, rId, loadPath) {
                var pname = productcolorGrid.cells(rId, 1).getValue();
                productcolorcreateWindow(rId, pname, productcolorGrid, loadPath);

            }
            /**************************END OF OBJECTS EVENTS********************************/
            function  productcolorcreateWindow(rId, pname, productcolorGrid, loadPath) {
       
                var win = dhxWins.createWindow("Customers " + rId, 370, 70, 800, 585);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                   // customersGrid.clearAll();
                   // customersGrid.load(loadPath, 'json');

                });
                win.setText("<b>" + pname + "</b>");



                var productcolorFormLayout = win.attachLayout({
                    pattern: "2E",
                    cells: [
                        {id: "a", text: "Views", header: false,width: 300},
                        {id: "b", text: "Views", header: false},

                    ]
                });
                var productcolorForm = createProductcolorform(productcolorFormLayout, productcolorGrid, rId);
            }
            function createProductcolorform(productcolorFormLayout, productcolorGrid, rId) {

                var productcolorForm = productcolorFormLayout.cells("a").attachForm();


                productcolorFormLayout.cells("a").progressOn();
                
                productcolorForm.loadStruct("./viewmodel/form/com/com/crm/productcolor.jsp?id=" + rId, function () {

                    productcolorFormLayout.cells("a").progressOff();
                });
                productcolorForm.enableLiveValidation(true);
                
                
             
                productcolorForm.attachEvent("onButtonClick", function (id) {
                    productcolorFormOnclick(id, productcolorForm, productcolorGrid, productcolorFormLayout);
                });
               
                return productcolorForm;
            }



        </script>



        <div id="comcomcrmitemcolor"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>


