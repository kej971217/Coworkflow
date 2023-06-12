package kr.or.ddit.board.vo.fullcalendar;

import java.time.LocalDateTime;

public interface FullCalendarVO {
	public String getId();
	public String getTitle();
	public LocalDateTime getStart();
	public LocalDateTime getEnd();
	public boolean isAllDay();
	public Object getSource();
}
