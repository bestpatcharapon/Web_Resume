/**
 * Homepage JavaScript Module
 * Clean, modular JavaScript for the portfolio homepage
 */

// Configuration
const CONFIG = {
  typing: {
    typeSpeed: 100,
    deleteSpeed: 50,
    pauseAfterType: 2000,
    pauseAfterDelete: 500,
    initialDelay: 800,
  },
  profileStack: {
    autoRotateInterval: 5000,
  },
};

/**
 * Typing Animation Module
 * Creates a typewriter effect with multiple texts
 */
const TypingAnimation = {
  element: null,
  texts: [],
  textIndex: 0,
  charIndex: 0,
  isDeleting: false,

  init(elementId, texts) {
    this.element = document.getElementById(elementId);
    if (!this.element || !texts.length) return;

    this.texts = texts;
    this.element.textContent = "";

    setTimeout(() => this.typeLoop(), CONFIG.typing.initialDelay);
  },

  typeLoop() {
    const currentText = this.texts[this.textIndex];

    if (!this.isDeleting) {
      this.typeForward(currentText);
    } else {
      this.typeBackward(currentText);
    }
  },

  typeForward(text) {
    if (this.charIndex < text.length) {
      this.element.textContent = text.substring(0, this.charIndex + 1);
      this.charIndex++;
      setTimeout(() => this.typeLoop(), CONFIG.typing.typeSpeed);
    } else {
      setTimeout(() => {
        this.isDeleting = true;
        this.typeLoop();
      }, CONFIG.typing.pauseAfterType);
    }
  },

  typeBackward(text) {
    if (this.charIndex > 0) {
      this.element.textContent = text.substring(0, this.charIndex - 1);
      this.charIndex--;
      setTimeout(() => this.typeLoop(), CONFIG.typing.deleteSpeed);
    } else {
      this.isDeleting = false;
      this.textIndex = (this.textIndex + 1) % this.texts.length;
      setTimeout(() => this.typeLoop(), CONFIG.typing.pauseAfterDelete);
    }
  },
};

/**
 * Tech Tags Search Module
 * Filters technology tags based on search input
 */
const TechTagsSearch = {
  input: null,
  tags: null,

  init() {
    this.input = document.querySelector(".search-input");
    this.tags = document.querySelectorAll(".tech-tags .tag");

    if (!this.input || !this.tags.length) return;

    this.bindEvents();
  },

  bindEvents() {
    this.input.addEventListener("input", (e) => this.handleSearch(e));
  },

  handleSearch(event) {
    const searchTerm = event.target.value.toLowerCase().trim();

    this.tags.forEach((tag) => {
      const tagText = tag.textContent.toLowerCase();
      const isMatch = searchTerm === "" || tagText.includes(searchTerm);

      tag.style.display = isMatch ? "inline-block" : "none";
      tag.style.opacity = isMatch ? "1" : "0";
    });
  },
};

/**
 * Smooth Scroll Module
 * Handles smooth scrolling for anchor links
 */
const SmoothScroll = {
  init() {
    const anchors = document.querySelectorAll('a[href^="#"]');
    anchors.forEach((anchor) => {
      anchor.addEventListener("click", (e) => this.handleClick(e, anchor));
    });
  },

  handleClick(event, anchor) {
    event.preventDefault();
    const targetId = anchor.getAttribute("href");
    const target = document.querySelector(targetId);

    if (target) {
      target.scrollIntoView({
        behavior: "smooth",
        block: "start",
      });
    }
  },
};

/**
 * Profile Stack Module
 * Handles the interactive profile image stack
 */
const ProfileStack = {
  cards: null,
  dots: null,
  currentIndex: 0,

  init() {
    this.cards = document.querySelectorAll(".profile-card");
    this.dots = document.querySelectorAll(".stack-dot");

    if (!this.cards.length) return;

    this.bindEvents();
  },

  bindEvents() {
    // Click on cards
    this.cards.forEach((card, index) => {
      card.addEventListener("click", () => {
        if (!card.classList.contains("card-main")) {
          this.updateStack(index);
        }
      });
    });

    // Click on dots
    this.dots.forEach((dot, index) => {
      dot.addEventListener("click", () => {
        this.updateStack(index);
      });
    });
  },

  updateStack(newIndex) {
    const totalCards = this.cards.length;

    this.cards.forEach((card, i) => {
      card.classList.remove("card-main", "card-back-1", "card-back-2");

      if (i === newIndex) {
        card.classList.add("card-main");
      } else if (i === (newIndex + 1) % totalCards) {
        card.classList.add("card-back-1");
      } else {
        card.classList.add("card-back-2");
      }
    });

    this.dots.forEach((dot, i) => {
      dot.classList.toggle("active", i === newIndex);
    });

    this.currentIndex = newIndex;
  },
};

/**
 * Navigation Active State Module
 * Updates active navigation link based on scroll position
 */
const NavigationState = {
  navLinks: null,
  sections: null,

  init() {
    this.navLinks = document.querySelectorAll(".nav-link");
    this.sections = document.querySelectorAll("section[id]");

    if (!this.navLinks.length || !this.sections.length) return;

    window.addEventListener("scroll", () => this.handleScroll());
  },

  handleScroll() {
    const scrollPosition = window.scrollY + 100;

    this.sections.forEach((section) => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      const sectionId = section.getAttribute("id");

      if (
        scrollPosition >= sectionTop &&
        scrollPosition < sectionTop + sectionHeight
      ) {
        this.setActiveLink(sectionId);
      }
    });
  },

  setActiveLink(sectionId) {
    this.navLinks.forEach((link) => {
      link.classList.remove("active");
      if (link.getAttribute("href") === `#${sectionId}`) {
        link.classList.add("active");
      }
    });
  },
};

/**
 * Projects Carousel Module
 * Handles auto-scrolling for the projects horizontal grid
 */
const ProjectsCarousel = {
  grid: null,
  scrollAmount: 0,
  autoScrollInterval: null,
  isHovered: false,

  init() {
    this.grid = document.querySelector(".projects-grid");
    if (!this.grid) return;

    this.bindEvents();
    this.startAutoScroll();
  },

  bindEvents() {
    // Pause auto-scroll on hover or touch
    this.grid.addEventListener("mouseenter", () => {
      this.isHovered = true;
    });

    this.grid.addEventListener("mouseleave", () => {
      this.isHovered = false;
    });

    this.grid.addEventListener("touchstart", () => {
      this.isHovered = true;
    });

    this.grid.addEventListener("touchend", () => {
      setTimeout(() => {
        this.isHovered = false;
      }, 2000); // Resume after a delay on mobile
    });
  },

  startAutoScroll() {
    this.autoScrollInterval = setInterval(() => {
      if (!this.isHovered) {
        this.scrollNext();
      }
    }, 3000); // Scroll every 3 seconds for more obvious motion
  },

  scrollNext() {
    if (!this.grid) return;

    const firstCard = this.grid.querySelector(".project-card");
    if (!firstCard) return;
    
    // Calculate the width of one card + the gap between cards
    const style = window.getComputedStyle(this.grid);
    const gap = parseInt(style.gap) || 24; 
    const scrollStep = firstCard.offsetWidth + gap;

    const maxScroll = this.grid.scrollWidth - this.grid.clientWidth;
    
    // Using Math.ceil to prevent sub-pixel issues where it thought it wasn't at the end
    if (Math.ceil(this.grid.scrollLeft) >= maxScroll - 10) { 
      // If at the end, snap back to start
      this.grid.scrollTo({
        left: 0,
        behavior: 'smooth'
      });
    } else {
      // Calculate next exact position
      const nextPosition = this.grid.scrollLeft + scrollStep;
      this.grid.scrollTo({
        left: nextPosition,
        behavior: 'smooth'
      });
    }
  }
};

/**
 * Initialize all modules when DOM is ready
 */
document.addEventListener("DOMContentLoaded", () => {
  // Typing animation with configurable texts
  const typingTexts = window.TYPING_TEXTS || [
    "Best Patcharapon",
    "Software Developer",
    "QA Tester",
    "Ruby on Rails Developer",
  ];

  TypingAnimation.init("typingName", typingTexts);
  TechTagsSearch.init();
  SmoothScroll.init();
  ProfileStack.init();
  NavigationState.init();
  ProjectsCarousel.init();
});

// Export modules for potential external use
window.HomepageModules = {
  TypingAnimation,
  TechTagsSearch,
  SmoothScroll,
  ProfileStack,
  NavigationState,
  ProjectsCarousel,
};
