# frozen_string_literal: true

module HomepageHelper
  def tech_skills
    %w[
      Python
      JavaScript
      PHP
      Ruby
      Rails
      React
      HTML/CSS
      PostgreSQL
      MySQL
      SQLite
      Git
      Bruno
      Postman
      Cypress
      Trello
      AzureDevOps
    ]
  end

  def experiences
    [
      {
        period: "Nov 2025 - Mar 2026",
        title: "Banana AI Work Assistant (R&D)",
        company: "Test Engineer Intern · Banana Coding Co., Ltd.",
        description: "Web-based AI assistant system integrated with MCP and external LLMs. Designed and executed test cases for MCP tools and web assistant features. Performed manual testing, contract testing, and API validation (Postman / JSON Schema). Validated system workflows (Azure DevOps, Banana Office, Pastel – read-only integration). Conducted regression testing and continuous validation to ensure system stability before release.",
        tags: ["Manual Testing", "API Validation", "Postman", "Regression Testing"]
      },
      {
        period: "Jan 2026",
        title: "CCT MIS Development",
        company: "Test Engineer Intern · Banana Coding Co., Ltd.",
        description: "Web-based Church Management Information System. Performed end-to-end testing across multiple modules. Executed functional and regression testing, and reported defects. Tracked test cases and progress via Trello.",
        tags: ["E2E Testing", "Functional Testing", "Trello", "Defect Reporting"]
      },
      {
        period: "Nov 2025 - Mar 2026",
        title: "SmartCheck",
        company: "Test Engineer Intern · Banana Coding Co., Ltd.",
        description: "Web-based Analytics Dashboard System. Performed end-to-end testing for analytics dashboard tiles (Fleet Comparison, Connectivity, Defect Summary, Vehicle Utilisation). Validated data accuracy, calculations, and percentage metrics against business requirements. Conducted API testing using Bruno, including request/response validation. Executed functional and regression testing for charts and reporting features.",
        tags: ["E2E Testing", "Bruno", "API Testing", "Dashboard Validation"]
      },
      {
        period: "Nov 2024 - Mar 2025",
        title: "Human Detection System with Edge Computing",
        company: "Developer · Rajamangala University of Technology Lanna",
        description: "AI-powered IoT Monitoring System. Developed an AI-based human detection system using ESP32 and Machine Learning on Edge Computing. Implemented real-time monitoring dashboard with automated alert notifications. Validated detection accuracy and system performance through continuous testing. Performed functional testing and system reliability verification before deployment.",
        tags: ["Python", "Machine Learning", "ESP32", "IoT"]
      }
    ]
  end

  def profile_images
    [
      {
        url: "https://img2.pic.in.th/pic/119910476_1085994998481636_5979345016126014253_n.jpg",
        alt: "Best Patcharapon - Test Engineer"
      },
      {
        url: "https://img2.pic.in.th/5f28bf8468995c032c41bee6daf8e65d.jpg",
        alt: "Coding"
      },
      {
        url: "https://img2.pic.in.th/d835428a4f951c34e26b8008ec0d958a.jpg",
        alt: "Working"
      }
    ]
  end

  def personal_info
    {
      name: "Patcharapon Yoriya",
      nickname: "Best",
      role: "Test Engineer | Software Developer",
      location: "Chiang Mai, TH",
      email: "Patcharaponyo65@gmail.com",
      birthday: "December 4, 2003",
      faculty: "Computer Engineering",
      primary_tools: "Bruno · Postman · Trello · Cypress",
      github_url: "https://github.com/bestpatcharapon",
      resume_path: "/Patcharapon_CV.pdf"
    }
  end

  def typing_texts
    [
      "Hi Everyone",
      "I'm Best Patcharapon",
      "Test Engineer",
      "Software Developer",
    ]
  end
end
