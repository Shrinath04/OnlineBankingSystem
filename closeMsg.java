import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/closeMsg"})
public class closeMsg extends HttpServlet {

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
            String close = (String)request.getParameter("msg");
            if(close.equals("buyCard")){
                request.getRequestDispatcher("giftcards.jsp").forward(request, response);
            }
            else if(close.equals("topup")){
                request.getRequestDispatcher("giftcards.jsp").forward(request, response);
            }
            else if(close.equals("block")){
                request.getRequestDispatcher("giftcards.jsp").forward(request, response);
            }
            else if(close.equals("addFriend")){
                request.getRequestDispatcher("netBanking.jsp").forward(request, response);
            }
            else if(close.equals("sendMoney")){
                request.getRequestDispatcher("netBanking.jsp").forward(request, response);
            }
        }
    }
}
