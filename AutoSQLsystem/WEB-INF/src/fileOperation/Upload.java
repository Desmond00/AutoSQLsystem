package fileOperation;
import java.io.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
 
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connect.*;
import fileOperation.XLSToTable;
import fileOperation.XLSToTable;
import stringPreProcessing.alterCharacters;

public class Upload extends HttpServlet {
   
   private boolean isMultipart;
   private String filePath, email, fileName, fileFullPath;
   private int maxFileSize = 90000 * 1024;
   private int maxMemSize = 4 * 1024;
   private int tableID=0;
   private File file ;
   private Connection con=null;
   private final static Logger logger = LoggerFactory.getLogger("Upload.class");
   
   public void init( ) {
      // Get the file location where it would be stored.
      filePath = getServletContext().getInitParameter("file-upload"); 
      try {
    	  Connect ob = new Connect();
    	  con = ob.c();
    	  PreparedStatement ps = con.prepareStatement("select max(tableid) from uploadedtables");
    	  ResultSet rs = ps.executeQuery();
    	  rs.next();
    	  tableID = rs.getInt(1)+1;    	
      }
      catch(Exception e) {}
   }
   
   public int fileRecorded(HttpServletRequest request, String tableName) {
	   try {
		   //Picking up the maximum table id
		   System.out.println("maximmum table id : "+tableID);
		   
		   //Picking up the table name.
		   tableName = new alterCharacters().modifyForUpload(tableName);
		   System.out.println("tableName : "+tableName);
    	   
		   //Picking up the email of user
		   System.out.println("user email : "+email);
		   PreparedStatement insertionQuery = con.prepareStatement("insert into uploadedtables values(?,?,?)");
		   insertionQuery.setInt(1, tableID);
		   insertionQuery.setString(2, tableName);
		   insertionQuery.setString(3, email);
		   System.out.println("Query ready");
		   if (insertionQuery.executeUpdate() > 0)
			   return 1;
		   else
			   return 0;
	   }
       catch(SQLException e) {System.out.println(e);}
	   return 0;
   }
   
   public void setEmail(HttpServletRequest request) {
	   HttpSession session = request.getSession();
	   email = (String)session.getAttribute("email");
   }
   
   public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, java.io.IOException {
	   init();
      // Check that we have a file upload request
      isMultipart = ServletFileUpload.isMultipartContent(request);
      response.setContentType("text/html");
      java.io.PrintWriter out = response.getWriter( );
      this.setEmail(request);
      
      if( !isMultipart ) {
         out.println("<html>");	
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         out.println("<p>No file uploaded</p>"); 
         out.println("</body>");
         out.println("</html>");
         return;
      }
  
      DiskFileItemFactory factory = new DiskFileItemFactory();
   
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
   
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("D:\\J2EE\\!Tomcat\\webapps\\AutoSQLsystem\\uploadedFiles\\"+email+"\\"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
   
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );

      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
	
         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
   
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            	if ( !fi.isFormField () ) {
	               // Get the uploaded file parameters
	               String fieldName = fi.getFieldName();
	               fileName = fi.getName();
	               if(fileRecorded(request, fileName) == 1) {
	            	   String contentType = fi.getContentType();
	            	   boolean isInMemory = fi.isInMemory();
	            	   long sizeInBytes = fi.getSize();
	            	   
	            	   // Write the file
	            	   fileName = new alterCharacters().modifyForUpload(fileName);
	            	   if( fileName.lastIndexOf("\\") >= 0 ) {
	            		   file = new File( filePath + email + "\\" + fileName.substring( fileName.lastIndexOf("\\"))) ;
	            		   fileFullPath = file.getPath();
	            		   System.out.println(file.getPath());
	            	   } else {
	            		   file = new File( filePath + email + "\\" + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
	            		   fileFullPath = file.getPath();
	            		   System.out.println(file.getPath());
	            	   }
	            	   fi.write( file ) ;
	            	   logger.info("file uploaded successfully");
	            	   if(fileName.substring(fileName.lastIndexOf("."), fileName.length()).equals(".xls")) {
	            		   XLSToTable tableOperation = new XLSToTable();
	            		   if(tableOperation.createTable(tableID, fileName.substring(0, fileName.lastIndexOf(".")), fileFullPath) == 1) {
	            			   if(tableOperation.insertIntoTable(tableID, fileName.substring(0, fileName.lastIndexOf(".")), fileFullPath) == 1)
	            				   response.sendRedirect("uploadTable?message=document: " + fileName + " has been uploaded and saved<br>");
	            			   else
	            				   response.sendRedirect("uploadTable?message=error in document upload");
	            		   }
	            		   else {
	            			   response.sendRedirect("uploadTable?message=error in document upload");
	            		   }
	            	   }
	            	   else if(fileName.substring(fileName.lastIndexOf("."), fileName.length()).equals(".csv")) {
	            		   CSVtoTable tableOperation = new CSVtoTable();
	            		   if(tableOperation.createTable(tableID, fileName.substring(0, fileName.lastIndexOf(".")), fileFullPath) == 1) {
	            			   if(tableOperation.insertIntoTable(tableID, fileName.substring(0, fileName.lastIndexOf(".")), fileFullPath) == 1)
	            				   response.sendRedirect("uploadTable?message=document: " + fileName + " has been uploaded and saved<br>");
	            			   else
	            				   response.sendRedirect("uploadTable?message=error in document upload");
	            		   }
	            		   else {
	            			   response.sendRedirect("uploadTable?message=error in document upload");
	            		   }
	            	   }
	            	   else if(fileName.substring(fileName.lastIndexOf("."), fileName.length()).equals(".xlsx")) {
	            		   XLSXtoTable tableOperation = new XLSXtoTable();
	            		   if(tableOperation.createTable(tableID, fileName.substring(0, fileName.lastIndexOf(".")), fileFullPath) == 1) {
	            			   if(tableOperation.insertIntoTable(tableID, fileName.substring(0, fileName.lastIndexOf(".")), fileFullPath) == 1)
	            				   response.sendRedirect("uploadTable?message=document: " + fileName + " has been uploaded and saved<br>");
	            			   else
	            				   response.sendRedirect("uploadTable?message=error in document upload");
	            		   }
	            		   else {
	            			   response.sendRedirect("uploadTable?message=error in document upload");
	            		   }
	            	   }
	            	   else {
	            		   logger.info("document type {} not supported", fileName.substring(fileName.lastIndexOf("."), fileName.length()));
	            		   response.sendRedirect("uploadTable?message=document type"+ fileName.substring(fileName.lastIndexOf("."), fileName.length()) + "not supported<br>");
	            	   }
		            }
         	}
		            out.println("</body>");
		            out.println("</html>");
       }
      }
      catch(Exception ex) {            	   
        	response.sendRedirect("uploadTable?message="+ex.toString());
      }
      }
      
      public void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, java.io.IOException {

         throw new ServletException("GET method used with " +
            getClass( ).getName( )+": POST method required.");
      }
   }
