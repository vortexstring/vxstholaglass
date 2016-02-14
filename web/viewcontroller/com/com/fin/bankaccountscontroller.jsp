<%-- 
    Document   : credentialscontroller
    Created on : Nov 16, 2015, 11:43:24 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function bankaccountFormOnclick(id, bankaccountForm, bankaccountGrid,bankaccountLayout) {

        switch (id)
        {
            case "save":
               
                var valid = bankaccountForm.validate();

                if (valid == true) {
                    var values = bankaccountForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/fin/bankaccounts.jsp";
                  alert(param);
                  dhtmlx.message({
                        text: "Data sent",
                        expire: 8000,
                        type: "success"
                    });
                  
                    winsaver(param, path, "Bankaccounts", bankaccountGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = bankaccountForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/fin/bankaccounts.jsp";
                
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this Bankaccounts?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Bankaccounts", bankaccountGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
                //setcredentialsSync();
             break;
        }
    }


    function bankaccountToolbarOnclick(itemId, bankaccountLayout, bankaccountGrid,bankaccountForm) {
        switch (itemId) {
            case 'new':

                createBankaccountForm(bankaccountLayout, bankaccountGrid, -1);
                break;
            case 'refresh':
                bankaccountGrid.clearAll();
                bankaccountGrid.load("./viewmodel/grid/com/com/fin/bankaccounts.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(bankaccountGrid);
                break;
            case 'excel':
                ExportExcel(bankaccountGrid);
                break;
        }
    }





</script>