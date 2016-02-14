<%-- 
    Document   : stores
    Created on : Dec 15, 2015, 10:17:22 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/inv/measurementunitscontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Vortexstring|Measurement Units</title></head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts
            var measurementunitsLayout = new dhtmlXLayoutObject({
                parent: "comcominvmeasurementunits",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });

            //1.Setting Layouts properties
            measurementunitsLayout.cells("a").setText("");
            measurementunitsLayout.cells("a").hideArrow();
            measurementunitsLayout.cells("a").hideHeader();
            measurementunitsLayout.cells("b").hideArrow();
            measurementunitsLayout.cells("b").setWidth('*');
            measurementunitsLayout.cells("b").hideHeader();
            measurementunitsLayout.cells("b").setWidth(350);

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var measurementunitsToolbar = measurementunitsLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var measurementunitsGrid = measurementunitsLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            measurementunitsGrid.setImagePath("config/mcsk_skin/imgs/");
            measurementunitsGrid.setColTypes("ro,ro,ro");
            measurementunitsGrid.setHeader("#,UOM Name,UOM Category");
            measurementunitsGrid.setColumnColor(",#d5f1ff,");
            measurementunitsGrid.setColAlign("left,left,left");
            measurementunitsGrid.setInitWidthsP("3,20,20");
            measurementunitsGrid.attachHeader(",#text_filter,#combo_filter");
            measurementunitsGrid.setColSorting("int,str,str");
            measurementunitsGrid.enableMultiselect(false);
            measurementunitsGrid.init();

            var measurementunitsForm = createMeasurementunitsform(measurementunitsLayout, measurementunitsGrid, -1);


            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/

            measurementunitsToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            measurementunitsToolbar.attachEvent("onClick", function (itemId) {
                measurementunitsToolbarOnclick(itemId, measurementunitsGrid,measurementunitsLayout);
            });
            measurementunitsGrid.attachEvent("onXLS", function () {
                measurementunitsLayout.cells("a").progressOn();
            });
            measurementunitsGrid.load('viewmodel/grid/com/com/inv/measurementunits.jsp', 'json');
            measurementunitsGrid.attachEvent("onXLE", function () {
                measurementunitsLayout.cells("a").progressOff();
            });
            rId=-1;
            measurementunitsGrid.attachEvent("onRowSelect", function (rId, cInd) {
                
               // alert(rId);
                measurementunitsGridOnselect(measurementunitsLayout,measurementunitsGrid, rId);
            });
             function measurementunitsGridOnselect(measurementunitsLayout, measurementunitsGrid, rId) {
                measurementunitsLayout.cells("b").progressOn();
                measurementunitsLayout.cells("b").detachObject();    
               measurementunitsForm=createMeasurementunitsform(measurementunitsLayout,measurementunitsGrid,rId);

            }

            /**************************END OF OBJECTS EVENTS********************************/
            function createMeasurementunitsform(measurementunitsLayout,measurementunitsGrid,rId) {
              
                var measurementunitsForm = measurementunitsLayout.cells("b").attachForm();
                                setRights("measurementunits", measurementunitsForm,measurementunitsToolbar)

              // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                measurementunitsLayout.cells("b").progressOn();
                measurementunitsForm.loadStruct("./viewmodel/form/com/com/inv/measurementunits.jsp?id="+rId, function () {
                    measurementunitsLayout.cells("b").progressOff();
                });
                measurementunitsForm.enableLiveValidation(true);
                measurementunitsForm.attachEvent("onButtonClick", function (id) {
                measurementunitsFormOnclick(id, measurementunitsForm, measurementunitsGrid,measurementunitsLayout);
            });

                return measurementunitsForm;
            }
        </script>
                <div id="comcominvmeasurementunits"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">
                </div>
    </body>
</html>
