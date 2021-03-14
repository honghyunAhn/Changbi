package forFaith.poi;

/**
 * @Class Name : CellInfo.java
 * @Description : 엑셀 데이터 추출 시 cell 정보
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

public class CellInfo {

	/**
     * general (normal) horizontal alignment
     */

    public final static short ALIGN_GENERAL = 0x0;

    /**
     * left-justified horizontal alignment
     */

    public final static short ALIGN_LEFT = 0x1;

    /**
     * center horizontal alignment
     */

    public final static short ALIGN_CENTER = 0x2;

    /**
     * right-justified horizontal alignment
     */

    public final static short ALIGN_RIGHT = 0x3;

    /**
     * fill? horizontal alignment
     */

    public final static short ALIGN_FILL = 0x4;

    /**
     * justified horizontal alignment
     */

    public final static short ALIGN_JUSTIFY = 0x5;

    /**
     * center-selection? horizontal alignment
     */

    public final static short ALIGN_CENTER_SELECTION = 0x6;

    /**
     * top-aligned vertical alignment
     */

    public final static short VERTICAL_TOP = 0x0;

    /**
     * center-aligned vertical alignment
     */

    public final static short VERTICAL_CENTER = 0x1;

    /**
     * bottom-aligned vertical alignment
     */

    public final static short VERTICAL_BOTTOM = 0x2;

    /**
     * vertically justified vertical alignment
     */

    public final static short VERTICAL_JUSTIFY = 0x3;

    /**
     * No border
     */

    public final static short BORDER_NONE = 0x0;

    /**
     * Thin border
     */

    public final static short BORDER_THIN = 0x1;

    /**
     * Medium border
     */

    public final static short BORDER_MEDIUM = 0x2;

    /**
     * dash border
     */

    public final static short BORDER_DASHED = 0x3;

    /**
     * dot border
     */

    public final static short BORDER_HAIR = 0x7;

    /**
     * Thick border
     */

    public final static short BORDER_THICK = 0x5;

    /**
     * double-line border
     */

    public final static short BORDER_DOUBLE = 0x6;

    /**
     * hair-line border
     */

    public final static short BORDER_DOTTED = 0x4;

    /**
     * Medium dashed border
     */

    public final static short BORDER_MEDIUM_DASHED = 0x8;

    /**
     * dash-dot border
     */

    public final static short BORDER_DASH_DOT = 0x9;

    /**
     * medium dash-dot border
     */

    public final static short BORDER_MEDIUM_DASH_DOT = 0xA;

    /**
     * dash-dot-dot border
     */

    public final static short BORDER_DASH_DOT_DOT = 0xB;

    /**
     * medium dash-dot-dot border
     */

    public final static short BORDER_MEDIUM_DASH_DOT_DOT = 0xC;

    /**
     * slanted dash-dot border
     */

    public final static short BORDER_SLANTED_DASH_DOT = 0xD;

    /**  No background */
    public final static short NO_FILL = 0;

    /**  Solidly filled */
    public final static short SOLID_FOREGROUND = 1;

    /**  Small fine dots */
    public final static short FINE_DOTS = 2;

    /**  Wide dots */
    public final static short ALT_BARS = 3;

    /**  Sparse dots */
    public final static short SPARSE_DOTS = 4;

    /**  Thick horizontal bands */
    public final static short THICK_HORZ_BANDS = 5;

    /**  Thick vertical bands */
    public final static short THICK_VERT_BANDS = 6;

    /**  Thick backward facing diagonals */
    public final static short THICK_BACKWARD_DIAG = 7;

    /**  Thick forward facing diagonals */
    public final static short THICK_FORWARD_DIAG = 8;

    /**  Large spots */
    public final static short BIG_SPOTS = 9;

    /**  Brick-like layout */
    public final static short BRICKS = 10;

    /**  Thin horizontal bands */
    public final static short THIN_HORZ_BANDS = 11;

    /**  Thin vertical bands */
    public final static short THIN_VERT_BANDS = 12;

    /**  Thin backward diagonal */
    public final static short THIN_BACKWARD_DIAG = 13;

    /**  Thin forward diagonal */
    public final static short THIN_FORWARD_DIAG = 14;

    /**  Squares */
    public final static short SQUARES = 15;

    /**  Diamonds */
    public final static short DIAMONDS = 16;

    /**  Less Dots */
    public final static short LESS_DOTS = 17;

    /**  Least Dots */
    public final static short LEAST_DOTS = 18;

	private int columnIndex;
	private String columnValue;

	private short borderBottom;
	private short borderLeft;
	private short borderRight;
	private short borderTop;

	/**
     * get the type of horizontal alignment for the cell
     * @return align - the type of alignment
     * @see #ALIGN_GENERAL
     * @see #ALIGN_LEFT
     * @see #ALIGN_CENTER
     * @see #ALIGN_RIGHT
     * @see #ALIGN_FILL
     * @see #ALIGN_JUSTIFY
     * @see #ALIGN_CENTER_SELECTION
     */
	private short alignment;

	private short boldWeight;
	private boolean bold;
	private short fontSize;
	private short fontColor;

	public int getColumnIndex() {
		return columnIndex;
	}
	public void setColumnIndex(int columnIndex) {
		this.columnIndex = columnIndex;
	}
	public String getColumnValue() {
		return columnValue;
	}
	public void setColumnValue(String columnValue) {
		this.columnValue = columnValue;
	}
	public short getBorderBottom() {
		return borderBottom;
	}
	public void setBorderBottom(short borderBottom) {
		this.borderBottom = borderBottom;
	}
	public short getBorderLeft() {
		return borderLeft;
	}
	public void setBorderLeft(short borderLeft) {
		this.borderLeft = borderLeft;
	}
	public short getBorderRight() {
		return borderRight;
	}
	public void setBorderRight(short borderRight) {
		this.borderRight = borderRight;
	}
	public short getBorderTop() {
		return borderTop;
	}
	public void setBorderTop(short borderTop) {
		this.borderTop = borderTop;
	}
	public short getAlignment() {
		return alignment;
	}
	public void setAlignment(short alignment) {
		this.alignment = alignment;
	}
	public short getBoldWeight() {
		return boldWeight;
	}
	public void setBoldWeight(short boldWeight) {
		this.boldWeight = boldWeight;
	}
	public boolean isBold() {
		return bold;
	}
	public void setBold(boolean bold) {
		this.bold = bold;
	}
	public short getFontSize() {
		return fontSize;
	}
	public void setFontSize(short fontSize) {
		this.fontSize = fontSize;
	}
	public short getFontColor() {
		return fontColor;
	}
	public void setFontColor(short fontColor) {
		this.fontColor = fontColor;
	}
}
