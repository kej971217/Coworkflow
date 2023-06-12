package kr.or.ddit.mail;

import kr.or.ddit.mail.vo.MailPagination;

public interface MailPaginationRenderer {
    public String renderMailPagination(MailPagination mailPagination);
}
