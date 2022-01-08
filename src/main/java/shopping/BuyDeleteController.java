package shopping;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model2.shopping.ShoppingDAO;
import utils.JSFunction;

@WebServlet("/market/buydelete.do")
public class BuyDeleteController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		ShoppingDAO dao = new ShoppingDAO();
		
		String id = (String)session.getAttribute("user_id");
		String[] check = req.getParameterValues("product");
		
		if (check != null) {
			for (int i = 0; i < check.length; i++) {
				dao.deleteList(check[i], id);
			}
		}
		
		dao.close();
		
		resp.sendRedirect("buy.do?id=" + id);
	}
}
