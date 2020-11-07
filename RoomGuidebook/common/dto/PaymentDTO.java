package dto;

public class PaymentDTO {
	int orderId;
	int amountSum;
	int paidAmount;
	boolean cancellationStatus;
	String progress;

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

}
