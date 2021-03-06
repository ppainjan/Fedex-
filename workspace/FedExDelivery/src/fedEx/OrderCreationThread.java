package fedEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Random;

public class OrderCreationThread extends Thread{
	
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
	
	
	public void run(){
		
		Connection con = getDbConnection(); 
		
		String query = "INSERT INTO fed_ex.orders(Service,weight,dimensions,signature_service,total_pieces,"
				+ "packaging,special_handeling_section,order_shortest_travel,order_status) VALUES(?,?,?,?,?,?,?,?,?)";
		
		PreparedStatement st;
		int trackingId = 0;
		for(int i=0;i<40;i++){
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
				
				st = con.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
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
					st1.setInt(2, sCityId);
					st1.setString(3, "Received");
					st1.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
					
					st1.executeUpdate();
					st1.close();
				}
				catch(SQLException se){
					se.printStackTrace();
				}
				
			}
		}
		
		try{
			con.close();
		}
		catch(SQLException se){
			se.printStackTrace();
		}
		
	}

}
