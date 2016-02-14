<%-- 
    Document   : supplierscontroller
    Created on : Dec 4, 2015, 11:34:01 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function suppliersToolbarOnclick(itemId, suppliersLayout, suppliersGrid) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Supplier";
                supplierscreateWindow(rId, pname, suppliersGrid, loadPath);
                break;
            case 'refresh':
                suppliersGrid.clearAll();
                suppliersGrid.load(loadPath, 'json');
                break;
            case 'pdf':
                ExportPdf(suppliersGrid);
                break;
            case 'excel':
                ExportExcel(suppliersGrid);
                break;
        }
    }

    function suppliersFormOnclick(id, suppliersForm, suppliersGrid, supplierFormLayout) {

        switch (id)
        {
            case "save":

                var valid = suppliersForm.validate();

                if (valid == true) {
                    var values = suppliersForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/prc/suppliers.jsp";

                    winsaver(param, path, "Suppliers", suppliersGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = suppliersForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/prc/suppliers.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this credentials?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Suppliers", suppliersGrid, false);
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