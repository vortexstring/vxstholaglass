<%-- 
    Document   : quotescontroller
    Created on : Dec 27, 2015, 8:33:43 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function quotesToolbarOnclick(itemId, quotesGrid) {
        switch (itemId) {
            case 'new':
                createQuoteCustomer(quotesGrid)
                //CREATE A WINDOW WHERE WE SELECT THE CUSTOMER

//                window.lastvisit = "new";
//                // Grid.clearSelection();
//                rId = -1;
//                pname = "Add Customer";
//                customerscreateWindow(rId, pname, customersGrid, loadPath);
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
      function  customersQuotesFormOnclick(id, customersQuotesForm, quoteslineGrid, quoteslineLayout,salesQuoteid) {


        switch (id)
        {
            case "save":

                var valid = customersQuotesForm.validate();

                if (valid == true) {
                    var values = customersQuotesForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/crm/customersquotes.jsp";
                    alert(param);
                    winsaver(param, path, "Customer Quotes", quoteslineGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = customersQuotesForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/crm/customersquotes.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this Customer Quotes?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Customer Quotes", quoteslineGrid, false);
                        }
                    }
                });

                
                break;
                
            case 'processquote':
            
            window.dhx4.ajax.post("./services/sv/com/com/crm/customersorders.jsp", "quoteid="+salesQuoteid, function(r){
             // alert("./services/sv/com/com/crm/customersorders.jsp");
                alert(r.xmlDoc.responseText);
                
            });
            
            break;

            default:
               // setsuppliersSync();
                break;
        }
    }

    
</script>
