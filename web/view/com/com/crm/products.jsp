<%-- 
    Document   : products
    Created on : Nov 16, 2015, 3:12:56 PM
    Author     : TBL
--%>

<%@page import="viewmodelhelpers.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/productscontroller.jsp" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="viewmodel.crud.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Untitled Document</title>

    </head>
    <body>
        <script>


            /* A **************************LAYOUT MANIPULATIONS***********************/
// 1.Creation of Layouts
            var productsLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmproducts",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
            //1.Setting  Layouts properties
            productsLayout.cells("a").hideHeader();
            productsLayout.cells("b").hideHeader();
            productsLayout.cells("a").setWidth(300);

            var productsTreeToolbar = productsLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/crm/products_tree.jsp",
                skin: "dhx_terrace"
            });

         var TreeloadPath = "./viewmodel/tree/com/com/products.jsp";
         
         
       function attachTree(productsLayout,TreeloadPath){
            var productsTree = productsLayout.cells("a").attachTree();
            productsTree.setImagePath("./codebase/imgs/dhxtree_skyblue/");
            productsTree.setSkin('dhx_skyblue');
            productsTree.attachEvent("onXLS", function () {
                productsLayout.cells("a").progressOn();
            });

         
            productsTree.loadJSON(TreeloadPath);
            productsTree.attachEvent("onXLE", function () {
                productsLayout.cells("a").progressOff();
            });

            productsTree.attachEvent("onClick", function (id) {

                // alert(id);


            });
            return productsTree;
            
            }
            
             var productsTree = attachTree(productsLayout,TreeloadPath);

            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var productsToolbar = productsLayout.cells("b").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var productsGrid = productsLayout.cells("b").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/
            var productsloadPath = 'viewmodel/grid/com/com/crm/products.jsp';


            productsGrid.setImagePath("config/mcsk_skin/imgs/");

            <%  ProductsVH PVH = new ProductsVH();
                out.write(PVH.getGrid());
            %>

            productsGrid.init();

            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            productsToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            productsToolbar.attachEvent("onClick", function (itemId) {
                productsToolbarOnclick(itemId, productsGrid, productsloadPath);
            });

            productsTreeToolbar.attachEvent("onClick", function (itemId) {

                var parentId = productsTree.getSelectedItemId();
                productsTreeToolbarOnclick(itemId, productsGrid, productsloadPath, parentId, productsTree, TreeloadPath,productsLayout)

            });
            productsGrid.attachEvent("onXLS", function () {
                productsLayout.cells("b").progressOn();
            });
            productsGrid.load(productsloadPath, 'json');
            productsGrid.attachEvent("onXLE", function () {
                productsLayout.cells("b").progressOff();
            });
            // rId=-1;
            productsGrid.attachEvent("onRowSelect", function (rId, cInd) {
                productsGridOnselect(productsGrid, rId, productsloadPath);
                //   alert(rId);
            });
            
            productsTree.attachEvent("onClick", function(id){

             var pname = productsGrid.cells(id, 2).getValue();
                productscreateWindow(id, pname, productsGrid, productsloadPath);
            
            });
            
            function productsGridOnselect(productsGrid, rId, productsloadPath) {
                var pname = productsGrid.cells(rId, 2).getValue();
                productscreateWindow(rId, pname, productsGrid, productsloadPath);

            }

            function  productscreateWindow(rId, pname, productsGrid, productsloadPath) {

                var win = dhxWins.createWindow("Products " + rId, 50, 50, 1200, 600);
                win.setText("<b>" + pname + "</b>");
                var productsTabbar = win.attachTabbar();
                productsTabbar.loadStruct("./viewmodel/tabbar/com/com/crm/products.jsp?id=" + rId, function () {



                    var productsFormLayout = productsTabbar.tabs("product").attachLayout({
                        pattern: "2U",
                        cells: [
                            {id: "a", text: "Views", header: false},
                            {id: "b", text: "Product configuration details"}
                        ]
                    });
                    productsFormLayout.cells("b").hideArrow();
                
                     var productsForm = createProductsform(productsFormLayout, productsGrid, rId,0);


                });

            }
            
              
            function createProductsform(productsFormLayout, productsGrid, rId,parentId) {

                var productsForm = productsFormLayout.cells("a").attachForm();
                productsForm.setSkin("dhx_web");
                  
              // alert("./viewmodel/form/com/com/crm/products.jsp?id=" + rId+"&parentid=" + parentId);
                productsFormLayout.cells("a").progressOn();
                productsForm.loadStruct("./viewmodel/form/com/com/crm/products.jsp?id=" + rId+"&parentid=" + parentId, function () {
                    productsFormLayout.cells("a").progressOff();
                    var value = productsForm.getItemValue("itemconfigurationid");

                    var productsConfigurationform = createProductsConfigurationform(productsFormLayout, productsGrid, value)
                });

                productsForm.enableLiveValidation(true);
                productsForm.attachEvent("onButtonClick", function (id) {

                    dhtmlx.message({
                        text: "Saving method called",
                        expire: 2000
                    });
                    productsFormOnclick(id, productsForm, productsGrid);
                });

                return productsForm;
            }

            function createProductsConfigurationform(productsFormLayout, productsGrid, rId) {
                var productsConfigurationform = productsFormLayout.cells("b").attachForm();
                productsConfigurationform.setSkin("dhx_web");

                // alert("./viewmodel/form/com/com/crm/products.jsp?id=" + rId);
                productsFormLayout.cells("b").progressOn();
                productsConfigurationform.loadStruct("./viewmodel/form/com/com/crm/productconfiguration.jsp?id=" + rId, function () {
                    productsFormLayout.cells("b").progressOff();
                });

                productsConfigurationform.enableLiveValidation(true);
                productsConfigurationform.attachEvent("onButtonClick", function (id) {

                    dhtmlx.message({
                        text: "Saving method called",
                        expire: 2000
                    });
                    productsConfigurationformOnclick(id, productsConfigurationform, productsGrid);
                });

                return productsConfigurationform;
            }



            /**********************CREATING A WINDOW DEVELOPED FROM  CLICKING A TREE******************/

            function  productsTreecreateWindow(rId, pname, productsGrid, productsloadPath, parentId, productsTree, TreeloadPath) {

                var win = dhxWins.createWindow("Products " + rId, 50, 50, 1200, 600);
                win.setText("<b>" + pname + "</b>");
                var productsTabbar = win.attachTabbar();

                productsTabbar.loadStruct("./viewmodel/tabbar/com/com/crm/products.jsp?id=" + rId, function () {

             
                            var productsFormLayout = productsTabbar.tabs("product").attachLayout({
                        pattern: "2U",
                        cells: [
                            {id: "a", text: "Views", header: false},
                            {id: "b", text: "Product configuration details"}
                        ]
                    });
                    productsFormLayout.cells("b").hideArrow();
                    
                 
                    var productsForm = createProductsform(productsFormLayout, productsGrid, rId,parentId);


                });



            }


        </script>


        <div id="comcomcrmproducts"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
