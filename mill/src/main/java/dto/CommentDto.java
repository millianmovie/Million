package dto;

import java.util.Date;

public class CommentDto {
    private Integer cno;
    private Integer bno;
    private String  comment;
    private String  commenter;
    private Date    reg_date;

    public CommentDto() {
    	super();
    }
    
    public CommentDto(Integer bno, String comment, String commenter) {
        this.bno = bno;
        this.comment = comment;
        this.commenter = commenter;
    }

//    public CommentDto( String comment, Integer bno, String commenter) {
//		super();
//		this.comment = comment;
//		this.bno = bno;
//		this.commenter = commenter;
//	}
    
	public Integer getBno() {
        return bno;
    }

    public void setBno(Integer bno) {
        this.bno = bno;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCommenter() {
        return commenter;
    }

    public void setCommenter(String commenter) {
        this.commenter = commenter;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

    public Integer getCno() {
        return cno;
    }

    public void setCno(Integer cno) {
        this.cno = cno;
    }
	
    @Override
	public String toString() {
		return "CommentDto [cno=" + cno + ", bno=" + bno + ", comment=" + comment + ", commenter=" + commenter
				+ ", reg_date=" + reg_date + "]";
	}
}