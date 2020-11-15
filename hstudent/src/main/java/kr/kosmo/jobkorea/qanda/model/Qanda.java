package kr.kosmo.jobkorea.qanda.model;

public class Qanda {
	

	private int qa_id;
	private String login_id;
	private String bod_tit;
	private String bod_con;
	private String regdate;
	private int hit;
	private String name;
	// hit = 조회수
	public int getQa_id() {
		return qa_id;
	}
	public void setQa_id(int qa_id) {
		this.qa_id = qa_id;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getBod_tit() {
		return bod_tit;
	}
	public void setBod_tit(String bod_tit) {
		this.bod_tit = bod_tit;
	}
	public String getBod_con() {
		return bod_con;
	}
	public void setBod_con(String bod_con) {
		this.bod_con = bod_con;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
	
}
