<%-- 
    Document   : credentialscontroller
    Created on : Nov 16, 2015, 11:43:24 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function credentialsFormOnclick(id, credentialsForm, credentialsGrid, credentialsLayout) {

        switch (id)
        {
            case "save":

                var valid = credentialsForm.validate();

                if (valid == true) {
                    var values = credentialsForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/sec/credentials.jsp";
alert(param);
                    dhtmlx.message({
                        text: "Data sent",
                        expire: 8000,
                        type: "success"
                    });

                    winsaver(param, path, "Credentials", credentialsGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = credentialsForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/sec/credentials.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this credentials?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Credentials", credentialsGrid, false);
                        }
                    }
                });

                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;

            default:
                setcredentialsSync();
                break;
        }
    }


    function credentialsToolbarOnclick(itemId, credentialsLayout, credentialsGrid, credentialsForm) {
        switch (itemId) {
            case 'new':

                createCredentialsform(credentialsLayout, credentialsGrid, -1);
                break;
            case 'refresh':
                credentialsGrid.clearAll();
                credentialsGrid.load("./viewmodel/grid/com/com/sec/credentials.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(credentialsGrid);
                break;
            case 'excel':
                ExportExcel(credentialsGrid);
                break;
        }
    }


    function setcredentialsSync() {
//dhtmlx.message('Credentials page Heartbeat!');

        /***************AJAX FUNCTIONALITY**************/
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

        /*******************FUNCTION TO SEND DATA TO THE DATABASE AS A  QUERY***************/
        var myAjaxPostrequest = new GetXmlHttpObject();
        var parameters = "type=gridupdate";
        myAjaxPostrequest.open("POST", "viewmodel/grid/com/com/sec/credentials.jsp", true);
        myAjaxPostrequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        myAjaxPostrequest.send(parameters);
        myAjaxPostrequest.onreadystatechange = function () {
            if (myAjaxPostrequest.readyState == 4) {
                if (myAjaxPostrequest.status == 200) {
                    var jsontext = myAjaxPostrequest.responseText;
                    updategrid(jsontext, credentialsGrid)

                }
            }
        }



    }
    /****************************END OF UPDATING THE GRID**********************************************/

    function updategrid(jsontext, credentialsGrid) {

        //GET THE VALUE OF THE FILTERS
        var filterelem = Array();
        var colNum = credentialsGrid.getColumnsNum();
        for (var x = 0; x < colNum; x++) {
            filterelem[x] = credentialsGrid.getFilterElement(x);

        }

        credentialsGrid.attachEvent("onXLE", function () {
            //SET THE FILTERS
            var colNum = credentialsGrid.getColumnsNum();

            for (var n = 0; n < colNum; n++) {
                if (filterelem[n] !== "") {

                    credentialsGrid.filterBy(n, filterelem[n], true);
                }
            }
             
        });

        //GET THE SELECTED ROW
        var selectedRowId = credentialsGrid.getSelectedRowId();


        credentialsGrid.clearAll();
        credentialsGrid.parse(jsontext, "json");
        credentialsGrid.selectRowById(selectedRowId, true, true, false);


    }




</script>