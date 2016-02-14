<%-- 
    Document   : customers
    Created on : Jun 15, 2015, 10:54:52 AM
    Author     : JFX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/sec/userscontroller.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Untitled Document</title>

    </head>
    <body>

        <script>


            var usersLayout = new dhtmlXLayoutObject({
                parent: "comcomusers",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });


            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts


            //1.Setting  Layouts properties
            usersLayout.cells("a").setText("<b><u>SUBJECTS</b></u>");
            usersLayout.cells("a").hideArrow();
            usersLayout.cells("a").hideHeader();
            usersLayout.cells("b").hideArrow();
            usersLayout.cells("b").setWidth('*');
            usersLayout.cells("b").hideHeader();
            usersLayout.cells("b").setWidth(450);

            /**********************END LAYOUT MANIPULATIONS**************************/


            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var usersToolbar = usersLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });

            var usersGrid = usersLayout.cells("a").attachGrid("dhx_web");
          //  var usersForm = usersLayout.cells("b").attachForm();
           // usersForm.loadStruct("./viewmodel/form/com/com/sec/users.jsp", function () {
           // });
           // usersForm.enableLiveValidation(true);
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/


            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            usersGrid.setImagePath("./codebase/skins/web/imgs/");
            usersGrid.setHeader("#,Other Name,surname,Profile,Active");
            usersGrid.setColAlign("left,left,left,left,left");
            usersGrid.setInitWidthsP("5,20,25,25,25,10");
            usersGrid.attachHeader(",#text_filter,#text_filter,#combo_filter,#combo_filter");
            usersGrid.setColumnColor("white,#d5f1ff,white,white");
            usersGrid.setColTypes("ro,ro,ro,ro,ro");
            usersGrid.setColSorting(",str,str,str,str");
            usersGrid.enableMultiselect(false);
            usersGrid.init();
            var usersForm=createUsersform(usersLayout,usersGrid,-1,usersToolbar);


            //usersForm.load('out/form/com/com/users.php?id=-1');

            //window.dhx4.skin = "dhx_terrace";

            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/
            usersToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            usersToolbar.attachEvent("onClick", function (itemId) {
                usersToolbarOnclick(itemId, usersLayout, usersGrid);
            });
            usersGrid.attachEvent("onXLS", function () {
                usersLayout.cells("a").progressOn();
            });
            usersGrid.load('viewmodel/grid/com/com/sec/users.jsp', 'json');
            usersGrid.attachEvent("onXLE", function () {
                usersLayout.cells("a").progressOff();
            });
            rId = -1;
            usersGrid.attachEvent("onRowSelect", function (rId, cInd) {
                usersGridOnselect(rId, usersGrid, usersLayout,usersToolbar);
            
            });

            function usersGridOnselect(rId, usersGrid, usersLayout,usersToolbar) {
                usersLayout.cells("b").progressOn();
                usersLayout.cells("b").detachObject();    
                var usersForm=createUsersform(usersLayout,usersGrid,rId,usersToolbar);

            }

    function createUsersform(usersLayout,usersGrid,rId,usersToolbar) {
              
                var usersForm = usersLayout.cells("b").attachForm();
                setRights("users", usersForm,usersToolbar)
               // alert("./viewmodel/form/com/com/sec/credentials.jsp?id="+rId);
                usersLayout.cells("b").progressOn();
                usersForm.loadStruct("./viewmodel/form/com/com/sec/users.jsp?id="+rId, function () {
                    usersLayout.cells("b").progressOff();
                });
                usersForm.enableLiveValidation(true);
                usersForm.attachEvent("onButtonClick", function (id) {
                usersFormOnclick(id, usersForm, usersGrid,usersLayout);
            });

                return usersForm;
            }


        </script>


        <div id="comcomusers"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>