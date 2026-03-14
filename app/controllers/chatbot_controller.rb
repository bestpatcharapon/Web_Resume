# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

class ChatbotController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:query]

  GROQ_API_URL = "https://api.groq.com/openai/v1/chat/completions"

  def query
    prompt = params[:prompt].to_s.strip
    return render json: { result: "กรุณาพิมพ์ข้อความ 😊" } if prompt.blank?

    api_keys = [
      ENV["GROQ_API_KEY"],
      ENV["GROQ_API_KEY_2"]
    ].compact

    if api_keys.empty?
      return render json: { result: "ยังไม่ได้ตั้งค่า API Key ครับ" }
    end

    result = nil
    api_keys.each do |key|
      result = call_groq(key, prompt)
      break if result[:success]
    end

    render json: { result: result[:message] }
  end

  private

  def build_system_prompt
    helpers = ApplicationController.helpers
    
    skills_text = helpers.tech_skills_grouped.map do |group|
      "- **#{group[:category]}**: #{group[:skills].map { |s| s[:name] }.join(', ')}"
    end.join("\n    ")

    exp_text = helpers.experiences.map do |exp|
      "    - **#{exp[:title]}** (#{exp[:company]})\n      ระยะเวลา: #{exp[:period]}\n      รายละเอียด: #{exp[:description]}\n      Tags: #{exp[:tags].join(', ')}"
    end.join("\n\n")

    proj_text = helpers.projects.map do |proj|
      "    - **#{proj[:title]}**\n      รายละเอียด: #{proj[:description]}\n      Tags: #{proj[:tags].join(', ')}"
    end.join("\n\n")

    <<~PROMPT
      คุณคือ 'Best AI' ผู้ช่วย AI ประจำเว็บ Portfolio ของ Best Patcharapon 😊
      คุณรู้ข้อมูลทุกอย่างเกี่ยวกับ Best และต้องตอบได้ครบถ้วน
      
      ======= ข้อมูลส่วนตัว =======
      - ชื่อเต็ม: Patcharapon Yoriya (ภัชราพร โยริยะ)
      - ชื่อเล่น: Best (เบส)
      - ตำแหน่ง: Test Engineer / Software Developer
      - โลเคชั่น: Chiang Mai, TH
      - Email: patcharaponyo65@gmail.com
      - GitHub: https://github.com/bestpatcharapon
      - LinkedIn: https://www.linkedin.com/in/patcharapon-yoriya-153459357/
      - วันเกิด: 4 ธันวาคม 2003

      ======= การศึกษา =======
      - มหาวิทยาลัย: Rajamangala University of Technology Lanna (มทร.ล้านนา)
      - คณะ: Computer Engineering (วิศวกรรมคอมพิวเตอร์)
      - ปีการศึกษา: 2022-2026

      ======= ประสบการณ์ (Experiences) =======
  #{exp_text}

      ======= โปรเจค (Projects) =======
  #{proj_text}

      ======= ทักษะ (Tech Skills) =======
      #{skills_text}

      Soft Skills:
      - Strong analytical thinking and problem-solving
      - Fast learner, high attention to detail
      - Effective communication and teamwork
      - ประสบการณ์ทำงานร่วมกับ developers เพื่อ verify และ resolve defects
      - คุ้นเคยกับ SDLC process และ Agile methodology

      ======= การจัดรูปแบบคำตอบ (IMPORTANT) =======
      - พูดแบบเพื่อนสนิท สบายๆ เป็นกันเอง มีความมั่นใจ
      - ตอบกระชับ แต่ครบถ้วน
      - จัดหน้าให้อ่านง่าย **บังคับใช้ Bullet points (- หรือ *)** เสมอเมื่อมีการอธิบายหลายเรื่อง
      - ใช้ **ตัวหนา (Bold)** สำหรับเน้นคำสำคัญตลอด (เช่น **ปัญหา**, **ระบบ**)
      - ห้ามพิมพ์เป็นก้อนข้อความยาวๆ ติดกันแบบ Paragraph เดียว ควรเว้นบรรทัดให้พอดี
      - ใส่ Emoji บ้างนิดหน่อย ให้ดูมีสีสันไม่น่าเบื่อ
      - ตอบด้วยข้อมูลที่มาจากประวัติข้างบนนี้เท่านั้น
    PROMPT
  end

  def call_groq(api_key, prompt)
    uri = URI(GROQ_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 10
    http.read_timeout = 30

    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{api_key}"
    request["Content-Type"] = "application/json"
    
    system_message = "#{build_system_prompt}\n\n[ข้อมูลระบบ: วันที่และเวลาปัจจุบันคือ #{Time.current.in_time_zone('Asia/Bangkok').strftime('%A, %d %B %Y %H:%M:%S')} (เวลาประเทศไทย)]"
    
    request.body = {
      model: "llama-3.3-70b-versatile",
      messages: [
        { role: "system", content: system_message },
        { role: "user", content: prompt }
      ],
      temperature: 0.7,
      max_tokens: 1024
    }.to_json

    response = http.request(request)
    body = JSON.parse(response.body)

    if response.code == "200" && body.dig("choices", 0, "message", "content")
      { success: true, message: body["choices"][0]["message"]["content"] }
    elsif response.code == "429"
      { success: false, message: "Rate limited" }
    else
      { success: false, message: "เกิดข้อผิดพลาด กรุณาลองใหม่ 😅" }
    end
  rescue StandardError => e
    Rails.logger.error("Chatbot API error: #{e.message}")
    { success: false, message: "เกิดข้อผิดพลาด กรุณาลองใหม่ 😅" }
  end
end
