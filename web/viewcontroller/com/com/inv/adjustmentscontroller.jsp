<%-- 
    Document   : storescontroller
    Created on : Dec 15, 2015, 11:26:54 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>

<script>
  function adjustmentsFormOnclick(id, adjustmentsForm, adjustmentsGrid, adjustmentsFormLayout){

        switch (id)
        {
            case "save":

                var valid = adjustmentsForm.validate();

                if (valid == true) {
                    var values = adjustmentsForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/inv/adjustments.jsp";
alert(param);
                    dhtmlx.message({
                        text: "Data sent",
                        expire: 8000,
                        type: "success"
                    });

                    winsaver(param, path, "Adjustments", adjustmentsGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = adjustmentsForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/inv/adjustments.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this Adjustments?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Adjustments", adjustmentsGrid, false);
                        }
                    }
                });

                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;

            default:
           //     setcredentialsSync();
                break;
        }
    }


    function adjustmentsToolbarOnclick(itemId, adjustmentsLayout,adjustmentsGrid) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Adjustments";
                adjustmentscreateWindow(rId, pname, adjustmentsGrid, loadPath);
               // createStoresform(adjustmentsLayout, adjustmentsGrid, -1);
                break;
            case 'refresh':
                adjustmentsGrid.clearAll();
                adjustmentsGrid.load("./viewmodel/grid/com/com/inv/adjusments.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(adjustmentsGrid);
                break;
            case 'excel':
                ExportExcel(adjustmentsGrid);
                break;
        }
    }
 

</script>