<%-- 
    Document   : receiptscontroller
    Created on : Dec 19, 2015, 11:59:24 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>

<script>


    function receiptsToolbarOnclick(itemId, Grid) {
        switch (itemId) {
            case 'new':
                Grid.clearSelection();
                rId = -1;
                pname = "Add Receipts";
                receiptscreateWindow(rId, pname, Grid);
                //createReceiptsform(receiptslineLayout, receiptsGrid, -1);
                break;
            case 'refresh':
                Grid.clearAll();
                Grid.load("./viewmodel/grid/com/com/inv/stores.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(receiptsGrid);
                break;
            case 'excel':
                ExportExcel(receiptsGrid);
                break;
        }
    }


    function receiptslineToolbarOnclick(itemId, mygrid, loadPath) {
        switch (itemId) {
            case 'new':
                mygrid.clearSelection();
                rId = -1;
                pname = "Add Receipts";
             //   receiptscreateWindow(rId, pname, Grid);
                receiptsLineCreateWindow(rId, pname, mygrid, loadPath);
                //createReceiptsform(receiptslineLayout, receiptsGrid, -1);
                break;
            case 'refresh':
                mygrid.clearAll();
                mygrid.load("./viewmodel/grid/com/com/inv/stores.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(mygrid);
                break;
            case 'excel':
                ExportExcel(mygrid);
                break;
        }
    }
</script>
