package val.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import val.shop.model.*;

public class OrderDao {

    private Connection con;

    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public OrderDao(Connection con) {
        super();
        this.con = con;
    }

    public boolean insertOrder(Order model) {
        boolean result = false;
        try {
            query = "insert into BTLWEB.orders (p_id, u_id, o_quantity, o_date, full_name,address,number_phone,status) values(?,?,?,?,?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, model.getId());
            pst.setInt(2, model.getUid());
            pst.setInt(3, model.getO_qunatity());
            pst.setString(4, model.getDate());
            pst.setString(5, model.getFull_name());
            pst.setString(6, model.getAddress());
            pst.setString(7, model.getNumber_phone());
            pst.setString(8, model.getStatus());
            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    public List<Order> userOrders(int id) {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from BTLWEB.orders where u_id=? order by orders.o_id desc";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setO_qunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getString("status"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }
    public List<Order> cpdOrders() {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from BTLWEB.orders where status= 'Chờ Phê Duyệt' ";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setO_qunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getString("status"));
                order.setFull_name(rs.getString("full_name"));
                order.setNumber_phone(rs.getString("number_phone"));
                order.setAddress(rs.getString("address"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }
    public List<Order> ddOrders() {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from BTLWEB.orders where status= 'Đã Duyệt' ";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setO_qunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getString("status"));
                order.setFull_name(rs.getString("full_name"));
                order.setNumber_phone(rs.getString("number_phone"));
                order.setAddress(rs.getString("address"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }
    public List<Order> tcOrders() {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from BTLWEB.orders where status= 'Từ Chối' ";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setO_qunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getString("status"));
                order.setFull_name(rs.getString("full_name"));
                order.setNumber_phone(rs.getString("number_phone"));
                order.setAddress(rs.getString("address"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }
    public void cancelOrder(int id) {
        //boolean result = false;
        try {
            query = "delete from BTLWEB.orders where o_id=?";
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

    public double monthOrders(int month) {
        List<Order> list = new ArrayList<>();
        double total=0;
        try {
            query = "SELECT * FROM BTLWEB.orders WHERE SUBSTRING(o_date, 6, 2) = ? and status = 'Đã Duyệt';";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, month);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setO_qunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getString("status"));
                list.add(order);
                total +=(product.getPrice() * rs.getInt("o_quantity"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return total;
    }
    
    public int monthQualityOrders(int month) {
        List<Order> list = new ArrayList<>();
        int total=0;
        try {
            query = "SELECT * FROM BTLWEB.orders WHERE SUBSTRING(o_date, 6, 2) = ? and status = 'Đã Duyệt';";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, month);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setO_qunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getString("status"));
                list.add(order);
                total +=(rs.getInt("o_quantity"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return total;
    }
    public void editOrder(String model,int id) {
        try {
            query = "UPDATE `BTLWEB`.`orders` SET `status` = ? WHERE (`o_id` = ?);";
            pst = this.con.prepareStatement(query);
            pst.setString(1, model);
            pst.setInt(2, id);
            pst.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
//UPDATE `BTLWEB`.`orders` SET `status` = 'Đã Duyệt' WHERE (`o_id` = '147');