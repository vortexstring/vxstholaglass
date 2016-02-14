<%-- 
    Document   : bankaccounts
    Created on : Dec 24, 2015, 2:08:34 PM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/fin/bankaccountscontroller.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Untitled Document</title>

    </head>
    <body>

        <script>


            var bankaccountLayout = new dhtmlXLayoutObject({
                parent: "comcomfinbankaccounts",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });


            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts


            //1.Setting  Layouts properties
            bankaccountLayout.cells("a").setText("");
            bankaccountLayout.cells("a").hideArrow();
            bankaccountLayout.cells("a").hideHeader();
            bankaccountLayout.cells("b").hideArrow();
            bankaccountLayout.cells("b").setWidth('*');
            bankaccountLayout.cells("b").hideHeader();
            bankaccountLayout.cells("b").setWidth(350);

            /**********************END LAYOUT MANIPULATIONS**************************/

            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var bankaccountToolbar = bankaccountLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var bankaccountGrid = bankaccountLayout.cells("a").attachGrid("dhx_web");
            

            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            bankaccountGrid.setImagePath("./codebase/skins/web/imgs/");
            bankaccountGrid.setHeader("#,Account,Bank,Account Number,Currency,Default Account?");
            bankaccountGrid.setColAlign("left,left,left,left,left,center");
            bankaccountGrid.setInitWidthsP("5,*,20,20,15,15,10");
            bankaccountGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#combo_filter,#combo_filter");
            bankaccountGrid.setColumnColor(",#d5f1ff,,,,");
            bankaccountGrid.setColTypes("ro,ro,ro,ro,ro,ro");
            bankaccountGrid.setColSorting(",str,str,int,str,str");
            bankaccountGrid.enableMultiselect(false);
            bankaccountGrid.init();

            var bankaccountForm=createBankaccountForm(bankaccountLayout,bankaccountGrid,-1);

            //window.dhx4.skin = "dhx_terrace";

            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            
           /* credentialsGrid.attachEvent("onFilterStart", function(indexes,values){
               //any custom logic
              // alert(values);
        });*/
            
            bankaccountToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            bankaccountToolbar.attachEvent("onClick", function (itemId) {
                bankaccountToolbarOnclick(itemId, bankaccountLayout, bankaccountGrid);
            });
            bankaccountGrid.attachEvent("onXLS", function () {
                bankaccountLayout.cells("a").progressOn();
            });
            bankaccountGrid.load('viewmodel/grid/com/com/fin/bankaccounts.jsp', 'json');
            bankaccountGrid.attachEvent("onXLE", function () {
                bankaccountLayout.cells("a").progressOff();
             });
          
            rId = -1;
            bankaccountGrid.attachEvent("onRowSelect", function (rId, cInd) {
                bankaccountGridOnselect(rId, bankaccountGrid, bankaccountLayout);
            
            });

            function bankaccountGridOnselect(rId, bankaccountGrid, bankaccountLayout) {
                bankaccountLayout.cells("b").progressOn();
                bankaccountLayout.cells("b").detachObject();    
                var bankaccountForm=createBankaccountForm(bankaccountLayout,bankaccountGrid,rId);

            }


            function createBankaccountForm(bankaccountLayout,bankaccountGrid,rId) {
              
                var bankaccountForm = bankaccountLayout.cells("b").attachForm();
                //setRights("bankaccounts", bankaccountForm,bankaccountToolbar)
                alert("./viewmodel/form/com/com/fin/bankaccounts.jsp?id="+rId);
                bankaccountLayout.cells("b").progressOn();
                bankaccountForm.loadStruct("./viewmodel/form/com/com/fin/bankaccounts.jsp?id="+rId, function () {
                    bankaccountLayout.cells("b").progressOff();
                });
                bankaccountForm.enableLiveValidation(true);
                bankaccountForm.attachEvent("onButtonClick", function (id) {
                bankaccountFormOnclick(id, bankaccountForm, bankaccountGrid,bankaccountLayout);
            });

                return bankaccountForm;
            }


        </script>


        <div id="comcomfinbankaccounts"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

        </div>
    </body>
</html