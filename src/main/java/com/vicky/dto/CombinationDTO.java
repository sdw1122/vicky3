package com.vicky.dto;

import java.sql.Timestamp;

public class CombinationDTO {
    private int logId;
    private String memberId;
    private String combinationName;
    private Timestamp regDate;
    
    public CombinationDTO() {}

    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }
    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
    public String getCombinationName() { return combinationName; }
    public void setCombinationName(String combinationName) { this.combinationName = combinationName; }
    public Timestamp getRegDate() { return regDate; }
    public void setRegDate(Timestamp regDate) { this.regDate = regDate; }
}