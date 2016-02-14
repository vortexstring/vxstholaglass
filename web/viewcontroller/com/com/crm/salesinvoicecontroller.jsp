<%-- 
    Document   : salesinvoicecontroler
    Created on : Jan 28, 2016, 12:28:28 AM
    Author     : pharis wambui
--%>
<script>

function customersInvoiceFormOnclick(id, customersInvoiceForm, salesinvoicelineGrid, salesinvoicelineLayout){
        switch (id)
        {
            case "save":

                var valid = customersInvoiceForm.validate();

                if (valid == true) {
                    var values = customersInvoiceForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/crm/customersinvoices.jsp";
                    alert(param);
                    winsaver(param, path, "Customer Invoices", salesinvoicelineGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = customersInvoiceForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/crm/customersinvoices.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this Customer Invoices?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Customer Invoices", salesinvoicelineGrid, false);
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