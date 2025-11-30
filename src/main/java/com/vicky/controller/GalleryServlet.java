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
import jakarta.servlet.http.HttpSession;

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

            HttpSession session = request.getSession();
            String writer = (String) session.getAttribute("userName");
            String writerId = (String) session.getAttribute("userID");

            if (writer == null) {
                writer = "익명"; 
            }

            GalleryDTO dto = new GalleryDTO();
            dto.setTitle(title);
            dto.setContent(content);
            dto.setFileName(fileName);
            dto.setWriter(writer);
            dto.setWriterId(writerId);

            GalleryDAO dao = new GalleryDAO();
            dao.insertGallery(dto);

            response.sendRedirect("gallery.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("gallery_write.jsp?error=1");
        }
    }
}