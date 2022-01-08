package shopping;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model2.shopping.BasketDTO;
import model2.shopping.ShoppingDAO;
import utils.JSFunction;

@WebServlet("/market/basketedit.do")
public class BasketEditController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		ShoppingDAO dao = new ShoppingDAO();
		BasketDTO dto = new BasketDTO();
		
		String id = (String)session.getAttribute("user_id");
		String idx = req.getParameter("basket_idx");
		String count = req.getParameter("basket_count");
		
		dto.setIdx(idx);
		dto.setId(id);
		dto.setCount(count);
		
		int affted = dao.editBasket(count, idx, id);
		if (affted >= 1) {
			System.out.println("업데이트 성공");
		}
		else {
			System.out.println("업데이트 실패");
		}
		
		dao.close();
		
		resp.sendRedirect("basketedit.do?id=" + id);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		ShoppingDAO dao = new ShoppingDAO();
		
		String id = (String)session.getAttribute("user_id");
		
		List<BasketDTO> list = dao.showBasketList(id);
		
		int total = dao.basketTotal(id);
		dao.close();
		
		req.setAttribute("total", total);
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/market/basket.jsp").forward(req, resp);
	}
}
