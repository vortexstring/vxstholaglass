<%-- 
    Document   : home
    Created on : May 2, 2015, 9:38:01 PM
    Author     : JFX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="./controller/mainController.jsp" %>

<!DOCTYPE html>

<html>
    <head>
        <title>Vortexstring|ERP</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" type="text/css" href="./codebase/skins/skyblue/dhtmlx.css"/>
        <link rel="stylesheet" type="text/css" href="./codebase/skins/terrace/dhtmlx.css"/>
        <link rel="stylesheet" type="text/css" href="./codebase/skins/web/dhtmlx.css"/>
        <script src='./codebase/dhtmlxgrid.js'></script>
	<script src='./codebase/dhtmlxgridcell.js'></script>
	<script src='./codebase/dhtmlxgrid_export.js'></script>
        <script src="./codebase/dhtmlx.js"></script>
         <script src="./controller/clock.js"></script>


        <style>
            div#layoutObj {
                position: relative;
                margin-top: 20px;
                margin-left: 20px;
                width:auto;
                height:500px;
            }
        </style>

        <style type="text/css">
            .dhtmlx-fail{
                font-weight:bold !important;
                color:white !important;
                background-color:red !important;
            }

        </style>



        <style type="text/css">
            .dhtmlx-success{
                font-weight:bold !important;
                color:black !important;
                background-color:lightgreen;
            }

        </style>


        <script>



            function doOnLoad() {


                function GetXmlHttpObject()
                {
                    if (window.XMLHttpRequest)
                    {
                        return new XMLHttpRequest();
                    }
                    if (window.ActiveXObject)
                    {
                        return new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    return null;
                }//END  OF AJAX


                var myLayout = new dhtmlXLayoutObject({
                    parent: "main",
                    pattern: "3T",
                    skin: "dhx_terrace",
                    cells: [{id: "a", text: "<b> HIDDEN MAIN MENU</b>"}]
                });

                dhxWins = new dhtmlXWindows();
                dhxWins.setSkin("dhx_web");
                dhxWins.attachViewportTo("main");


                myLayout.cells("a").setHeight(60);
                myLayout.cells("b").setWidth(250);
                myLayout.cells("a").hideHeader();
                myLayout.cells("b").hideHeader();
                myLayout.cells("c").hideHeader();
                myLayout.cells("a").fixSize(true, true);
                myLayout.cells("b").fixSize(true, true);
                myLayout.cells("c").fixSize(true, true);


                var myToolbar = myLayout.cells("a").attachToolbar({
                    icons_path: "./icons/toolbar/icons_web/",
                    json: "./viewmodel/toolbar/com/com/all/menu.jsp"

                });




                var dhxTabbar1 = myLayout.cells("c").attachTabbar();
                dhxTabbar1.setSkin("dhx_terrace");
               events(dhxTabbar1);
                var caption = 'HOME';
                var id = caption;
                dhxTabbar1.addTab(id, caption, ((caption.length * 5) + 70), null, true, false);
                var dhxLayout = dhxTabbar1.tabs(id).attachLayout("1C");
                //dhxLayout.cells("a").hideHeader();
                dhxLayout.cells("a").setText("<b> FORTNIGHT PROFITS SUMMARY (JULY)</b>");
                dhxLayout.cells("a").setWidth('230');
                //ATTAHING A GRID TO THE DHTMLX CODE

                myToolbar.attachEvent("onXLE", function () {
                    var myLayout;
                    var myPop = new dhtmlXPopup({toolbar: myToolbar, id: "open"});
                    var layoutLoaded = "no";
                    myPop.show();

                    myPop.attachEvent("onShow", function () {

                        if (layoutLoaded == "no") {
                            var myLayout = myPop.attachLayout(1350, 120, "1C");
                            var myRibbon = myLayout.cells("a").attachRibbon({
                                icons_path: "./icons/ribbon/",
                                json: "./viewmodel/ribbon/com/com/sec/menu.jsp",
                                skin: "dhx_terrace"
                            });
                            myLayout.cells("a").progressOn();
                            myRibbon.attachEvent("onClick", function (id) {
                                
                              //  alert(id);
                                tbevent(id, myRibbon,dhxTabbar1,myPop);
                            });

                            //   myRibbon.attachEvent("onXLS", function () {  alert("Started");  }); 
                            myRibbon.attachEvent("onXLE", function () {
                                myLayout.cells("a").progressOff();
                                layoutLoaded = "yes";
                            });




                            myLayout.cells("a").hideHeader();
                        } else { //  alert("Exists") 
                 
                            layoutLoaded = "yes";
                        }

                    });

                });


                myToolbar.setIconSize(32);
                myToolbar.setSkin("dhx_web");


                var dhxAccord = myLayout.cells("b").attachAccordion();
                dhxAccord.setSkin("dhx_web");


                dhxAccord.addItem("1", "<b>Notifications</b>");
                dhxAccord.addItem("2", "<b>Quick Links</b>");
                dhxAccord.addItem("3", "<b>Widgets</b>");
                dhxAccord.cells("1").open();






                /*****************************ATTACHING BAR CHART**************************************/
                var multiple_dataset = [
                    {sales: "2000", sales2: "3500", sales3: "5500", year: "Mon 14"},
                    {sales: "4000", sales2: "2400", sales3: "4000", year: "Tue 15"},
                    {sales: "4004", sales2: "2000", sales3: "2700", year: "Wed 16"},
                    {sales: "2300", sales2: "5000", sales3: "430", year: "Thur 17"},
                    {sales: "2100", sales2: "3600", sales3: "301", year: "Fri 18"},
                    {sales: "5000", sales2: "40", sales3: "560", year: "Mon 21"},
                    {sales: "3000", sales2: "65", sales3: "7500", year: "Tue 22"},
                    {sales: "9000", sales2: "62", sales3: "5500", year: "Wed 23"},
                    {sales: "5500", sales2: "40", sales3: "6000", year: "Thur 24"},
                    {sales: "7200", sales2: "45", sales3: "540", year: "Fri 25"}
                ];

                /***************BAR CHART***********************************************************/



                var invoicesfollowup = {
                    view: "bar",
                    value: "#sales#",
                    //color:"#66cc33",
                    width: 30,
                    tooltip: "#year#",
                    xAxis: {
                        title: "Date.",
                        template: "#year#"
                    },
                    yAxis: {
                        start: 0,
                        end: 10000,
                        step: 1000,
                        template: "{obj}",
                        title: "Amount"
                    }
                };

                Chart2 = dhxLayout.cells("a").attachChart(invoicesfollowup);
                Chart2.parse(multiple_dataset, "json");
             // dhxTabbar1.enableTabCloseButton(true);
                //dhxTabbar1.setImagePath("./config/tab/imgs/");
                // dhxTabbar1.setHrefMode("ajax-html");

            }
        </script>
    </head>

    <body onload="doOnLoad();">

        <div id="main"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

        </div>

    </body>
</html>
