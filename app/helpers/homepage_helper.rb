# frozen_string_literal: true

module HomepageHelper
  def tech_skills_grouped
    [
      {
        category: "Programming & Scripting",
        skills: [
          { name: "Python", icon: "fa-brands fa-python" },
          { name: "JavaScript", icon: "fa-brands fa-js" },
          { name: "PHP", icon: "fa-brands fa-php" },
          { name: "Ruby", icon: "fa-solid fa-gem" },
          { name: "HTML", icon: "fa-brands fa-html5" },
          { name: "CSS", icon: "fa-brands fa-css3-alt" },
          { name: "Machine Learning", icon: "fa-solid fa-robot" }
        ]
      },
      {
        category: "Frameworks & Web Technologies",
        skills: [
          { name: "Ruby on Rails", icon: "fa-solid fa-train-subway" },
          { name: "React", icon: "fa-brands fa-react" },
          { name: "RESTful APIs", icon: "fa-solid fa-plug" }
        ]
      },
      {
        category: "Testing Methodology",
        skills: [
          { name: "Black-box Testing", icon: "fa-solid fa-box" },
          { name: "Functional Testing", icon: "fa-solid fa-list-check" },
          { name: "Regression Testing", icon: "fa-solid fa-arrows-rotate" },
          { name: "E2E Testing", icon: "fa-solid fa-route" },
          { name: "UAT", icon: "fa-solid fa-user-check" },
          { name: "API Validation", icon: "fa-solid fa-server" },
          { name: "Test Case Design", icon: "fa-solid fa-pen-ruler" }
        ]
      },
      {
        category: "Tools & Platforms",
        skills: [
          { name: "Git", icon: "fa-brands fa-git-alt" },
          { name: "VS Code", icon: "fa-solid fa-code" },
          { name: "Bruno", icon: "fa-solid fa-flask" },
          { name: "Postman", icon: "fa-solid fa-paper-plane" },
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

  def projects
    [
      {
        title: "Web Resume ",
        description: "Personal portfolio website built with Ruby on Rails featuring responsive bento-grid design, interactive profile card stack, animated skill marquee, and AI chatbot integration.",
        tags: ["Ruby on Rails", "HTML/CSS", "JavaScript", "Responsive Design"],
        icon: "fa-solid fa-globe",
        link: nil,
        color: "#728559",
        image: "/resume.png"
      },
      {
        title: "Human Detection System",
        description: "AI-powered IoT monitoring system using ESP32 and Machine Learning on Edge Computing with real-time dashboard and automated alert notifications.",
        tags: ["Python", "Machine Learning", "ESP32", "IoT"],
        icon: "fa-solid fa-microchip",
        link: "https://github.com/bestpatcharapon",
        color: "#3498db",
        images: ["/img_3407.png", "/1image.png"]
      },
      {
        title: "SmartCheck Dashboard Testing",
        description: "End-to-end testing for analytics dashboard tiles including Fleet Comparison, Connectivity, and Vehicle Utilisation with API validation using Bruno.",
        tags: ["E2E Testing", "Bruno", "API Testing", "Dashboard"],
        icon: "fa-solid fa-chart-line",
        link: nil,
        color: "#e67e22",
        image: "/smartcheck.png"
      },
      {
        title: "CCT MIS Testing",
        description: "Comprehensive testing of Church Management Information System across multiple modules with functional testing, regression testing, and defect reporting via Trello.",
        tags: ["E2E Testing", "Functional Testing", "Trello", "Defect Reporting"],
        icon: "fa-solid fa-building",
        link: nil,
        color: "#9b59b6",
        image: "/CCT.png"
      },
      {
        title: "Banana AI Work Assistant",
        description: "Testing and validation of a web-based AI assistant system integrated with MCP. Designed and executed test cases for new feature rollouts.",
        tags: ["Manual Testing", "API Validation", "Regression Testing"],
        icon: "fa-solid fa-robot",
        link: nil,
        color: "#f1c40f",
        images: ["/image copy.png", "/bananaai.png"]
      },
      {
        title: "Alignerr Testing",
        description: "Testing and evaluating advanced AI/LLM models for code generation, reasoning, and logic to improve model performance and accuracy constraints.",
        tags: ["AI Testing", "LLM Evaluation", "Prompt Engineering"],
        icon: "fa-solid fa-brain",
        link: "https://app.alignerr.com/",
        color: "#8e44ad",
        image: "/Aligner.png",
        status: "Doing"
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
