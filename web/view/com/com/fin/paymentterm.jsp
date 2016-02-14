<%-- 
    Document   : paymentterm
    Created on : Dec 24, 2015, 2:11:08 PM
    Author     : pharis wambui
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/fin/paymenttermcontroller.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Untitled Document</title>

    </head>
    <body>

        <script>


            var paytermLayout = new dhtmlXLayoutObject({
                parent: "comcomfinpaymentterm",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });


            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts


            //1.Setting  Layouts properties
            paytermLayout.cells("a").setText("");
            paytermLayout.cells("a").hideArrow();
            paytermLayout.cells("a").hideHeader();
            paytermLayout.cells("b").hideArrow();
            paytermLayout.cells("b").setWidth('*');
            paytermLayout.cells("b").hideHeader();
            paytermLayout.cells("b").setWidth(350);

            /**********************END LAYOUT MANIPULATIONS**************************/

            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var paytermToolbar = paytermLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var paytermGrid = paytermLayout.cells("a").attachGrid("dhx_web");
            

            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            paytermGrid.setImagePath("./codebase/skins/web/imgs/");
            paytermGrid.setHeader("#,Payment Term,Comments");
            paytermGrid.setColAlign("left,left,left");
            paytermGrid.setInitWidthsP("5,35,*");
            paytermGrid.attachHeader(",#text_filter,#text_filter");
            paytermGrid.setColumnColor(",#d5f1ff,,,,");
            paytermGrid.setColTypes("ro,ro,ro");
            paytermGrid.setColSorting(",str,str");
            paytermGrid.enableMultiselect(false);
            paytermGrid.init();

            var paytermForm=createPaytermform(paytermLayout,paytermGrid,-1,paytermToolbar);

            //window.dhx4.skin = "dhx_terrace";

            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            
           /* credentialsGrid.attachEvent("onFilterStart", function(indexes,values){
               //any custom logic
              // alert(values);
        });*/
            
            paytermToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            paytermToolbar.attachEvent("onClick", function (itemId) {
                paytermToolbarOnclick(itemId, paytermLayout, paytermGrid);
            });
            paytermGrid.attachEvent("onXLS", function () {
                paytermLayout.cells("a").progressOn();
            });
            paytermGrid.load('viewmodel/grid/com/com/fin/paymentterm.jsp', 'json');
            paytermGrid.attachEvent("onXLE", function () {
                paytermLayout.cells("a").progressOff();
             });
          
            rId = -1;
            paytermGrid.attachEvent("onRowSelect", function (rId, cInd) {
                paytermGridOnselect(rId, paytermGrid, paytermLayout,paytermToolbar);
            
            });

            function paytermGridOnselect(rId, paytermGrid, paytermLayout,paytermToolbar) {
                paytermLayout.cells("b").progressOn();
                paytermLayout.cells("b").detachObject();    
                var paytermForm=createPaytermform(paytermLayout,paytermGrid,rId,paytermToolbar);

            }


            function createPaytermform(paytermLayout,paytermGrid,rId,paytermToolbar) {
              
                var paytermForm = paytermLayout.cells("b").attachForm();
                setRights("paymentterm", paytermForm,paytermToolbar)
               // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                paytermLayout.cells("b").progressOn();
                paytermForm.loadStruct("./viewmodel/form/com/com/fin/paymentterm.jsp?id="+rId, function () {
                    paytermLayout.cells("b").progressOff();
                });
                paytermForm.enableLiveValidation(true);
                paytermForm.attachEvent("onButtonClick", function (id) {
                paytermFormOnclick(id, paytermForm, paytermGrid,paytermLayout);
            });

                return paytermForm;
            }


        </script>


        <div id="comcomfinpaymentterm"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

        </div>
    </body>
</html
