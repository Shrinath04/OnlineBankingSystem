<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>NewUser Signup</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <style>

            /*Common background for all pages*/
            .bg{
                background: #00094B no-repeat;
                width: 100%;
                height: 93vh;
                background-size: 200%;
                font: bold 14px/1.4 'Open Sans', arial, sans-serif;
            }

            /*login page styles*/
            .login-form{
                position: absolute;
                top: 20vh;
                right: 10%;
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px 0px #000; 
            }

            @media only screen and (max-width: 678px){
                .bg{
                    background-size: 300%;
                }
            }
            .down-buttons{
                position: absolute;
                margin-top: 348px;
                margin-left: 730px;
            }
            
            .down-btn{
                margin-left: 20px;
            }
        </style>
        <script>
            var myVar = setInterval(function () {
                myTimer()
            }, 1);
            var counter = 0;
            function myTimer() {
                var date = new Date();
                document.getElementById("time").innerHTML = date.toLocaleTimeString();
            }
            
            function goBackFunc(){
                location.href = "index.jsp";
            }
        </script>
    </head>
    <body>
        <nav class="navbar navbar-expand-sm">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="newUser.jsp"><b><i class="fa-solid fa-building-columns"></i>&nbsp;ABC Banking<b></a>
                </div>
                <ul class="nav navbar-nav navbar-right">
                    <li style="font-weight: bold;" id="time"></li>
                    &nbsp;&nbsp;
                </ul>
            </div>
        </nav>
        <section class="container-fluid bg">
            <section class="row justify-content-center">
                <section class="col-12 col-sm-6 col-md-3">
                    <h1 style="color:#F9F6EE;text-align:center;margin-top:20px;">Welcome!</h1>
                    <!--<h6 style="text-align:center;"><font color="red"> ${error} </font></h6>-->
                    <form class="login-form" action="newuser" method="post">
                        <!--<div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>-->
                        <div class="form-group">
                            <label for="accountNumber">Bank Account Number</label>
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Your Email Id</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Create Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-success">SignUp</button><br><br>
                        <%
                            String error = (String) request.getAttribute("newUserErr");
                            if (error != null) {
                                if (error.equals("userRegistered")) {
                                    request.setAttribute("newCardErr", "nil");
                        %>
                        <h6 style="color:#FF3131;text-align:center;font-weight: bold;">User Already Registered!</h6>
                        <%
                        } else if (error.equals("success")) {
                            request.setAttribute("blockCardErr", "nil");
                        %>
                        <h6 style="color:#0BDA51;text-align:center;font-weight: bold;">New User Created!</h6>
                        <%
                        } else if (error.equals("notFound")) {
                            request.setAttribute("blockCardErr", "nil");
                        %>
                        <h6 style="color:#FF3131;text-align:center;font-weight: bold;">Invalid Credentials!</h6>
                        <%
                                }
                            }
                        %>
                    </form> 
                </section>
            </section>
                    <div class="down-buttons">
                        <button class=" btn btn-danger down-btn" onclick="goBackFunc()">Go Back</button>
                    </div>
        </section>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>