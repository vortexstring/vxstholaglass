<%-- 
    Document   : supplierscontroller
    Created on : Dec 4, 2015, 11:34:01 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>

    function purchaseordersToolbarOnclick(itemId, purchaseordersGrid) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                purchaseOrderId = -1;
                pname = "Add New LPO";
                alert(purchaseOrderId);
                //itempurchasecreateWindow(purchaseOrderId, pname, purchaseorderslineGrid);
                purchaseorderscreateWindow(purchaseOrderId, pname, purchaseordersGrid, loadPath);

                break;
            case 'refresh':
                purchaseordersGrid.clearAll();
                purchaseordersGrid.load('viewmodel/grid/com/com/prc/purchaseorders.jsp', 'json');
                break;
            case 'pdf':
                ExportPdf(purchaseordersGrid);
                break;
            case 'excel':
                ExportExcel(purchaseordersGrid);
                break;
        }
    }
    ///*  function suppliersToolbarOnclick(itemId, suppliersLayout, suppliersGrid) 
    function purchaseorderslineToolbarOnclick(itemId, purchaseorderslineGrid, purchaseOrderId) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                //purchaseOrderId = -1;
                pname = "Add Item";
                alert(purchaseOrderId);
                itempurchasecreateWindow(purchaseOrderId, pname, purchaseorderslineGrid);
                break;
            case 'refresh':
                purchaseorderslineGrid.clearAll();
                purchaseorderslineGrid.load('viewmodel/grid/com/com/prc/supplierspurchaseorders.jsp', 'json');
                break;
            case 'pdf':
                ExportPdf(purchaseorderslineGrid);
                break;
            case 'excel':
                ExportExcel(purchaseorderslineGrid);
                break;
        }
    }

    function  supplierPurchaseorderFormOnclick(id, supplierPurchaseorderForm, purchaseordersGrid, purchaseorderslineLayout) {

        switch (id)
        {
            case "save":

                var valid = supplierPurchaseorderForm.validate();

                if (valid == true) {
                    var values = supplierPurchaseorderForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/prc/supplierspurchaseorders.jsp";
                    alert(param);
                    winsaver(param, path, "SuppliersPurchase", purchaseordersGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = supplierPurchaseorderForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/prc/supplierspurchaseorders.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this Suppliers Purchase?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "SuppliersPurchase", purchaseordersGrid, false);
                        }
                    }
                });

                // createSuppliersform(supplierFormLayout, suppliersGrid, -1)
                break;

            default:
                // setsuppliersSync();
                break;
        }
    }

</script>