package kr.or.ddit.schedule.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.board.vo.fullcalendar.FullCalendarVO;

public class ScheduleVOWrapperForFullCalendar implements FullCalendarVO{
	private ScheduleVO schedule;

	public ScheduleVOWrapperForFullCalendar(ScheduleVO schedule) {
		super();
		this.schedule = schedule;
	}

	@Override
	public String getId() {
		return schedule.getSchdlId().toString();
	}
	
	@Override
	public String getTitle() {
		return schedule.getSchdlTitle();
	}

	@JsonFormat(shape = Shape.STRING)
	@Override
	public LocalDateTime getStart() {
		return schedule.getSchdlBgn();
	}

	@JsonFormat(shape = Shape.STRING)
	@Override
	public LocalDateTime getEnd() {
		return schedule.getSchdlEnd();
	}

	@Override
	public boolean isAllDay() {
		return false;
	}

	@Override
	public Object getSource() {
		
		return schedule;
	}
	
	

}
