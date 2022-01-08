package model2.shopping;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.DBConnPool;
import smtp.NaverEmail;

public class ShoppingDAO extends DBConnPool {
	
	//검색 조건에 맞는 게시물의 개수를 반환한다.
	public int selectCount() {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM management";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	//상품 리스트 페이지 처리
	public List<ManagementDTO> selectListPage(Map<String, Object> map) {
		List<ManagementDTO> board = new Vector<ManagementDTO>();
		
		String query = " "
				+ "SELECT idx, img, name, price, point, exp FROM management ORDER BY idx DESC LIMIT ?, ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				ManagementDTO dto = new ManagementDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setImg(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setPoint(rs.getString(5));
				dto.setExp(rs.getString(6));
				
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return board;
	}
	
	public List<ManagementDTO> selectList() {
		List<ManagementDTO> board = new Vector<ManagementDTO>();
		
		String query = "SELECT idx, img, name, price, point FROM management ORDER BY idx DESC";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				ManagementDTO dto = new ManagementDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setImg(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setPoint(rs.getString(5));
				
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return board;
	}
	
	//주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환한다.
	public ManagementDTO selectView(String idx) {
		ManagementDTO dto = new ManagementDTO(); //DTO 객체 생성
		String query = "SELECT idx, img, name, price, point, exp FROM management WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if (rs.next()) { //결과를 DTO에 저장
				dto.setIdx(rs.getString(1));
				dto.setImg(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setPoint(rs.getString(5));
				dto.setExp(rs.getString(6));
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	//장바구니 테이블에 객체 저장
	public int insertBasket(BasketDTO dto) {
		int result = 0;
		
		String query = "INSERT INTO basket VALUES (?, ?, ?, ?, ?)";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getIdx());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getPrice());
			psmt.setString(4, dto.getCount());
			psmt.setInt(5, Integer.parseInt(dto.getPrice()) *
					Integer.parseInt(dto.getCount()));
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("장바구니에 삽입 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//장바구니 리스트 출력
	public List<BasketDTO> showBasketList(String id) {
		List<BasketDTO> list = new Vector<BasketDTO>();
		String query = "SELECT img, name, M.price, point, count, total, M.idx "
				+ "    		FROM management M INNER JOIN basket B "
				+ "    			ON M.idx = B.idx "
				+ "		 WHERE id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			while (rs.next()) { //결과를 DTO에 저장
				BasketDTO dto = new BasketDTO(); //DTO 객체 생성
				
				dto.setImg(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setPrice(rs.getString(3));
				dto.setPoint(rs.getString(4));
				dto.setCount(rs.getString(5));
				dto.setTotal(rs.getString(6));
				dto.setIdx(rs.getString(7));
				
				list.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("장바구니 가져오기 중 예외 발생");
			e.printStackTrace();
		}
		
		return list;
	}
	
	//아이디와 상품의 일련번호가 같을시 장바구니의 수량을 한개 증가
	public int updateCount(String idx, String id) {
		int result = 0;
		
		String query1 = "UPDATE basket SET count = count + 1 WHERE idx=? AND id=?";
		String query2 =	"UPDATE basket SET total = price * count WHERE idx=? AND id=?";
		
		try {
			psmt = con.prepareStatement(query1);
			psmt.setString(1, idx);
			psmt.setString(2, id);
			result = psmt.executeUpdate();
			if (result >= 1) {
				psmt = con.prepareStatement(query2);
				psmt.setString(1, idx);
				psmt.setString(2, id);
				result = psmt.executeUpdate();
			}
		}
		catch (Exception e) {
			System.out.println("장바구니 수량 증가 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//장바구니 수량 수정
	public int editBasket(String count, String idx, String id) {
		int result = 0;
		String query1 = "UPDATE basket SET count=? WHERE idx=? AND id=?";
		String query2 = "UPDATE basket SET total = price * count WHERE idx=? AND id=?";
		
		try {
			psmt = con.prepareStatement(query1);
			psmt.setString(1, count);
			psmt.setString(2, idx);
			psmt.setString(3, id);
			result = psmt.executeUpdate();
			if (result >= 1) {
				psmt = con.prepareStatement(query2);
				psmt.setString(1, idx);
				psmt.setString(2, id);
				result = psmt.executeUpdate();
			}
		}
		catch (Exception e) {
			System.out.println("장바구니 업데이트 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//장바구니 합계 금액 구하기
	public int basketTotal(String id) {
		int result = 0;
		
		String query = "SELECT total FROM basket WHERE id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				result += rs.getInt(1);
			}
		}
		catch (Exception e) {
			System.out.println("합계 금액을 구하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//장바구니 항목 삭제
	public void deleteList(String idx, String id) {
		String query = "DELETE FROM basket WHERE idx=? AND id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.setString(2, id);
			psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("장바구니 삭제 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	//구매목록 가져오기
	public List<BasketDTO> buyList(String id) {
		List<BasketDTO> list = new Vector<BasketDTO>();
		String query = "SELECT img, NAME, M.price, point, count, total, M.idx "
				+ " FROM management M INNER JOIN basket B " 
				+ " ON M.idx = B.idx " 
				+ " WHERE id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				BasketDTO dto = new BasketDTO(); //DTO 객체 생성
				
				dto.setImg(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setPrice(rs.getString(3));
				dto.setPoint(rs.getString(4));
				dto.setCount(rs.getString(5));
				dto.setTotal(rs.getString(6));
				dto.setIdx(rs.getString(7));
				
				list.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("구매목록을 가져오는 중 예외 발생");
			e.printStackTrace();
		}
		
		return list;
	}
	
	//주문자 정보 저장
	public int orderInfo(OrderformDTO dto) {
		int result = 0;
		
		String query = "INSERT INTO orderform (idx, order_name, order_postcode, "
				+ " order_basicadd, order_detailadd, order_phone_num, order_email, "
				+ " deliv_name, deliv_postcode, deliv_basicadd, deliv_detailadd, "
				+ " deliv_phone_num, deliv_email, id, message, payment) "
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getIdx());
			psmt.setString(2, dto.getOrder_name());
			psmt.setString(3, dto.getOrder_postcode());
			psmt.setString(4, dto.getOrder_basicadd());
			psmt.setString(5, dto.getOrder_detailadd());
			psmt.setString(6, dto.getOrder_phone_num());
			psmt.setString(7, dto.getOrder_email());
			psmt.setString(8, dto.getDeliv_name());
			psmt.setString(9, dto.getDeliv_postcode());
			psmt.setString(10, dto.getDeliv_basicadd());
			psmt.setString(11, dto.getDeliv_detailadd());
			psmt.setString(12, dto.getDeliv_phone_num());
			psmt.setString(13, dto.getDeliv_email());
			psmt.setString(14, dto.getId());
			psmt.setString(15, dto.getMessage());
			psmt.setString(16, dto.getPayment());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("주문자 정보를 저장 하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//상품 구매 후 장바구니 목록 삭제
	public void afterBuy(String idx, String id) {
		String query = "DELETE FROM basket WHERE idx=? AND id=?";
		String[] idxs = idx.split(" ");
		
		try {
			psmt = con.prepareStatement(query);
			for (int i = 0; i < idxs.length; i++) {
				psmt.setString(1, idxs[i]);
				psmt.setString(2, id);
				psmt.executeUpdate();
			}
		}
		catch (Exception e) {
			System.out.println("장바구니 목록 삭제 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	//이메일 보내기
	public void emailSend(OrderformDTO dto, ServletContext application) {
		Map<String, String> emailInfo1 = new HashMap<String, String>();
		Map<String, String> emailInfo2 = new HashMap<String, String>();
		
		String query = "SELECT name FROM management WHERE idx=?";
		String[] idxs = dto.getIdx().split(" ");
		String buyList = "";
		
		try {
			psmt = con.prepareStatement(query);
			
			for (int i = 0; i < idxs.length; i++) {
				psmt.setString(1, idxs[i]);
				rs = psmt.executeQuery();
				rs.next();
				
				if (i == idxs.length - 1) {
					buyList += rs.getString(1);
				}
				else {
					buyList += rs.getString(1) + ", ";
				}
			}
		}
		catch (Exception e) {
			System.out.println("주문자 정보를 가져오는 중 예외 발생");
			e.printStackTrace();
		}
		
		emailInfo1.put("from", "sonjy2717@naver.com");
		emailInfo1.put("to", dto.getOrder_email());
		emailInfo1.put("subject", "[마포구립장애인 직업재활센터] 상품구매 안내");
		
		emailInfo2.put("from", "sonjy2717@naver.com");
		emailInfo2.put("to", dto.getDeliv_email());
		emailInfo2.put("subject", "[마포구립장애인 직업재활센터] 상품구매 안내");
		
		String content
		= "<strong>["+ dto.getOrder_name() +"님의 상품구매 상세 내역]</strong><br><br>"
		+ "<strong>주문 상품 목록 : </strong>"+ buyList +"<br>"
		+ "<strong>주문자 정보 : </strong>"+ dto.getOrder_name() +"<br>"
		+ "<strong>주문자 휴대번호 : </strong>"+ dto.getOrder_phone_num() +"<br>"
		+ "<strong>주문자 이메일 : </strong>"+ dto.getOrder_email() +"<br><br><br>"
		+ "<strong>배송 받는 분 성함 : </strong>"+ dto.getDeliv_name() +"<br>"
		+ "<strong>배송지 주소(우편번호) : </strong>"+ dto.getDeliv_postcode() +"<br>"
		+ "<strong>배송지 주소(기본주소) : </strong>"+ dto.getDeliv_basicadd() +"<br>"
		+ "<strong>배송지 주소(상세주소) : </strong>"+ dto.getDeliv_detailadd() +"<br>"
		+ "<strong>배송 받는 분 휴대번호 : </strong>"+ dto.getDeliv_phone_num() +"<br>"
		+ "<strong>배송 받는 분 이메일 : </strong>"+ dto.getDeliv_email() +"<br>"
		+ "<strong>배송메세지 : </strong>"+ dto.getMessage() +"<br>";
		
		String htmlContent = "";
		try {
			String templatePath = application.getRealPath("/emailSend/BuyMailForm.html");
			BufferedReader br = new BufferedReader(new FileReader(templatePath));
			
			String oneLine;
			while ((oneLine = br.readLine()) != null) {
				htmlContent += oneLine +"\n";
			}
			br.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		htmlContent = htmlContent.replace("__CONTENT__", content);
		
		emailInfo1.put("content", htmlContent);
		emailInfo1.put("format", "text/html;charset=UTF-8");
		
		emailInfo2.put("content", htmlContent);
		emailInfo2.put("format", "text/html;charset=UTF-8");
		
		try {
			NaverEmail smtpServer = new NaverEmail();
			
			if (dto.getOrder_phone_num().equals(dto.getDeliv_phone_num())) {
				smtpServer.emailSending(emailInfo1);
			} 
			else {
				smtpServer.emailSending(emailInfo1);
				smtpServer.emailSending(emailInfo2);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
