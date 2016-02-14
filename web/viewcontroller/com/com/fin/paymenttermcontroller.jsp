<%-- 
    Document   : paymentterm
    Created on : Dec 24, 2015, 4:59:48 PM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function paytermFormOnclick(id, paytermForm, paytermGrid,paytermLayout) {

        switch (id)
        {
            case "save":
               
                var valid = paytermForm.validate();

                if (valid == true) {
                    var values = paytermForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/fin/paymentterm.jsp";
                  alert (param);
                  dhtmlx.message({
                        text: "Data sent",
                        expire: 8000,
                        type: "success"
                    });
                  
                    winsaver(param, path, "Payterm", paytermGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = paytermForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/fin/paymentterm.jsp";
                
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this Bankaccounts?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Payterm", paytermGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
                //setcredentialsSync();
             break;
        }
    }

    function  paytermToolbarOnclick(itemId, paytermLayout, paytermGrid,paytermForm)
 {
        switch (itemId) {
            case 'new':

                createPaytermform(paytermLayout, paytermGrid, -1);
                break;
            case 'refresh':
                paytermGrid.clearAll();
                paytermGrid.load("./viewmodel/grid/com/com/fin/paymentterm.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(paytermGrid);
                break;
            case 'excel':
                ExportExcel(paytermGrid);
                break;
        }
    }





</script>
