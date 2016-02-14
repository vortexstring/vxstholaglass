<%-- 
    Document   : userscontroller
    Created on : Nov 16, 2015, 11:43:24 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<script>
  function usersFormOnclick(id, usersForm, usersGrid,usersLayout){

        switch (id)
        {
            case "save":

                var valid = usersForm.validate();

                if (valid == true) {
                    var values = usersForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/sec/users.jsp";
alert(param);
                    dhtmlx.message({
                        text: "Data sent",
                        expire: 8000,
                        type: "success"
                    });

                    winsaver(param, path, "Users", usersGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = usersForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/sec/users.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this User?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Users", usersGrid, false);
                        }
                    }
                });

                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;

            default:
           //     setcredentialsSync();
                break;
        }
    }


    function usersToolbarOnclick(itemId, usersLayout, usersGrid, usersForm) {
        switch (itemId) {
            case 'new':

                createUsersform(usersLayout, usersGrid, -1);
                break;
            case 'refresh':
                usersGrid.clearAll();
                usersGrid.load("./viewmodel/grid/com/com/sec/users.jsp", 'json');
                break;
            case 'pdf':
                ExportPdf(usersGrid);
                break;
            case 'excel':
                ExportExcel(usersGrid);
                break;
        }
    }

</script>