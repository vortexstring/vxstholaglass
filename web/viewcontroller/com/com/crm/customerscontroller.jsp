<%-- 
    Document   : credentialscontroller
    Created on : Nov 16, 2015, 11:43:24 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>

      function customersToolbarOnclick(itemId, customersGrid, customersGrid) {
        switch (itemId) {
            case 'new':

window.lastvisit = "new";
              // Grid.clearSelection();
               rId = -1;
               pname = "Add Customer";
               customerscreateWindow(rId, pname,customersGrid, loadPath);     
               break;
            case 'refresh':
                customersGrid.clearAll();
                customersGrid.load(loadPath, 'json');
                break;
            case 'pdf':
                ExportPdf(customersGrid);
                break;
            case 'excel':
                ExportExcel(customersGrid);
                break;
        }
    }
 
        function customersFormOnclick(id, customersForm, customersGrid,customerLayout) {

        switch (id)
        {
            case "save":
               
                var valid = customersForm.validate();

                if (valid == true) {
                    var values = customersForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/crm/customers.jsp";
               alert(param);
             
                    winsaver(param, path, "Customers", customersGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = customersForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/crm/customers.jsp";
                alert(param);
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this customer?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Customers", customersGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
               // setcustomersSync();
             break;
        }
    }

    

</script>