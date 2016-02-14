<%-- 
    Document   : customers
    Created on : Jun 15, 2015, 10:54:52 AM
    Author     : JFX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../view/helper.jsp" %>
<%@include  file="../../../../viewcontroller/com/com/sec/profilescontroller.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Profiles</title>

    </head>
    <body>

        <script>
            var profilesLayout = new dhtmlXLayoutObject({
                parent: "comcomprofiles",
                pattern: "2U",
                skin: "dhx_web",
                cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
            });



            /* A **************************LAYOUT MANIPULATIONS***********************/
            // 1.Creation of Layouts


            //1.Setting  Layouts properties

            profilesLayout.cells("a").setWidth('270');
            profilesLayout.cells("a").setText("<b><u>USER PROFILES</b></u>");
            profilesLayout.cells("a").hideArrow();
            profilesLayout.cells("b").setWidth('*');
            profilesLayout.cells("b").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/



            /* B **************************ATTACHING THE OBJECTS TO THE LAYOUTS************/


            var profilesToolbar = profilesLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/sec/profmain.jsp",
                skin: "dhx_terrace"

            });


            rightsAssignGrid = profilesLayout.cells("b").attachGrid("dhx_web");


            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            var profilesGrid = profilesLayout.cells("a").attachGrid("dhx_web");
            profilesGrid.setImagePath("./codebase/skins/web/imgs/");
            profilesGrid.setHeader("PROFILE");
            profilesGrid.setColAlign("left");
            profilesGrid.setInitWidths("*");
            profilesGrid.attachHeader("#text_filter");
            profilesGrid.setColTypes("ro");
            profilesGrid.setColSorting("str");

            profilesGrid.load("viewmodel/grid/com/com/sec/profiles_main.jsp", "json");
            profilesGrid.init();
          /* profilesGrid.attachEvent("onRightClick", function(id,ind,obj){
                        alert(obj)  ;
                profilesGridOnRightClick(profilesGrid, id);

           });
  
             
             function profilesGridOnRightClick(profilesGrid, id, loadPath) {
             var pname = profilesGrid.cells(id, 1).getValue();
             profilescreateWindow(id, pname, profilesGrid, loadPath);
             
             }
             */
             
            /*
             profilesGrid.attachEvent("onRowSelect", function (rId, cInd) {
             profilesGridOnselect(profilesGrid, rId);
             });
             */

            function  profilescreateWindow(rId, pname, profilesGrid) {

                var win = dhxWins.createWindow("Profiles " + rId, 600, 200, 350, 270);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    profilesGrid.clearAll();
                    profilesGrid.load("viewmodel/grid/com/com/sec/profiles_main.jsp", 'json');

                });
                win.setText("<b>" + pname + "</b>");

                var profilesFormLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false, height: 300},
                    ]
                });

                var profilesForm = createProfilesform(profilesFormLayout, profilesGrid, rId);

            }

            function createProfilesform(profilesFormLayout, profilesGrid, rId) {

                var profilesForm = profilesFormLayout.cells("a").attachForm();


                profilesFormLayout.cells("a").progressOn();
                profilesForm.loadStruct("./viewmodel/form/com/com/sec/profiles.jsp?id=" + rId, function () {
                    profilesFormLayout.cells("a").progressOff();
                });
                profilesForm.enableLiveValidation(true);
                profilesForm.attachEvent("onButtonClick", function (id) {

                    dhtmlx.message({
                        text: "Saving method called",
                        expire: 2000
                    });
                    profilesFormOnclick(id, profilesForm, profilesGrid, profilesFormLayout);
                });

                return profilesForm;
            }

            rightsAssignGrid.setImagePath("./codebase/skins/hybrid/imgs/");
            rightsAssignGrid.setHeader("MODULE,ITEM,View,Add,Edit,Delete,Export,Authorize,Approve");
            rightsAssignGrid.setColAlign("left,left,left,left,left,left,left,left,left");
            rightsAssignGrid.setInitWidthsP("25,*,7,7,7,7,7,7,7");
            rightsAssignGrid.attachHeader("#combo_filter,#text_filter,,,,,,,");
            rightsAssignGrid.setColTypes("ro,ro,ch,ch,ch,ch,ch,ch,ch");
            rightsAssignGrid.setColSorting("str,str,int,int,int,int,int,int,int");
            rightsAssignGrid.init();

            /***************END OF OBJECT PROPERTIES**************************************/

            /* D *************************OBJECTS EVENTS***********************************/

            profilesToolbar.attachEvent("onXLE", function () {
                window.lastvisit = 'new';
            });
            profilesToolbar.attachEvent("onClick", function (itemId) {
                profilesToolbarOnclick(itemId, profilesLayout, profilesGrid);
            });
            profilesGrid.attachEvent("onRowSelect", function (id, ind) {
                //      profilescreateWindow(rId, pname, profilesGrid, loadPath);
                // profilesGridOnselect(profilesGrid, id);

                rightsAssignGrid.clearAll();
                window.activeID = id;
                rightsAssignGrid.attachEvent("onXLS", function () {
                    profilesLayout.cells("b").progressOn();
                });
                rightsAssignGrid.load('viewmodel/grid/com/com/sec/profiles_rights.jsp', 'json');
                rightsAssignGrid.attachEvent("onXLE", function () {
                    profilesLayout.cells("b").progressOff();
                });
                //alert('viewmodel/grid/com/com/sec/profiles_rights.jsp?id=' + id);
            });
           

            rightsAssignGrid.attachEvent("onCheck", function (rId, cInd, state) {
                var val;
                if (state == true) {
                    val = 1;
                } else {
                    val = 0;
                }
                id = window.activeID;
                rightsAssignGrid.load("viewmodel/grid/com/com/sec/profiles_rights_update.jsp?id=" + id + "&cid=" + cInd + "&val=" + val + "&rid=" + rId);
                alert("viewmodel/grid/com/com/sec/profiles_rights_update.jsp?id=" + id + "&cid=" + cInd + "&val=" + val + "&rid=" + rId);
            });



            /***********************EVENT HANDLERS IMPLEMETATION******************/


        </script>


        <div id="comcomprofiles"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>