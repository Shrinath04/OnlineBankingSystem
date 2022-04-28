import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import static java.sql.JDBCType.NULL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/removeFriend"})
public class removeFriend extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String friendAccNo = request.getParameter("friendAccNo");
        request.setAttribute("friendAccNo", friendAccNo);
        HttpSession session = request.getSession();
        session.setAttribute("friendAccNo", friendAccNo);
        request.getRequestDispatcher("removeFriend.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String accountNo = (String) session.getAttribute("accountNo");
            String password = (String) session.getAttribute("password");
            String inputPassword = request.getParameter("password");
            inputPassword = encrypt(inputPassword);
            if(password.equals(inputPassword)){
            String friendAccNo = (String) session.getAttribute("friendAccNo");

            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");

            //checking whether your friend account is there in the bank
            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.BANK where ACCOUNT_NO='" + friendAccNo + "'");
            ResultSet rs = st.executeQuery();
            String zero = "0";
            if (rs.next()) {
                st = connect.prepareStatement("SELECT * FROM A.FRIENDS where ACCOUNT_NO='" + accountNo + "'");
                rs = st.executeQuery();

                if (rs.next()) {
                    if (rs.getString(3).equals(friendAccNo)) {
                        st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_1 ='" + zero + "' where ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();
                        request.setAttribute("removeFriendErr", "success");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    } else if (rs.getString(4).equals(friendAccNo)) {
                        st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_2 ='" + zero + "' where ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();
                        request.setAttribute("removeFriendErr", "success");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    } else if (rs.getString(5).equals(friendAccNo)) {
                        st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_3 ='" + zero + "' where ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();
                        request.setAttribute("removeFriendErr", "success");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    } else if (rs.getString(6).equals(friendAccNo)) {
                        st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_4 ='" + zero + "' where ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();
                        request.setAttribute("removeFriendErr", "success");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    }
                }
            } 
            }
            else {
                request.setAttribute("removeFriendErr", "invalid");
                request.getRequestDispatcher("removeFriend.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(addFriend.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(addFriend.class.getName()).log(Level.SEVERE, null, ex);
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
