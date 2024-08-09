package bank;

public class AccountVO {

	private String a_no;
	private String a_item_dist;
	private String a_item_name;
	private String a_c_no;
	private String a_balance;
	private String a_open_date;
	
	public String getA_no() {
		return a_no;
	}
	public void setA_no(String a_no) {
		this.a_no = a_no;
	}
	public String getA_item_dist() {
		return a_item_dist;
	}
	public void setA_item_dist(String a_item_dist) {
		this.a_item_dist = a_item_dist;
	}
	public String getA_item_name() {
		return a_item_name;
	}
	public void setA_item_name(String a_item_name) {
		this.a_item_name = a_item_name;
	}
	public String getA_c_no() {
		return a_c_no;
	}
	public void setA_c_no(String a_c_no) {
		this.a_c_no = a_c_no;
	}
	public String getA_balance() {
		return a_balance;
	}
	public void setA_balance(String a_balance) {
		this.a_balance = a_balance;
	}
	public String getA_open_date() {
		return a_open_date;
	}
	public void setA_open_date(String a_open_date) {
		this.a_open_date = a_open_date;
	}
	
	@Override
	public String toString() {
		return "AccountVO [a_no=" + a_no + ", a_item_dist=" + a_item_dist + ", a_item_name=" + a_item_name + ", a_c_no="
				+ a_c_no + ", a_balance=" + a_balance + ", a_open_date=" + a_open_date + "]";
	}
	
}
