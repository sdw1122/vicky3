package com.vicky.main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import com.vicky.dao.HistoricalEventDAO;
import com.vicky.dto.HistoricalEventDTO;

public class EventDataUploader {
    public static void main(String[] args) {
        String filePath = "src/main/webapp/upload/Victoria3_HistoricalEventDB.txt";
        HistoricalEventDAO dao = new HistoricalEventDAO();

        try (BufferedReader br = new BufferedReader(new FileReader(new File(filePath)))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty() || line.startsWith("[source")) continue;

                // 형식: 국가/연도/이벤트명/대상/유형
                String[] parts = line.split("/");
                if (parts.length >= 5) {
                    HistoricalEventDTO dto = new HistoricalEventDTO();
                    dto.setCountry(parts[0].trim());
                    try {
                        dto.setYear(Integer.parseInt(parts[1].trim()));
                    } catch (NumberFormatException e) { continue; } // 연도 오류시 스킵
                    dto.setEventName(parts[2].trim());
                    dto.setTarget(parts[3].trim());
                    dto.setEventType(parts[4].trim());

                    dao.insertEvent(dto);
                    System.out.println("등록: " + dto.getEventName());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}