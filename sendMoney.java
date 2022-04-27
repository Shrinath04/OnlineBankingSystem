//java servlet program for otp verification purpose
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;

@WebServlet(urlPatterns = {"/sendMoney"})
public class sendMoney extends HttpServlet {

    String otp = String.valueOf((int) ((Math.random() * (9999 - 1000)) + 1000));

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String accountNo = (String) session.getAttribute("accountNo");
            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");
            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.BANK where ACCOUNT_NO='" + accountNo + "'");
            ResultSet rs = st.executeQuery();
            String receiver = "";
            if (rs.next()) {
                receiver = rs.getString(6);
            }
            Mailing.sendMail(receiver, otp);

            String friendAccNo = request.getParameter("friendAccNo");
            request.setAttribute("friendAccNo", friendAccNo);
            session.setAttribute("friendAccNo", friendAccNo);
            request.getRequestDispatcher("otp.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(sendMoney.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(sendMoney.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(sendMoney.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(true);
            String accountNo = (String) session.getAttribute("accountNo");
            String receiverAccNo = (String) session.getAttribute("friendAccNo");
            String amount = request.getParameter("amount");
            String inputOtp = request.getParameter("otp");
            int money = Integer.parseInt(amount);
            int receiverBalance = 0;
            if (otp.equals(inputOtp)) {
                Connection connect;
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");
                PreparedStatement st = connect.prepareStatement("SELECT * FROM A.BANK where ACCOUNT_NO='" + accountNo + "'");
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    int balance = Integer.parseInt(rs.getString(4));
                    if (balance >= money) {
                        balance -= money;
                        st = connect.prepareStatement("SELECT * FROM A.BANK where ACCOUNT_NO='" + receiverAccNo + "'");
                        rs = st.executeQuery();
                        if (rs.next()) {
                            receiverBalance = Integer.parseInt(rs.getString(4));
                            receiverBalance += money;
                        }
                        st = connect.prepareStatement("UPDATE A.BANK SET BALANCE = '" + String.valueOf(balance) + "'WHERE ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();
                        st = connect.prepareStatement("UPDATE A.USERS SET BALANCE = '" + String.valueOf(balance) + "'WHERE ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();
                        st = connect.prepareStatement("UPDATE A.BANK SET BALANCE = '" + String.valueOf(receiverBalance) + "'WHERE ACCOUNT_NO='" + receiverAccNo + "'");
                        st.executeUpdate();
                        st = connect.prepareStatement("UPDATE A.USERS SET BALANCE = '" + String.valueOf(receiverBalance) + "'WHERE ACCOUNT_NO='" + receiverAccNo + "'");
                        st.executeUpdate();
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");// 
                        DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("HH:mm:ss");
                        LocalDateTime now = LocalDateTime.now();
                        String date = dtf.format(now);
                        String time = dtf2.format(now);
                        st = connect.prepareStatement("INSERT INTO A.TRANSACTIONS VALUES (?,?,?,?,?)");
                        st.setString(1, accountNo);
                        st.setString(2, receiverAccNo);
                        st.setString(3, amount);
                        st.setString(4, time);
                        st.setString(5, date);
                        st.executeUpdate();

                        request.setAttribute("sendMoneyErr", "success");
                        request.getRequestDispatcher("otp.jsp").forward(request, response);
                    } else {
                        request.setAttribute("sendMoneyErr", "lowBalance");
                        request.getRequestDispatcher("otp.jsp").forward(request, response);
                    }
                }
            } else {
                request.setAttribute("sendMoneyErr", "invalidOtp");
                request.getRequestDispatcher("otp.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(sendMoney.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(sendMoney.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static String encrypt(String pass) {

        String encryptedPass = "";

        for (int i = 0; i < pass.length(); i++) {
            if (pass.charAt(i) >= 'a' && pass.charAt(i) <= 'y') {
                String addChar = String.valueOf((Character.toChars(pass.charAt(i) + 1)));
                encryptedPass += addChar;
            } else if (pass.charAt(i) == 'z') {
                encryptedPass += 'a';
            } else if (pass.charAt(i) >= 'A' && pass.charAt(i) <= 'Y') {
                String addChar = String.valueOf((Character.toChars(pass.charAt(i) + 1)));
                encryptedPass += addChar;
            } else if (pass.charAt(i) == 'Z') {
                encryptedPass += 'A';
            } else if (pass.charAt(i) >= '0' && pass.charAt(i) <= '8') {
                String addChar = String.valueOf((Character.toChars(pass.charAt(i) + 1)));
                encryptedPass += addChar;
            } else if (pass.charAt(i) == '9') {
                encryptedPass += '0';
            }
        }
        return encryptedPass;
    }
}
