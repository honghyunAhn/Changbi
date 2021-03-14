package forFaith.dev.excel;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import forFaith.file.FileInfo;

public class ExcelUpLoad {

	@SuppressWarnings("resource")
    public static List<Map<Integer, String>> getDataList( FileInfo fileInfo ) throws Exception {
	    List<Map<Integer, String>> dataList = new ArrayList<Map<Integer, String>>();

	    if(fileInfo != null && fileInfo.getFile() != null && fileInfo.getFile().isFile()) {
    	    FileInputStream excelFile = new FileInputStream(fileInfo.getFile());

    	    Workbook workbook = null;
    	    OPCPackage opcPackage = null;

    	    Sheet sheet = null;    // 엑셀의 시트
    	    Row row = null;        // 엑셀의 열
            Cell cell = null;      // 엑셀의 셀

            int rowIndex = 0;       // 가지고 올 로우의 인덱스
            int columnLen = 0;		// 컬럼 갯수(첫번째 로우의 컬럼 수로 결정)

    	    if(fileInfo.getExt().endsWith("xlsx") || fileInfo.getExt().endsWith("xlsm")) {
    	        opcPackage = OPCPackage.open(excelFile);
    	        workbook = new XSSFWorkbook(opcPackage);
    	    } else {
    	        workbook = new HSSFWorkbook(excelFile);
    	    }

    	    // 시트는 0번째껄 가지고 옴
    	    sheet = workbook.getSheetAt(0);
    	    
    	    columnLen = sheet.getRow(0).getLastCellNum();

    	    while(true) {
    	        Map<Integer, String> data = new HashMap<Integer, String>();

    	        // 2번째 로우부터 가지고 온다. index로는 1부터
    	        row = sheet.getRow(++rowIndex);

    	        // 로우 데이터가 널이거나 첫번째 쉘 값이 비어 있으면 멈춤
    	        if(row == null || row.getCell(0).getStringCellValue().equals("")) {
    	            break;
    	        }

    	        // 해당 로우의 셀값을 가지고 옴
    	        for(int i=0; i<columnLen; ++i) {
    	            cell = row.getCell(i);

    	            if(cell == null || cell.getCellType() == Cell.CELL_TYPE_BLANK) {
    	                data.put(i, "");
    	            } else {
    	                // 셀 문자로 설정
    	                cell.setCellType(Cell.CELL_TYPE_STRING);

    	                data.put(i,  cell.getStringCellValue() == null ? "" : cell.getStringCellValue());
    	            }
    	        }

    	        dataList.add(data);
    	    }
	    }

	    return dataList;
	}
}
