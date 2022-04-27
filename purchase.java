//java servlet program for purchasing things

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

@WebServlet(urlPatterns = {"/purchase"})
public class purchase extends HttpServlet {

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
            String cardNumber = request.getParameter("cardNumber");
            String cardPin = request.getParameter("cardPin");
            int purchaseAmt = Integer.parseInt(request.getParameter("purchaseAmt"));

            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");

            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.GIFTCARDS where CARD_NO='" + cardNumber + "' and CARD_PIN='" + cardPin + "'");
            ResultSet rs = (ResultSet) st.executeQuery();
            if (rs.next()) {
                int cardAmt = Integer.parseInt(rs.getString(3));

                if (cardAmt >= purchaseAmt) {
                    cardAmt -= purchaseAmt;

                    st = connect.prepareStatement("UPDATE A.GIFTCARDS SET CARD_AMT ='" + String.valueOf(cardAmt) + "' WHERE CARD_NO='" + cardNumber + "' and CARD_PIN='" + cardPin + "'");
                    st.executeUpdate();

                    request.setAttribute("purchaseErr", "success");
                    request.getRequestDispatcher("purchase.jsp").forward(request, response);
                } else {
                    request.setAttribute("purchaseErr", "lowBalance");
                    request.getRequestDispatcher("purchase.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("purchaseErr", "notFound");
                request.getRequestDispatcher("purchase.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(purchase.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(purchase.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
