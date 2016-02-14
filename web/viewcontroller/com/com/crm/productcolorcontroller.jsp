<%-- 
    Document   : productcolorcontroller
    Created on : Jan 30, 2016, 2:38:46 PM
    Author     : TBL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
function productcolorToolbarOnclick(itemId, productcolorGrid,loadPath) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Color Details";
                productcolorcreateWindow(rId, pname, productcolorGrid, loadPath);
                break;
            case 'refresh':
                productcolorGrid.clearAll();
                
                productcolorGrid.load(loadPath, 'json');
                break;
            case 'pdf':
                ExportPdf(productcolorGrid);
                break;
            case 'excel':
                ExportExcel(productcolorGrid);
                break;
        }
    }

    function  productcolorFormOnclick(id, productcolorForm, productcolorGrid, productcolorFormLayout) {

        switch (id)
        {
            case "save":

                var valid = productcolorForm.validate();

                if (valid == true) {
                    var values = productcolorForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/crm/productcolor.jsp";
alert(param);
                    winsaver(param, path, "productcolor", productcolorGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = productcolorForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/crm/productcolor.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this productcolor?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "productcolor", productcolorGrid, false);
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
