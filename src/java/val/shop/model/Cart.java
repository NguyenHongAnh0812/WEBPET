package val.shop.model;

public class Cart extends Product{
	private int cartId;
	private int pid,uid;
	private int c_quantity;
	private String date;
	

	

	public Cart() {
	}

    public Cart(int cartId, int pid, int uid, int c_quantity, String date) {
        this.cartId = cartId;
        this.pid = pid;
        this.uid = uid;
        this.c_quantity = c_quantity;
        this.date = date;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
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

    public int getC_quantity() {
        return c_quantity;
    }

    public void setC_quantity(int c_quantity) {
        this.c_quantity = c_quantity;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    


	
	
}
