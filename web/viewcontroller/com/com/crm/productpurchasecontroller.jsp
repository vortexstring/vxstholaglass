<%-- 
    Document   : productpurchasecontroller
    Created on : Jan 30, 2016, 2:38:32 PM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
  function productpurchaseToolbarOnclick(itemId, productpurchaseGrid,loadPath,itemid) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Purchase Details";
                productpurchasecreateWindow(rId, pname, productpurchaseGrid, loadPath,itemid);
                break;
            case 'refresh':
                productpurchaseGrid.clearAll();
                
                productpurchaseGrid.load(loadPath, 'json');
                break;
            case 'pdf':
                ExportPdf(productpurchaseGrid);
                break;
            case 'excel':
                ExportExcel(productpurchaseGrid);
                break;
        }
    }

    function  productpurchaseFormOnclick(id, productpurchaseForm, productpurchaseGrid, productpurchaseFormLayout) {

        switch (id)
        {
            case "save":

                var valid = productpurchaseForm.validate();

                if (valid == true) {
                    var values = productpurchaseForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/crm/productpurchase.jsp";
//alert(param);
                    winsaver(param, path, "productpurchase", productpurchaseGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = productpurchaseForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/crm/productpurchase.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this productpurchase?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "productpurchase", productpurchaseGrid, false);
                        }
                    }
                });

                // createSuppliersform(supplierFormLayout, suppliersGrid, -1)
                break;

            default:
                setsuppliersSync();
                break;
        }
    }

</script>

