package kr.or.ddit.board;

public class BoardException extends RuntimeException{

	public BoardException(int boNo) {
		super(String.format("%d 번의 글에 문제가 생겼음.", boNo));
	}
	
}
