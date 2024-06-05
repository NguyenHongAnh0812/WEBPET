package val.shop.dao;

import java.sql.*;
import val.shop.model.*;

public class UserDao {
	private Connection con;

	private String query;
    private PreparedStatement pst;
    private ResultSet rs;

	public UserDao(Connection con) {
		this.con = con;
	}
	
	public User userLogin(String email, String password) {
		User user = null;
        try {
            query = "select * from BTLWEB.users where email=? and password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if(rs.next()){
            	user = new User();
            	user.setId(rs.getInt("id"));
            	user.setEmail(rs.getString("email"));
                user.setFullname(rs.getString("fullname"));
            	user.setNumberphone(rs.getString("numberphone"));
                user.setDate(rs.getString("date"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return user;
    }
        public boolean checkEmail(String email) {
		User user = null;
        try {
            query = "select * from BTLWEB.users where email=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            rs = pst.executeQuery();
            if(rs.next()){
            	user = new User();
            	user.setId(rs.getInt("id"));
            	user.setEmail(rs.getString("email"));
                user.setFullname(rs.getString("fullname"));
            	user.setNumberphone(rs.getString("numberphone"));
                user.setDate(rs.getString("date"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        if(user !=null)return false;
        else return true;
    }
        public boolean checkNumber(String number) {
		User user = null;
        try {
            query = "select * from BTLWEB.users where numberphone=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, number);
            rs = pst.executeQuery();
            if(rs.next()){
            	user = new User();
            	user.setId(rs.getInt("id"));
            	user.setEmail(rs.getString("email"));
                user.setFullname(rs.getString("fullname"));
            	user.setNumberphone(rs.getString("numberphone"));
                user.setDate(rs.getString("date"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        if(user !=null)return false;
        else return true;
    }
        public void insertUser(User model) {
        try {
            query = "insert into BTLWEB.users (email, password, fullname, numberphone,date,address,role) values(?,?,?,?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setString(1, model.getEmail());
            pst.setString(2, model.getPassword());
            pst.setString(3, model.getFullname());
            pst.setString(4, model.getNumberphone());
            pst.setString(5, model.getDate());
            pst.setString(6, model.getAddress());
            pst.setString(7, model.getRole());
            pst.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
