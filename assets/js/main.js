const menuToggle = document.getElementById("menuToggle");
const mainNav = document.getElementById("mainNav");
const pageLoader = document.getElementById("pageLoader");
const themeToggle = document.getElementById("themeToggle");
const backToTop = document.getElementById("backToTop");

if (pageLoader) {
    const hideLoader = () => {
        pageLoader.classList.add("is-hidden");
    };

    window.addEventListener("load", () => {
        setTimeout(hideLoader, 250);
    });

    setTimeout(hideLoader, 2200);
}

if (menuToggle && mainNav) {
    menuToggle.addEventListener("click", () => {
        mainNav.classList.toggle("open");
    });
}

if (themeToggle) {
    const icon = themeToggle.querySelector("i");
    const toggleText = themeToggle.querySelector(".toggle-text");
    const setTheme = (theme) => {
        document.body.setAttribute("data-theme", theme);
        localStorage.setItem("theme", theme);

        if (icon) {
            icon.className = theme === "dark" ? "fa-solid fa-sun" : "fa-solid fa-moon";
        }

        themeToggle.setAttribute(
            "aria-label",
            theme === "dark" ? "Switch to light mode" : "Switch to dark mode"
        );

        themeToggle.title = theme === "dark" ? "Switch to light mode" : "Switch to dark mode";

        if (toggleText) {
            toggleText.textContent = theme === "dark" ? "Light mode" : "Dark mode";
        }
    };

    const savedTheme = localStorage.getItem("theme");
    if (savedTheme === "dark" || savedTheme === "light") {
        setTheme(savedTheme);
    }

    themeToggle.addEventListener("click", () => {
        const currentTheme = document.body.getAttribute("data-theme") || "light";
        setTheme(currentTheme === "dark" ? "light" : "dark");
    });
}

if (backToTop) {
    const toggleBackToTop = () => {
        backToTop.classList.toggle("show", window.scrollY > 300);
    };

    window.addEventListener("scroll", toggleBackToTop);
    toggleBackToTop();

    backToTop.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });
}

const navLinks = document.querySelectorAll('a[href^="#"]');
navLinks.forEach((link) => {
    link.addEventListener("click", (event) => {
        const targetId = link.getAttribute("href");
        if (!targetId || targetId.length < 2) {
            return;
        }

        const target = document.querySelector(targetId);
        if (!target) {
            return;
        }

        event.preventDefault();
        target.scrollIntoView({ behavior: "smooth", block: "start" });

        if (mainNav && mainNav.classList.contains("open")) {
            mainNav.classList.remove("open");
        }
    });
});

const tabs = document.querySelectorAll(".menu-tabs .tab");
tabs.forEach((tab) => {
    tab.addEventListener("click", () => {
        tabs.forEach((item) => item.classList.remove("active"));
        tab.classList.add("active");
    });
});

const targetDate = new Date();
targetDate.setDate(targetDate.getDate() + 8);

const daysEl = document.getElementById("days");
const hoursEl = document.getElementById("hours");
const minutesEl = document.getElementById("minutes");
const secondsEl = document.getElementById("seconds");

function updateCountdown() {
    const now = new Date().getTime();
    const distance = targetDate.getTime() - now;

    if (distance <= 0) {
        if (daysEl) daysEl.textContent = "00";
        if (hoursEl) hoursEl.textContent = "00";
        if (minutesEl) minutesEl.textContent = "00";
        if (secondsEl) secondsEl.textContent = "00";
        return;
    }

    const dayMs = 1000 * 60 * 60 * 24;
    const hourMs = 1000 * 60 * 60;
    const minuteMs = 1000 * 60;

    const days = Math.floor(distance / dayMs);
    const hours = Math.floor((distance % dayMs) / hourMs);
    const minutes = Math.floor((distance % hourMs) / minuteMs);
    const seconds = Math.floor((distance % minuteMs) / 1000);

    if (daysEl) daysEl.textContent = String(days).padStart(2, "0");
    if (hoursEl) hoursEl.textContent = String(hours).padStart(2, "0");
    if (minutesEl) minutesEl.textContent = String(minutes).padStart(2, "0");
    if (secondsEl) secondsEl.textContent = String(seconds).padStart(2, "0");
}

updateCountdown();
setInterval(updateCountdown, 1000);

const revealElements = document.querySelectorAll(".reveal");

if ("IntersectionObserver" in window) {
    const observer = new IntersectionObserver(
        (entries) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("visible");
                    observer.unobserve(entry.target);
                }
            });
        },
        { threshold: 0.12 }
    );

    revealElements.forEach((el) => observer.observe(el));
} else {
    revealElements.forEach((el) => el.classList.add("visible"));
}
