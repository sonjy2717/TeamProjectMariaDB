package shopping;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model2.shopping.OrderformDTO;
import model2.shopping.ShoppingDAO;
import utils.JSFunction;

@WebServlet("/market/order.do")
public class OrderController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext application = getServletContext();
		HttpSession session = req.getSession();
		ShoppingDAO dao = new ShoppingDAO();
		OrderformDTO dto = new OrderformDTO();
		
		String idx = "";
		String deliv_name = "";
		String deliv_postcode = "";
		String deliv_basicadd1 = "";
		String deliv_basicadd2 = "";
		String deliv_detailadd = "";
		String deliv_phone1 = "";
		String deliv_phone2 = "";
		String deliv_phone3 = "";
		String deliv_email1 = "";
		String deliv_email2 = "";
		
		String message = req.getParameter("message");
		String payment = req.getParameter("payment");
		String yesno = req.getParameter("yesno");
		
		if (yesno == null) yesno = "no";
		if (message == null) message = "없음";
		
		String id = (String)session.getAttribute("user_id");
		String[] idxs = req.getParameterValues("idx");
		
		String order_name = req.getParameter("name");
		String order_postcode = req.getParameter("postcode");
		String order_basicadd1 = req.getParameter("basicadd1");
		String order_basicadd2 = req.getParameter("basicadd2");
		String order_detailadd = req.getParameter("detailadd");
		String order_phone1 = req.getParameter("phone1");
		String order_phone2 = req.getParameter("phone2");
		String order_phone3 = req.getParameter("phone3");
		String order_email1 = req.getParameter("email1");
		String order_email2 = req.getParameter("email2");
		
		for (int i = 0; i < idxs.length; i++) {
			if (i == idxs.length - 1) {
				idx += idxs[i];
			}
			else {
				idx += idxs[i] + " ";
			}
		}
		
		if (yesno.equals("yes")) {
			//주문자와 배송지의 정보가 같음
			deliv_name = order_name;
			deliv_postcode = order_postcode;
			deliv_basicadd1 = order_basicadd1;
			deliv_basicadd2 = order_basicadd2;
			deliv_detailadd = order_detailadd;
			deliv_phone1 = order_phone1;
			deliv_phone2 = order_phone2;
			deliv_phone3 = order_phone3;
			deliv_email1 = order_email1;
			deliv_email2 = order_email2;
		}
		else if (yesno.equals("no")) {
			//주문자와 배송지의 정보가 다름
			deliv_name = req.getParameter("name_");
			deliv_postcode = req.getParameter("postcode_");
			deliv_basicadd1 = req.getParameter("basicadd1_");
			deliv_basicadd2 = req.getParameter("basicadd2_");
			deliv_detailadd = req.getParameter("detailadd_");
			deliv_phone1 = req.getParameter("phone1_");
			deliv_phone2 = req.getParameter("phone2_");
			deliv_phone3 = req.getParameter("phone3_");
			deliv_email1 = req.getParameter("email1_");
			deliv_email2 = req.getParameter("email2_");
		}
		
		String order_basicadd = order_basicadd1 + order_basicadd2;
		String order_phone_num = order_phone1 + "-" + order_phone2 + "-" + order_phone3;
		String order_email = order_email1 + "@" + order_email2;
		
		String deliv_basicadd = deliv_basicadd1 + deliv_basicadd2;
		String deliv_phone_num = deliv_phone1 + "-" + deliv_phone2 + "-" + deliv_phone3;
		String deliv_email = deliv_email1 + "@" + deliv_email2;
		
		dto.setIdx(idx);
		dto.setId(id);
		dto.setMessage(message);
		dto.setPayment(payment);
		if (yesno.equals("yes")) {
			dto.setOrder_name(order_name);
			dto.setOrder_postcode(order_postcode);
			dto.setOrder_basicadd(order_basicadd);
			dto.setOrder_detailadd(order_detailadd);
			dto.setOrder_phone_num(order_phone_num);
			dto.setOrder_email(order_email);
			dto.setDeliv_name(order_name);
			dto.setDeliv_postcode(order_postcode);
			dto.setDeliv_basicadd(order_basicadd);
			dto.setDeliv_detailadd(order_detailadd);
			dto.setDeliv_phone_num(order_phone_num);
			dto.setDeliv_email(order_email);
		}
		else if (yesno.equals("no")) {
			dto.setOrder_name(order_name);
			dto.setOrder_postcode(order_postcode);
			dto.setOrder_basicadd(order_basicadd);
			dto.setOrder_detailadd(order_detailadd);
			dto.setOrder_phone_num(order_phone_num);
			dto.setOrder_email(order_email);
			dto.setDeliv_name(deliv_name);
			dto.setDeliv_postcode(deliv_postcode);
			dto.setDeliv_basicadd(deliv_basicadd);
			dto.setDeliv_detailadd(deliv_detailadd);
			dto.setDeliv_phone_num(deliv_phone_num);
			dto.setDeliv_email(deliv_email);
		}
		
		int insert = dao.orderInfo(dto);
		
		//폼값 확인용
//		for (int i = 0; i < idx.length; i++) {
//			System.out.print(idx[i] + " ");
//		}
//		System.out.println("\n" + order_name);
//		System.out.println(order_postcode);
//		System.out.println(order_basicadd);
//		System.out.println(order_detailadd);
//		System.out.println(order_phone_num);
//		System.out.println(order_email);
//		System.out.println(name);
//		System.out.println(postcode);
//		System.out.println(deliv_basicadd);
//		System.out.println(detailadd);
//		System.out.println(deliv_phone_num);
//		System.out.println(deliv_email);
//		System.out.println(idx);
		
		if (insert >= 1) {
			System.out.println("정보 저장 성공");
			dao.emailSend(dto, application);
			dao.afterBuy(idx, id);
			JSFunction.alertLocation(resp, "상품구매가 완료되었습니다.", "../main/main.do");
		}
		else {
			System.out.println("정보 저장 실패");
			JSFunction.alertBack(resp, "상품구매에 실패했습니다.");
		}
	}
}
