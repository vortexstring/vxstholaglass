<%-- 
    Document   : storescontroller
    Created on : Dec 15, 2015, 11:26:54 AM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>

<script>
    function storesFormOnclick(id, storesForm, storesGrid,storesLayout) {

        switch (id)
        {
            case "save":
               
                var valid = storesForm.validate();

                if (valid == true) {
                    var values = storesForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata+ "&actiontype=0";
                    var path = "./services/sv/com/com/inv/stores.jsp";
               alert(param);
             
                    winsaver(param, path, "Stores", storesGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = storesForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path =  "./services/sv/com/com/inv/stores.jsp";
                alert(param);
                dhtmlx.confirm({
                title: "Delete Confirm",
                type:"confirm-warning",
                text: "Are you sure you want to delete this credentials?",
                callback: function(status) {               
                    if(status==true){  winsaver(param, path, "Stores", storesGrid, false); }
                    }
                 });
               
                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;
                
            default:
                setstoresSync();
             break;
        }
    }


    function storesToolbarOnclick(itemId, storesGrid,storesLayout) {
        switch (itemId) {
            case 'new':

                createStoresform(storesLayout, storesGrid, -1);
                break;
            case 'refresh':
                storesGrid.clearAll();
                storesGrid.load("./viewmodel/grid/com/com/inv/stores.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(storesGrid);
                break;
            case 'excel':
                ExportExcel(storesGrid);
                break;
        }
    }


 function setstoresSync() {
dhtmlx.message('Stores page Heartbeat!');

        /***************AJAX FUNCTIONALITY**************/
        function GetXmlHttpObject()
        {
            if (window.XMLHttpRequest)
            {
                return new XMLHttpRequest();
            }
            if (window.ActiveXObject)
            {
                return new ActiveXObject("Microsoft.XMLHTTP");
            }
            return null;
        }//END  OF AJAX

        /*******************FUNCTION TO SEND DATA TO THE DATABASE AS A  QUERY***************/
  var myAjaxPostrequest = new GetXmlHttpObject();
        var parameters = "type=gridupdate";
         myAjaxPostrequest.open("POST", "viewmodel/grid/com/com/inv/stores.jsp", true);
        myAjaxPostrequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        myAjaxPostrequest.send(parameters);
        myAjaxPostrequest.onreadystatechange = function () {
            if (myAjaxPostrequest.readyState == 4) {
                if (myAjaxPostrequest.status == 200) {
                    var jsontext = myAjaxPostrequest.responseText;
            
                        
                      updategrid(jsontext,storesGrid)  
                      
                        
                }
            }
        }
        
      
        
    }
        /****************************END OF UPDATING THE GRID**********************************************/

function updategrid(jsontext,storesGrid){
 
       //GET THE VALUE OF THE FILTERS
         var filterelem = Array();
        var colNum = storesGrid.getColumnsNum();
        for (var x = 0; x < colNum; x++) {
            filterelem[x] = storesGrid.getFilterElement(x);
           
        
        }

  storesGrid.attachEvent("onXLE", function () { 
         //SET THE FILTERS
        var colNum = storesGrid.getColumnsNum();
        
            for (var n = 0; n < colNum; n++) {  
             if(filterelem[n]!==""){
            
              storesGrid.filterBy(n, filterelem[n], true);
            }
         }
    });
  
        //GET THE SELECTED ROW
        var selectedRowId = storesGrid.getSelectedRowId();
    
    
        storesGrid.clearAll(); 
        storesGrid.parse(jsontext,"json");
   
    
}




</script>