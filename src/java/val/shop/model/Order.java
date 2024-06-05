package val.shop.model;

public class Order extends Product{
	private int orderId;
	private int pid,uid;
	private int o_qunatity;
	private String date,full_name,address,number_phone,status;
	
	public Order() {
	}

    public Order(int orderId, int pid, int uid, int o_qunatity, String date, String full_name, String address, String number_phone, String status) {
        this.orderId = orderId;
        this.pid = pid;
        this.uid = uid;
        this.o_qunatity = o_qunatity;
        this.date = date;
        this.full_name = full_name;
        this.address = address;
        this.number_phone = number_phone;
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getO_qunatity() {
        return o_qunatity;
    }

    public void setO_qunatity(int o_qunatity) {
        this.o_qunatity = o_qunatity;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNumber_phone() {
        return number_phone;
    }

    public void setNumber_phone(String number_phone) {
        this.number_phone = number_phone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   

    
	
	
}
