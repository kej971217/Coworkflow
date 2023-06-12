package kr.or.ddit.commons.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class News implements Serializable{
	private String addr;
	private String title;
    private String description;
    private String beforeTime;

    public News(String addr, String title, String description, String beforeTime) {
    	this.addr = addr;
        this.title = title;
        this.description = description;
        this.beforeTime = beforeTime;
    }

    // getters and setters
}
