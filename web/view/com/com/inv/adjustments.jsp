<%-- 
    Document   : customer
    Created on : Nov 17, 2015, 5:34:39 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/inv/adjustmentscontroller.jsp" %>
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
            var adjustmentsLayout = new dhtmlXLayoutObject({
                parent: "comcominvadjustments",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting  Layouts properties

            adjustmentsLayout.cells("a").hideHeader();



            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var adjustmentsToolbar = adjustmentsLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var adjustmentsGrid = adjustmentsLayout.cells("a").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/


            adjustmentsGrid.setImagePath("config/mcsk_skin/imgs/");
            adjustmentsGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
            adjustmentsGrid.setHeader("#,Item,Adjustment Date,Store,Quantity,Type,Reason,Status");
            adjustmentsGrid.setColAlign("left,left,left,left,left,left,left,left");
            adjustmentsGrid.setInitWidthsP("3,12,15,10,15,15,15,15");
            adjustmentsGrid.setColumnColor(",,#d5f1ff,,,,,,,");
            adjustmentsGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#text_filter,#combo_filter,#text_filter,#combo_filter");
            adjustmentsGrid.setColSorting("int,str,str,str,str,str,str");
            adjustmentsGrid.enableMultiselect(false);
            adjustmentsGrid.init();
            //  var customersForm = createCustomersform(customerLayout, customersGrid, rId);







            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/inv/adjustments.jsp';
            adjustmentsToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            adjustmentsToolbar.attachEvent("onClick", function (itemId) {
                adjustmentsToolbarOnclick(itemId, adjustmentsGrid);
            });
            adjustmentsGrid.attachEvent("onXLS", function () {
                adjustmentsLayout.cells("a").progressOn();
            });
            adjustmentsGrid.load(loadPath, 'json');
            adjustmentsGrid.attachEvent("onXLE", function () {
                adjustmentsLayout.cells("a").progressOff();
            });
            rId = -1;
            adjustmentsGrid.attachEvent("onRowSelect", function (rId, cInd) {
                adjustmentsGridOnselect(adjustmentsGrid, rId);
//alert(rId);

            });
            function adjustmentsGridOnselect(adjustmentsGrid, rId, loadPath) {
                var pname = adjustmentsGrid.cells(rId, 1).getValue();
                adjustmentscreateWindow(rId, pname, adjustmentsGrid, loadPath);

            }
            /**************************END OF OBJECTS EVENTS********************************/
            function  adjustmentscreateWindow(rId, pname, adjustmentsGrid, loadPath) {
                // var loadPath = 'viewmodel/grid/com/com/crm/customers.jsp';
                //     var customersForm=createCustomersform(customerLayout,customersGrid,rId);

                var win = dhxWins.createWindow("Adjustments " + rId, 480, 100, 430, 600);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    adjustmentsGrid.clearAll();
                    adjustmentsGrid.load('viewmodel/grid/com/com/inv/adjustments.jsp', 'json');

                });
                 win.setText("<b>" + pname + "</b>");

                var adjustmentsFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false, height: 300},
                    ]
                });
                var adjustmentsForm = createAdjustmentsform(adjustmentsFormLayout, adjustmentsGrid, rId);
            }
            
            
                function createAdjustmentsform(adjustmentsFormLayout, adjustmentsGrid, rId) {

                var adjustmentsForm = adjustmentsFormLayout.cells("a").attachForm();


                adjustmentsFormLayout.cells("a").progressOn();
                adjustmentsForm.loadStruct("./viewmodel/form/com/com/inv/adjustments.jsp?id=" + rId, function () {
                    adjustmentsFormLayout.cells("a").progressOff();
                });
                adjustmentsForm.enableLiveValidation(true);
                adjustmentsForm.attachEvent("onButtonClick", function (id) {
                    
                    //dhtmlx.message({
                    //    text: "Saving method called",
                    //    expire: 2000
                    // });
                    adjustmentsFormOnclick(id, adjustmentsForm, adjustmentsGrid, adjustmentsFormLayout);
                    alert(id);
                });

                return adjustmentsForm;
            }

            
            
            
            
            
            
            /*                           // function createCustomersform(customerLayout,customersGrid,rId) {
             //
             var customersForm = customerLayout.cells("a").attachForm();
             //
             //
             // customerLayout.cells("a").progressOn();
             //                customersForm.loadStruct("./viewmodel/form/com/com/crm/customers.jsp?id="+rId, function () {
             //                    customerLayout.cells("a").progressOff();
             //                });
             //                customersForm.enableLiveValidation(true);
             //                customersForm.attachEvent("onButtonClick", function (id) {
             //                customersFormOnclick(id, customersForm, customersGrid,customerLayout,loadPath);
             //            });
             //
             //              //  return customersForm;
             //           // }
             // customerLayout.cells("a").attachURL("in/forms/mfc/com/customers.php", null, {key: rId});
             
             
             
             
             }
                        function createCustomersform(customerLayout, customersGrid, rId) {

                var customersForm = customerLayout.cells("a").attachForm();


                customerLayout.cells("a").progressOn();
                customersForm.loadStruct("./viewmodel/form/com/com/crm/customers.jsp?id=" + rId, function () {
                    customerLayout.cells("a").progressOff();
                });
                customersForm.enableLiveValidation(true);
                customersForm.attachEvent("onButtonClick", function (id) {
                    customersFormOnclick(id, customersForm, customersGrid, customerLayout);
                });

                return customersForm;
            }
*/


        </script>



        <div id="comcominvadjustments"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
