<%-- 
    Document   : customers
    Created on : Jun 15, 2015, 10:54:52 AM
    Author     : JFX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/sec/credentialscontroller.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Untitled Document</title>

    </head>
    <body>

        <script>


            var credentialsLayout = new dhtmlXLayoutObject({
                parent: "comcomcredentials",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });


            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts


            //1.Setting  Layouts properties
            credentialsLayout.cells("a").setText("");
            credentialsLayout.cells("a").hideArrow();
            credentialsLayout.cells("a").hideHeader();
            credentialsLayout.cells("b").hideArrow();
            credentialsLayout.cells("b").setWidth('*');
            credentialsLayout.cells("b").hideHeader();
            credentialsLayout.cells("b").setWidth(350);

            /**********************END LAYOUT MANIPULATIONS**************************/

            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var credentialsToolbar = credentialsLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var credentialsGrid = credentialsLayout.cells("a").attachGrid("dhx_web");
            

            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            credentialsGrid.setImagePath("./codebase/skins/web/imgs/");
            credentialsGrid.setHeader("#,User Details,username,Loginkey,Profile,Status");
            credentialsGrid.setColAlign("left,left,left,left,left,center");
            credentialsGrid.setInitWidthsP("5,*,20,20,15,15,10");
            credentialsGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#combo_filter,#combo_filter");
            credentialsGrid.setColumnColor(",#d5f1ff,,,,");
            credentialsGrid.setColTypes("ro,ro,ro,ro,ro,ro");
            credentialsGrid.setColSorting(",str,str,int,str,str");
            credentialsGrid.enableMultiselect(false);
            credentialsGrid.init();

            var credentialsForm=createCredentialsform(credentialsLayout,credentialsGrid,-1,credentialsToolbar);

            //window.dhx4.skin = "dhx_terrace";

            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            
           /* credentialsGrid.attachEvent("onFilterStart", function(indexes,values){
               //any custom logic
              // alert(values);
        });*/
            
            credentialsToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            credentialsToolbar.attachEvent("onClick", function (itemId) {
                credentialsToolbarOnclick(itemId, credentialsLayout, credentialsGrid);
            });
            credentialsGrid.attachEvent("onXLS", function () {
                credentialsLayout.cells("a").progressOn();
            });
            credentialsGrid.load('viewmodel/grid/com/com/sec/credentials.jsp', 'json');
            credentialsGrid.attachEvent("onXLE", function () {
                credentialsLayout.cells("a").progressOff();
             });
          
            rId = -1;
            credentialsGrid.attachEvent("onRowSelect", function (rId, cInd) {
                credentialsGridOnselect(rId, credentialsGrid, credentialsLayout,credentialsToolbar);
            
            });

            function credentialsGridOnselect(rId, credentialsGrid, credentialsLayout,credentialsToolbar) {
                credentialsLayout.cells("b").progressOn();
                credentialsLayout.cells("b").detachObject();    
                var credentialsForm=createCredentialsform(credentialsLayout,credentialsGrid,rId,credentialsToolbar);

            }


            function createCredentialsform(credentialsLayout,credentialsGrid,rId,credentialsToolbar) {
              
                var credentialsForm = credentialsLayout.cells("b").attachForm();
                setRights("credentials", credentialsForm,credentialsToolbar)
               // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                credentialsLayout.cells("b").progressOn();
                credentialsForm.loadStruct("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId, function () {
                    credentialsLayout.cells("b").progressOff();
                });
                credentialsForm.enableLiveValidation(true);
                credentialsForm.attachEvent("onButtonClick", function (id) {
                credentialsFormOnclick(id, credentialsForm, credentialsGrid,credentialsLayout);
            });

                return credentialsForm;
            }


        </script>


        <div id="comcomcredentials"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

        </div>
    </body>
</html