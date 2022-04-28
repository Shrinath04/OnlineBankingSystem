<!--HTML page for index-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/442d40b03c.js" crossorigin="anonymous"></script>
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
            
            .down-buttons{
                position: absolute;
                margin-top: 350px;
                margin-left: 610px;
            }
            
            .down-btn{
                margin-left: 20px;
            }
            
            .down-btn:hover{
                height: 50px;
                width: 130px;
                filter: brightness(120%);
                color: black;
                font-weight: bold;
            }

            @media only screen and (max-width: 678px){
                .bg{
                    background-size: 300%;
                }
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
            function newUserFunc(){
                location.href = "newUser.jsp";
            }
            function purchaseFunc(){
                location.href = "purchase.jsp";
            }
        </script>
    </head>
    <body>
        <!--<nav class="navbar navbar-expand-sm bg-light navbar-light">-->
        <nav class="navbar navbar-expand-sm cust-nav">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp"><b><i class="fa-solid fa-building-columns"></i>&nbsp;ABC Banking<b></a>
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
                    <h1 style="color:#F9F6EE;text-align:center;margin-top:80px;">Welcome!</h1>
                    <form class="login-form" action="login" method="post">
                        <div class="form-group">
                            <label for="accountNo">Bank Account Number: </label>
                            <input type="text" class="form-control" id="accountNo" name="accountNo">
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        <button type="submit" class="btn btn-primary">Login</button><br><br>
                        <%
                            String error = (String) request.getAttribute("loginError");
                            if (error != null) {
                                if (error.equals("err")) {
                                    request.setAttribute("loginError", "nil");
                        %>
                        <h6 style="color:red;text-align:center;font-weight: bold;">Invalid Credentials!</h6>
                        <%
                                }
                            }
                        %>
                    </form> 
                </section>
            </section>
                    <div class="down-buttons">
                        <button class=" btn btn-success down-btn" onclick="newUserFunc()"><i class="fa-solid fa-user"></i>&nbsp;New User?</button>
                        <button class=" btn btn-success down-btn" onclick="purchaseFunc()"><i class="fa-solid fa-cart-shopping"></i>&nbsp;Purchase</button>
                    </div>
        </section>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>