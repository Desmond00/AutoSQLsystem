package user;
import connect.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.sql.*;

public class signupCheck {
	String email;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public int check()throws SQLException
	{
		Connect ob = new Connect();
		Connection con=ob.c();
		PreparedStatement ps = con.prepareStatement("select * from sqlusers where email=?");
		ps.setString(1,this.email);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			return 1;
		}
		else
			return 0;
	}
}
