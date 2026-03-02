/**
 * Chatbot Widget Module
 * AI-powered chatbot for Best Patcharapon's Portfolio
 */
const Chatbot = {
  elements: {},
  isOpen: false,
  isLoading: false,

  init() {
    this.cacheElements();
    if (!this.elements.toggle) return;
    this.bindEvents();
  },

  cacheElements() {
    this.elements = {
      toggle: document.getElementById("chatbotToggle"),
      window: document.getElementById("chatbotWindow"),
      close: document.getElementById("chatbotClose"),
      form: document.getElementById("chatbotForm"),
      input: document.getElementById("chatbotInput"),
      messages: document.getElementById("chatbotMessages"),
      suggestions: document.getElementById("chatbotSuggestions"),
      badge: document.getElementById("chatbotBadge"),
      send: document.getElementById("chatbotSend"),
    };
  },

  bindEvents() {
    // Toggle chat window
    this.elements.toggle.addEventListener("click", () => this.toggleChat());
    this.elements.close.addEventListener("click", () => this.closeChat());

    // Form submit
    this.elements.form.addEventListener("submit", (e) => {
      e.preventDefault();
      this.sendMessage();
    });

    // Suggestion chips
    const chips = document.querySelectorAll(".suggestion-chip");
    chips.forEach((chip) => {
      chip.addEventListener("click", () => {
        const prompt = chip.getAttribute("data-prompt");
        this.elements.input.value = prompt;
        this.sendMessage();
      });
    });

    // Close on outside click
    document.addEventListener("click", (e) => {
      if (
        this.isOpen &&
        !this.elements.window.contains(e.target) &&
        !this.elements.toggle.contains(e.target)
      ) {
        this.closeChat();
      }
    });

    // Enter key support
    this.elements.input.addEventListener("keydown", (e) => {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        this.sendMessage();
      }
    });
  },

  toggleChat() {
    if (this.isOpen) {
      this.closeChat();
    } else {
      this.openChat();
    }
  },

  openChat() {
    this.isOpen = true;
    this.elements.window.classList.add("open");
    this.elements.toggle.querySelector(".chat-icon").style.display = "none";
    this.elements.toggle.querySelector(".close-icon").style.display = "block";

    // Focus input
    setTimeout(() => this.elements.input.focus(), 300);
  },

  closeChat() {
    this.isOpen = false;
    this.elements.window.classList.remove("open");
    this.elements.toggle.querySelector(".chat-icon").style.display = "block";
    this.elements.toggle.querySelector(".close-icon").style.display = "none";
  },

  async sendMessage() {
    const text = this.elements.input.value.trim();
    if (!text || this.isLoading) return;

    // Add user message
    this.addMessage(text, "user");
    this.elements.input.value = "";

    // Hide suggestions after first message
    if (this.elements.suggestions) {
      this.elements.suggestions.style.display = "none";
    }

    // Show typing indicator
    this.isLoading = true;
    this.elements.send.disabled = true;
    const typingEl = this.showTyping();

    try {
      const response = await fetch("/chatbot/query", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCSRFToken(),
        },
        body: JSON.stringify({ prompt: text }),
      });

      const data = await response.json();
      this.removeTyping(typingEl);
      this.addMessage(data.result || "เกิดข้อผิดพลาด ลองใหม่นะ 😅", "bot");
    } catch (error) {
      this.removeTyping(typingEl);
      this.addMessage("ไม่สามารถเชื่อมต่อได้ ลองใหม่นะครับ 😅", "bot");
    } finally {
      this.isLoading = false;
      this.elements.send.disabled = false;
      this.elements.input.focus();
    }
  },

  addMessage(text, sender) {
    const messageDiv = document.createElement("div");
    messageDiv.className = `chat-message ${sender === "user" ? "user-message" : "bot-message"}`;

    const botSvg = `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" width="16" height="16" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L9 7H4l3.5 5L6 17l6-3 6 3-1.5-5L20 7h-5L12 2z"/></svg>`;
    const userSvg = `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" width="16" height="16" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>`;

    const avatarClass = sender === "user" ? "user-avatar" : "bot-avatar";
    const avatar = sender === "user" ? userSvg : botSvg;

    // Bot messages get linkified, user messages get escaped
    const content = sender === "bot" ? this.linkify(this.escapeHtml(text)) : this.escapeHtml(text);

    messageDiv.innerHTML = `
      <div class="message-avatar ${avatarClass}">${avatar}</div>
      <div class="message-bubble">${content}</div>
    `;

    this.elements.messages.appendChild(messageDiv);
    this.scrollToBottom();
  },

  linkify(text) {
    // Convert URLs to clickable links
    const urlRegex = /(https?:\/\/[^\s<]+)/g;
    return text.replace(urlRegex, '<a href="$1" target="_blank" rel="noopener noreferrer" class="chat-link">$1</a>');
  },

  showTyping() {
    const typingDiv = document.createElement("div");
    typingDiv.className = "chat-message bot-message typing-message";
    typingDiv.innerHTML = `
      <div class="message-avatar bot-avatar">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" width="16" height="16" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L9 7H4l3.5 5L6 17l6-3 6 3-1.5-5L20 7h-5L12 2z"/></svg>
      </div>
      <div class="message-bubble">
        <div class="typing-indicator">
          <span></span><span></span><span></span>
        </div>
      </div>
    `;
    this.elements.messages.appendChild(typingDiv);
    this.scrollToBottom();
    return typingDiv;
  },

  removeTyping(element) {
    if (element && element.parentNode) {
      element.parentNode.removeChild(element);
    }
  },

  scrollToBottom() {
    const messages = this.elements.messages;
    messages.scrollTop = messages.scrollHeight;
  },

  escapeHtml(text) {
    const div = document.createElement("div");
    div.textContent = text;
    return div.innerHTML;
  },

  getCSRFToken() {
    const meta = document.querySelector('meta[name="csrf-token"]');
    return meta ? meta.getAttribute("content") : "";
  },
};

// Initialize chatbot when DOM is ready
document.addEventListener("DOMContentLoaded", () => {
  Chatbot.init();
});
