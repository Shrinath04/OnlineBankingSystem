//java servlet program for login validation
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/login"})
public class login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");
            String accountNo = request.getParameter("accountNo");
            String password = request.getParameter("password");
            password = encrypt(password);
            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.USERS where ACCOUNT_NO='" + accountNo + "' and PASSWORD='" + password + "'");
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                //String name = rs.getString(2);
                //String balance = rs.getString(4);
                //String emailId = rs.getString(6);
                HttpSession session = request.getSession(true);
                //session.setAttribute("name", name);
                //session.setAttribute("balance", balance);
                session.setAttribute("accountNo", accountNo);
                //session.setAttribute("emailId", emailId);
                session.setAttribute("password", password);
                request.getRequestDispatcher("welcome.jsp").forward(request, response);
            } else {
                request.setAttribute("loginError", "err");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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
