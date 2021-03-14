package forFaith.poi;

import java.util.ArrayList;
import java.util.List;

/**
 * @Class Name : RowInfo.java
 * @Description : 엑셀의 로우 정보
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

public class RowInfo {

	private int rowIndex;

	private List<CellInfo> cellInfoList;

	public RowInfo() {
		this.cellInfoList = new ArrayList<CellInfo>();
	}

	public int getRowIndex() {
		return rowIndex;
	}

	public void setRowIndex(int rowIndex) {
		this.rowIndex = rowIndex;
	}

	public List<CellInfo> getCellInfoList() {
		return cellInfoList;
	}

	public void setCellInfoList(List<CellInfo> cellInfoList) {
		this.cellInfoList = cellInfoList;
	}

	public void addCellInfo(CellInfo cellInfo) {
		this.cellInfoList.add(cellInfo);
	}
}
