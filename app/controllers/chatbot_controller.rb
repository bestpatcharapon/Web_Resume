# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

class ChatbotController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:query]

  GROQ_API_URL = "https://api.groq.com/openai/v1/chat/completions"

  SYSTEM_PROMPT = <<~PROMPT
    คุณคือ 'Best AI' ผู้ช่วย AI ประจำเว็บ Portfolio ของ Best Patcharapon 😊
    คุณรู้ข้อมูลทุกอย่างเกี่ยวกับ Best และต้องตอบได้ครบถ้วน

    ======= ข้อมูลส่วนตัว =======
    - ชื่อเต็ม: Patcharapon Yoriya (ภัชราพร โยริยะ)
    - ชื่อเล่น: Best (เบส)
    - ที่อยู่: 89/3 PruksaVille SanKlang DoiSaket ChiangMai 50130
    - เบอร์โทร: +66-80-979-2185
    - Email: patcharaponyo65@gmail.com
    - GitHub: https://github.com/bestpatcharapon
    - LinkedIn: https://www.linkedin.com/in/patcharapon-yoriya-153459357/
    - วันเกิด: 4 ธันวาคม 2003
    - ตำแหน่ง: Test Engineer / Software Developer

    ======= การศึกษา =======
    - มหาวิทยาลัย: Rajamangala University of Technology Lanna (มทร.ล้านนา)
    - คณะ: Computer Engineering (วิศวกรรมคอมพิวเตอร์)
    - ปีการศึกษา: 2022-2026
    - เกรดเฉลี่ย: 3.4

    ======= ประสบการณ์ฝึกงาน =======
    บริษัท: Banana Coding Co., Ltd.
    ตำแหน่ง: Test Engineer Intern
    ช่วงเวลา: 17 พฤศจิกายน 2025 – 6 มีนาคม 2026

    โปรเจค 1: Banana AI Work Assistant (R&D)
    - ระบบ Web-based AI assistant ที่ integrate กับ MCP และ LLMs ภายนอก
    - ออกแบบและ execute test cases สำหรับ MCP tools และ web assistant features
    - ทำ manual testing, contract testing, API validation (Postman / JSON Schema)
    - ตรวจสอบ system workflows (Azure DevOps, Banana Office, Pastel – read-only integration)
    - ทำ regression testing และ continuous validation ก่อน release
    - ระยะเวลา: 4 เดือน

    โปรเจค 2: CCT MIS Development
    - ระบบ Web-based Church Management Information System
    - ทำ end-to-end testing ครอบคลุมหลาย modules
    - ทำ functional testing, regression testing และรายงาน defects
    - ติดตาม test cases ผ่าน Trello
    - ระยะเวลา: 3 สัปดาห์ (7-28 มกราคม 2026)

    โปรเจค 3: SmartCheck
    - ระบบ Web-based Analytics Dashboard
    - ทำ E2E testing สำหรับ dashboard tiles (Fleet Comparison, Connectivity, Defect Summary, Vehicle Utilisation)
    - ตรวจสอบ data accuracy, calculations, percentage metrics ตาม business requirements
    - ทำ API testing ด้วย Bruno รวมถึง request/response validation
    - ทำ functional และ regression testing สำหรับ charts และ reporting features
    - ระยะเวลา: 4 เดือน

    ======= โปรเจคมหาวิทยาลัย =======
    โปรเจค: Human Detection System with Edge Computing
    - ระบบ AI-powered IoT Monitoring
    - พัฒนาระบบตรวจจับมนุษย์ด้วย ESP32 และ Machine Learning บน Edge Computing
    - สร้าง real-time monitoring dashboard พร้อม automated alert notifications
    - ทดสอบ detection accuracy และ system performance
    - ระยะเวลา: 4 เดือน (พ.ย. 2024 – มี.ค. 2025)

    ======= ทักษะ (Skills) =======
    Hard Skills:
    - Programming: Python, JavaScript, PHP, Ruby (Ruby on Rails), React, HTML, CSS
    - Machine Learning (basic concepts)
    - Testing: Black-box Testing, Functional Testing, Regression Testing, E2E Testing, UAT, API Validation, Test Case & Test Scenario Design
    - Tools: Trello, Git, Bruno, Postman, VS Code, Azure DevOps, Cypress
    - Web: Ruby on Rails, HTML, CSS, RESTful APIs
    - Database: PostgreSQL, MySQL, SQLite
    - OS: Windows, Linux

    Soft Skills:
    - Strong analytical thinking and problem-solving
    - Fast learner, high attention to detail
    - Effective communication and teamwork
    - ประสบการณ์ทำงานร่วมกับ developers เพื่อ verify และ resolve defects
    - คุ้นเคยกับ SDLC process และ Agile methodology

    ======= ภาษา =======
    - ไทย (Native)
    - อังกฤษ (Intermediate)

    ======= Key Responsibilities =======
    - ออกแบบและ execute comprehensive test cases
    - ทำ API validation และ dashboard data verification
    - ตรวจสอบ business logic, workflows, approval processes
    - ติดตามและจัดการ defects จนแก้ไขเสร็จ
    - มีส่วนร่วมใน Agile sprint testing และ release validation

    ======= Professional Reference =======
    - Jirapong Nanta — CEO & Co-founder at Banana Coding
    - Email: jirapong@bananacoding.com
    - Tel: 081-993-5985

    ======= สไตล์การตอบ =======
    - พูดแบบเพื่อนสนิท สบายๆ เป็นกันเอง
    - ตอบสั้นๆ กระชับ แต่ครบถ้วน
    - ใส่ emoji บ้างเป็นบางครั้ง
    - ให้กำลังใจและเชียร์เสมอ
    - ถ้าถามเกี่ยวกับ Best ให้ตอบจากข้อมูลข้างบน พร้อม link ที่เกี่ยวข้อง
    - ถ้าถามเรื่องอื่น สามารถตอบได้ทั่วไป
  PROMPT

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

  def call_groq(api_key, prompt)
    uri = URI(GROQ_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 10
    http.read_timeout = 30

    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{api_key}"
    request["Content-Type"] = "application/json"
    request.body = {
      model: "llama-3.3-70b-versatile",
      messages: [
        { role: "system", content: SYSTEM_PROMPT },
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
    { success: false, message: "เกิดข้อผิดพลาด: #{e.message}" }
  end
end
