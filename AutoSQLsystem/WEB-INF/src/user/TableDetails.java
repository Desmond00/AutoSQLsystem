package user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

import connect.*;


public class TableDetails {
	
	private static Connection con=null;
	private static String email;
	
	public static LinkedHashMap<String, String> getCreatedTableList(String email) {
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		try {
			con = new Connect().c();
			System.out.println(email);
			PreparedStatement selectionQuery = con.prepareStatement("select tableID, tableName from createdtables where email=?");
			selectionQuery.setString(1,email);
			ResultSet rs = selectionQuery.executeQuery();
			while(rs.next()) {
				int tableID = rs.getInt(1);
				String tableName = rs.getString(2);
				map.put(Integer.toString(tableID), tableName);
			}
		}
		catch(Exception e) {System.out.println(e);}
		return map;			
	}
	
	
	public static LinkedHashMap<String, String> getUploadedTableList(String email) {
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		try {
			con = new Connect().c();
			System.out.println(email);
			PreparedStatement selectionQuery = con.prepareStatement("select tableID, table_Name from uploadedtables where user_email=?");
			selectionQuery.setString(1,email);
			ResultSet rs = selectionQuery.executeQuery();
			while(rs.next()) {
				int tableID = rs.getInt(1);
				String tableName = rs.getString(2);
				map.put(Integer.toString(tableID), tableName);
			}
		}
		catch(Exception e) {System.out.println(e);}
		return map;			
	}

}
