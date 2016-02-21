<%-- 
    Document   : index
    Created on : Nov 7, 2015, 7:23:45 AM
    Author     : TBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="model.*,viewmodel.*" %>



<%! String flg, required_username_error, required_pass_error, usercomp, pwdcomp, msg, required_key_error;
    String key, uname, pwd, credentials, credentials_error, myq;
    List mydata, formdata;
    Integer i;
%>

<%

    required_username_error = null;
    required_pass_error = null;
    required_key_error = null;
    credentials_error = null;
    if (request.getParameter("k") != null && request.getParameter("u") != null && request.getParameter("p") != null) {
        key = request.getParameter("k");
        uname = request.getParameter("u");
        pwd = request.getParameter("p");
        if (uname.equals("empty") == true) {
            required_username_error = "<font color='red' >* Provide  a username  *</font>";
        }
        if (pwd.equals("empty") == true) {
            required_pass_error = "<font color='red' >* Provide a password*</font>";
        }
        if (key.equals("empty") == true) {
            required_key_error = "<font color='red' >* Provide user  Key *</font>";
        }
    }

    if (request.getParameter("c") != null) {
        credentials = request.getParameter("c");
        if (credentials.equals("invalid") == true) {
            credentials_error = "<font color='red' >* Invalid Login credentials*</font>";
        }
    }


%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VORTEXSTRING|ERP</title>
        
     
     
        
    </head>
    <script>
        jQuery(document).ready(function () {
            Main.init();
            Login.init();
        });
        
        
    </script>
	<body class="login example2">

        

        <!--%            DataLoader ME = new DataLoader();
            StringBuilder myquery = new StringBuilder("FROM ViewMenuParent");
            myq = myquery.toString();
            mydata = ME.getData(myq);

            if (!mydata.isEmpty()) {
                i = 0;
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    ViewMenuParent DC = (ViewMenuParent) iterator.next();
                    out.println("<br/><b>Object Caption:</b> " + DC.getParentcaptionobjectname());
                    out.println("<br/><b>Objects:</b> " + DC.getParentobjectname());
                   
                    out.println("<br/><b>Level</b> " + DC.getParentobjectlevel());

                    out.println("</br>");
                    i++;
                }
            }


        %-->     

        <div class="main-login col-sm-4 col-sm-offset-4">
            <div class="logo">Vortexstring<i class=""></i>
            </div>
            <!-- start: LOGIN BOX -->
            <div class="box-login">
                <h3>Sign in to your account to Login </h3>
                <p>
                    Please enter your userkey and username and password to log in.
                </p>
                <form action="./services/login.jsp" method="post" name="login">
                    <%  if (credentials_error != null) {
                            out.print(credentials_error);
                        }

                    %>
                    <div class="errorHandler alert alert-danger no-display">
                        <i class="fa fa-remove-sign"></i> You have some form errors. Please check below.
                    </div>
                    <fieldset>
                        <div class="form-group">
                            <span class="input-icon">
                                <input type="text" class="form-control" name="userkey" placeholder="Userkey">
                                <i class="fa fa-key"></i> 
                                <%  if (required_key_error != null) {
                                        out.print(required_key_error);
                                    }

                                %>
                            </span>
                        </div>
                        <div class="form-group">
                            <span class="input-icon">
                                <input type="text" class="form-control" name="username" placeholder="Username">
                                <i class="fa fa-user"></i>
                                <%  if (required_username_error != null) {
                                        out.print(required_username_error);
                                    }


                                %>
                            </span>
                        </div>
                        <div class="form-group form-actions">
                            <span class="input-icon">
                                <input type="password" class="form-control password" name="password" placeholder="Password">
                                <i class="fa fa-lock"></i>
                                <%  if (required_pass_error != null) {
                                        out.print(required_pass_error);
                                    }

                                %>
                            </span>

                        </div>
                        <div class="form-actions">

                            <button type="submit" class="btn btn-bricky pull-right">
                                Login <i class="fa fa-arrow-circle-right"></i>
                            </button>
                        </div>

                    </fieldset>
                </form>
            </div>

            <!-- start: COPYRIGHT -->
            <div class="copyright">
&copy  <script type="text/javascript">
                var cur = 2015; 
        var year = new Date(); 
        if(cur == year.getFullYear()) year = year.getFullYear(); 
        else year = cur + ' - ' + year.getFullYear()
        ; document.write(year);</script>  Vortexstring Limited. All right reserved            </div>
            <!-- end: COPYRIGHT -->
        </div>


    </body>
</html>
