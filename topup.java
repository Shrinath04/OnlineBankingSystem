//java servlet program for topping up the giftcard
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

@WebServlet(urlPatterns = {"/topup"})
public class topup extends HttpServlet {

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
        request.getRequestDispatcher("topup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String cardNumber = (String)session.getAttribute("cardNumber");
            session.removeAttribute("cardNumber");
            int topupAmt = Integer.parseInt(request.getParameter("topupAmt"));

            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");

            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.GIFTCARDS where CARD_NO='" + cardNumber + "'");
            ResultSet rs = (ResultSet) st.executeQuery();

            if (rs.next()) {
                String accountNo = rs.getString(1);
                int cardAmt = Integer.parseInt(rs.getString(3));

                st = connect.prepareStatement("SELECT * FROM A.USERS where ACCOUNT_NO='" + accountNo + "'");
                rs = st.executeQuery();
                if (rs.next()) {
                    int balance = Integer.parseInt(rs.getString(4));

                    if (balance >= topupAmt) {
                        cardAmt += topupAmt;
                        balance -= topupAmt;

                        st = connect.prepareStatement("UPDATE A.GIFTCARDS SET CARD_AMT ='" + String.valueOf(cardAmt) + "' WHERE CARD_NO='" + cardNumber + "'");
                        st.executeUpdate();
                        st = connect.prepareStatement("UPDATE A.USERS SET BALANCE ='" + String.valueOf(balance) + "' WHERE ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();
                        st = connect.prepareStatement("UPDATE A.BANK SET BALANCE ='" + String.valueOf(balance) + "' WHERE ACCOUNT_NO='" + accountNo + "'");
                        st.executeUpdate();

                        request.setAttribute("topupErr", "success");
                        request.getRequestDispatcher("topup.jsp").forward(request, response);

                    } else {
                        request.setAttribute("topupErr", "lowBalance");
                        request.getRequestDispatcher("topup.jsp").forward(request, response);
                    }
                }
            } else {
                request.setAttribute("topupErr", "notFound");
                request.getRequestDispatcher("topup.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(topup.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(topup.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
