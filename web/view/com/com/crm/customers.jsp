<%-- 
    Document   : customer
    Created on : Nov 17, 2015, 5:34:39 PM
    Author     : carol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/customerscontroller.jsp" %>
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
            var customersLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmcustomer",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting  Layouts properties

            customersLayout.cells("a").hideHeader();



            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var customersToolbar = customersLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var customersGrid = customersLayout.cells("a").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/


            customersGrid.setImagePath("config/mcsk_skin/imgs/");
            customersGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro");
            customersGrid.setHeader("#,Customer Code,Customer Name,Customer Type,Phone Number,Email,Contact Person");
            customersGrid.setColAlign("left,left,left,left,left,left,left");
            customersGrid.setInitWidthsP("3,12,20,10,15,20,20");
            customersGrid.setColumnColor(",,#d5f1ff,,,,,,,");
            customersGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#text_filter,#text_filter,#text_filter");
            customersGrid.setColSorting("int,str,str,str,str,str,str");
            customersGrid.enableMultiselect(false);
            customersGrid.init();
            //  var customersForm = createCustomersform(customerLayout, customersGrid, rId);







            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            var loadPath = 'viewmodel/grid/com/com/crm/customers.jsp';
            customersToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            customersToolbar.attachEvent("onClick", function (itemId) {
                customersToolbarOnclick(itemId, customersGrid, loadPath);
            });
            customersGrid.attachEvent("onXLS", function () {
                customersLayout.cells("a").progressOn();
            });
            customersGrid.load(loadPath, 'json');
            customersGrid.attachEvent("onXLE", function () {
                customersLayout.cells("a").progressOff();
            });
            rId = -1;
            customersGrid.attachEvent("onRowSelect", function (rId, cInd) {
                customersGridOnselect(customersGrid, rId, loadPath);
//alert(rId);

            });
            function customersGridOnselect(customersGrid, rId, loadPath) {
                var pname = customersGrid.cells(rId, 2).getValue();
                customerscreateWindow(rId, pname, customersGrid, loadPath);

            }
            /**************************END OF OBJECTS EVENTS********************************/
            function  customerscreateWindow(rId, pname, customersGrid, loadPath) {
                // var loadPath = 'viewmodel/grid/com/com/crm/customers.jsp';
                //     var customersForm=createCustomersform(customerLayout,customersGrid,rId);

                var win = dhxWins.createWindow("Customers " + rId, 370, 70, 800, 585);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    customersGrid.clearAll();
                    customersGrid.load(loadPath, 'json');

                });
                win.setText("<b>" + pname + "</b>");


                customerTabbar = win.attachTabbar();
                var customerid = "customer";
                var customercaption = "Customer Details";
                var statementid = "statementdetails";
                var statementcaption = "Statement Details";
                var creditid = "creditamount";
                var creditcaption = "Credit Amounts";
                customerTabbar.addTab(customerid, customercaption, ((customercaption.length * 5) + 70), null, true, false);
                customerTabbar.addTab(statementid, statementcaption, ((statementcaption.length * 5) + 70), null, false, false);
                customerTabbar.addTab(creditid, creditcaption, ((creditcaption.length * 5) + 70), null, false, false);
                customerTabbar.setSkin("dhx_terrace");

                var customerLayout = customerTabbar.cells(customerid).attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false},
                    ]
                });
                var customersForm = createCustomersform(customerLayout, customersGrid, rId);
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
             */            function createCustomersform(customerLayout, customersGrid, rId) {

                var customersForm = customerLayout.cells("a").attachForm();


                customerLayout.cells("a").progressOn();
                var isChecked = customersForm.isItemChecked("credit");
//alert(isChecked);
                    if (isChecked == true) {
                        customersForm.enableItem("creditlimit");
                    } else {
                        customersForm.disableItem("creditlimit");

                    }
                customersForm.loadStruct("./viewmodel/form/com/com/crm/customers.jsp?id=" + rId, function () {
                    
                    customerLayout.cells("a").progressOff();
                });
                customersForm.enableLiveValidation(true);
                customersForm.attachEvent("onButtonClick", function (id) {
                    customersFormOnclick(id, customersForm, customersGrid, customerLayout);
                });
                  customersForm.attachEvent("onChange", function (name, value, state) {
                    //your code here
                    //alert ("name is:"+name+ " state is:"+state);
                    if (name == "credit") {
                        if (state == true) {
                            customersForm.enableItem("creditlimit");
                        } else {
                            customersForm.disableItem("creditlimit");

                        }
                    }
                });

                  customersForm.attachEvent("onValidateError", function (name, value, result){
                        
                     
                       
                       var text = customersForm.getItemLabel(name);
                      
                      customValidationMessage(text,value);
                       // alert("Validation failed for "+name+" with value :"+value+" with result "+result);
                       //customValidationMessage(name,value)
                    });
                return customersForm;
            }



        </script>



        <div id="comcomcrmcustomer"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
