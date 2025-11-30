package com.vicky.controller;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.vicky.dao.GalleryDAO;
import com.vicky.dto.GalleryDTO;
import jakarta.servlet.http.HttpSession; // 세션 사용을 위해 임포트 추가

@WebServlet("/galleryUpload")
public class GalleryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String savePath = request.getServletContext().getRealPath("upload");
        
        File uploadDir = new File(savePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        int maxSize = 10 * 1024 * 1024; 
        String encoding = "UTF-8";
        
        try {
            MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

            String title = multi.getParameter("title");
            String content = multi.getParameter("content");
            String fileName = multi.getFilesystemName("file");

            // [추가] 세션에서 로그인된 사용자 ID 가져오기
            HttpSession session = request.getSession();
            String writer = (String) session.getAttribute("userName");
            String writerId = (String) session.getAttribute("userID");

            // 만약 로그인이 안 되어 있다면 "익명" 또는 기본값 처리 (필요 시)
            if (writer == null) {
                writer = "익명"; 
            }

            GalleryDTO dto = new GalleryDTO();
            dto.setTitle(title);
            dto.setContent(content);
            dto.setFileName(fileName);
            dto.setWriter(writer); // [추가] 작성자 정보 설정
            dto.setWriterId(writerId);

            GalleryDAO dao = new GalleryDAO();
            dao.insertGallery(dto); // [참고] DAO 메서드도 수정 필요

            response.sendRedirect("gallery.jsp"); // 목록 페이지로 이동하는 것이 더 자연스러움

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("gallery_write.jsp?error=1");
        }
    }
}