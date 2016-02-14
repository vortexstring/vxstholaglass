<script>
    /**********************UPDATING AN ITEM RIGHTS***********************/
    function setRights(item, myForm, myToolbar) {


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


        var myAjaxPostrequest = new GetXmlHttpObject();
        var parameters = "id=" + item;

        myAjaxPostrequest.open("POST", "services/getdata/rights.jsp", true);
        myAjaxPostrequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        myAjaxPostrequest.send(parameters);
        myAjaxPostrequest.onreadystatechange = function () {
            if (myAjaxPostrequest.readyState == 4) {
                if (myAjaxPostrequest.status == 200) {

                    var rsp = myAjaxPostrequest.responseText;


                    setTimeout(function () {
                        var authobj = JSON.parse(rsp);

                        if (authobj['canadd'] == true) {
                            myToolbar.enableItem("new");

                        } else {
                            myToolbar.disableItem("new");
                        }


                        if (authobj['canedit'] == true) {
                            //  myForm.enableItem('save');
                        } else {
                            //  myForm.disableItem('save');
                        }
                        if (authobj['candel'] == true) {
                            myForm.enableItem('delete');
                        } else {
                            myForm.disableItem('delete');
                        }
                    }, 50);
                }
            }
        }

    }


    /**************************SAVER OF THE DATA***************************************/

    function tabsaver(param, path, Item, parentGrid, toHighlightrow, winLayout, rId, myForm, activetab) {


        alert(Item + "--" + param);
        myForm.send(path, "POST", function (loader, response) {

            var respobj = JSON.parse(response);
            var msgtype = respobj['msgtype'];
            var msgtext = respobj['msg'];
            var actiontype = respobj['type'];
            var recordId = respobj['recId'];
            // var info=respobj['info'];
            //    alert(execsql);
            msgtext = Item + " " + msgtext;

            dhtmlx.message({
                text: msgtext,
                expire: 2000,
                type: msgtype
            });

            if (msgtype == 'success') {
                setTimeout(function () {
                    loadme()
                }, 100);
                function loadme() {
                    winLayout.cells("a").detachObject(true);
                    winLayout.cells("b").detachObject(true);
                    loadWindowdata(winLayout, rId, activetab);

                }




            }
            //IF DELETION WAS SUCCESSFUL REMOVE THE ROW.
            if (actiontype == -5 && msgtype == 'success') {
                parentGrid.deleteRow(recordId);
            }
            //AFTER SAVING IS COMPLETE UPDATE ALL THE NECCESSARY FIELDS
            //sethighsccomproductssubjectsSync();
            //setcomcomtownTownsSync();
            //alert(toHighlightrow);
            setTimeout(function () {
                highlight()
            }, 100);
            function highlight() {
                if (toHighlightrow == true) {
                    parentGrid.setRowTextStyle(respobj['recId'], "background-color:lightgreen; font-family: arial; font-weight:bold;");
                }
            }

        });



    }//END SAVER FUNCTION


    /************************UPDATING THE GRID******************************************/


    function updategrid(d, Grid) {

        var rowno = d[0]['rno'];




        for (i = 0; i < rowno; i++) {
            Grid.addRow(d[i]['id'], +d[i]['count'] + ',' + d[i]['col0'] + ',' + d[i]['col1'] + ',' + d[i]['col2'], 1);
         
//for(i=0;i<rowno; i++){
            Grid.selectRow(i, false, true, false);
//}


        }


    }



    /************EVENTS************/

    function sideMenuStatelist(id, value) {
        switch (id) {
            case 'fullscreen':
                if (value == true) { //window.fullscreen(); 
                }
                break;
            case 'hideribbon':
                if (value == true) {
                    myLayout.cells("a").collapse();
                } else {
                    myLayout.cells("a").expand();
                }
                break;
            default:
                break;

        }

    }



    function sideMenulist(id) {

        var capt = id.split("|");
        myid = capt[0];
        if (myid == "logout") {
            window.location = "./config/logout.php";
        } else {

        }

    }


    function notifRibbonevent(id) {

        switch (id) {
            case 'companydetails':

                var win = dhxWins.createWindow("companydetails", 300, 30, 800, 550);
                win.setText("Company Details");
                win.attachURL("itf/com/com/company.php", true, true);

                break;
            default:
                break;

        }


    }




   

    /****************A FUNCTION THAT ACTS AS EVENT LISTENER FOR THE MAIN TREE AND THE MAIN RIBBON**************/
    function tbevent(id, myRibbon, dhxTabbar1, myPop) {
        var originalid = id;
        myPop.hide();
        // alert(id);		
        switch (id) {
            case 'highsc/com/graphs|Graphical  Reports':
                break;
            case 'highsc/com/reports|Prepared  Reports':
                var myPop = new dhtmlXPopup({ribbon: myRibbon, id: "highsc/com/reports|Prepared  Reports"});
                //myPop = new dhtmlXPopup({ toolbar: myToolbar, id: "workbut" });
                myPop.attachEvent("onShow", function () {
                    // grid cosmetic fix
                    //myGrid.setSizes();
                    //myGrid.setSizes();
                    //myPop.detachEvent(eId);


                    myGrid = myPop.attachGrid(200, 300);
                    myGrid.setImagePath("./codebase/imgs/dhxgrid_web/");
                    myGrid.setHeader("Icon,Report Item");
                    myGrid.setColAlign("left,left");
                    myGrid.setInitWidths("60,*");
                    myGrid.init();
                    myGrid.loadXML("./out/menu/setuplist.php?id=" + id);
                    myGrid.attachEvent("onRowDblClicked", function () {
                        myPop.hide();
                    });

                });


                break;
            default:
                var p = -1;
                // alert(id);
                var capt = id.split("|");
                caption = capt[1];
                //SEARCH FROM THE TABS THAT ARE PRINTED WHETHER THE CLICKED TAB EXISTS 
                var mytabs = dhxTabbar1.getAllTabs();
                var tcount = 0;
                for (var i = 0; i < mytabs.length; i++)
                {
                    var str = mytabs[i];
                    if (str == id) {
                        tcount++;
                    }
                }
                if (tcount > 0) {
                    dhxTabbar1.tabs(id).setActive();
                } else
                {
                    dhxTabbar1.addTab(id, caption, ((caption.length * 5) + 70), null, true, true);
                    var myid = "";
                    myid = capt[0];
                   var objectid = myid.split("/");
                  
                    myid = (myid.toLowerCase()).replace(/\s|/g, '');
                    //alert("./itf/"+myid+".php?id="+id);
                    dhxTabbar1.tabs(id).attachURL("./view/" + myid + ".jsp?id=" + id, true); //AJAX LOADING MODE TRUE
                    getValidationRules(objectid[3]);
    
    
                    }

                break;
        }


    }


    /*******************************A FUNCTION THAT UPDATES THE GRID DATA WHEN THE DATASTRING IS PASSED**********/

    function updategrid(jsontext, catGrid) {

        //GET THE VALUE OF THE FILTERS

        var filterelem = Array();
        var colNum = catGrid.getColumnsNum();
        for (x = 0; x < colNum; x++) {
            filterelem[x] = catGrid.getFilterElement(x);
        }

        //GET THE SELECTED ROW
        var selectedRowId = catGrid.getSelectedRowId();

        var udata = Array();
        var rowsExistarray = Array();
        udata = JSON.parse(jsontext);
        var count = udata[0]['rno'];


        for (i = 0; i < count; i++) {

            catGrid.deleteRow(udata[i]['id']);
            catGrid.addRow(udata[i]['id'], udata[i]['row']);
            rowsExistarray[i] = udata[i]['id'];
        }

        //REMOVE THE DELETED ROWS
        removeDeletedrows(catGrid, rowsExistarray);

        //SET THE FILTERS
        var colNum = catGrid.getColumnsNum();
        for (n = 0; n < colNum; n++) {
            catGrid.filterBy(n, filterelem[n], true);

        }

        //SELECT THE PREVIOUSLY SELECTED ROW
        catGrid.selectRowById(selectedRowId, false, false, true);

    }



    function removeDeletedrows(Grid, rowsExistarray) {

        Grid.forEachRow(function (id) {
            var idIndex = rowsExistarray.indexOf(id);
            if (idIndex == -1) {
                Grid.deleteRow(id);
            }
        });
    }




    function loadFiltercombos(combos, pageid, combovalues) {
        path = './out/combo/gridfilterCombo.php';

        for (i = 0; i < combos.length; i++) {
            var comboid = combos[i];
            html = "";
            /* obj = {
             "1" : "Name",
             "2": "Age",
             "3" : "Gender"
             }*/

            param = 'id=' + pageid + '&col=' + combos[i] + '&combovals=' + combovalues[i];
            // alert(param);

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


            var myAjaxPostrequest = new GetXmlHttpObject();
            myAjaxPostrequest.open("POST", path, true);
            myAjaxPostrequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            myAjaxPostrequest.send(param);
            myAjaxPostrequest.onreadystatechange = function () {
                if (myAjaxPostrequest.readyState == 4) {
                    //alert(myAjaxPostrequest.status);
                    if (myAjaxPostrequest.status == 200) {

                        //READ THE RESPONSE INFORMATION
                        var resp = myAjaxPostrequest.responseText;
                        //alert('The Response is:'+resp);
                        var obj = JSON.parse(resp);

                        for (var key in obj) {

                            html += "<option value=" + key + ">" + obj[key] + "</option>"
                        }
                        document.getElementById(comboid).innerHTML = html;

                    }
                }
            }

        }
    }



    /**************************SAVER OF THE DATA***************************************/

    function winsaver(param, path, Item, parentGrid, toHighlightrow) {




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


        var myAjaxPostrequest = new GetXmlHttpObject();
        myAjaxPostrequest.open("POST", path, true);
        myAjaxPostrequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        myAjaxPostrequest.send(param);
        myAjaxPostrequest.onreadystatechange = function () {
            if (myAjaxPostrequest.readyState == 4) {

                if (myAjaxPostrequest.status == 200) {
                    //READ THE RESPONSE INFORMATION
                    var resp = myAjaxPostrequest.responseText;
   
                    
                    var respobj = JSON.parse(resp);
                    var msgtype = respobj['msgtype'];
                    var msgtext = respobj['msg'];
                    var actiontype = respobj['actiontype'];
                    var recordId = respobj['recId'];
                    var gridData = respobj['gridData'];

                    msgtext = Item + " " + msgtext;

                 
                    if (msgtype == "fail") {
                        dhtmlx.alert({
                            type: "alert-error",
                            text: msgtext,
                            title: "Saving Error!",
                            ok: "Ok"
                        });
                    } else {
                        dhtmlx.message({
                            text: msgtext,
                            expire: 8000,
                            type: msgtype
                        });
                    }
                    //IF DELETION WAS SUCCESSFUL REMOVE THE ROW.
                    if (actiontype == 'd' && msgtype == 'success') {
                        parentGrid.deleteRow(recordId);
                        reNumberGrid(parentGrid);
                    }

                    if (actiontype == "c") {  //IF YOU WERE INSERTING A NEW RECORD               
                        parentGrid.addRow(recordId, gridData, 0);
                        setTimeout(function () {
                            highlight(recordId)
                        }, 100);
                        reNumberGrid(parentGrid);
                    } else if (actiontype == "u") {  //IF YOU ARE UPDATING A PARTICULAR RECORD

                        var rowIndex = parentGrid.getRowIndex(recordId);
                        parentGrid.deleteRow(recordId);
                        parentGrid.addRow(recordId, gridData, rowIndex);
                        setTimeout(function () {
                            highlight(recordId)
                        }, 100);
                        reNumberGrid(parentGrid);
                    }



                    //FUNCTION TO HIGHLIGHT THE AFFECTED ROW
                    function highlight(recordId) {
                        if (toHighlightrow == true) {
                            parentGrid.setRowTextStyle(recordId, "background-color:lightgreen; font-family: arial; font-weight:bold;");
                        }
                    }
                } else {
                    validatestatus(myAjaxPostrequest.status);
                }
            }
        }





    }//END SAVER FUNCTION




    function validatestatus(status) {

        dhtmlx.alert({
            title: "Saving Failed",
            type: "alert-error",
            text: "Saving failed with error code  : <b>" + status + "</b>"
        });


    }

    function reNumberGrid(parentGrid) {
        var i = 0;
        var j;
          
        var rcount = parentGrid.getRowsNum();
     
        parentGrid.forEachRow(function (id) {
            j = rcount - (rcount - i);
          var n=j+1;
          var rowID=parentGrid.getRowId(j);
            parentGrid.cells(rowID, 0).setValue(n);
            i++;
        });

    }


    function customValidationMessage(caption, value,name) {
        
        
   
                  setTimeout(function () {
                      var validateobj = JSON.parse(window.validationobj);
                      var inputobj=validateobj[name];
                      var msg;
                      var msg2="";
                    var head="";
                    var tail="";
                    msg ="["+caption+" validation failure] ";
                    if(value.length<inputobj["minlength"] || value.length>inputobj["maxlength"]){
                       msg =msg+ inputobj["lengthmessage"];
    
                    }
                    
                    if(inputobj["isemail"]=="true"){
                        
                       msg2=msg2+" ,Valid email ";
                    }
                    
                    if(inputobj["isalphanumeric"]=="true"){
                        
                       msg2=msg2+" ,Both numbers and alphabets  ";
                    }
                    
                      if(inputobj["isnumeric"]=="true"){
                        
                       msg2=msg2+" ,Numbers only  ";
                    }
                    
                   if(inputobj["isinteger"]=="true"){
                        
                       msg2=msg2+" ,Whole Numbers only  ";
                    }
                    
                    if(msg2!=""){ tail=" ,Please provide "+msg2;}else{ tail="";}
                    
                    if(msg!=""){ head=msg;}else{ head="";}
                    var fullmsg=head+" "+tail;
  
                    dhtmlx.message({
                         text: fullmsg,
                         expire: 10000,
                         type: "fail"
                     });

                   
                    
                    }, 50);  
   
     
    }



     
        
     function getValidationRules(objectid){             
                    
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


        var myAjaxPostrequest = new GetXmlHttpObject();
      var parameters ="id="+objectid;
      //  var parameters ="id=nani";
        myAjaxPostrequest.open("POST", "services/getdata/validator.jsp", true);
        myAjaxPostrequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        myAjaxPostrequest.send(parameters);
        myAjaxPostrequest.onreadystatechange = function () {
            if (myAjaxPostrequest.readyState == 4) {
                if (myAjaxPostrequest.status == 200) {

                    var rsp = myAjaxPostrequest.responseText;

                    window.validationobj=rsp;
      
                    
                }
            }
        }

           
    }




     function ValidateLength(data){ 
         if(window.activeformitem!=null){
        var validateobj = JSON.parse(window.validationobj);
         var inputobj=validateobj[window.activeformitem];
                   
         var minlength = inputobj["minlength"];
         var maxlength = inputobj["maxlength"];
     }else{
         minlength=1;
     }
  
         
        if(data.length<minlength || data.length>maxlength){
           return  false; 
        }else{  return  true;  }
      
        }







    /****************************************CUSTOM HTML COMPONENTS************************************************/
    var emptextcol0 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol0' type='text' id='emptextcol0id' oninput='customFilter()'  />";
    var emptextcol1 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol1' type='text' id='emptextcol1id' oninput='customFilter()'  />";
    var emptextcol2 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol2' type='text' id='emptextcol2id' oninput='customFilter()'  />";
    var emptextcol3 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol3' type='text' id='emptextcol3id' oninput='customFilter()'  />";
    var emptextcol4 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol4' type='text' id='emptextcol4id' oninput='customFilter()'  />";
    var emptextcol5 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol5' type='text' id='emptextcol5id' oninput='customFilter()'  />";
    var emptextcol6 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol6' type='text' id='emptextcol6id' oninput='customFilter()'  />";
    var emptextcol7 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol7' type='text' id='emptextcol7id' oninput='customFilter()'  />";
    var emptextcol8 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol8' type='text' id='emptextcol8id' oninput='customFilter()'  />";
    var emptextcol9 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol9' type='text' id='emptextcol9id' oninput='customFilter()'  />";
    var emptextcol10 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol10' type='text' id='emptextcol10id' oninput='customFilter()'  />";
    var emptextcol11 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol11' type='text' id='emptextcol11id' oninput='customFilter()'  />";
    var emptextcol12 = "<input   style='width: 97%; ' horizontal-align:center;' name='emptextcol12' type='text' id='emptextcol12id' oninput='customFilter()'  />";

    var empcombocol0 = "<select  style='width: 100%;' name='empcombocol0' id='empcombocol0id'  onchange='customFilter()'></select>";
    var empcombocol1 = "<select  style='width: 100%;' name='empcombocol1' id='empcombocol1id'  onchange='customFilter()'></select>";
    var empcombocol2 = "<select  style='width: 100%;' name='empcombocol2' id='empcombocol2id'  onchange='customFilter()'></select>";
    var empcombocol3 = "<select  style='width: 100%;' name='empcombocol3' id='empcombocol3id'  onchange='customFilter()'></select>";
    var empcombocol4 = "<select  style='width: 100%;' name='empcombocol4' id='empcombocol4id'  onchange='customFilter()'></select>";
    var empcombocol5 = "<select  style='width: 100%;' name='empcombocol5' id='empcombocol5id'  onchange='customFilter()'></select>";
    var empcombocol6 = "<select  style='width: 100%;' name='empcombocol6' id='empcombocol6id'  onchange='customFilter()'></select>";
    var empcombocol7 = "<select  style='width: 100%;' name='empcombocol7' id='empcombocol7id'  onchange='customFilter()'></select>";
    var empcombocol8 = "<select  style='width: 100%;' name='empcombocol8' id='empcombocol8id'  onchange='customFilter()'></select>";
    var empcombocol9 = "<select  style='width: 100%;' name='empcombocol9' id='empcombocol9id'  onchange='customFilter()'></select>";
    var empcombocol10 = "<select  style='width: 100%;' name='empcombocol10' id='empcombocol10id'  onchange='customFilter()'></select>";
    var empcombocol11 = "<select  style='width: 100%;' name='empcombocol11' id='empcombocol11id'  onchange='customFilter()'></select>";
    var empcombocol12 = "<select  style='width: 100%;' name='empcombocol12' id='empcombocol12id'  onchange='customFilter()'></select>";


</script>
