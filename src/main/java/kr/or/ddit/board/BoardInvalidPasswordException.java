package kr.or.ddit.board;

public class BoardInvalidPasswordException extends BoardException{

	public BoardInvalidPasswordException(int boNo) {
		super(boNo);
	}

}
