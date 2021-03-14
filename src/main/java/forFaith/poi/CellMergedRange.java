package forFaith.poi;

/**
 * @Class Name : CellMergedRange.java
 * @Description : 엑셀로 html 변환 시 셀 병합관련
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

public class CellMergedRange {
	// firstRow ~ lastRow, firstColumn ~ lastColumn
	private int firstRow;
	private int lastRow;
	private int firstColumn;
	private int lastColumn;

	public int getFirstRow() {
		return firstRow;
	}
	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}
	public int getLastRow() {
		return lastRow;
	}
	public void setLastRow(int lastRow) {
		this.lastRow = lastRow;
	}
	public int getFirstColumn() {
		return firstColumn;
	}
	public void setFirstColumn(int firstColumn) {
		this.firstColumn = firstColumn;
	}
	public int getLastColumn() {
		return lastColumn;
	}
	public void setLastColumn(int lastColumn) {
		this.lastColumn = lastColumn;
	}
}
