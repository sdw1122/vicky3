package com.vicky.dto;

public class HistoricalEventDTO {
    private int id;
    private String country;
    private int year;
    private String eventName;
    private String target;
    private String eventType;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }
    public String getTarget() { return target; }
    public void setTarget(String target) { this.target = target; }
    public String getEventType() { return eventType; }
    public void setEventType(String eventType) { this.eventType = eventType; }
}