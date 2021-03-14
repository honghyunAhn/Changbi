package forFaith.dev.excel;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelDownLoad extends AbstractExcelView {
	@Override
	@SuppressWarnings("unchecked")
	protected void buildExcelDocument( @SuppressWarnings("rawtypes") Map model, HSSFWorkbook wb
									 , HttpServletRequest req, HttpServletResponse res) throws Exception {
		Map<String, Object> map	= (Map<String, Object>)model.get("excelMap");

		// 엑셀 헤더생성
		String fileName		= (String)map.get("fileName");
		String userAgent	= req.getHeader("User-Agent");

		if(userAgent.indexOf("MSIE") > -1) {
			fileName = URLEncoder.encode(fileName, "utf-8");
		} else {
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
		}

		res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");

		//HSSFCell cell	= null;
		HSSFSheet sheet	= wb.createSheet("sheet1");
		//sheet.setDefaultColumnWidth(100);

		List<Object> srcHeder		= (List<Object>)map.get("header");
		List<Object> stcBody		= (List<Object>)map.get("body");
		List<Object> stcBodyWidth	= (List<Object>)map.get("bodyWidth");

		int[] tempBodyWidth = (int[])stcBodyWidth.get(0);

		for( int k=0 ; k < tempBodyWidth.length ; k++ ){
			sheet.setColumnWidth(k, 400*tempBodyWidth[k]); //386
		}

		String[] tempHeader = (String[])srcHeder.get(0);

		for (int ii = 0; ii < tempHeader.length; ii++){
			setText(wb, getCell(sheet, 0, ii), tempHeader[ii]);
		}

		for (int i = 0; i < stcBody.size(); i++) {
			String[] tempBoby = (String[])stcBody.get(i);

			for (int ii = 0; ii < tempBoby.length; ii++){
				setText(getCell(sheet, i+1, ii), tempBoby[ii]);
			}
		}
	}

	// 상속 받지 않고 자체적으로 다시 사용 (헤더만 사용)
	protected void setText(HSSFWorkbook wb, HSSFCell cell, String text) {
		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setWrapText(true);		// 개행문자 처리
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);

		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue(text);
		cell.setCellStyle(cellStyle);
	}
}
