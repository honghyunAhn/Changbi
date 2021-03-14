package forFaith.poi;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import forFaith.file.FileInfo;
import forFaith.file.FileInfoImpl;

/**
 * @Class Name : PoiControl.java
 * @Description : POI 를 이용한 excel 처리기
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

public class PoiControl {

	private Workbook workbook = null;

	public PoiControl() {}

	public PoiControl(String pathname) {
		try {
			FileInfo fileInfo = new FileInfoImpl(pathname);

			if(fileInfo.getExt().equals("xlsx")) {
				// excel 2007
				this.workbook = new XSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			} else {
				// excel 97-2003
				this.workbook = new HSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			}
		} catch (Exception e) {
		}
	}

	public PoiControl(File file) {
		try {
			FileInfo fileInfo = new FileInfoImpl(file);

			if(fileInfo.getExt().equals("xlsx")) {
			    // excel 2007
				this.workbook = new XSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			} else {
			    // excel 97-2003
				this.workbook = new HSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			}
		} catch (Exception e) {
		}
	}

	public PoiControl(FileInfo fileInfo) {
		try {
			if(fileInfo.getExt().equals("xlsx")) {
			    // excel 2007
				this.workbook = new XSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			} else {
			    // excel 97-2003
				this.workbook = new HSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			}
		} catch (Exception e) {
		}
	}

	public void setWorkbook(String pathname) {
		try {
			FileInfo fileInfo = new FileInfoImpl(pathname);

			if(fileInfo.getExt().equals("xlsx")) {
			    // excel 2007
				this.workbook = new XSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			} else {
			    // excel 97-2003
				this.workbook = new HSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			}
		} catch (Exception e) {
		}
	}

	public void setWorkbook(File file) {
		try {
			FileInfo fileInfo = new FileInfoImpl(file);

			if(fileInfo.getExt().equals("xlsx")) {
			    // excel 2007
				this.workbook = new XSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			} else {
			    // excel 97-2003
				this.workbook = new HSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			}
		} catch (Exception e) {
		}
	}

	public void setWorkbook(FileInfo fileInfo) {
		try {
			if(fileInfo.getExt().equals("xlsx")) {
			    // excel 2007
				this.workbook = new XSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			} else {
			    // excel 97-2003
				this.workbook = new HSSFWorkbook(new FileInputStream(fileInfo.getFile()));
			}
		} catch (Exception e) {
		}
	}

	public Sheet getSheet() {
		return this.getSheet(0);
	}

	public Sheet getSheet(int index) {
		return this.workbook.getSheetAt(index);
	}

	public Sheet getSheet(String sheetName) {
		return this.workbook.getSheet(sheetName);
	}

	public int getSheetIndex(String sheetName) {
		return this.workbook.getSheetIndex(sheetName);
	}

	public int getSheetIndex(Sheet sheet) {
		return this.workbook.getSheetIndex(sheet);
	}

	public void setSheetName(int index, String name) {
		this.workbook.setSheetName(index, name);
	}

    public String getSheetName(int index) {
    	return this.workbook.getSheetName(index);
    }

    public Iterator<Row> getRows() {
    	return this.getRows(this.workbook.getSheetAt(0));
    }

    public Iterator<Row> getRows(int index) {
    	return this.getRows(this.workbook.getSheetAt(index));
    }

    public Iterator<Row> getRows(String sheetName) {
    	return this.getRows(this.workbook.getSheet(sheetName));
    }

    public Iterator<Row> getRows(Sheet sheet) {
    	return (sheet != null) ? sheet.iterator() : null;
    }

    public Row getRow() {
    	return this.getRow(this.workbook.getSheetAt(0));
    }

    public Row getRow(int index) {
    	return this.getRow(this.workbook.getSheetAt(index));
    }

    public Row getRow(int sheetIndex, int rowIndex) {
    	return this.getRow(this.workbook.getSheetAt(sheetIndex), rowIndex);
    }

    public Row getRow(String sheetName) {
    	return this.getRow(this.workbook.getSheet(sheetName));
    }

    public Row getRow(String sheetName, int rowIndex) {
    	return this.getRow(this.workbook.getSheet(sheetName), rowIndex);
    }

    public Row getRow(Sheet sheet) {
    	return this.getRow(sheet, 0);
    }

    public Row getRow(Sheet sheet, int index) {
    	Iterator<Row> rowIterator = sheet.iterator();
    	Row row = null;
    	int count = 0;

    	if(index > -1) {
	    	while(rowIterator.hasNext()) {
	    		Row temp = rowIterator.next();

	    		if(index == count++) {
	    			row = temp;
	    			break;
	    		}
	    	}
    	}

    	return row;
    }

    /**
     * Cell Iterator
     * @return
     */
    public Iterator<Cell> getCells() {
    	return this.getCells(this.workbook.getSheetAt(0));
    }

    public Iterator<Cell> getCells(int index) {
    	return this.getCells(this.workbook.getSheetAt(index));
    }

    public Iterator<Cell> getCells(int sheetIndex, int rowIndex) {
    	return this.getCells(this.workbook.getSheetAt(sheetIndex), rowIndex);
    }

    public Iterator<Cell> getCells(String sheetName) {
    	return this.getCells(this.workbook.getSheet(sheetName));
    }

    public Iterator<Cell> getCells(String sheetName, int rowIndex) {
    	return this.getCells(this.workbook.getSheet(sheetName), rowIndex);
    }

    public Iterator<Cell> getCells(Sheet sheet) {
    	return this.getCells(sheet, 0);
    }

    public Iterator<Cell> getCells(Sheet sheet, int rowIndex) {
    	Iterator<Row> rowIterator = sheet.iterator();
    	Iterator<Cell> cellIterator = null;
    	int count = 0;

    	if(rowIndex > -1) {
	    	while(rowIterator.hasNext()) {
	    		Row row = rowIterator.next();

	    		if(rowIndex == count++) {
	    			cellIterator = row.cellIterator();
	    		}
	    	}
    	}

    	return cellIterator;
    }

    public SheetInfo getSheetInfo() {
    	return this.getSheetInfo(0);
    }

    public SheetInfo getSheetInfo(int index) {
    	return this.getSheetInfo(this.workbook.getSheetAt(index));
    }

    public SheetInfo getSheetInfo(String sheetName) {
    	return this.getSheetInfo(this.workbook.getSheet(sheetName));
    }

    public SheetInfo getSheetInfo(Sheet sheet) {
    	SheetInfo sheetInfo = null;

    	if(sheet != null) {
    		sheetInfo = new SheetInfo();
    		int maxCellCount = 0;

    		for(int rownum=0; rownum<=sheet.getLastRowNum(); ++rownum) {
    			Row row = sheet.getRow(rownum);
    			RowInfo rowInfo = new RowInfo();

    			sheetInfo.addRowInfo(rowInfo);
    			rowInfo.setRowIndex(rownum);

    			if(row != null) {
	    			for(int cellnum=0; cellnum<row.getLastCellNum(); ++cellnum) {
	    				Cell cell = row.getCell(cellnum);
	    				CellInfo cellInfo = new CellInfo();

	    				rowInfo.addCellInfo(cellInfo);

	    			    if(cell != null) {
	    			    	CellStyle cellStyle = cell.getCellStyle();
	    			    	String strCellValue = "";

		    			    switch(cell.getCellType()) {
		    					case Cell.CELL_TYPE_NUMERIC:
		    						if(DateUtil.isCellDateFormatted(cell)) {
		    							SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		    							strCellValue = format.format(cell.getDateCellValue());
		    						} else {
		    							strCellValue = String.valueOf((int)cell.getNumericCellValue());
		    						}
		    						break;
		    					case Cell.CELL_TYPE_STRING:
		    						strCellValue = cell.getStringCellValue();
		    						break;
		    					case Cell.CELL_TYPE_BLANK:
		    						strCellValue = "";
		    						break;
		    					case Cell.CELL_TYPE_BOOLEAN:
		    						strCellValue = String.valueOf( cell.getBooleanCellValue());
		    						break;
		    					case Cell.CELL_TYPE_FORMULA:
		    						SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		    						strCellValue = format.format(cell.getDateCellValue());
		    						break;
		    					default:
		    						strCellValue = "";
		    						break;
		    				}

		    			    cellInfo.setColumnIndex(cell.getColumnIndex());
		    			    cellInfo.setColumnValue(strCellValue);
		    			    cellInfo.setBorderBottom((cellStyle.getBorderBottom() > CellStyle.BORDER_MEDIUM) ?  CellStyle.BORDER_THIN : cellStyle.getBorderBottom());
		    			    cellInfo.setBorderLeft((cellStyle.getBorderLeft() > CellStyle.BORDER_MEDIUM) ?  CellStyle.BORDER_THIN : cellStyle.getBorderLeft());
		    			    cellInfo.setBorderRight((cellStyle.getBorderRight() > CellStyle.BORDER_MEDIUM) ?  CellStyle.BORDER_THIN : cellStyle.getBorderRight());
		    			    cellInfo.setBorderTop((cellStyle.getBorderTop() > CellStyle.BORDER_MEDIUM) ?  CellStyle.BORDER_THIN : cellStyle.getBorderTop());
		    			    cellInfo.setAlignment(cellStyle.getAlignment());

		    			    cellInfo.setBoldWeight(this.workbook.getFontAt(cellStyle.getFontIndex()).getBoldweight());
		    			    cellInfo.setBold(this.workbook.getFontAt(cellStyle.getFontIndex()).getBold());
		    			    cellInfo.setFontSize(this.workbook.getFontAt(cellStyle.getFontIndex()).getFontHeightInPoints());
		    			    cellInfo.setFontColor(this.workbook.getFontAt(cellStyle.getFontIndex()).getColor());
	    			    } else {
	    			    	cellInfo.setColumnIndex(-1);
	    			    }
	    			}

	    			if(maxCellCount < row.getLastCellNum()) {
	    				maxCellCount = row.getLastCellNum();
	    			}
    			}
    		}

    		for(int i=0; i<sheet.getNumMergedRegions(); ++i) {
    			CellMergedRange cellMergedRange = new CellMergedRange();

    			cellMergedRange.setFirstRow(sheet.getMergedRegion(i).getFirstRow());
    			cellMergedRange.setLastRow(sheet.getMergedRegion(i).getLastRow());
    			cellMergedRange.setFirstColumn(sheet.getMergedRegion(i).getFirstColumn());
    			cellMergedRange.setLastColumn(sheet.getMergedRegion(i).getLastColumn());

    			sheetInfo.addCellMergedRange(cellMergedRange);
    		}

    		sheetInfo.setCellCount(maxCellCount);

    		for(int i=0; i<maxCellCount; ++i) {
    			sheetInfo.addColumnWidth(sheet.getColumnWidth(i));
    		}
    	}

    	return sheetInfo;
    }
}