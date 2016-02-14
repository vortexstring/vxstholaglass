<%-- 
    Document   : menu
    Created on : Nov 6, 2015, 6:47:25 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



[ 
	
	{ id: "open", type: "button", img: "open.gif", text: "Open Menu", title: "Shows the Menu ribbon",},
	{ id:   "sep_id",	type: "separator",},
	{ id: "profile", type: "buttonSelect", img: "open.gif", text: "Profile Details", title: "Profile Details",
        
        options: [
			{ type: "button", id: "profile", text: "My Profile", img: "pdf.png" },
			{ type: "button", id: "calendar", text: "My Calendar", img: "excel.png"},
                        { type: "button", id: "messages", text: "Messages", img: "pdf.png" },
                        { id:   "sep_id", type: "separator",},
			{ type: "button", id: "lockscreen", text: "Lock Screen", img: "excel.png" },
			{ type: "button", id: "logout", text: "Log Out", img: "pdf.png" }
		]
        }


]

                