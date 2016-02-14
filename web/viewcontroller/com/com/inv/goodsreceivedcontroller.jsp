<%-- 
    Document   : storescontroller
    Created on : Dec 15, 2015, 11:26:54 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>

<script>
    function suppliersGoodsreceivedFormOnclick(id, suppliersGoodsreceivedForm, goodsreceivedlineGrid, goodsreceivedlineLayout) {

        switch (id)
        {
            case "save":
               
                var valid = suppliersGoodsreceivedForm.validate();

                if (valid == true) {
                    var values = suppliersGoodsreceivedForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/inv/goodsreceived.jsp";
                    winsaver(param, path, "Goodsreceived", goodsreceivedlineGrid, true);
                  //  alert(param);

                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = suppliersGoodsreceivedForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/inv/goodsreceived.jsp";
                alert(param);
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this Goods Received?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Goodsreceived", goodsreceivedlineGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
              //  setstoresSync();
             break;
        }
    }

    function suppliersgoodsreceivedLineFormOnclick(id, suppliersgoodsreceivedLineForm, goodsreceivedlineGrid, goodsreceivedLineFormLayout) {

        switch (id)
        {
            case "save":
               
                var valid = suppliersgoodsreceivedLineForm.validate();

                if (valid == true) {
                    var values = suppliersgoodsreceivedLineForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/inv/suppliersgoodsreceived.jsp";
                    winsaver(param, path, "Goodsreceived", goodsreceivedlineGrid, true);
                  //  alert(param);

                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = suppliersgoodsreceivedLineForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/inv/suppliersgoodsreceived.jsp";
                alert(param);
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this Goods Received?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Goodsreceived", goodsreceivedlineGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
              //  setstoresSync();
             break;
        }
    }

    function goodsreceivedToolbarOnclick(itemId, goodsreceivedGrid) {
        switch (itemId) {
            case 'new':

                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "New Goods Received";
                goodsreceivedcreateWindow(rId, pname, goodsreceivedGrid, loadPath);
               // createStoresform(adjustmentsLayout, adjustmentsGrid, -1);
                break;
            case 'refresh':
                goodsreceivedGrid.clearAll();
                goodsreceivedGrid.load("./viewmodel/grid/com/com/inv/suppliersgoodsreceived.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(goodsreceivedGrid);
                break;
            case 'excel':
                ExportExcel(goodsreceivedGrid);
                break;
        }
    }
 

</script>