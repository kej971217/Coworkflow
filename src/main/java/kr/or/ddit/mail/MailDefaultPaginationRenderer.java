package kr.or.ddit.mail;

import kr.or.ddit.mail.vo.MailPagination;

/**
 * 페이지에 표시되는 이전, 다음 버튼 UI 태그 생성
 */
public class MailDefaultPaginationRenderer implements MailPaginationRenderer {

    /**
     * 이전, 다음 버튼 HTML 태그
     * %d 페이지 정보
     * %s 아이콘 정보
     */
    private final String CHEVRONPATTERN = "<a href=\"javascript:;\" onclick=\"return fn_paging(%d, event);\"><i icon-name=\"chevron-%s\"></i></a>";


    private final String PATTERN = "<a href=\"javascript:;\" onclick=\"return fn_paging(%d, event);\">%d</a>";


    /**
     * 페이지네이션에서 처리하는 정보
     *
     * 1. 한번에 표시되는 페이지 번호의 시작
     * 2. 한번에 표시되는 페이지 번호의 마지막
     * 3. 전체 페이지의 개수
     * 4. 현재 페이지 블록이 마지막 블록인 경우, 마지막 페이지 번호 다르게 제약
     * 5. 한번에 표시되는 페이지 번호의 개수
     * 6. startPage가 한번에 표시되는 페이지의 개수보다 큰 경우, previous 버튼을 'htmlTag'라는 StringBuffer 객체에 추가하는 부분
     * 7. startPage부터 lastPageOfBlock까지의 페이지 번호를 반복하면서, 페이지네이션 UI의 각 페이지 번호를 생성하는 부분
     * 8. lastPageOfBlock이 totalPage보다 작은 경우, next 버튼을 'htmlTag'라는 StringBuffer 객체에 추가하는 부분
     *
     * @param mailPagination
     * @return 페이지네이션 클릭 UI 태그 (String)
     */
    @Override
    public String renderMailPagination(MailPagination mailPagination) {
        int startPage = mailPagination.getStartPage();//1
        int endPage = mailPagination.getEndPage();//2
        int totalPages = mailPagination.getTotalPages();//3
        int lastPageOfBlock = endPage > totalPages ? totalPages : endPage;//4
        int paginationBlockSizeOfPages = mailPagination.getPaginationBlockSizeOfPages();//5
        int currentPage = mailPagination.getCurrentPage();

        int startRow = (currentPage - 1) * mailPagination.getPaginationSize() + 1;
        int endRow = Math.min(currentPage * mailPagination.getPaginationSize(), mailPagination.getTotalRows());
        int totalRow = mailPagination.getTotalRows();

        StringBuffer htmlTag = new StringBuffer();
        htmlTag.append(String.format("%d - %d of %d  │ ", startRow, endRow, totalRow));
        htmlTag.append(" ");

        if (startPage > paginationBlockSizeOfPages) {
            htmlTag.append(String.format(CHEVRONPATTERN, startPage - paginationBlockSizeOfPages, "left"));
            htmlTag.append(" ");
        }//6


        for (int page = startPage; page <= lastPageOfBlock; page++) {
            htmlTag.append(String.format(PATTERN, page, page));
            htmlTag.append(" ");
        } // 7


        if (lastPageOfBlock < totalPages) {
            htmlTag.append(String.format(CHEVRONPATTERN, startPage - paginationBlockSizeOfPages, "right"));
            htmlTag.append(" ");
        }//8

        return htmlTag.toString();
    }
}
