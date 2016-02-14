<%-- 
    Document   : supplierscontroller
    Created on : Dec 4, 2015, 11:34:01 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../controller/mainController.jsp" %>
<%@include  file="../../../../view/helper.jsp" %>
<script>
    function profilesToolbarOnclick(itemId, profilesLayout, profilesGrid) {
        switch (itemId) {
            case 'new':
                window.lastvisit = "new";
                // Grid.clearSelection();
                rId = -1;
                pname = "Add Profiles";
                profilescreateWindow(rId, pname, profilesGrid);

                break;

            case 'edit':
                var rId = profilesGrid.getSelectedRowId();
                if (rId == null)
                    (dhtmlx.alert("select the profile you want to edit"))
                else {
                     window.lastvisit = "new";
                // Grid.clearSelection();
                //rId = -1;
                pname = "Add Profiles";
                    profilescreateWindow(rId, pname, profilesGrid);
                }
                                //alert(rId);

                break;

        }
    }

    function profilesFormOnclick(id, profilesForm, profilesGrid, profilesFormLayout) {

        switch (id)
        {
            case "save":

                var valid = profilesForm.validate();

                if (valid == true) {
                    var values = profilesForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/sec/profiles.jsp";

                    winsaver(param, path, "Profiles", profilesGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;
            case'delete' :

                var values = profilesForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/sec/profiles.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this profiles?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Profiles", profilesGrid, false);
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