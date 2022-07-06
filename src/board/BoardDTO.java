package board;

import java.sql.Timestamp;

//DTO, VO, DataBean - jsp 페이지에서 board 데이터의 이동을 담당한다.
public class BoardDTO {
	// property, 멤버 변수
	private int num;
	private String writer;
	private String subject;
	private String content;
	private Timestamp regDate;
	private int readcount;
	private int ref;
	private int re_step;
	private int re_level;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

	@Override
	public String toString() {
		return "BoardDTO [num=" + num + ", writer=" + writer + ", subject=" + subject + ", content=" + content
				+ ", regDate=" + regDate + ", readcount=" + readcount + ", ref=" + ref + ", re_step=" + re_step
				+ ", re_level=" + re_level + "]";
	}

}
