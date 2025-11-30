<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    #chatbot-btn {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: #ee5057;
        color: white;
        border: none;
        box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        cursor: pointer;
        z-index: 1000;
        font-size: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    #chatbot-container {
        position: fixed;
        bottom: 90px;
        right: 20px;
        width: 350px;
        height: 500px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        z-index: 1000;
        display: none; /* 기본적으로 숨김 */
        flex-direction: column;
        overflow: hidden;
        border: 1px solid #ddd;
    }

    .chat-header {
        background-color: #ee5057;
        color: white;
        padding: 15px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .chat-body {
        flex: 1;
        padding: 15px;
        overflow-y: auto;
        background-color: #f9f9f9;
    }

    .chat-input-area {
        padding: 10px;
        border-top: 1px solid #ddd;
        display: flex;
        background-color: white;
    }

    #chat-input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 20px;
        outline: none;
    }

    #send-btn {
        background-color: #ee5057;
        color: white;
        border: none;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        margin-left: 10px;
        cursor: pointer;
    }

    .message {
        margin-bottom: 10px;
        max-width: 80%;
        padding: 10px;
        border-radius: 10px;
        font-size: 14px;
        line-height: 1.4;
    }

    .user-message {
        background-color: #ee5057;
        color: white;
        margin-left: auto;
        border-bottom-right-radius: 0;
    }

    .bot-message {
        background-color: #e9ecef;
        color: #333;
        margin-right: auto;
        border-bottom-left-radius: 0;
    }
    
    .loading-dots {
        display: none;
        text-align: center;
        font-size: 20px;
        color: #888;
    }
</style>

<button id="chatbot-btn" onclick="toggleChat()">
    <i class="fa fa-comments"></i>
</button>

<div id="chatbot-container">
    <div class="chat-header">
        <span>Vicky AI 도우미</span>
        <i class="fa fa-times" style="cursor:pointer;" onclick="toggleChat()"></i>
    </div>
    <div class="chat-body" id="chat-body">
        <div class="message bot-message">
            안녕하세요! 빅토리아3 공략이나 역사에 대해 궁금한 점을 물어보세요.
        </div>
        <div class="loading-dots" id="loading">...</div>
    </div>
    <div class="chat-input-area">
        <input type="text" id="chat-input" placeholder="질문을 입력하세요..." onkeypress="handleEnter(event)">
        <button id="send-btn" onclick="sendMessage()">
            <i class="fa fa-paper-plane"></i>
        </button>
    </div>
</div>

<script>
    function toggleChat() {
        var chatContainer = document.getElementById('chatbot-container');
        if (chatContainer.style.display === 'none' || chatContainer.style.display === '') {
            chatContainer.style.display = 'flex';
        } else {
            chatContainer.style.display = 'none';
        }
    }

    function handleEnter(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    }

    function appendMessage(text, sender) {
        var chatBody = document.getElementById('chat-body');
        var messageDiv = document.createElement('div');
        messageDiv.classList.add('message');
        messageDiv.classList.add(sender === 'user' ? 'user-message' : 'bot-message');
        messageDiv.innerText = text;
        
        var loadingDiv = document.getElementById('loading');
        chatBody.insertBefore(messageDiv, loadingDiv);
        
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    function sendMessage() {
        var inputField = document.getElementById('chat-input');
        var message = inputField.value.trim();
        
        if (message === "") return;

        appendMessage(message, 'user');
        inputField.value = '';
        
        document.getElementById('loading').style.display = 'block';

        $.ajax({
            type: "POST",
            url: "chat", // web.xml이나 @WebServlet에 정의된 URL 패턴
            data: { message: message },
            dataType: "json",
            success: function(response) {
                document.getElementById('loading').style.display = 'none';
                
                if (response.candidates && response.candidates.length > 0) {
                    var botReply = response.candidates[0].content.parts[0].text;
                    appendMessage(botReply, 'bot');
                } else if (response.error) {
                    appendMessage("오류: " + response.error, 'bot');
                } else {
                    appendMessage("죄송합니다. 답변을 생성하지 못했습니다.", 'bot');
                }
            },
            error: function(xhr, status, error) {
                document.getElementById('loading').style.display = 'none';
                appendMessage("서버 연결 오류가 발생했습니다.", 'bot');
                console.error(error);
            }
        });
    }
</script>