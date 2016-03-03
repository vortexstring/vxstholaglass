<%-- 
    Document   : basic
    Created on : Nov 15, 2015, 10:52:09 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
[ 
	
	
        { id: "refresh", type: "button", img: "refresh.jpg", text: "Refresh", title: "Clears and loads the grid date",},
        { id: "print", type: "buttonSelect", img: "print.gif", text: "Print", title: "Exports data to various formats",   width: 90,
		options: [
			{ type: "button", id: "pdf", text: "Pdf", img: "pdf.png" },
			{ type: "button", id: "excel", text: "Excel", img: "excel.png" }
			
		]
	}
	
	
]

     