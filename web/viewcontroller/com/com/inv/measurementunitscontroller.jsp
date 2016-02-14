<%-- 
    Document   : storescontroller
    Created on : Dec 15, 2015, 11:26:54 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>

<script>
    function measurementunitsFormOnclick(id, measurementunitsForm, measurementunitsGrid,measurementunitsLayout) {

        switch (id)
        {
            case "save":
               
                var valid = measurementunitsForm.validate();

                if (valid == true) {
                    var values = measurementunitsForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/inv/measurementunits.jsp";
               alert(param);
             
                    winsaver(param, path, "Measurementunits", measurementunitsGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 8000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = measurementunitsForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/inv/measurementunits.jsp";
                alert(param);
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this Measurementunits?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Measurementunits", measurementunitsGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
               // setstoresSync();
             break;
        }
    }


    function measurementunitsToolbarOnclick(itemId, measurementunitsGrid,measurementunitsLayout) {
        switch (itemId) {
            case 'new':

                createMeasurementunitsform(measurementunitsLayout, measurementunitsGrid, -1);
                break;
            case 'refresh':
                measurementunitsGrid.clearAll();
                measurementunitsGrid.load("./viewmodel/grid/com/com/inv/measurementunits.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(measurementunitsGrid);
                break;
            case 'excel':
                ExportExcel(measurementunitsGrid);
                break;
        }
    }





</script>