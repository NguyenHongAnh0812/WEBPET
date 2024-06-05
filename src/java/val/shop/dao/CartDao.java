package val.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import val.shop.model.*;

public class CartDao {
	
	private Connection con;

	private String query;
    private PreparedStatement pst;
    private ResultSet rs;
    
    

	public CartDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insertCart(Cart model) {
        boolean result = false;
        try {
            query = "insert into BTLWEB.cart (p_id, u_id, c_quantity, c_date) values(?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, model.getPid());
            pst.setInt(2, model.getUid());
            pst.setInt(3, model.getC_quantity());
            pst.setString(4, model.getDate());
            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }
	

    public List<Cart> userCart(int id) {
        List<Cart> list = new ArrayList<>();
        try {
            query = "select * from BTLWEB.cart where u_id=? order by cart.c_id desc";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                cart.setCartId(rs.getInt("c_id"));
                cart.setId(pId);
                cart.setName(product.getName());
                cart.setCategory(product.getCategory());
                cart.setPrice(product.getPrice()*rs.getInt("c_quantity"));
                cart.setC_quantity(rs.getInt("c_quantity"));
                cart.setDate(rs.getString("c_date"));
                list.add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void cancelCart(int id) {
        //boolean result = false;
        try {
            query = "delete from BTLWEB.cart where p_id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            pst.execute();
            //result = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        //return result;
    }
    
    public void updateCart(int id,int k) {
        //boolean result = false;
        try {
            query = "UPDATE `BTLWEB`.`cart` SET `c_quantity` = ? WHERE (`p_id` = ?);";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, k);
            pst.setInt(2, id);
            pst.execute();
            //result = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        //return result;
    }
}
