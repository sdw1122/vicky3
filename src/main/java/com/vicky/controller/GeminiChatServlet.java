package com.vicky.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

// 변경된 부분: javax -> jakarta
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chat")
public class GeminiChatServlet extends HttpServlet {
    
    // 여기에 Google AI Studio에서 발급받은 API 키를 입력하세요
    private static final String API_KEY = "put-api-key-here";
    //모델 설정
    private static final String API_MODEL = "gemini-3-pro-preview";
    
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/" + API_MODEL + ":generateContent?key=" + API_KEY;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String userMessage = request.getParameter("message");
        
        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.getWriter().write("{\"error\": \"메시지가 비어있습니다.\"}");
            return;
        }

        // Gson 라이브러리 없이 문자열로 JSON 생성
        String jsonInputString = "{"
                + "\"contents\": [{"
                + "\"parts\": [{\"text\": \"" + escapeJson(userMessage) + "\"}]"
                + "}]"
                + "}";

        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            BufferedReader br;
            if (responseCode >= 200 && responseCode < 300) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            }

            StringBuilder responseBuilder = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                responseBuilder.append(responseLine);
            }
            br.close();

            response.getWriter().write(responseBuilder.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\": \"서버 내부 오류가 발생했습니다.\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}