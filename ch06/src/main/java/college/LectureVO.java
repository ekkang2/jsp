package college;

public class LectureVO {

	private int lecNo;
	private String lecName;
	private int lecCredit;
	private int lecTime;
	private String lecClass;
	
	public int getLecNo() {
		return lecNo;
	}
	public void setLecNo(int lecNo) {
		this.lecNo = lecNo;
	}
	public String getLecName() {
		return lecName;
	}
	public void setLecName(String lecName) {
		this.lecName = lecName;
	}
	public int getLecCredit() {
		return lecCredit;
	}
	public void setLecCredit(int lecCredit) {
		this.lecCredit = lecCredit;
	}
	public int getLecTime() {
		return lecTime;
	}
	public void setLecTime(int lecTime) {
		this.lecTime = lecTime;
	}
	public String getLecClass() {
		return lecClass;
	}
	public void setLecClass(String lecClass) {
		this.lecClass = lecClass;
	}
	
	@Override
	public String toString() {
		return "LectureVO [lecNo=" + lecNo + ", lecName=" + lecName + ", lecCredit=" + lecCredit + ", lecTime="
				+ lecTime + ", lecClass=" + lecClass + "]";
	}
	
}
