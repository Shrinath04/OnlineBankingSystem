<%@ page language="java" import = "java.sql.*" import = "java.util.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!--HTML page for Giftcards -->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">         
        <title>GiftCards</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/442d40b03c.js" crossorigin="anonymous"></script>
        <style>
            /*Common background for all pages*/
            .bg{
                background: #00094B no-repeat;
                width: 80%;
                height: 90vh;
                margin-left: 304px;
                background-size: 200%;
                font: bold 14px/1.4 'Open Sans', arial, sans-serif;
                overflow-y: hidden;
            }

            .side-btn-div{
                position: absolute;
                width: 20%;
                height: 90vh;
                margin-top: 0px;
                background-color: #232023;
                border-right:2px solid rgb(222, 209, 209);
            }
            
            .side-buttons{
                margin-top: 150px;
                margin-left: 30px;
            }
            
            .si-button{
                width: 220px;
                height: 80px;
                margin-top: 15px;
                background-color: #28a745;
                border-radius: 5px;
                box-shadow: inset 0 0 0 0 #f42424;
                transition: ease-out 0.3s;
                outline: none;
                font-size: 20px;
                font-weight: bold;
                color: black;
                filter: brightness(120%);
            }
            
            .si-button:hover{
                filter: brightness(140%);
                color: black;
            }
            
            .do-button{
                position: absolute;
                width: 160px;
                height: 50px;
                background-color: #ffc107;
                border-radius: 5px;
                outline: none;
                font-size: 20px;
                font-weight: bold;
                color: black;
                margin-left: 500px;
                margin-top: 300px;
            }
            
            .do-button:hover{
                background-color: #ff5100;
                color: white;
            }
            
            .button{
                width: 150px;
                margin-top: 10px;
            }

            .button-down{
                width: 150px;
                margin-left: 10px;
            }
            .cust-btn-down{
                position: absolute;
                margin-top: 350px;
                margin-left: 400px;
            }

            table{
                display: block;
                max-height: 255px;
                width: 700px;
                overflow-y: auto;
                overflow-x: hidden;
                border: 2px solid #000000;
                border-collapse: collapse;
                position: absolute;
                margin-left: 250px;
                margin-top: 20px;
                background-color: rgb(237, 225, 227);
            }

            #th-fix{
                position: sticky;
                top: 0;
                background-color: rgb(238, 75, 75);
                color: #000;
                width: 250px;
            }
            
            #th-fix-icon{
                position: sticky;
                border: 1px solid black;
                top: 0;
                background-color: rgb(238, 75, 75);
                color: #000;
                width: 89px;
            }

            td,th{
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
                color: black;
                font-size: 20px;
                height: 50px;
            }
            
            .topup-btn{
                background-color: #28a745;
                border-radius: 3px;
            }
            
            .deleteCard-btn{
                background-color: #dc3545;
                border-radius: 3px;
                color: #353935;
            }
            
            .Topup-form{
                position: absolute;
                margin-top: 350px;
                margin-left: 450px;
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px 0px #000; 
            }
            
            .buy-card-div{
                visibility: hidden;
            }
            
            .buy-card-div-active{
                visibility: visible !important;
            }
            
            .login-form{
                height: 170px;
                position: absolute;
                margin-top: 370px;
                margin-left: 450px;
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px 0px #000; 
            }
            
            .form-close{
                position:absolute;
                /*margin-top: 340px;
                margin-left: 695px;*/
                margin-top: -10px;
                margin-left: 200px;
                background-color: red;
                border-radius: 5px;
            }
            
            .buy-card-message{
                height: 100px;
                width: 300px;
                margin-top: 380px;
                background-color: white;
                margin-left: 450px;
            }
            
            .msg-close{
                position:absolute;
                margin-top: -30px;
                margin-left: 270px;
                background-color: red;
                border-radius: 5px;
            }

            h1{
                color:#F9F6EE;
                margin-top:15px;
                white-space: nowrap;
                text-align: center;
            }

            @media only screen and (max-width: 678px){
                .bg{
                    background-size: 300%;
                }
            }
            
            .active{
                filter: brightness(100%);
                color: white;
            }
            .logout-btn{
                background-color: red;
                border-radius: 5px;
                color: white;
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
            function welcomeFunc() {
                location.href = "welcome.jsp";
            }
            function giftcardsFunc() {
                location.href = "giftcards.jsp";
            }
            function netBankingFunc() {
                location.href = "netBanking.jsp";
            }
            function newCardFunc() {
                location.href = "newCard.jsp";
            }
            function purchaseFunc() {
                location.href = "purchase.jsp";
            }
            function topupFunc() {
                location.href = "topup.jsp";
            }
            function blockCardFunc() {
                location.href = "blockCard.jsp";
            }
            function showFormFunc(){
                var element = document.getElementById("buy-card-btn");
                element.classList.add("active");
                var element = document.getElementById("buy-card-form");
                element.classList.add("buy-card-div-active");
            }
            function closeFormFunc(){
                var element = document.getElementById("buy-card-form");
                element.classList.remove("buy-card-div-active");
                var element = document.getElementById("buy-card-btn");
                element.classList.remove("active");
            }
        </script>
    </head>
    <body>
        <%
                        try {
                            String accountNo = (String) session.getAttribute("accountNo");
                            Connection connect;
                            Class.forName("org.apache.derby.jdbc.ClientDriver");
                            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");
                            
                            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.USERS where ACCOUNT_NO='" + accountNo + "'");
                            ResultSet rs = st.executeQuery();
                            String name = null;
                            if(rs.next()){
                                name = rs.getString(2);
                            }
                            
                            String cardNoArr[] = new String[1000];
                            String cardAmtArr[] = new String[1000];
                            st = connect.prepareStatement("SELECT * FROM A.GIFTCARDS where ACCOUNT_NO='" + accountNo + "'");
                            rs = st.executeQuery();
                            int flag = 0;
                            int r = 0;
                            while (rs.next()) {
                                cardNoArr[r] = rs.getString(2);
                                cardAmtArr[r] = rs.getString(3);
                                r++;
                                flag = 1;
                            }
                    %>
        <nav class="navbar navbar-expand-sm">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="giftcards.jsp"><b><i class="fa-solid fa-building-columns"></i>&nbsp;ABC Banking<b></a>
                </div>
                <p><b>Logged in: <%=name%><b></p>
                <ul class="nav navbar-nav">
                    <li style="font-weight: bold;" id="time"></li>
                    &nbsp;&nbsp;
                    <form action="logout" method="post"  <input type="hidden"><button class="logout-btn"><i class="fa-solid fa-xmark"></i>&nbsp;Logout</button></form>
                </ul>
            </div>
        </nav>
        <div class="side-btn-div btn-group-lg">
            <div class="side-buttons">
            <button class="si-button" onclick="welcomeFunc()"><i class="fa-solid fa-building-columns"></i>&nbsp;Account Details</button><br>
            <button class="si-button active" onclick="giftcardsFunc()"><i class="fa-solid fa-gift"></i>&nbsp;Gift cards</button><br>
            <button class="si-button" onclick="netBankingFunc()"><i class="fa-solid fa-money-check-dollar"></i>&nbsp;Net Banking</button>
            </div>    
        </div>
        <section class="container-fluid bg">
            <section class="row justify-content-center">
                <section class="col-12 col-sm-6 col-md-3">
                    <h1>Available Giftcards</h1>
                </section>
            </section>

            <div class="table-div">
                <table bordercolor="black">
                    <tr>
                        <th id="th-fix">Giftcard Number</th>
                        <th id="th-fix">Card Balance</th>
                        <th id="th-fix-icon">Top-Up</th>
                        <th id="th-fix-icon">Block</th>
                    </tr>
                    <%
                            int i=0;
                            while(i<r){
                    %>
                    <tr>
                        <td><%= cardNoArr[i]%></td>
                        <td><%= cardAmtArr[i]%></td>
                        <td><form method = "get" action = "topup"><input type="hidden" name="cardNumber" value="<%=cardNoArr[i] %>"><button class="topup-btn"><i class="fa-solid fa-indian-rupee-sign"></i></button></form></td>
                        <td><form method="get" action="block" ><input type="hidden" name = "cardNumber" value="<%=cardNoArr[i]%>"><button class="deleteCard-btn"><i class="fa-solid fa-trash-can"></i></button></form></td>
                        <%i++;%>
                    </tr>
                    <%
                    }
                        if (flag == 0) {
                    %>
                    <tr>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {

                        }
                    %>
                </table>
            </div>
                
                <button class="do-button" onclick="showFormFunc()" id="buy-card-btn"><i class="fa-solid fa-bag-shopping"></i>&nbsp;Buy Card</button>
                
                <div class="buy-card-div" id="buy-card-form">
                <form class="login-form" action="newCard" method="post">
                    <button class="form-close" onclick="closeFormFunc()"><i class="fa-solid fa-xmark"></i></button>
                        <div class="form-group">
                            <label for="giftCardAmt">Gift Card amount: </label>
                            <input type="text" class="form-control" id="giftCardAmt" name="giftCardAmt" required>
                        </div>
                        <button type="submit" class="btn btn-success">Buy</button><br><br>
                </form> 
            </div>
                <%
                            String error = (String) request.getAttribute("newCardErr");
                            if (error != null) {
                                if (error.equals("success")) {
                                    request.setAttribute("newCardErr", "nil");
                                    String cardNo = (String) request.getAttribute("newCardNo");
                                    String cardPin = (String) request.getAttribute("newCardPin");
                        %>
                        <div class="buy-card-message">
                            <form action="closeMsg" method="post"><input type="hidden" name="msg" value="buyCard"><button class="msg-close"><i class="fa-solid fa-xmark"></i></button></form>
                        <h6 style="color:#0BDA51;text-align:center;font-weight: bold; padding-top: 10px;">New Card Generated</h6>
                        <h6 style="color:black;text-align:center;font-weight: bold;">Card Number: <%=cardNo%></h6>
                        <h6 style="color:black;text-align:center;font-weight: bold;">Card Pin: <%=cardPin%></h6>
                        <%
                        } else if (error.equals("lowBalance")) {
                            request.setAttribute("blockCardErr", "nil");
                        %>
                        <h6 style="color:#FF3131;text-align:center;font-weight: bold;">Low balance in your bank!</h6>
                        <%
                        } else if (error.equals("notFound")) {
                            request.setAttribute("blockCardErr", "nil");
                        %>
                        <h6 style="color:#FF3131;text-align:center;font-weight: bold;">Invalid Credentials!</h6>
                        </div>
                        <%
                                }
                            }
                        %>
        </section>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>