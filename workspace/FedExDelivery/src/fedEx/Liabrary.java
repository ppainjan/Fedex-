package fedEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class Liabrary {
	
	private Connection getDbConnection(){
 
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fed_ex?autoReconnect=true&useSSL=false","root","root");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}  
		return con;
	}
	
	public void createOrder(Map<String, String> orderData){
		
		Connection con  = getDbConnection();
		String query = "INSERT INTO fed_ex.orders(Service,weight,dimensions,signature_service,total_pieces,"
				+ "packaging,special_handeling_section,order_shortest_travel,order_status) VALUES(?,?,?,?,?,?,?,?,?)";
		PreparedStatement st;
		int trackingId = 0;
		try {
			
			st = con.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			st.setString(1, orderData.get("service").toString());
			st.setString(2, orderData.get("weight").toString());
			st.setString(3, orderData.get("dimensions").toString());
			st.setString(4, orderData.get("signature_service").toString());
			st.setInt(5, Integer.parseInt(orderData.get("total_pieces").toString()));
			st.setString(6, orderData.get("packaging").toString());
			st.setString(7, orderData.get("special_handeling_section").toString());
			
			int sCityId = getCityIdFromName(orderData.get("sourceCity").toString());
			int dcityId = getCityIdFromName(orderData.get("destinationCity").toString());
			String shortPath = new DijkstrasAlgorithm().dijkstrasAlgo(sCityId, dcityId);
			
			st.setString(8, shortPath);
			st.setString(9, "In Transit");
			
			st.executeUpdate();
			ResultSet rs = st.getGeneratedKeys();
			if(rs.next())
				trackingId = rs.getInt(1);
			
			rs.close();
			st.close();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(trackingId!=0){
			String queryTracking = "INSERT INTO fed_ex.order_tracking(tracking_id,city,city_status,tracking_date)VALUES(?,?,?,?)";
			PreparedStatement st1;
			try{
				st1= con.prepareStatement(queryTracking);
				st1.setInt(1, trackingId);
				st1.setInt(2, getCityIdFromName(orderData.get("sourceCity").toString()));
				st1.setString(3, "Received");
				st1.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
				
				st1.executeUpdate();
				st1.close();
				con.close();
			}
			catch(SQLException se){
				se.printStackTrace();
			}
			
		}
		
		
	}

	public void orderTracker(Map<String,String>trackingData){
		
		Connection con = getDbConnection();
		String query = "INSERT INTO fed_ex.order_tracking(tracking_id,city,city_status,tracking_date)VALUES(?,?,?,?)";
		
		
		
		try{
			PreparedStatement st = con.prepareStatement(query);
			st.setInt(1, Integer.parseInt(trackingData.get("tracking_id").toString()));
			st.setInt(2, getCityIdFromName(trackingData.get("city").toString()));
			st.setString(3, trackingData.get("curr_tracking_status").toString());
			st.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
		}
		catch(SQLException se){
			se.printStackTrace();
		}
	}
	
	public List<String> getOrderStatus(int trackingId){
		
		Connection con = getDbConnection();
		String query = "Select city,city_status,tracking_date from fed_ex.order_tracking where tracking_id = "+trackingId+" order by tracking_date desc";
		PreparedStatement st;
		ResultSet rs;
		List<String> trackingData = new ArrayList<String>();
		try{
			st = con.prepareStatement(query);
			rs = st.executeQuery();
			while(rs.next()){
				String track;
				track = getCityNameFromId(rs.getString(1))+"@"+rs.getString(2)+"@"+rs.getTimestamp(3);
				trackingData.add(track);
			}
			
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		return trackingData;
	}
	
	public String getOrderInfo(int trackingId){
		
		Connection con = getDbConnection();
		String query = "Select * from fed_ex.orders where tracking_id = "+trackingId;
		PreparedStatement st;
		ResultSet rs;
		String orderInfo = null;
		try{
			st = con.prepareStatement(query);
			rs = st.executeQuery();
			while(rs.next()){
				orderInfo = rs.getInt(1)+","+rs.getString(2)+","+rs.getString(3)+","+rs.getString(4)+","+rs.getString(5)+","+rs.getInt(6)+","
						+rs.getString(7)+","+rs.getString(8)+","+rs.getString(9)+","+rs.getString(10);
			}
			
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		System.out.println(orderInfo);
		return orderInfo;	
	}
	
	private int getCityIdFromName(String city){
		
		Connection con = getDbConnection();
		String query = "select city_id from cities where city_name = ?";
		int cityId = 0;
		try{
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, city);
			ResultSet rs = st.executeQuery();
			rs.next();
			cityId = rs.getInt(1);
		}
		catch(SQLException se){
			se.printStackTrace();
		}
		return cityId;
	}

	private String getCityNameFromId(String cityId){
		
		Connection con = getDbConnection();
		String query = "select city_name from cities where city_id = ?";
		String cityName = null;
		try{
			PreparedStatement st = con.prepareStatement(query);
			st.setInt(1, Integer.parseInt(cityId));
			ResultSet rs = st.executeQuery();
			rs.next();
			cityName = rs.getString(1);
		}
		catch(SQLException se){
			se.printStackTrace();
		}
		return cityName;
	}
	
	
	public void createOrderThread(){
		
		Connection con  = getDbConnection();
		String query = "INSERT INTO fed_ex.orders(Service,weight,dimensions,signature_service,total_pieces,"
				+ "packaging,special_handeling_section,order_shortest_travel,order_status) VALUES(?,?,?,?,?,?,?,?,?)";
		PreparedStatement st;
		
		Random r = new Random();
		int Low = 1;
		int High = 26;
		int sCityId = r.nextInt(High-Low) + Low;
		int dcityId = r.nextInt(High-Low) + Low;
		while(sCityId == dcityId){
			dcityId = r.nextInt(High-Low) + Low;
		}
		String shortPath = new DijkstrasAlgorithm().dijkstrasAlgo(sCityId, dcityId);
		
		try {
			
			st = con.prepareStatement(query);
			st.setString(1, "FedEx Home Delivery");
			st.setString(2, "2kgs");
			st.setString(3, "10x10x3cms");
			st.setString(4, "Direct Signature Required");
			st.setInt(5, 1);
			st.setString(6, "Package");
			st.setString(7, "Direct Signature Required");			
			st.setString(8, shortPath);
			st.setString(9, "In Transit");
			
			st.executeUpdate();
			st.close();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		/*if(trackingId!=0){
			String queryTracking = "INSERT INTO fed_ex.order_tracking(tracking_id,city,city_status,tracking_date)VALUES(?,?,?,?)";
			PreparedStatement st1;
			try{
				st1= con.prepareStatement(queryTracking);
				st1.setInt(1, trackingId);
				st1.setInt(2, sCityId);
				st1.setString(3, "Received");
				st1.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
				
				st1.executeUpdate();
				st1.close();
				con.close();
			}
			catch(SQLException se){
				se.printStackTrace();
			}
			
		}*/
		
		
	}
	
	
	
	
	
}
