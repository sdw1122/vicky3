package com.vicky.main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import com.vicky.dao.CompanyDAO;
import com.vicky.dto.CompanyDTO;

public class CompanyDataUploader {

    public static void main(String[] args) {
        String filePath = "src/main/webapp/upload/Victoria3_CompanyDB.txt"; 
        
        CompanyDAO dao = new CompanyDAO();
        
        try (BufferedReader br = new BufferedReader(new FileReader(new File(filePath)))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                
                if (line.isEmpty()) continue;
                
                // 0:국가, 1:이름, 2:영문명, 3:적용건물, 4:산업건물, 5:상품, 6:효과
                String[] parts = line.split("/");
                
                if (parts.length >= 7) {
                    CompanyDTO dto = new CompanyDTO();
                    dto.setCountry(parts[0].trim());
                    dto.setName(parts[1].trim());
                    dto.setEnglishName(parts[2].trim());
                    dto.setAppliedBuildings(parts[3].trim());
                    dto.setIndustrialBuildings(parts[4].trim());
                    dto.setLuxuryProduct(parts[5].trim());
                    dto.setProsperityEffect(parts[6].trim());
                    
                    dao.insertCompany(dto);
                } else {
                    System.err.println("데이터 형식 오류 라인: " + line);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}