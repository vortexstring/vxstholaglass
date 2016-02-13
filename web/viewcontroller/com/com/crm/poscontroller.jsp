<%-- 
    Document   : poscontroller
    Created on : Dec 1, 2015, 12:58:25 PM
    Author     : pharis wambui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    function posglassFormOnclick(id, posglassForm, posLineGrid) {

        switch (id)
        {
            case "process":

                var valid = posglassForm.validate();

                if (valid == true) {
                    var values = posglassForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=-10";
                    var path = "./services/sv/com/com/crm/posglass.jsp";

                    dhtmlx.message({
                        text: "Data sent",
                        expire: 8000,
                        type: "success"
                    });

                    // winsaver(param, path, "Pos",  true);

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

                    var myAjaxPostrequest = new GetXmlHttpObject();
                    myAjaxPostrequest.open("POST", path, true);
                    myAjaxPostrequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    myAjaxPostrequest.send(param);
                    myAjaxPostrequest.onreadystatechange = function () {
                        if (myAjaxPostrequest.readyState == 4) {

                            if (myAjaxPostrequest.status == 200) {
                                //READ THE RESPONSE INFORMATION
                                var resp = myAjaxPostrequest.responseText;


                                var respobj = JSON.parse(resp);
                                var msgtype = respobj['msgtype'];
                                var msgtext = respobj['msg'];
                                var actiontype = respobj['actiontype'];
                                var recordId = respobj['recId'];
                                var areaData = respobj['uomqty'];

                                var countData = respobj['pricecount'];
                                alert("Count : "+countData);

                                if(countData==0 || countData>1){
            
                                        dhtmlx.alert({
                                        type: "alert-error",
                                        text: respobj['error_msg'],
                                        title: "Error while fetching Price",
                                        ok: "Ok"
                                         });
                                 
                                 
                                
                                }
                            
                                posglassForm.setFormData({
                                    uomid: respobj['uomid'], price: respobj['price'],
                                    percentdisc: respobj['percentdisc'], percentint: respobj['percentint'],
                                    discount: respobj['discount'], interest: respobj['interest'],
                                    amount: respobj['amount'], vatableamount: respobj['vatableamount'],
                                    vatamount: respobj['vatamount'], uomqty: respobj['uomqty'],
                                    qdate: respobj['qdate'], memo: respobj['memo'], itemsaleid: respobj['itemsaleid'],
                                    vatrate: respobj['vatrate'], vatid: respobj['vatid']
                                });
                                //alert("Area : "+areaData+" Price : "+priceData+" Count : "+countData);
                                //alert("PercentInt : " + respobj['vatrate'] + " Discount : " + respobj['percentdisc'] + " UOM : " + respobj['uomid'] + "Date is : :" + respobj['qdate'] + " ItemSale Id is :" + respobj['itemsaleid']);


                            }
                        }
                    }


                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }
                break;

            case 'save':



                var valid = posglassForm.validate();

                if (valid == true) {
                    var values = posglassForm.getFormData();
                    var mydata = "" + JSON.stringify(values);
                    var param = "data=" + mydata + "&actiontype=0";
                    var path = "./services/sv/com/com/crm/posglass.jsp";
                    alert(param);

                    winsaver(param, path, "POS Sale", posLineGrid, true);
                } else {
                    dhtmlx.message({
                        text: "Please provide the required fields",
                        expire: 2000,
                        type: "fail" // 'customCss' - css class
                    });
                }

                break;
            case'delete' :

                var values = posglassForm.getFormData();
                var mydata = "" + JSON.stringify(values);
                var param = "data=" + mydata + "&actiontype=-5";
                var path = "./services/sv/com/com/crm/posglass.jsp";

                dhtmlx.confirm({
                    title: "Delete Confirm",
                    type: "confirm-warning",
                    text: "Are you sure you want to delete this POS?",
                    callback: function (status) {
                        if (status == true) {
                            winsaver(param, path, "Pos", false);
                        }
                    }
                });

                //createCredentialsform(credentialsLayout,credentialsGrid,-1)
                break;

            default:
                setcredentialsSync();
                break;
        }
    }
    function toolbarOnclick(id, dhxWins, serviceGrid, subjectQuotelinekey, serviceloadPath, subjectProductkey) {

        switch (id) {

            case 'new':
//alert(id);
                //  (subjectProductkey, pname, dhxWins, serviceloadPath,subjectQuotelinekey
                createserviceWindow(subjectProductkey, "Add Product Sevice", dhxWins, serviceGrid, serviceloadPath, subjectQuotelinekey);

            case 'refresh':

                Grid.clearAll();
                Grid.load(serviceloadPath, 'json');
                break
            default:

                break;
        }
    }
    function dhxTreeOnclick(winLayout, dhxTree,id){
        createServiceform(winLayout, dhxTree, -1);
    }
</script>
