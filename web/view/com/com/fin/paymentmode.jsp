<%-- 
    Document   : paymentmode
    Created on : Dec 24, 2015, 2:10:06 PM
    Author     : pharis wambui
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/fin/paymentmodecontroller.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Untitled Document</title>

    </head>
    <body>

        <script>


            var paymentmodeLayout = new dhtmlXLayoutObject({
                parent: "comcomfinpaymentmode",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });


            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts


            //1.Setting  Layouts properties
            paymentmodeLayout.cells("a").setText("");
            paymentmodeLayout.cells("a").hideArrow();
            paymentmodeLayout.cells("a").hideHeader();
            paymentmodeLayout.cells("b").hideArrow();
            paymentmodeLayout.cells("b").setWidth('*');
            paymentmodeLayout.cells("b").hideHeader();
            paymentmodeLayout.cells("b").setWidth(350);

            /**********************END LAYOUT MANIPULATIONS**************************/

            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var paymentmodeToolbar = paymentmodeLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var paymentmodeGrid = paymentmodeLayout.cells("a").attachGrid("dhx_web");
            

            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            paymentmodeGrid.setImagePath("./codebase/skins/web/imgs/");
            paymentmodeGrid.setHeader("#,Name,Comments");
            paymentmodeGrid.setColAlign("left,left,left");
            paymentmodeGrid.setInitWidthsP("5,*,20,20");
            paymentmodeGrid.attachHeader(",#text_filter,#text_filter");
            paymentmodeGrid.setColumnColor(",#d5f1ff,,,,");
            paymentmodeGrid.setColTypes("ro,ro,ro");
            paymentmodeGrid.setColSorting(",str,str");
            paymentmodeGrid.enableMultiselect(false);
            paymentmodeGrid.init();

            var paymentmodeForm=createPaymentmodeform(paymentmodeLayout,paymentmodeGrid,-1,paymentmodeToolbar);

            //window.dhx4.skin = "dhx_terrace";

            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            
           /* credentialsGrid.attachEvent("onFilterStart", function(indexes,values){
               //any custom logic
              // alert(values);
        });*/
            
            paymentmodeToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            paymentmodeToolbar.attachEvent("onClick", function (itemId) {
                paymentmodeToolbarOnclick(itemId, paymentmodeLayout, paymentmodeGrid);
            });
            paymentmodeGrid.attachEvent("onXLS", function () {
                paymentmodeLayout.cells("a").progressOn();
            });
            paymentmodeGrid.load('viewmodel/grid/com/com/fin/paymentmode.jsp', 'json');
            paymentmodeGrid.attachEvent("onXLE", function () {
                paymentmodeLayout.cells("a").progressOff();
             });
          
            rId = -1;
            paymentmodeGrid.attachEvent("onRowSelect", function (rId, cInd) {
                paymentmodeGridOnselect(rId, paymentmodeGrid, paymentmodeLayout,paymentmodeToolbar);
            
            });

            function paymentmodeGridOnselect(rId, paymentmodeGrid, paymentmodeLayout,paymentmodeToolbar) {
                paymentmodeLayout.cells("b").progressOn();
                paymentmodeLayout.cells("b").detachObject();    
                var paymentmodeForm=createPaymentmodeform(paymentmodeLayout,paymentmodeGrid,rId,paymentmodeToolbar);

            }


            function createPaymentmodeform(paymentmodeLayout,paymentmodeGrid,rId,paymentmodeToolbar) {
              
                var paymentmodeForm = paymentmodeLayout.cells("b").attachForm();
                setRights("paymentmode", paymentmodeForm,paymentmodeToolbar)
               // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                paymentmodeLayout.cells("b").progressOn();
                paymentmodeForm.loadStruct("./viewmodel/form/com/com/fin/paymentmode.jsp?id="+rId, function () {
                    paymentmodeLayout.cells("b").progressOff();
                });
                paymentmodeForm.enableLiveValidation(true);
                paymentmodeForm.attachEvent("onButtonClick", function (id) {
                paymentmodeFormOnclick(id, paymentmodeForm, paymentmodeGrid,paymentmodeLayout);
            });

                return paymentmodeForm;
            }


        </script>


        <div id="comcomfinpaymentmode"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

        </div>
    </body>
</html