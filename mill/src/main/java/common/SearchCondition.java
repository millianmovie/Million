package common;

public class SearchCondition {
	private int page=1;
	private int pageSize=10;
	public SearchCondition() {
		super();
	}
	public SearchCondition(int page, int pageSize) {
		this.page = page;
		this.pageSize = pageSize;
	}
	@Override
	public String toString() {
		return "SearchCondition [ page=" + page
				+ ", pageSize=" + pageSize + "]";
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPagaSize() {
		return pageSize;
	}
	public void setPagaSize(int pagaSize) {
		this.pageSize = pageSize;
	}
	
	//offset은 page를 입력받아 구함.
	public int getOffset(int page) {
		return (page-1)*pageSize;
	}

	//현재 페이지 기준 쿼리스트링 반환
	public String getQueryString() {
		return getQueryString(page);
	}
	//지정된 페이지가 있을때 쿼리스트링 반환
	public String getQueryString(int page) {
		return "?page="+page+"&pageSize="+pageSize;
	}
	
}
