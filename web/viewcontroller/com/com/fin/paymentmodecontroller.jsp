<%-- 
    Document   : paymentterm
    Created on : Dec 24, 2015, 4:59:48 PM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function paymentmodeFormOnclick(id, paymentmodeForm, paymentmodeGrid,paymentmodeLayout) {

        switch (id)
        {
            case "save":
               
                var valid = paymentmodeForm.validate();

                if (valid == true) {
                    var values = paymentmodeForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/fin/paymentmode.jsp";
                  alert (param);
                  dhtmlx.message({
                        text: "Data sent",
                        expire: 8000,
                        type: "success"
                    });
                  
                    winsaver(param, path, "Paymentmode", paymentmodeGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = paymentmodeForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/fin/paymentmode.jsp";
                
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this Bankaccounts?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Paymentmode", paymentmodeGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
                //setcredentialsSync();
             break;
        }
    }

    function  paymentmodeToolbarOnclick(itemId, paymentmodeLayout, paymentmodeGrid,paymentmodeForm)
 {
        switch (itemId) {
            case 'new':

                createPaymentmodeform(paymentmodeLayout, paymentmodeGrid, -1);
                break;
            case 'refresh':
                paymentmodeGrid.clearAll();
                paymentmodeGrid.load("./viewmodel/grid/com/com/fin/paymentmode.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(paymentmodeGrid);
                break;
            case 'excel':
                ExportExcel(paymentmodeGrid);
                break;
        }
    }





</script>
