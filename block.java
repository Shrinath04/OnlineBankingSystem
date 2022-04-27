//java servlet program for blocking the card
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/block"})
public class block extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cardNumber = request.getParameter("cardNumber");
        request.setAttribute("cardNumber", cardNumber);
        HttpSession session = request.getSession();
        session.setAttribute("cardNumber", cardNumber);
        request.getRequestDispatcher("blockCard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String accountNo = (String)session.getAttribute("accountNo");
            String cardNumber = (String)session.getAttribute("cardNumber");
            String password = (String)session.getAttribute("password");
            session.removeAttribute("cardNumber");
            String inputPassword = request.getParameter("password");
            inputPassword = encrypt(inputPassword);
            if(!(password.equals(inputPassword))){
                request.setAttribute("blockCardErr", "notFound");
                request.getRequestDispatcher("blockCard.jsp").forward(request, response);
            }
            else{
            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");
            
            PreparedStatement st = connect.prepareStatement("SELECT * FROM GIFTCARDS WHERE CARD_NO='" + cardNumber + "'");
            ResultSet rs = st.executeQuery();
            String strCardBalance = "";
            if(rs.next()){
                strCardBalance = rs.getString(3);
            }
            int cardBalance = Integer.parseInt(strCardBalance);
            st = connect.prepareStatement("SELECT * FROM A.BANK WHERE ACCOUNT_NO='" + accountNo + "'");
            rs = st.executeQuery();
            if(rs.next()){
                int balance = Integer.parseInt(rs.getString(4));
                balance+=cardBalance;
                st = connect.prepareStatement("UPDATE A.BANK SET BALANCE ='"+balance+"' WHERE ACCOUNT_NO='" + accountNo + "'");
                st.executeUpdate();
                st = connect.prepareStatement("UPDATE A.USERS SET BALANCE ='"+balance+"' WHERE ACCOUNT_NO='" + accountNo + "'");
                st.executeUpdate();
            }
            st = connect.prepareStatement("DELETE FROM GIFTCARDS WHERE CARD_NO='" + cardNumber + "'");
            if (st.executeUpdate() == 1) {
                request.setAttribute("blockCardErr", "success");
                request.getRequestDispatcher("blockCard.jsp").forward(request, response);
            }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(block.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(block.class.getName()).log(Level.SEVERE, null, ex);
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
