  <%-- 
    Document   : supplierscontroller
    Created on : Dec 4, 2015, 11:34:01 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function productsToolbarOnclick(itemId, productsGrid,loadPath) {
        switch (itemId) {
            case 'new':
      
                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Products";
                productscreateWindow(rId, pname, productsGrid,loadPath);
                break;
            case 'refresh':
                productsGrid.clearAll();
                productsGrid.load(loadPath, 'json');
                break;
            case 'pdf':
                ExportPdf(productsGrid);
                break;
            case 'excel':
                ExportExcel(productsGrid);
                break;
        }
    }

    function  productsFormOnclick(id, productsForm, productsGrid) {

        switch (id)
        {
            case "save":

                var valid = productsForm.validate();

                if (valid == true) {
                    var values = productsForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/crm/products.jsp";

                    winsaver(param, path, "products", productsGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = productsForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/crm/products.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this credentials?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "products", productsGrid, false);
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
    
    function productsTreeToolbarOnclick(itemId, productsGrid,loadPath,parentId, productsTree,TreeloadPath,productsLayout) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Products";
                 productsTreecreateWindow(rId, pname, productsGrid,loadPath,parentId, productsTree,TreeloadPath);
              
                break;
            case 'edit':
           setTimeout(function () {
               var rId=productsTree.getSelectedItemId();
               var pname= productsTree.getItemText(rId);
    
               var parentId=0;
               productsTreecreateWindow(rId, pname, productsGrid,loadPath,parentId, productsTree,TreeloadPath);
           },100);
               
               break; 
           case 'refresh':
    
             productsLayout.cells("a").detachObject(); 
             var productsTree = attachTree(productsLayout,TreeloadPath);
                break;
            case 'pdf':
                ExportPdf(productsGrid);
                break;
            case 'excel':
                ExportExcel(productsGrid);
                break;
        }
    }

</script>