package connect;
import java.sql.*;

public class Connect {
	Connection con = null;
	public Connection c()
	{
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection("jsbc:oracle:thin:@localhost:1521:XE","autosql","sql1234");
		}
		catch(Exception e)
		{
			
		}
		return con;
	}
}