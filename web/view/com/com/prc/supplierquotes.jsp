<%-- 
    Document   : supplierquotes
    Created on : Dec 4, 2015, 12:39:47 PM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Vortexstring|Supplier Quotes</title></head>
    <body>
        <script>
            /* A **************************LAYOUT MANIPULATIONS***********************/
        // 1.Creation of Layouts
var supplierquotesLayout = new dhtmlXLayoutObject({
                parent: "comcomprcsupplierquotes",
                pattern: "1C",
                skin: "dhx_web",
                cells: [{id: "a", text: ""}]
            });
        //1.Setting Layouts properties
            supplierquotesLayout.cells("a").hideHeader();

            /**********************END LAYOUT MANIPULATIONS**************************/
            /* B *******************ATTACHING THE OBJECTS TO THE LAYOUTS**************/


            var supplierquotesToolbar = supplierquotesLayout.cells("a").attachToolbar({
                icons_path: "./icons/toolbar/icons_terrace/",
                xml: "./viewmodel/toolbar/com/com/all/basic.jsp",
                skin: "dhx_terrace"
            });
            var supplierquotesGrid = supplierquotesLayout.cells("a").attachGrid("dhx_web");
            /***************************END ATTACHING THE OBJECTS TO THE LAYOUTS************/

            /* C ***********SETTING OBJECTS PROPERTIES***********************************/

            supplierquotesGrid.setImagePath("config/mcsk_skin/imgs/");
            supplierquotesGrid.setColTypes("ro,ro,ro,ro,ro,ro");
            supplierquotesGrid.setHeader("#,Code,Product Name,Category,Class,Quotes count");
            supplierquotesGrid.setColAlign("left,left,left,left,left,left");
            supplierquotesGrid.setInitWidthsP("5,8,*,25,12,10");
            supplierquotesGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#combo_filter,#text_filter");
            supplierquotesGrid.setColSorting("int,str,str,str,str,str");
            supplierquotesGrid.init();


            /****************END OF SETTING OBJECT PROPERTIES************/


            /* D *************************OBJECTS EVENTS***********************************/

            var loadPath ="out/grid/mfc/com/supplierquotes.php";
            supplierquotesToolbar.attachEvent("onXLE", function () { window.lastvisit = 'new';       });
            supplierquotesToolbar.attachEvent("onClick", function (itemId) { supplierquotesToolbarOnclick(itemId, supplierquotesGrid);   });
           // supplierquotesGrid.attachEvent("onXLS", function () {  supplierquotesLayout.cells("a").progressOn();    });
            supplierquotesGrid.load(loadPath, "json");
            supplierquotesGrid.attachEvent("onXLE", function () {   supplierquotesLayout.cells("a").progressOff();       });
            supplierquotesGrid.attachEvent("onRowSelect", function (rId, cInd) { var supplierQuoteskey=rId;
              supplierquotesGridOnselect(supplierquotesGrid, rId,loadPath);     });
           
         /**************************END OF OBJECTS EVENTS********************************/
            function suppliersquotescreateWindow(rId, pname, mygrid,loadPath) {
                var productkey=rId;
                var win = dhxWins.createWindow("supplierquotes" + rId, 50, 5, 1300, 600);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                    mygrid.clearAll();
                    mygrid.load(loadPath, 'json');
                 
                });
                win.setText("<b>" + pname + "</b>");
                var supplierquoteslineLayout = win.attachLayout({
                    pattern: "2U",
                    cells: [
                        {id: "a", text: "FORM", header: false, width: 400},
                        {id: "b", text: "GRID", header: false},
                    ]
                });

                /**************************ATTACHING THE FORM URL******************************/
                supplierquoteslineLayout.cells("a").attachURL("./in/forms/mfc/com/supplierquotes.php", null, {key: rId});
              
    
        var supplierquoteslineToolbar = supplierquoteslineLayout.cells("b").attachToolbar({
                    icons_path: "./icons/all/",
                    xml: "out/toolbars/mfc/com/supplierquoteline_toolbar.php",
                    skin: "dhx_terrace"
                });

                var supplierquoteslineGrid = supplierquoteslineLayout.cells("b").attachGrid();
                window.xp=supplierquoteslineGrid;
                supplierquoteslineGrid.setColTypes("ro,ro,ro,ro,ro,ro");
                supplierquoteslineGrid.setHeader("#,Supplier Name,Price,units,vat rate,Range,Date");
                supplierquoteslineGrid.setColAlign("left,left,left,left,left,left,left");
                supplierquoteslineGrid.setInitWidthsP("5,*,8,18,10,10,15");
                supplierquoteslineGrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter");
                supplierquoteslineGrid.setColSorting("int,str,str,str,str,str,str");
                supplierquoteslineGrid.init();
                
                 var lineLoadPath="out/grid/mfc/com/supplierquotesline.php?productkey="+rId;
                supplierquoteslineToolbar.attachEvent("onXLE", function () {   window.lastvisit = 'new';             });
                supplierquoteslineToolbar.attachEvent("onClick", function (itemId) {  supplierquoteslineToolbarOnclick(itemId, lineLoadPath,rId,supplierquoteslineGrid);  });
                supplierquoteslineGrid.attachEvent("onXLS", function () {  supplierquoteslineLayout.cells("b").progressOn();    });
                supplierquoteslineGrid.load(lineLoadPath, 'json');
                supplierquoteslineGrid.attachEvent("onXLE", function () {supplierquoteslineLayout.cells("b").progressOff();     });
                supplierquoteslineGrid.attachEvent("onRowSelect", function (rId, cInd) { 
                   var supplierQuotelinekey=rId;
                      
                      
                        supplierquoteslineGridOnselect(supplierQuotelinekey,productkey);  
                       });
              }
            
            function supplierquoteslinecreatelineWindow(supplierQuotelinekey, pname,productkey) {
                var win = dhxWins.createWindow("supplierquotesline" + supplierQuotelinekey, 300, 5, 700, 450);
                win.attachEvent("onClose", function (win) {
                    win.hide();
                   // mygrid.clearAll();
                    //mygrid.load('out/grid/mfc/com/supplierquotesline.php', 'json');
                });
                win.setText("<b>" + pname + "</b>");
                var supplierquoteslineLayout = win.attachLayout({
                    pattern: "1C",
                    cells: [
                        {id: "a", text: "Views", header: false, height: 300},
                    ]
                });
            loadWindowdata(supplierquoteslineLayout,supplierQuotelinekey,productkey);
	
}


function loadWindowdata(supplierquoteslineLayout,supplierQuotelinekey,productkey){
	
       
	supplierquoteslineLayout.cells("a").attachURL("in/forms/mfc/com/supplierquotesline.php", null, {key: supplierQuotelinekey,productkey:productkey});

	
}
        </script>
                <div id="comcomprcsupplierquotes"  style="position:absolute; top:0px;  bottom:10px; left:5px; right:15px; width:99%; height:100%; aborder: #B5CDE4 1px solid;">

    </body>
</html>
