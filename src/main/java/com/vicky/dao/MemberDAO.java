package com.vicky.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.vicky.dto.MemberDTO;

public class MemberDAO {
    // DB 연결 정보 (CompanyDAO와 동일)
    private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
    private final String UID = "root";
    private final String PWD = "1234";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, UID, PWD);
    }

    // 로그인 인증 메소드
    // 반환값: 1(로그인 성공), 0(비밀번호 불일치), -1(아이디 없음)
    public int login(String id, String passwd) {
        String sql = "SELECT PASSWD FROM MEMBER WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 아이디 존재, 비밀번호 비교
                    if (rs.getString("PASSWD").equals(passwd)) {
                        return 1; // 로그인 성공
                    } else {
                        return 0; // 비밀번호 불일치
                    }
                }
                return -1; // 아이디 없음
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB 오류
    }

    // 회원 이름 가져오기 (로그인 성공 후 세션 등에 저장용)
    public String getUserName(String id) {
        String name = null;
        String sql = "SELECT NAME FROM MEMBER WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("NAME");
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return name;
    }
    
    public void insertMember(MemberDTO dto) {
        String sql = "INSERT INTO MEMBER (ID, PASSWD, NAME) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPasswd());
            pstmt.setString(3, dto.getName());
            
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // [추가] 아이디 중복 확인 메소드 (중복이면 true, 아니면 false 반환)
    public boolean confirmId(String id) {
        String sql = "SELECT ID FROM MEMBER WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return true; // 이미 존재하는 아이디
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // 사용 가능한 아이디
    }
}