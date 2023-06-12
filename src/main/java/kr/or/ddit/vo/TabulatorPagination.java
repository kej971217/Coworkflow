package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.ui.DefaultPaginationRenderer;
import kr.or.ddit.ui.PaginationRenderer;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Tabulator 페이징 처리에 필요한 속성들을 정의한 객체.
 *
 */
@Getter
@NoArgsConstructor
public class TabulatorPagination<T> implements Serializable{
	
	@Setter
	private String empId;
	
	public TabulatorPagination(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	// 
	private int totalRecord; // DB
	
	// 화면에 출력할 게시글 수
	private int screenSize=10;
	public void setScreenSize(int screenSize) {
		this.screenSize = screenSize;
	}
	
	
	
	// 페이징 수
	private int blockSize=5;
	
	
	// 현재 페이지
	private int currentPage; // parameter
	
	
	// 총 페이지
//	private int totalPage;
	private int lastPage;
	
	
	// 시작 쪽수, 끝 쪽수
	private int startRow;
	private int endRow;
	
	
	// 시작 페이지, 끝 페이지
	private int startPage;
	private int endPage;
	
	@JsonIgnore
	private transient PaginationRenderer renderer = new DefaultPaginationRenderer();
	
	
	// 글 목록
//	private List<T> dataList;
	private List<T> data;
	

	// 단순 키워드 검색 조건.
	private TabulatorSimpleCondition tabulatorSimpleCondition;

	
	// 상세 검색.
	private T detailCondition; 
	
	
//	private T entity;
//
//    public T getEntity() {
//        return entity;
//    }
//
//    public void setEntity(T entity) {
//        this.entity = entity;
//    }
	
	
    

	
	
	
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		lastPage = (totalRecord+(screenSize-1)) / screenSize;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize - 1);
		
		endPage = ((currentPage+(blockSize-1))/blockSize) * blockSize;
		startPage = endPage - (blockSize - 1);
	}
	
	
	public void setRenderer(PaginationRenderer renderer) {
		this.renderer = renderer;
	}
	
//	public String getPagingHTML() {
//		return renderer.renderPagination(this);
//	}
	
	public void setData(List<T> data) {
		this.data = data;
	}
	
	
	
	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}

	public void setTabulatorSimpleCondition(TabulatorSimpleCondition tabulatorSimpleCondition) {
		this.tabulatorSimpleCondition = tabulatorSimpleCondition;
	}

}






















