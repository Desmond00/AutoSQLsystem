package fileOperation;


import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import au.com.bytecode.opencsv.CSVReader;
import java.util.*;
import java.sql.*; 

import connect.Connect;
import stringPreProcessing.*;
public class CSVtoTable {  
		private final static Logger logger = LoggerFactory.getLogger("CSVtoTable.class");
		private final static alterCharacters alterCharacters = new alterCharacters();
		static int totalCellNo;
		
		public static LinkedHashMap getColumnNames(String filePath) {
			LinkedHashMap<String, String> LHmap = new LinkedHashMap<String, String>();
			try {
				CSVReader reader = new CSVReader(new FileReader(filePath));
				String[] columnNames = reader.readNext();
				totalCellNo = columnNames.length;
				for(int i=0;i<columnNames.length; ++i) 
					columnNames[i] = alterCharacters.removeSpecialCharactersFromFirst(columnNames[i].replaceAll("[ .-]","_"));
				String[] firstRowValues = reader.readNext();
				logger.info("Getting {} column names",totalCellNo);
				for(int i=0;i < firstRowValues.length;++i) {
					if(alterCharacters.isNumeric(firstRowValues[i]))
						LHmap.put(columnNames[i], "number(38)");
					else
						LHmap.put(columnNames[i], "varchar2(3000)");
				}
				logger.info("column names received");
				reader.close();
			}
			catch(java.io.FileNotFoundException e) {
				logger.info("file not found in specified path");
			}
			catch(Exception e) {}
			return LHmap;
		}
		
		public static int createTable(int tableID, String tableName, String filePath) {
			try {
				Connection con = new Connect().c();
				LinkedHashMap<String, String> columnNames= getColumnNames(filePath);
				String creationQuery = "create table "+tableName+tableID+" (";
				for (Map.Entry<String, String> entry : columnNames.entrySet()) {
					String columnName = entry.getKey();
					String columnType = entry.getValue();
					creationQuery += columnName + " " + columnType + ",";
				}
				creationQuery = creationQuery.substring(0, creationQuery.length()-1)+")";
				System.out.println(creationQuery);
				PreparedStatement ps = con.prepareStatement(creationQuery);
				int updateResult = ps.executeUpdate();
				con.close();
				if(updateResult == 0) {
					System.out.println(tableName+" created successfully");
					return 1;
				}
				else
				{
					System.out.println("table creation error");
					return 0;			
				}
			}
			catch(Exception e) {
				System.out.println(e);
			}
			return 0;
		}
		
		
		public static int insertIntoTable(int tableID, String tableName, String filePath) {
			try {
				Connection con = new Connect().c();
				PreparedStatement insertionStatement = null;
				String insertionQuery = "INSERT INTO "+tableName+tableID
						+ " VALUES(";
				for(int index = 0; index<totalCellNo-1; index++)
					insertionQuery += "?,";
				insertionQuery += "?)";
				insertionStatement = con.prepareStatement(insertionQuery);
				/* We should now load CSV rows and loop through them*/
				CSVReader reader = new CSVReader(new FileReader(filePath));
                /* Variables to loop through the CSV File */
                String [] row; /* for every line in the file */            
//                logger.info("total rows {}",reader.readNext().length);	
                int lnNum = 0; /* line number */
                row = reader.readNext();
                while ((row = reader.readNext()) != null) {
                	int cellIndex = 1;
                	for(String columnValue : row) {
                		if (alterCharacters.isNumeric(columnValue) == true)
                			insertionStatement.setDouble(cellIndex, Double.parseDouble(columnValue));
                		else
                			insertionStatement.setString(cellIndex, columnValue);
                		cellIndex += 1;
                	}
                	if(insertionStatement.executeUpdate() <= 0)
                		return 0;
                }               
				logger.info("records inserted successfully");
				/*Close input stream*/
				reader.close();
                /* Close prepared statement */
				insertionStatement.close();
                /* COMMIT transaction */
                con.commit();
                /* Close connection */
                con.close();
			}
			catch(Exception e) {
				logger.info(e.toString());	
			}
			return 1;
		}
}