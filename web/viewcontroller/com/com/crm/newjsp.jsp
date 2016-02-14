<%-- 
    Document   : newjsp
    Created on : Jan 21, 2016, 4:04:30 PM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>

    /*
    function createQuoteCustomer(quotesGrid) {
        var win = dhxWins.createWindow("Make Customer Quote ", 260, 110, 1000, 500);
        win.setText("<b>Make New Customer Quote</b>");
        win.attachEvent("onClose", function (win) {
            win.hide();
            quotesGrid.clearAll();
            quotesGrid.load("viewmodel/grid/com/com/crm/quotes.jsp", "json");

        });
        // 1.Creation of Layouts

        quotedetailsLayout = new dhtmlXLayoutObject({parent: win, pattern: "2E"});
        quotedetailsLayout.cells("a").hideHeader();
        quotedetailsLayout.cells("b").hideHeader();
        quotedetailsLayout.cells("a").setHeight(50);
        /********ATTACH FORM TO THE STRUCTURE****************/
        var formStructure = [
            {type: "newcolumn", offset: 20},
            {type: "input", name: "customer", label: "<b>Search Customer by Name / Phone No /Contact Person</b>", labelWidth: 400, inputWidth: 200},
            {type: "newcolumn", offset: 20},
            {type: "button", name: "search", value: "Search", width: 100},
            {type: "newcolumn", offset: 20},
            {type: "button", name: "loadall", value: "Load all", width: 100},
        ];
        var dhxForm1 = quotedetailsLayout.cells("a").attachForm();
        dhxForm1.loadStruct(formStructure, "json");

        var mygrid = quotedetailsLayout.cells("b").attachGrid();
        mygrid.setHeader("#,Cust No,Customer Name,Phone, Contact person,Category");
        mygrid.setColAlign("left,left,left,left,left,left");
        mygrid.setInitWidths("50,100,220,200,200,150");
        mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
        mygrid.setColSorting("int,int,str,str,str,str");
        mygrid.attachHeader(",#text_filter,#text_filter,#text_filter,#text_filter,#combo_filter");
        mygrid.init();

//        mygrid.attachEvent("onXLS", function () {
//            quotedetailsLayout.cells("b").progressOn();
//        });
        alert("./viewmodel/grid/com/com/crm/searchcustomer.jsp");
        mygrid.load("./viewmodel/grid/com/com/crm/searchcustomer.jsp", "json");
        mygrid.attachEvent("onXLE", function () {
            quotedetailsLayout.cells("b").progressOff();
        });

        dhxForm1.attachEvent("onButtonClick", function (name) {
            if (name == 'search') {
                var param = dhxForm1.getItemValue("customer");
                if (param == "")
                {
                    msg = "Please provide the Search Criteria!";
                    dhtmlx.alert(msg);

                } else {
                    customerSearch(mygrid, param, quotedetailsLayout);
                }

            }
        });

        //CREATE A KEY UP EVENT THAT ENABLES ONE SYSTEM TO AUTOMATICLLY SEARCH A CUSTOMER AS YOU TYPE
        dhxForm1.attachEvent("onKeyUp", function (inp, ev, name, value) {
            //your code here
            var param = dhxForm1.getItemValue("customer");
            customerSearch(mygrid, param, quotedetailsLayout);
        });

        //ON SELECT EVENT
        mygrid.attachEvent("onRowSelect", function (rId, cInd) {
            var customerId = rId;
            win.close();
            mygridGridOnselect(mygrid, customerId, rId);
        });

    }
    function customerSearch(mygrid, param, quotedetailsLayout) {
        mygrid.clearAll();
        mygrid.attachEvent("onXLS", function () {
            quotedetailsLayout.cells("b").progressOn();
        });
        mygrid.load("./viewmodel/grid/com/com/crm/searchcustomer.jsp?param=" + param, "json");
        mygrid.attachEvent("onXLE", function () {
            quotedetailsLayout.cells("b").progressOff();
        });

    }
    function mygridGridOnselect(mygrid, rId) {
        var pname = mygrid.cells(rId, 2).getValue();

        customersquotecreateWindow(rId, pname, mygrid);
    }
    ///CREATE POS SELECTION WINDOW
    function customersquotecreateWindow(rId, pname, mygrid) {
        var quoteWin = dhxWins.createWindow("Make Customer Quote " + rId, 350, 110, 540, 500);
        quoteWin.setText("<b>" + pname + "</b>");
        quoteWin.attachEvent("onClose", function (quoteWin) {
            quoteWin.hide();
            mygrid.clearAll();
            mygrid.load("viewmodel/grid/com/com/crm/quotes.jsp", "json");

        });

        // 1.Creation of Layouts

        customersquoteLayout = new dhtmlXLayoutObject({parent: quoteWin, pattern: "2E"});
        customersquoteLayout.cells("a").hideHeader();
        customersquoteLayout.cells("b").hideHeader();
        customersquoteLayout.cells("a").setHeight(50);
        /********ATTACH FORM TO THE STRUCTURE****************/
        var formStructure1 = [
            {type: "newcolumn", offset: 20},
            {type: "input", name: "customer", label: "<b>Search POS by Code / Amount </b>", labelWidth: 200, inputWidth: 100},
            {type: "newcolumn", offset: 20},
            {type: "button", name: "search", value: "Search", width: 100},
        ];
        var dhxForm2 = customersquoteLayout.cells("a").attachForm();
        dhxForm2.loadStruct(formStructure1, "json");

        var mygrid1 = customersquoteLayout.cells("b").attachGrid();
        mygrid1.setHeader("#,POS Code,Amount");
        mygrid1.setColAlign("left,left,left");
        mygrid1.setInitWidthsP("20,40,40");
        mygrid1.setColTypes("ro,ro,ro");
        mygrid1.setColSorting("int,int,str");
        mygrid1.attachHeader(",#text_filter,#text_filter");
        mygrid1.init();

//        mygrid.attachEvent("onXLS", function () {
//            quotedetailsLayout.cells("b").progressOn();
//        });
        alert("./viewmodel/grid/com/com/crm/searchpos.jsp");
        mygrid1.load("./viewmodel/grid/com/com/crm/searchpos.jsp", "json");
        mygrid1.attachEvent("onXLE", function () {
            customersquoteLayout.cells("b").progressOff();
        });
        dhxForm2.attachEvent("onButtonClick", function (name) {
            if (name == 'search') {
                var param1 = dhxForm2.getItemValue("pos");
                if (param1 == "")
                {
                    msg = "Please provide the Search Criteria!";
                    dhtmlx.alert(msg);

                } else {
                    posSearch(mygrid1, param1, customersquoteLayout);
                }

            }
        });

        //CREATE A KEY UP EVENT THAT ENABLES ONE SYSTEM TO AUTOMATICLLY SEARCH A CUSTOMER AS YOU TYPE
        dhxForm2.attachEvent("onKeyUp", function (inp, ev, name, value) {
            //your code here
            var param1 = dhxForm2.getItemValue("pos");
            posSearch(mygrid1, param1, customersquoteLayout);
        });
    }
    function posSearch(mygrid1, param1, customersquoteLayout) {
        mygrid1.clearAll();
        mygrid1.attachEvent("onXLS", function () {
            customersquoteLayout.cells("b").progressOn();
        });
        mygrid1.load("./viewmodel/grid/com/com/crm/searchpos.jsp?param1=" + param1, "json");
        mygrid1.attachEvent("onXLE", function () {
            customersquoteLayout.cells("b").progressOff();
        });

    }*/