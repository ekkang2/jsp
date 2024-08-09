package sub1;

public class Account {

	private String bank;
	private String accId;
	private String name;
	private int balance;
	
	public Account(String bank, String accId, String name, int balance) {
		super();
		this.bank = bank;
		this.accId = accId;
		this.name = name;
		this.balance = balance;
	}

	@Override
	public String toString() {
		return "Account [bank=" + bank + ", accId=" + accId + ", name=" + name + ", balance=" + balance + "]";
	}
	
	
	
}
