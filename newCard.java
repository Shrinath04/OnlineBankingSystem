//java servlet program for getting new card.
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

@WebServlet(urlPatterns = {"/newCard"})
public class newCard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(true);
            String accountNo = (String) session.getAttribute("accountNo");

            int giftCardAmt = Integer.parseInt(request.getParameter("giftCardAmt"));

            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");

            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.USERS where ACCOUNT_NO='" + accountNo + "'");
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                int balance = Integer.parseInt(rs.getString(4));
                if (balance >= giftCardAmt) {
                    String cardNo = String.valueOf((int) ((Math.random() * (999999 - 100000)) + 100000));
                    String cardPin = String.valueOf((int) ((Math.random() * (9999 - 1000)) + 1000));
                    String cardAmt = request.getParameter("giftCardAmt");
                    st = connect.prepareStatement("INSERT INTO A.GIFTCARDS VALUES (?,?,?,?)");
                    st.setString(1, accountNo);
                    st.setString(2, cardNo);
                    st.setString(3, cardAmt);
                    st.setString(4, cardPin);
                    st.executeUpdate();
                    balance -= giftCardAmt;

                    st = connect.prepareStatement("UPDATE A.USERS SET BALANCE ='" + String.valueOf(balance) + "' WHERE ACCOUNT_NO='" + accountNo + "'");
                    st.executeUpdate();

                    st = connect.prepareStatement("UPDATE A.BANK SET BALANCE ='" + String.valueOf(balance) + "' WHERE ACCOUNT_NO='" + accountNo + "'");
                    st.executeUpdate();

                    request.setAttribute("newCardErr", "success");
                    request.setAttribute("newCardNo", cardNo);
                    request.setAttribute("newCardPin", cardPin);
                    request.getRequestDispatcher("giftcards.jsp").forward(request, response);
                } else {
                    request.setAttribute("newCardErr", "lowBalance");
                    request.getRequestDispatcher("giftcards.jsp").forward(request, response);
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(newCard.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(newCard.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
