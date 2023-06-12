package kr.or.ddit.mail.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import kr.or.ddit.mail.MailDefaultPaginationRenderer;
import kr.or.ddit.mail.MailPaginationRenderer;
import kr.or.ddit.vo.SimpleCondition;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * T : 저네릭 선언 -> 다양한 타입의 데이터를 페이지네이션하는데 사용가능
 * @param <T>
 */
@Data
@NoArgsConstructor
public class MailPagination<T> implements Serializable {


    public MailPagination(int paginationSize, int paginationBlockSizeOfPages) {
        this.paginationSize = paginationSize;
        this.paginationBlockSizeOfPages = paginationBlockSizeOfPages;
    }

    /**
     * 각 페이지마다 표시되는 데이터 행의 개수
     */
    private int paginationSize = 10;

    /**
     * 한번에 표시되는 페이지 번호의 개수
     */
    private int paginationBlockSizeOfPages = 5;

    /**
     * 전체 데이터 행(record)의 개수
     */
    private int totalRows;

    /**
     * 현재 페이지 번호
     */
    private int currentPage;

    /**
     * 전체 페이지의 개수
     */
    private int totalPages;

    /**
     * 현재 페이지에 표시될 데이터의 시작 인덱스
     */
    private int startRow;

    /**
     * 현재 페이지에 표시될 데이터의 마지막 인덱스
     */
    private int endRow;

    /**
     * 한번에 표시되는 페이지 번호의 시작
     */
    private int startPage;

    /**
     * 한번에 표시되는 페이지 번호의 끝
     */
    private int endPage;


    /**
     * JSON -> 직렬화/역직렬화 -> 자바 객체 에서 제외 : @JsonIgnore
     * 자바 객체 -> 직렬화/역직렬화 -> 이진데이터 에서 제외 : transient
     *
     * 페이지 선택 UI 태그(String) 만드는 객체
     */
    @JsonIgnore
    private transient MailPaginationRenderer renderer = new MailDefaultPaginationRenderer();

    /**
     * 페이지에 표시될 데이터 리스트(행의 집합)를 저장
     */
    private List<MailBoxVO> dataList;
    private List<MailTrashVO> trashDataList;
    // 원래 List<T>

    /**
     * 단순 검색 조건
     * 1 카테고리(Type)
     * 2 검색어(Word)
     */
    private SimpleCondition simpleCondition;


    /**
     * 전체 행의 개수 저장
     * with 전체 페이지의 개수 저장
     *
     * @param totalRows
     */
    public void setTotalRows(int totalRows) {
        this.totalRows = totalRows;
        totalPages = (totalRows + (paginationSize - 1)) / paginationSize; // 나눈 후, 올림 처리
    }


    /**
     * 현재 페이지 번호 저장
     * with 현재 페이지에 표시되는 마지막 행의 인덱스
     * and 현재 페이지에 표시되는 첫 행의 인덱스
     * and 한번에 표시되는 페이지의 마지막 번호
     * and 한번에 표시되는 페이지의 첫 번호
     *
     * @param currentPage
     */
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
        endRow = currentPage * paginationSize;
        startRow = endRow - (paginationSize - 1);

        endPage = ((currentPage + (paginationBlockSizeOfPages - 1)) / paginationBlockSizeOfPages) * paginationBlockSizeOfPages;
        startPage = endPage - (paginationBlockSizeOfPages -1 );
    }


    /**
     * 페이지네이션 렌더러(UI 태그 문자열 생성) 설정
     *
     * @param renderer
     */
    public void setRenderer(MailPaginationRenderer renderer) {
        this.renderer = renderer;
    }


    /**
     * 현재 설정된 페이지네이션 렌더러(UI 태그 문자열 생성)로 '페이지네이션 HTML' 생성
     *
     * @return 페이지네이션 HTML(String)
     */
    public String getRenderer() {
        return renderer.renderMailPagination(this);
    }


    /**
     * 페이지에 표시되는 데이터 리스트(행의 집합)를 설정
     *
     * @param dataList
     */
    public void setDataList(List<MailBoxVO> dataList) {
        this.dataList = dataList;
    }


    /**
     * 단순한 검색 조건(1 카테고리, 2 검색어)을 설정
     * @param simpleCondition
     */
    public void setSimpleCondition(SimpleCondition simpleCondition) {
        this.simpleCondition = simpleCondition;
    }


    /**
     * 페이지에 표시되는 데이터 리스트(행의 집합)를 설정 : 휴지통
     *
     * @param dataList
     */
    public void setTrashDataList(List<MailTrashVO> dataList) {
        this.trashDataList = trashDataList;
    }
}
