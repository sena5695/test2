package com.one.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.util.CellReference;

public class GetExcelColumnName {

	public static String getName(Cell cell, int cellIndex) {
		int cellNum = 0;
		if(cell != null) {
			cellNum = cell.getColumnIndex();
		}else {
			cellNum = cellIndex;
		}
		
		return CellReference.convertNumToColString(cellNum);
	}
	
	public static String getValue(Cell cell) {
		String value = "";
		if(cell == null) value = "";
		System.out.println(cell);
		if(cell != null) {
			switch(cell.getCellType()) {
			case FORMULA:
				value = cell.getCellFormula();
				break;
			case NUMERIC:
				if(DateUtil.isCellDateFormatted(cell)) {
					SimpleDateFormat sdf = new SimpleDateFormat();
					value = sdf.format(cell.getDateCellValue());
					
					//DataFormatter formatter = new DataFormatter();
					//value = formatter.formatCellValue(cell);
					
				}else {
					value = String.valueOf(cell.getNumericCellValue());
				}
				value = cell.getNumericCellValue() + "";
				break;
			case STRING:
				value = cell.getStringCellValue();
				break;
			case BOOLEAN:
				value = cell.getBooleanCellValue() + "";
				break;
			case ERROR:
				value = cell.getErrorCellValue()+"";
				break;
			case BLANK:
				value = "";
				break;
			default:
				value = cell.getStringCellValue();
			}
		}else {
			value = "";
		}
		
		return value;
	}
}
