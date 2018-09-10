package fileOperation;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import au.com.bytecode.opencsv.CSVWriter;
import connect.*;
public class Download extends HttpServlet{
	private static Connection con = null;
	
	
	public static String downloadData(String query) {
		String filePath = "";
		try {
			con = new Connect().c();
			PreparedStatement selectQuery = con.prepareStatement(query);
			ResultSet rs = selectQuery.executeQuery();
			File file = new File("downloadableFiles/result.csv");
			filePath = file.getAbsolutePath();
			file.delete();
			CSVWriter writer = new CSVWriter(new FileWriter("webapps/AutoSQLsystem/downloadableFiles/result.csv"), ',');
			Boolean includeHeaders = true;
			writer.writeAll(rs, includeHeaders);
			System.out.println("file write successful");
			writer.close();			
		}
		catch(Exception e) {
			System.out.println("Exception in downloading data from SQL run\n"+e);
		}
		return filePath;
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		try {
			String query = req.getParameter("query");
			String downloadedFilePath = downloadData(query);
			PrintWriter pw = res.getWriter();
			pw.println(downloadedFilePath);			
		}
		catch(Exception e) {
			System.out.println("Exception during getting download file link of SQL result\n"+e);
		}
	}
}
