<%-- 
    Document   : productsale
    Created on : Jan 30, 2016, 11:40:47 AM
    Author     : TBL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/crm/productsalecontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
    </head>
    <body>
        <script>

        var searchString=document.location.href;
      /*  searchString=searchString.subString(1);
        
        var nvpairs=searchString.split("&");
        for(i=0; i<nvpairs.length; i++)
            {
                var nvpairs=nvPairs[i].split("=");
                var name=nvpairs[0];
                var value=nvpairs[1];
            }*/
      var itemid=<% out.write(request.getParameter("id"));  %>



            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var productsaleLayout = new dhtmlXLayoutObject({
                parent: "comcomcrmitemsale",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });

            //1.Setting  Layouts properties

            productsaleLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var productsaleToolbar = productsaleLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var productsaleGrid = productsaleLayout.cells("a").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/


            productsaleGrid.setImagePath("config/mcsk_skin/imgs/");
            productsaleGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro,ro");
            productsaleGrid.setHeader("#,Product,UOM,Sale Price,VAT,Start Date,End Date,Min Qty,Max Qty");
            productsaleGrid.setColAlign("left,left,left,left,left,left,left,left,left");
            productsaleGrid.setInitWidthsP("3,*,10,15,10,10,10,8,8");
            productsaleGrid.setColumnColor(",,#d5f1ff,,,,,,,");
            productsaleGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
            productsaleGrid.setColSorting("int,str,str,str,str,str,str,str,str");
            productsaleGrid.enableMultiselect(false);
            productsaleGrid.init();
     
            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            var productsaleloadpath = 'viewmodel/grid/com/com/crm/productsale.jsp?id='+itemid;
            productsaleToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            productsaleToolbar.attachEvent("onClick", function (itemId) {
           
               productsaleToolbarOnclick(itemId, productsaleGrid, productsaleloadpath,itemid);
            });
            productsaleGrid.attachEvent("onXLS", function () {
                productsaleLayout.cells("a").progressOn();
            });
            productsaleGrid.load(productsaleloadpath, 'json');
            productsaleGrid.attachEvent("onXLE", function () {
                productsaleLayout.cells("a").progressOff();
            });
            rId = -1;
            productsaleGrid.attachEvent("onRowSelect", function (rId, cInd) {
            productsaleGridOnselect(productsaleGrid, rId, productsaleloadpath,itemid);

            });
            function productsaleGridOnselect(productsaleGrid, rId, productsaleloadpath,itemid) {
                var pname = productsaleGrid.cells(rId, 1).getValue();
                productsalecreateWindow(rId, pname, productsaleGrid, productsaleloadpath,itemid);

            }
            /**************************END OF OBJECTS EVENTS********************************/
            function  productsalecreateWindow(rId, pname, productsaleGrid, productsaleloadpath,itemid) {
       
                var win = dhxWins.createWindow("Customers " + rId, 370, 70, 800, 585);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                   // customersGrid.clearAll();
                   // customersGrid.load(productsaleloadpath, 'json');

                });
                win.setText("<b>" + pname + "</b>");



                var productsaleFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false},
                    ]
                });
                var productsaleForm = createProductsaleform(productsaleFormLayout, productsaleGrid, rId,itemid);
            }
            function createProductsaleform(productsaleFormLayout, productsaleGrid, rId,itemid) {

                var productsaleForm = productsaleFormLayout.cells("a").attachForm();


                productsaleFormLayout.cells("a").progressOn();
                
                
              //  alert("./viewmodel/form/com/com/crm/productsale.jsp?id=" + rId+"&itemid="+itemid);
                productsaleForm.loadStruct("./viewmodel/form/com/com/crm/productsale.jsp?id=" + rId+"&itemid="+itemid, function () {

                    productsaleFormLayout.cells("a").progressOff();
                });
                productsaleForm.enableLiveValidation(true);
                
                
             
                productsaleForm.attachEvent("onButtonClick", function (id) {
                    productsaleFormOnclick(id, productsaleForm, productsaleGrid, productsaleFormLayout);
                });
               
                return productsaleForm;
            }



        </script>



        <div id="comcomcrmitemsale"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>

