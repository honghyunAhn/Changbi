package forFaith.dev.vo;

import com.changbi.tt.dev.data.vo.ChapterVO;
import com.changbi.tt.dev.data.vo.CourseVO;

//세부차시 VO(포팅용)
public class SubChapVO{
	
	private int seq; //일련번호
	private int chap_id; //챕터 id
	private int occ_num; //차시
	private String name; //이름
	private String filepath; //pc파일경로
	private String mo_filepath; //모바일파일경로
	private int depth; //depth
	private int order; //컨텐츠 순서
	private String content_type; //컨텐츠 타입
	
	private String course_id;
	
	private CourseVO course;
	private ChapterVO chapter;
	
	public SubChapVO() {
		super();
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getChap_id() {
		return chap_id;
	}

	public void setChap_id(int chap_id) {
		this.chap_id = chap_id;
	}

	public int getOcc_num() {
		return occ_num;
	}

	public void setOcc_num(int occ_num) {
		this.occ_num = occ_num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public String getContent_type() {
		return content_type;
	}

	public void setContent_type(String content_type) {
		this.content_type = content_type;
	}

	public String getMo_filepath() {
		return mo_filepath;
	}

	public void setMo_filepath(String mo_filepath) {
		this.mo_filepath = mo_filepath;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public ChapterVO getChapter() {
		return chapter;
	}

	public void setChapter(ChapterVO chapter) {
		this.chapter = chapter;
	}
	
	public String getCourse_id() {
		return course_id;
	}

	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}

	@Override
	public String toString() {
		return "SubChapVO [seq=" + seq + ", chap_id=" + chap_id + ", occ_num=" + occ_num + ", name=" + name
				+ ", filepath=" + filepath + ", mo_filepath=" + mo_filepath + ", depth=" + depth + ", order=" + order
				+ ", content_type=" + content_type + ", course_id=" + course_id + ", course=" + course + ", chapter="
				+ chapter + "]";
	}
	
}
