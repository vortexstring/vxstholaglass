<%-- 
    Document   : productsalecontroller
    Created on : Jan 30, 2016, 2:38:11 PM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
  function productsaleToolbarOnclick(itemId, productsaleGrid,loadPath,itemid) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Sale Details";
                productsalecreateWindow(rId, pname, productsaleGrid, loadPath,itemid);
                break;
            case 'refresh':
                productsaleGrid.clearAll();
                
                productsaleGrid.load(loadPath, 'json');
                break;
            case 'pdf':
                ExportPdf(productsaleGrid);
                break;
            case 'excel':
                ExportExcel(productsaleGrid);
                break;
        }
    }

    function  productsaleFormOnclick(id, productsaleForm, productsaleGrid, productsaleFormLayout) {

        switch (id)
        {
            case "save":

                var valid = productsaleForm.validate();

                if (valid == true) {
                    var values = productsaleForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/crm/productsale.jsp";
                       //alert(param);
                    winsaver(param, path, "productsale", productsaleGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = productsaleForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/crm/productsale.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this productsale?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "productsale", productsaleGrid, false);
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
