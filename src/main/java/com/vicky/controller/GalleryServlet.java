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

@WebServlet("/galleryUpload")
public class GalleryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String savePath = request.getServletContext().getRealPath("upload");
        
        File uploadDir = new File(savePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        int maxSize = 10 * 1024 * 1024; // 10MB
        String encoding = "UTF-8";

        try {
            // cos.jar 라이브러리 사용
            MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

            String title = multi.getParameter("title");
            String content = multi.getParameter("content");
            String fileName = multi.getFilesystemName("file");

            GalleryDTO dto = new GalleryDTO();
            dto.setTitle(title);
            dto.setContent(content);
            dto.setFileName(fileName);

            GalleryDAO dao = new GalleryDAO();
            dao.insertGallery(dto);

            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("gallery_write.jsp?error=1");
        }
    }
}