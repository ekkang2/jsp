package bank;

public class CustomerVO {


	private String c_no;
	private String c_name;
	private int c_dist;
	private String c_phone;
	private String c_addr;
	
	public String getC_no() {
		return c_no;
	}
	public void setC_no(String c_no) {
		this.c_no = c_no;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public int getC_dist() {
		return c_dist;
	}
	public void setC_dist(int c_dist) {
		this.c_dist = c_dist;
	}
	public String getC_phone() {
		return c_phone;
	}
	public void setC_phone(String c_phone) {
		this.c_phone = c_phone;
	}
	public String getC_addr() {
		return c_addr;
	}
	public void setC_addr(String c_addr) {
		this.c_addr = c_addr;
	}
	
	@Override
	public String toString() {
		return "CustomerVO [c_no=" + c_no + ", c_name=" + c_name + ", c_dist=" + c_dist + ", c_phone=" + c_phone
				+ ", c_addr=" + c_addr + "]";
	}
	
}
