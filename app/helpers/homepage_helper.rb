# frozen_string_literal: true

module HomepageHelper
  def tech_skills_grouped
    [
      {
        category: "Languages",
        skills: [
          { name: "Python", icon: "fa-brands fa-python" },
          { name: "JavaScript", icon: "fa-brands fa-js" },
          { name: "PHP", icon: "fa-brands fa-php" },
          { name: "Ruby", icon: "fa-solid fa-gem" },
          { name: "HTML/CSS", icon: "fa-brands fa-html5" }
        ]
      },
      {
        category: "Frameworks",
        skills: [
          { name: "Ruby on Rails", icon: "fa-solid fa-train-subway" },
          { name: "React", icon: "fa-brands fa-react" }
        ]
      },
      {
        category: "Tools • Testing",
        skills: [
          { name: "Git", icon: "fa-brands fa-git-alt" },
          { name: "VS Code", icon: "fa-solid fa-code" },
          { name: "Bruno", icon: "fa-solid fa-flask" },
          { name: "Postman", icon: "fa-solid fa-paper-plane" },
          { name: "Cypress", icon: "fa-solid fa-vial" },
          { name: "Trello", icon: "fa-brands fa-trello" },
          { name: "Azure DevOps", icon: "fa-brands fa-microsoft" }
        ]
      },
      {
        category: "Databases",
        skills: [
          { name: "PostgreSQL", icon: "fa-solid fa-database" },
          { name: "MySQL", icon: "fa-solid fa-database" },
          { name: "SQLite", icon: "fa-solid fa-database" }
        ]
      }
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

  def typing_texts
    [
      "Hi Everyone",
      "I'm Best Patcharapon",
      "Test Engineer",
      "Software Developer"
    ]
  end
end
