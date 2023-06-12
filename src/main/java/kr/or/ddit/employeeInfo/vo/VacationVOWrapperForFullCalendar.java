package kr.or.ddit.employeeInfo.vo;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.employeeInfo.vo.fullcalendar.FullCalendarVO;

public class VacationVOWrapperForFullCalendar implements FullCalendarVO {
	private VacationVO vacation;
	
	public VacationVOWrapperForFullCalendar(VacationVO vacation) {
		super();
		this.vacation = vacation;
	}

	@Override
	public String getId() {
		return vacation.getLeaveRecordId().toString();
	}

	@Override
	public String getTitle() {
		return vacation.getEmpName() + " " + vacation.getRankName();  
	}
	
	@JsonFormat(shape = Shape.STRING)
	@Override
	public LocalDateTime getStart() {
		return vacation.getLeaveStart();
	}
	
	@JsonFormat(shape = Shape.STRING)
	@Override
	public LocalDateTime getEnd() {
		return vacation.getLeaveEnd();
	}

	@Override
	public boolean isAllDay() {
		return true;
	}

	@Override
	public Object getSource() {
		return vacation;
	}

}
