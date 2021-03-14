package forFaith.poi;

import java.util.ArrayList;
import java.util.List;

/**
 * @Class Name : SheetInfo.java
 * @Description : 엑셀의 sheet 정보
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

public class SheetInfo {

	private int cellCount;
	private List<RowInfo> rowInfoList;
	private List<CellMergedRange> cellMergedRangeList;
	private List<Integer> columnWidthList;

	public SheetInfo() {
		this.rowInfoList = new ArrayList<RowInfo>();
		this.cellMergedRangeList = new ArrayList<CellMergedRange>();
		this.columnWidthList = new ArrayList<Integer>();
	}

	public int getCellCount() {
		return cellCount;
	}

	public void setCellCount(int cellCount) {
		this.cellCount = cellCount;
	}

	public List<Integer> getColumnWidthList() {
		return columnWidthList;
	}

	public void setColumnWidthList(List<Integer> columnWidthList) {
		this.columnWidthList = columnWidthList;
	}

	public void addColumnWidth(Integer columnWidth) {
		this.columnWidthList.add(columnWidth);
	}

	public List<RowInfo> getRowInfoList() {
		return rowInfoList;
	}

	public void setRowInfoList(List<RowInfo> rowInfoList) {
		this.rowInfoList = rowInfoList;
	}

	public void addRowInfo(RowInfo rowInfo) {
		this.rowInfoList.add(rowInfo);
	}

	public List<CellMergedRange> getCellMergedRangeList() {
		return cellMergedRangeList;
	}

	public void setCellMergedRangeList(List<CellMergedRange> cellMergedRangeList) {
		this.cellMergedRangeList = cellMergedRangeList;
	}

	public void addCellMergedRange(CellMergedRange cellMergedRange) {
		this.cellMergedRangeList.add(cellMergedRange);
	}
}
