<%-- 
    Document   : stores
    Created on : Dec 15, 2015, 10:17:22 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/inv/storescontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Vortexstring|Stores</title></head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var storesLayout = new dhtmlXLayoutObject({
                parent: "comcominvstores",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });

            //1.Setting Layouts properties
            storesLayout.cells("a").setText("");
            storesLayout.cells("a").hideArrow();
            storesLayout.cells("a").hideHeader();
            storesLayout.cells("b").hideArrow();
            storesLayout.cells("b").setWidth('*');
            storesLayout.cells("b").hideHeader();
            storesLayout.cells("b").setWidth(350);

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var storesToolbar = storesLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var storesGrid = storesLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            storesGrid.setImagePath("config/mcsk_skin/imgs/");
            storesGrid.setColTypes("ro,ro,ro");
            storesGrid.setHeader("#,store name,store Manager,Store Phone,Description");
            storesGrid.setColumnColor(",#d5f1ff,,,,");
            storesGrid.setColAlign("left,left,left,left,left");
            storesGrid.setInitWidthsP("3,20,20,20,*");
            storesGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
            storesGrid.setColSorting("int,str,str,str,str");
            storesGrid.enableMultiselect(false);
            storesGrid.init();

            var storesForm = createStoresform(storesLayout, storesGrid, -1);


            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/

            storesToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            storesToolbar.attachEvent("onClick", function (itemId) {
                storesToolbarOnclick(itemId, storesGrid,storesLayout);
            });
            storesGrid.attachEvent("onXLS", function () {
                storesLayout.cells("a").progressOn();
            });
            storesGrid.load('viewmodel/grid/com/com/inv/stores.jsp', 'json');
            storesGrid.attachEvent("onXLE", function () {
                storesLayout.cells("a").progressOff();
            });
            rId=-1;
            storesGrid.attachEvent("onRowSelect", function (rId, cInd) {
                
               // alert(rId);
                storesGridOnselect(storesLayout,storesGrid, rId);
            });
             function storesGridOnselect(storesLayout, storesGrid, rId) {
                storesLayout.cells("b").progressOn();
                storesLayout.cells("b").detachObject();    
               storesForm=createStoresform(storesLayout,storesGrid,rId);

            }

            /**************************END OF OBJECTS EVENTS********************************/
            function createStoresform(storesLayout,storesGrid,rId) {
              
                var storesForm = storesLayout.cells("b").attachForm();
              // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                storesLayout.cells("b").progressOn();
                storesForm.loadStruct("./viewmodel/form/com/com/inv/stores.jsp?id="+rId, function () {
                    storesLayout.cells("b").progressOff();
                });
                storesForm.enableLiveValidation(true);
                storesForm.attachEvent("onButtonClick", function (id) {
                storesFormOnclick(id, storesForm, storesGrid,storesLayout);
            });

                return storesForm;
            }
        </script>
                <div id="comcominvstores"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">
                </div>
    </body>
</html>
