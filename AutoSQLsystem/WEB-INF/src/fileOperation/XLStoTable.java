package fileOperation;
import java.io.File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;




import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataFormatter;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import connect.*;
import stringPreProcessing.alterCharacters;


public class XLStoTable {
	
	private static int totalCellNo;
	private static final Logger logger = LoggerFactory.getLogger("XLStoTable.class");
	private static final HSSFDataFormatter fmt = new HSSFDataFormatter();

	private static LinkedHashMap getColumnNames(String filePath)  {
		LinkedHashMap<String, String> map =  new LinkedHashMap<String, String>(); //Create map
		try {
			/* We should now load excel objects and loop through the worksheet data */
			FileInputStream input_document = new FileInputStream(new File(filePath));
			/* Load workbook */
			HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document);
			/* Load worksheet */
			HSSFSheet sheet = my_xls_workbook.getSheetAt(0);
			Iterator<Row> rowIterator =  sheet.iterator();
			Row row1 = rowIterator.next();
			row1 = rowIterator.next();
			Iterator<Cell> cellIterator =  row1.cellIterator();
			HSSFRow row = sheet.getRow(0); //Get first row
			//following is boilerplate from the java doc
			short minColIx = row.getFirstCellNum(); //get the first column index for a row
			short maxColIx = row.getLastCellNum(); //get the last column index for a row
			totalCellNo = maxColIx;
			for(short colIx=minColIx; colIx<maxColIx; colIx++) { //loop from first to last index
				HSSFCell cell = row.getCell(colIx); //get the cell
				Cell cellType = cellIterator.next();
				String cellName = new alterCharacters().removeSpecialCharactersFromFirst(cell.getStringCellValue().replaceAll("[ .-]","_"));
				switch(cellType.getCellType()) {
					case HSSFCell.CELL_TYPE_STRING: //handle string columns
						map.put(cellName, "varchar2(3000)"); //add the cell contents (name of column) and cell type
	                    break;
					case HSSFCell.CELL_TYPE_NUMERIC: //handle double data
						if(HSSFDateUtil.isCellDateFormatted(row1.getCell(colIx)))
							map.put(cellName,  "date");
						else
							map.put(cellName, "number(38)");
	                    break;
				}	
			}
		}
		catch(IOException e) {}
		return map;
	}
	
	public static int createTable(int tableID, String tableName, String filePath) {
		try {
			LinkedHashMap<String, String> columnNames= getColumnNames(filePath);
			Connection con = new Connect().c();
			String creationQuery = "create table "+tableName+tableID+" (";
			for (Map.Entry<String, String> entry : columnNames.entrySet()) {
				String columnName = entry.getKey();
				String columnType = entry.getValue();
				columnName = columnName.replace(' ', '_');
				columnName = columnName.replace(".", "");
				creationQuery += columnName + " " + columnType + ",";
			}
			creationQuery = creationQuery.substring(0, creationQuery.length()-1)+")";
			logger.info(creationQuery);
			PreparedStatement ps = con.prepareStatement(creationQuery);
			int updateResult = ps.executeUpdate();
			con.close();
			if(updateResult == 0) {
				logger.info(tableName+" created successfully");
				return 1;
			}
			else
			{
				logger.info("table creation error");
				return 0;			
			}
		}
		catch(Exception e) {
			logger.info(e.toString());
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
			/* We should now load excel objects and loop through the worksheet data */
			FileInputStream input_document = new FileInputStream(new File(filePath));
			/* Load workbook */
			HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document);
			/* Load worksheet */
			HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0);
			// we loop through and insert data
			Iterator<Row> rowIterator = my_worksheet.iterator(); 
			Row row = rowIterator.next();
			while(rowIterator.hasNext()) {
				int cellIndex=1;
				row = rowIterator.next();
				Iterator<Cell> cellIterator = row.cellIterator();
				while(cellIterator.hasNext()) {
					Cell cell = cellIterator.next();
					switch(cell.getCellType()) { 
					case Cell.CELL_TYPE_STRING: //handle string columns
						insertionStatement.setString(cellIndex, fmt.formatCellValue(cell));
						break;
					case Cell.CELL_TYPE_NUMERIC: //handle double and date
						if(HSSFDateUtil.isCellDateFormatted(row.getCell(cellIndex-1))) {
//							logger.info(cell.getDateCellValue().toString());
							java.sql.Date dateValue = new java.sql.Date(cell.getDateCellValue().getTime());
//							logger.info("{}",dateValue);
							insertionStatement.setDate(cellIndex, dateValue);
						}
						else
							insertionStatement.setDouble(cellIndex,Double.parseDouble(fmt.formatCellValue(cell)) );
						break;
					}
					cellIndex += 1;
				}
				//we can execute the statement before reading the next row
				if(insertionStatement.executeUpdate() <= 0)
					return 0;
			}
			logger.info("records inserted successfully");
			/* Close input stream */
			input_document.close();
			/* Close prepared statement */
			insertionStatement.close();
			/* COMMIT transaction */
			con.commit();
			/* Close connection */
			con.close();			
		}
		catch(Exception e) {
			logger.info("{}",e);
			return 0;
		}
		return 1;
	}
}
