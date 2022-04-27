<%@ page language="java" import = "java.sql.*" import = "java.util.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!--HTML page for selecting which page to visit-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">         
        <title>Select Page</title>
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
            /*select a page styles*/
            .select-a-page{
                position: absolute;
                top: 10vh;
                right: 10%;
                background: #fff;
                width: 300px;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px 0px #000; 
            }
            
            .side-btn-div{
                position: absolute;
                width: 20%;
                height: 90vh;
                margin-top: 0px;
                background-color: #232023;
                border-right:2px solid rgb(222, 209, 209);
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
            .side-buttons{
                margin-top: 150px;
                margin-left: 30px;
            }
            .down-buttons{
                position: absolute;
                margin-top: 240px;
                margin-left: 500px;
            }
            .do-button{
                width: 180px;
                height: 70px;
                background-color: #ffc107;
                border-radius: 5px;
                outline: none;
                font-size: 20px;
                font-weight: bold;
                color: black;
            }
            
            .do-button:hover{
                background-color: #ff5100;
                color: white;
            }

            table{
                border: 2px solid #000000;
                border-collapse: collapse;
                background-color: rgb(237, 225, 227);
                position: absolute;
                margin-left: 200px;
                margin-top: 30px;
                width: 50%;
            }

            td,th{
                padding-left: 10px;
                height: 45px;
                border: 1px solid black;
                background-color: rgb(237, 225, 227);
                color: #000;
                font-size: 20px;
            }

            h1{
                color:#F9F6EE;
                margin-top:20px;
                white-space: nowrap;
                text-align: center;
            }
            
            .transac-table-div{
                visibility: hidden;
                position: absolute;
                margin-top: 50px;
            }
            .transac-table-div-active{
                visibility: visible !important;
            }
            .transaction-table{
                position: absolute;
                margin-top: 300px;
                margin-left: 200px;
                display: block;
                max-height: 200px;
                overflow-y: auto;
                overflow-x: hidden;
                border: 2px solid #000000;
                border-collapse: collapse;
                background-color: rgb(237, 225, 227);
                width: 760px;
            }
            
            #th-fix{
                position: sticky;
                top: 0;
                background-color: rgb(238, 75, 75);
                color: #000;
                text-align: center;
            }
            
            .tran-tab-td,.tran-tab-tr{
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
                width: 300px;
                color: black;
                font-size: 20px;
            }
            .tab-close{
                position:absolute;
                margin-top: 270px;
                margin-left: 930px;
                background-color: red;
                border-radius: 5px;
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
            function welcomeFunc() {
                location.href = "welcome.jsp";
            }
            function giftcardsFunc() {
                location.href = "giftcards.jsp";
            }
            function netBankingFunc() {
                location.href = "netBanking.jsp";
            }
            function showTransactionsFunc(){
                var element = document.getElementById("transaction-btn");
                element.classList.add("active");
                var element = document.getElementById("transac-div");
                element.classList.add("transac-table-div-active");
                
            }
            function closeTransacFunc(){
                var element = document.getElementById("transac-div");
                element.classList.remove("transac-table-div-active");
                var element = document.getElementById("transaction-btn");
                element.classList.remove("active");
            }
        </script>
    </head>
    <body>
        <%
            
                try {
                    String accountNo = (String) session.getAttribute("accountNo");
                    String password = (String) session.getAttribute("password");

                    Connection connect;
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");

                    PreparedStatement st = connect.prepareStatement("SELECT * FROM A.BANK where ACCOUNT_NO='" + accountNo + "'");
                    ResultSet rs = st.executeQuery();
                    
                    String balance = null;
                    String name = null;
                    String emailId = null;
                    if (rs.next()) {
                        name = rs.getString(2);
                        balance = rs.getString(4);
                        emailId = rs.getString(6);
                    }           
        %>
        <nav class="navbar navbar-expand-sm">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="welcome.jsp"><b><i class="fa-solid fa-building-columns"></i>&nbsp;ABC Banking<b></a>
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
            <button class="si-button active" onclick="welcomeFunc()"><i class="fa-solid fa-building-columns"></i>&nbsp;Account Details</button><br>
            <button class="si-button" onclick="giftcardsFunc()"><i class="fa-solid fa-gift"></i>&nbsp;Gift cards</button><br>
            <button class="si-button" onclick="netBankingFunc()"><i class="fa-solid fa-money-check-dollar"></i>&nbsp;Net Banking</button>
            </div>    
        </div>
        <section class="container-fluid bg">
            <section class="row justify-content-center">
                <section class="col-12 col-sm-6 col-md-3">
                    <h1>Welcome <%= name%>!</h1>
                </section>
            </section>

            <table>
                <tr>
                    <th>Name </th>
                    <td> &nbsp;<%= name%> </td>
                </tr>
                <tr>
                    <th>Account Number </th>
                    <td> &nbsp;<%= accountNo%> </td>
                </tr>
                <tr>
                    <th>Balance </th>
                    <td> &nbsp;&#8377 <%= balance%> </td>
                </tr>
                <tr>
                    <th>Email id</th>
                    <td> &nbsp;<%= emailId%></td>
                </tr>
            </table>

            <%
                }
                catch (Exception e) {

                }
            %>
            
            <div class="down-buttons">
                <button class="do-button" onclick="showTransactionsFunc()" id="transaction-btn"><i class="fa-solid fa-money-bill-transfer" ></i>&nbsp;Transactions</button>
            </div>
            <div class="transac-table-div" id="transac-div">
                <h4 style="position:absolute; color:#F9F6EE;margin-top:270px;margin-left: 480px;white-space: nowrap;"><b>Your Transactions</b></h4>
                <button class="tab-close" onclick="closeTransacFunc()"><i class="fa-solid fa-xmark"></i></button>
            <table class="transaction-table">
                <tr>
                    <th id="th-fix">Sender</th>
                    <th id="th-fix">Receiver</th>
                    <th id="th-fix">Amount</th>
                    <th id="th-fix">Time</th>
                    <th id="th-fix">Date</th>
                </tr>
            
            <%
                try {
                    Connection connect;
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");
                    String accountNo = (String) session.getAttribute("accountNo");
                    String password = (String) session.getAttribute("password");
                    PreparedStatement st = connect.prepareStatement("SELECT * FROM A.TRANSACTIONS where SENDER='" + accountNo + "' OR RECEIVER='" + accountNo + "'");
                    ResultSet rs = st.executeQuery();
                    int flag=0;
                    while (rs.next()) {
                        flag=1;
                        String sender = rs.getString(1);
                        String receiver = rs.getString(2);
                        String amount = rs.getString(3);
                        String time = rs.getString(4);
                        String date = rs.getString(5);
            %>
            <tr class="tran-tab-tr">
                    <td class="tran-tab-td"><%= sender%></td>
                    <td class="tran-tab-td"><%= receiver%></td>
                    <td class="tran-tab-td"><%= amount%></td>
                    <td class="tran-tab-td"><%= time%></td>
                    <td class="tran-tab-td"><%= date%></td>
                </tr>
                <%
                    }
                if(flag==0){
                    %>
                    <tr class="tran-tab-tr">
                    <td class="tran-tab-td">--</td>
                    <td class="tran-tab-td">--</td>
                    <td class="tran-tab-td">--</td>
                    <td class="tran-tab-td">--</td>
                    <td class="tran-tab-td">--</td>
                </tr>
                    
                <%
                }
                    } catch (Exception e) {

                    }
                %>
            </table><br>
            </div>
        </section>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>