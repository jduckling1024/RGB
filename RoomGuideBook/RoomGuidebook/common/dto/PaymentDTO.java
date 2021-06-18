package dto;

public class PaymentDTO {
	int orderId;
	int amountSum;
	int paidAmount;
	boolean cancellationStatus;
	String progress;
	String name;
	String phoneNum;
	String address;
	String email;
	String paymentMethod;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getAmountSum() {
		return amountSum;
	}

	public void setAmountSum(int amountSum) {
		this.amountSum = amountSum;
	}

	public int getPaidAmount() {
		return paidAmount;
	}

	public void setPaidAmount(int paidAmount) {
		this.paidAmount = paidAmount;
	}

	public boolean isCancellationStatus() {
		return cancellationStatus;
	}

	public void setCancellationStatus(boolean cancellationStatus) {
		this.cancellationStatus = cancellationStatus;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getPaymentMethod() {
		// TODO Auto-generated method stub
		return paymentMethod;
	}
	
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

}
