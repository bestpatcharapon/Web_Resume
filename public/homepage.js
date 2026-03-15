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
 * Projects Slider Module
 * Handles dot navigation and scroll snapping for projects
 */
const ProjectsSlider = {
  track: null,
  cards: null,
  dotsContainer: null,
  dots: [],
  totalPages: 0,
  cardsPerPage: window.innerWidth > 768 ? 3 : 1,

  init() {
    this.track = document.getElementById("projects-track");
    this.dotsContainer = document.getElementById("projects-nav-dots");
    
    if (!this.track || !this.dotsContainer) return;
    
    this.cards = this.track.querySelectorAll(".project-card");
    if (this.cards.length === 0) return;

    // Use a small timeout to let CSS layout calculate widths properly
    setTimeout(() => {
      this.setupDots();
      this.bindEvents();
      this.updateActiveDot();
    }, 100);
  },

  setupDots() {
    this.dotsContainer.innerHTML = "";
    this.dots = [];
    
    // Remove any existing placeholders from previous calculations
    const existingPlaceholders = this.track.querySelectorAll(".project-card-placeholder");
    existingPlaceholders.forEach(el => el.remove());

    this.cardsPerPage = window.innerWidth > 768 ? 3 : 1;
    this.totalPages = Math.ceil(this.cards.length / this.cardsPerPage);
    
    if (this.totalPages <= 1) return;

    // Append invisible placeholder cards to pad the final page so it scrolls cleanly
    const remainder = this.cards.length % this.cardsPerPage;
    if (remainder > 0) {
      const placeholdersNeeded = this.cardsPerPage - remainder;
      for (let i = 0; i < placeholdersNeeded; i++) {
        const placeholder = document.createElement("div");
        placeholder.className = "project-card project-card-placeholder";
        placeholder.style.visibility = "hidden";
        placeholder.style.border = "none";
        placeholder.style.boxShadow = "none";
        placeholder.style.background = "transparent";
        this.track.appendChild(placeholder);
      }
    }

    // Save the full list of cards (including placeholders) for accurate scroll measurements
    this.displayCards = this.track.querySelectorAll(".project-card");

    for (let i = 0; i < this.totalPages; i++) {
      const dot = document.createElement("button");
      dot.className = "project-dot";
      dot.setAttribute("aria-label", `Go to page ${i + 1}`);
      if (i === 0) dot.classList.add("active");
      
      this.dotsContainer.appendChild(dot);
      this.dots.push(dot);
      
      dot.addEventListener("click", () => this.scrollToPage(i));
    }
  },

  bindEvents() {
    // Re-calculate dots on resize since number of cards per page changes
    window.addEventListener("resize", () => {
      clearTimeout(this.resizeTimer);
      this.resizeTimer = setTimeout(() => {
        const newCardsPerPage = window.innerWidth > 768 ? 3 : 1;
        if (this.cardsPerPage !== newCardsPerPage) {
          this.setupDots();
        }
        this.updateActiveDot();
      }, 250);
    });

    // Update active dot when user scrolls manually
    this.track.addEventListener("scroll", () => {
      if (!this.isScrolling) {
        window.requestAnimationFrame(() => {
          this.updateActiveDot();
          this.isScrolling = false;
        });
        this.isScrolling = true;
      }
    });
  },

  scrollToPage(index) {
    if (this.totalPages <= 1) return;
    
    // Find the first card of the target page
    const targetCardIndex = index * this.cardsPerPage;
    const targetCards = this.displayCards || this.cards;
    if (!targetCards[targetCardIndex]) return;
    
    const card = targetCards[targetCardIndex];
    const scrollLeft = card.offsetLeft - this.track.offsetLeft;
    
    this.track.scrollTo({
      left: scrollLeft,
      behavior: "smooth"
    });
  },

  updateActiveDot() {
    if (this.totalPages <= 1 || !this.dots.length) return;
    
    const trackWidth = this.track.clientWidth;
    const scrollLeft = this.track.scrollLeft;
    const maxScroll = this.track.scrollWidth - trackWidth;
    
    let activeIndex = 0;
    
    // If scrolled to the very end
    if (Math.abs(scrollLeft - maxScroll) < 10) {
      activeIndex = this.totalPages - 1;
    } else {
      activeIndex = Math.round(scrollLeft / trackWidth);
    }

    this.dots.forEach((dot, index) => {
      if (index === activeIndex) {
        dot.classList.add("active");
      } else {
        dot.classList.remove("active");
      }
    });
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
  ProjectsSlider.init();
  ImageLightbox.init();
});

// Image Lightbox Module
const ImageLightbox = (() => {
  const lightboxElement = document.getElementById("image-lightbox");
  const lightboxImage = document.getElementById("lightbox-image");
  const lightboxTitle = document.getElementById("lightbox-title");
  const closeButton = document.querySelector(".lightbox-close");

  const init = () => {
    // Add click listeners to all clickable images
    const clickableImages = document.querySelectorAll(".clickable-image");
    clickableImages.forEach((img) => {
      img.addEventListener("click", openLightbox);
    });

    // Close button
    closeButton.addEventListener("click", closeLightbox);

    // Close when clicking outside the image
    lightboxElement.addEventListener("click", (e) => {
      if (e.target === lightboxElement) {
        closeLightbox();
      }
    });

    // Close on Escape key
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") {
        closeLightbox();
      }
    });
  };

  const openLightbox = (e) => {
    const img = e.target;
    lightboxImage.src = img.src;
    lightboxTitle.textContent = img.getAttribute("data-title") || "Image";
    lightboxElement.classList.add("active");
    document.body.style.overflow = "hidden"; // Prevent scrolling
  };

  const closeLightbox = () => {
    lightboxElement.classList.remove("active");
    document.body.style.overflow = "auto"; // Allow scrolling again
  };

  return {
    init,
  };
})();

// Export modules for potential external use
window.HomepageModules = {
  TypingAnimation,
  TechTagsSearch,
  SmoothScroll,
  ProfileStack,
  NavigationState,
  ProjectsSlider,
  ImageLightbox,
};
