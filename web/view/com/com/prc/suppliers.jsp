<%-- 
    Document   : suppliers
    Created on : Dec 4, 2015, 10:55:37 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/prc/supplierscontroller.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

        <title>Vortexstring|Suppliers</title>

    </head>
    <body>

        <script>


            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var suppliersLayout = new dhtmlXLayoutObject({
                parent: "comcomprcsuppliers",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting  Layouts properties

            suppliersLayout.cells("a").hideHeader();



            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var suppliersToolbar = suppliersLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var suppliersGrid = suppliersLayout.cells("a").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            var loadPath = 'viewmodel/grid/com/com/prc/suppliers.jsp';

            suppliersGrid.setImagePath("config/mcsk_skin/imgs/");
            suppliersGrid.setColTypes("ro,ro,ro,ro,ro,ro");
            suppliersGrid.setHeader("#,Supplier Code,Supplier Name,Phone Number,Email,Contact Person,Payment Term,Balance");
            suppliersGrid.setColAlign("left,left,left,left,left,left,left,left");
            suppliersGrid.setInitWidthsP("3,8,*,13,13,13,13,13");
            suppliersGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#combo_filter,#text_filter");
            suppliersGrid.setColSorting("int,str,str,str,str,str");
            suppliersGrid.init();







            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            suppliersToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            suppliersToolbar.attachEvent("onClick", function (itemId) {
                suppliersToolbarOnclick(itemId, suppliersGrid);
            });
         suppliersGrid.attachEvent("onXLS", function () {
              suppliersLayout.cells("a").progressOn();
           });
            suppliersGrid.load(loadPath, 'json');
            suppliersGrid.attachEvent("onXLE", function () {
                suppliersLayout.cells("a").progressOff();
            });
            suppliersGrid.attachEvent("onRowSelect", function (rId, cInd) {
                suppliersGridOnselect(suppliersGrid, rId);
            });
            function suppliersGridOnselect(suppliersGrid, rId, loadPath) {
                var pname = suppliersGrid.cells(rId, 2).getValue();
                supplierscreateWindow(rId, pname, suppliersGrid, loadPath);

            }
            /**************************END OF OBJECTS EVENTS********************************/

            function  supplierscreateWindow(rId, pname, suppliersGrid) {

                var win = dhxWins.createWindow("Suppliers " + rId, 360, 110, 800, 500);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    suppliersGrid.clearAll();
                    suppliersGrid.load(loadPath, 'json');

                });
                win.setText("<b>" + pname + "</b>");

                var supplierFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false, height: 300},
                    ]
                });

                var suppliersForm = createSuppliersform(supplierFormLayout, suppliersGrid, rId);

            }


           function createSuppliersform(supplierFormLayout, suppliersGrid, rId) {

                var suppliersForm = supplierFormLayout.cells("a").attachForm();


                supplierFormLayout.cells("a").progressOn();
                suppliersForm.loadStruct("./viewmodel/form/com/com/prc/suppliers.jsp?id=" + rId, function () {
                    supplierFormLayout.cells("a").progressOff();
                });
                suppliersForm.enableLiveValidation(true);
                suppliersForm.attachEvent("onButtonClick", function (id) {
                    
                    dhtmlx.message({
                        text: "Saving method called",
                        expire: 2000
                     });
                    suppliersFormOnclick(id, suppliersForm, suppliersGrid, supplierFormLayout);
                });

                return suppliersForm;
            }



        </script>
        <div id="comcomprcsuppliers"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
