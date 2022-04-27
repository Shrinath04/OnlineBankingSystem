<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Purchase</title>
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
            .purchase-form{
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
                white-space: nowrap;
                position: absolute;
                margin-left: 20px;
                margin-top: 75px;
            }
            .heading{
                position:absolute;
                color:#F9F6EE;
                margin-left: 85px;
                margin-top:50px;
                
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
                    <a class="navbar-brand" href="purchase.jsp"><b><i class="fa-solid fa-building-columns"></i>&nbsp;ABC Banking<b></a>
                </div>
                <ul class="nav navbar-nav">
                    <li style="font-weight: bold;" id="time"></li>
                    &nbsp;&nbsp;
                </ul>
            </div>
        </nav>
        <section class="container-fluid bg">
            <section class="row justify-content-center">
                <section class="col-12 col-sm-6 col-md-3">
                    <h1 class="heading">Purchase</h1>
                    <form class="purchase-form" action="purchase" method="post">
                        <div class="form-group">
                            <label for="cardNumber">Card Number: </label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" required>
                        </div>
                        <div class="form-group">
                            <label for="cardPin">Card Pin: </label>
                            <input type="password" class="form-control" id="cardPin" name="cardPin" required>
                        </div>
                        <div class="form-group">
                            <label for="purchaseAmt">Enter the amount you want to spend:</label>
                            <input type="text" class="form-control" id="purchaseAmt" name="purchaseAmt" required>
                        </div>
                        <button type="submit" class="btn btn-success">Purchase</button><br><br>
                        <%
                            String error = (String) request.getAttribute("purchaseErr");
                            if (error != null) {
                                if (error.equals("success")) {
                                    request.setAttribute("purchaseErr", "nil");
                        %>
                        <h6 style="color:#0BDA51;text-align:center;font-weight: bold;">Purchase Successful!</h6>
                        <%
                        } else if (error.equals("lowBalance")) {
                            request.setAttribute("blockCardErr", "nil");
                        %>
                        <h6 style="color:#FF3131;text-align:center;font-weight: bold;">Low Balance!</h6>
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