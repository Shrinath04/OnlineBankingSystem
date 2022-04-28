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

@WebServlet(urlPatterns = {"/addFriend"})
public class addFriend extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            HttpSession session = request.getSession();
            String accountNo = (String) session.getAttribute("accountNo");

            String friendAccNo = request.getParameter("friendAccNo");

            Connection connect;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/giftcardsystem", "a", "a");

            //checking whether your friend account is there in the bank
            PreparedStatement st = connect.prepareStatement("SELECT * FROM A.BANK where ACCOUNT_NO='" + friendAccNo + "'");
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                st = connect.prepareStatement("SELECT * FROM A.FRIENDS where ACCOUNT_NO='" + accountNo + "'");
                rs = st.executeQuery();

                if (rs.next()) {
                    if (rs.getString(3).equals(friendAccNo)) {
                        request.setAttribute("addFriendErr", "alreadyAdded");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    } else if (rs.getString(4).equals(friendAccNo)) {
                        request.setAttribute("addFriendErr", "alreadyAdded");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    } else if (rs.getString(5).equals(friendAccNo)) {
                        request.setAttribute("addFriendErr", "alreadyAdded");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    } else if (rs.getString(6).equals(friendAccNo)) {
                        request.setAttribute("addFriendErr", "alreadyAdded");
                        request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                    } else {
                        if (rs.getString(3).equals("0")) {
                            st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_1 ='" + friendAccNo + "' where ACCOUNT_NO='" + accountNo + "'");
                            st.executeUpdate();
                            request.setAttribute("addFriendErr", "success");
                            request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                        } else if (rs.getString(4).equals("0")) {
                            st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_2 ='" + friendAccNo + "' where ACCOUNT_NO='" + accountNo + "'");
                            st.executeUpdate();
                            request.setAttribute("addFriendErr", "success");
                            request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                        } else if (rs.getString(5).equals("0")) {
                            st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_3 ='" + friendAccNo + "' where ACCOUNT_NO='" + accountNo + "'");
                            st.executeUpdate();
                            request.setAttribute("addFriendErr", "success");
                            request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                        } else if (rs.getString(6).equals("0")) {
                            st = connect.prepareStatement("UPDATE A.FRIENDS SET FRIEND_4 ='" + friendAccNo + "' where ACCOUNT_NO='" + accountNo + "'");
                            st.executeUpdate();
                            request.setAttribute("addFriendErr", "success");
                            request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                        } else {
                            request.setAttribute("addFriendErr", "full");
                            request.getRequestDispatcher("netBanking.jsp").forward(request, response);
                        }
                    }
                }
            } else {
                request.setAttribute("addFriendErr", "invalid");
                request.getRequestDispatcher("netBanking.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(addFriend.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(addFriend.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
