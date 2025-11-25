package com.vicky.dto;

import java.sql.Timestamp;

public class GalleryDTO {
    private int no;
    private String title;
    private String content;
    private String fileName;
    private Timestamp regDate;

    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }
    public Timestamp getRegDate() { return regDate; }
    public void setRegDate(Timestamp regDate) { this.regDate = regDate; }
}