<%-- 
    Document   : helper
    Created on : Nov 15, 2015, 2:48:47 PM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
    
     function   ExportPdf(Grid){
         
     Grid.toPDF('./codebase/pdf/pdfcomingsoon.jsp','gray');     
         
     }
     
     
     
      function   ExportExcel(Grid){
         
     Grid.toPDF('./codebase/pdf/excelcomingsoon.jsp','gray');     
         
     }
   // alert("help initiated!");
    </script>