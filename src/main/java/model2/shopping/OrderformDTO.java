package model2.shopping;

public class OrderformDTO {
	private String order_idx; //주문번호
	private String idx; //상품 일련번호
	private String order_name; //주문자 이름
	private String order_postcode; //주문자의 우편번호
	private String order_basicadd; //주문자의 기본주소
	private String order_detailadd; //주문자의 상세주소
	private String order_phone_num; //주문자의 핸드폰번호
	
	private String order_email; //주문자의 이메일
	private String deliv_name; //배송받는 사람 이름
	private String deliv_postcode; //배송받는 사람의 우편번호
	private String deliv_basicadd; //배송받는 사람의 기본주소
	private String deliv_detailadd; //배송받는 사람의 상세주소
	private String deliv_phone_num; //배송받는 사람의 핸드폰 번호
	private String deliv_email; //배송받는 사람의 이메일 주소
	
	private String id; //주문자의 아이디
	private String message; //배송메세지
	private String payment; //결제방법
	
	public String getOrder_idx() {
		return order_idx;
	}
	public String getIdx() {
		return idx;
	}
	public String getOrder_name() {
		return order_name;
	}
	public String getOrder_postcode() {
		return order_postcode;
	}
	public String getOrder_basicadd() {
		return order_basicadd;
	}
	public String getOrder_detailadd() {
		return order_detailadd;
	}
	public String getOrder_phone_num() {
		return order_phone_num;
	}
	public String getOrder_email() {
		return order_email;
	}
	public String getDeliv_name() {
		return deliv_name;
	}
	public String getDeliv_postcode() {
		return deliv_postcode;
	}
	public String getDeliv_basicadd() {
		return deliv_basicadd;
	}
	public String getDeliv_detailadd() {
		return deliv_detailadd;
	}
	public String getDeliv_phone_num() {
		return deliv_phone_num;
	}
	public String getDeliv_email() {
		return deliv_email;
	}
	public String getId() {
		return id;
	}
	public String getMessage() {
		return message;
	}
	public String getPayment() {
		return payment;
	}
	public void setOrder_idx(String order_idx) {
		this.order_idx = order_idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public void setOrder_postcode(String order_postcode) {
		this.order_postcode = order_postcode;
	}
	public void setOrder_basicadd(String order_basicadd) {
		this.order_basicadd = order_basicadd;
	}
	public void setOrder_detailadd(String order_detailadd) {
		this.order_detailadd = order_detailadd;
	}
	public void setOrder_phone_num(String order_phone_num) {
		this.order_phone_num = order_phone_num;
	}
	public void setOrder_email(String order_email) {
		this.order_email = order_email;
	}
	public void setDeliv_name(String deliv_name) {
		this.deliv_name = deliv_name;
	}
	public void setDeliv_postcode(String deliv_postcode) {
		this.deliv_postcode = deliv_postcode;
	}
	public void setDeliv_basicadd(String deliv_basicadd) {
		this.deliv_basicadd = deliv_basicadd;
	}
	public void setDeliv_detailadd(String deliv_detailadd) {
		this.deliv_detailadd = deliv_detailadd;
	}
	public void setDeliv_phone_num(String deliv_phone_num) {
		this.deliv_phone_num = deliv_phone_num;
	}
	public void setDeliv_email(String deliv_email) {
		this.deliv_email = deliv_email;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
}
