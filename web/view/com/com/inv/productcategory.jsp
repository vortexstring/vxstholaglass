<%-- 
    Document   : stores
    Created on : Dec 15, 2015, 10:17:22 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/inv/productcategorycontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Vortexstring|Stores</title></head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var productcategoryLayout = new dhtmlXLayoutObject({
                parent: "comcominvproductcategory",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });

            //1.Setting Layouts properties
            productcategoryLayout.cells("a").setText("");
            productcategoryLayout.cells("a").hideArrow();
            productcategoryLayout.cells("a").hideHeader();
            productcategoryLayout.cells("b").hideArrow();
            productcategoryLayout.cells("b").setWidth('*');
            productcategoryLayout.cells("b").hideHeader();
            productcategoryLayout.cells("b").setWidth(350);

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var productcategoryToolbar = productcategoryLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var productcategoryGrid = productcategoryLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            productcategoryGrid.setImagePath("config/mcsk_skin/imgs/");
            productcategoryGrid.setColTypes("ro,ro,ro");
            productcategoryGrid.setHeader("#,Category Code,Category Name,Product Class");
            productcategoryGrid.setColumnColor(",,#d5f1ff,,,,");
            productcategoryGrid.setColAlign("left,left,left,left");
            productcategoryGrid.setInitWidthsP("5,30,30,30");
            productcategoryGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter");
            productcategoryGrid.setColSorting("int,str,str,str");
            productcategoryGrid.enableMultiselect(false);
            productcategoryGrid.init();

            var productcategoryForm = createCategoryform(productcategoryLayout, productcategoryGrid, -1,productcategoryToolbar);


            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/

            productcategoryToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            productcategoryToolbar.attachEvent("onClick", function (itemId) {
                productcategoryToolbarOnclick(itemId,productcategoryLayout, productcategoryGrid);
            });
            productcategoryGrid.attachEvent("onXLS", function () {
                productcategoryLayout.cells("a").progressOn();
            });
            productcategoryGrid.load('viewmodel/grid/com/com/inv/productcategory.jsp', 'json');
            productcategoryGrid.attachEvent("onXLE", function () {
                productcategoryLayout.cells("a").progressOff();
            });
            rId=-1;
            productcategoryGrid.attachEvent("onRowSelect", function (rId, cInd) {
                
               // alert(rId);
                productcategoryGridOnselect(productcategoryLayout,productcategoryGrid, rId,productcategoryToolbar);
            });
             function productcategoryGridOnselect(productcategoryLayout,productcategoryGrid, rId,productcategoryToolbar) {
                productcategoryLayout.cells("b").progressOn();
                productcategoryLayout.cells("b").detachObject();    
               productcategoryForm=createCategoryform(productcategoryLayout,productcategoryGrid,rId,productcategoryToolbar);

            }

            /**************************END OF OBJECTS EVENTS********************************/
            function createCategoryform(productcategoryLayout,productcategoryGrid,rId,productcategoryToolbar) {
              
                var productcategoryForm = productcategoryLayout.cells("b").attachForm();
                 setRights("productcategory", createCategoryform,productcategoryToolbar)
              // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                productcategoryLayout.cells("b").progressOn();
                productcategoryForm.loadStruct("./viewmodel/form/com/com/inv/productcategory.jsp?id="+rId, function () {
                    productcategoryLayout.cells("b").progressOff();
                });
                productcategoryForm.enableLiveValidation(true);
                productcategoryForm.attachEvent("onButtonClick", function (id) {
                productcategoryFormOnclick(id, productcategoryForm, productcategoryGrid,productcategoryLayout);
            });

                return productcategoryForm;
            }
        </script>
                <div id="comcominvproductcategory"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">
                </div>
    </body>
</html>
