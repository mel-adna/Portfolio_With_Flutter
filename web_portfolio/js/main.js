// Data is loaded from data.js

document.addEventListener('DOMContentLoaded', () => {
    // Theme Toggle
    initTheme();

    // Mobile Menu
    initMobileMenu();

    // Render Content
    renderAbout();
    renderSkills();
    renderProjects('all');
    renderExperience();
    renderContact();

    // Event Listeners
    initTabs();
    initScrollSpy();
    initAnimations();
    initUIEnhancements();
    initContactForm();

    // Smooth scroll
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
});

// Theme Logic
function initTheme() {
    const themeToggle = document.getElementById('theme-toggle');
    const icon = themeToggle.querySelector('.material-icons-round');

    // Check local storage or system preference
    const savedTheme = localStorage.getItem('theme');
    const systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

    if (savedTheme === 'light') {
        setTheme('light');
    } else {
        setTheme('dark'); // Default to dark
    }

    themeToggle.addEventListener('click', () => {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        setTheme(newTheme);
    });
}

function setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
    const icon = document.querySelector('#theme-toggle .material-icons-round');
    icon.textContent = theme === 'dark' ? 'light_mode' : 'dark_mode';
}

// Mobile Menu Logic
function initMobileMenu() {
    const toggleBtn = document.getElementById('mobile-menu-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    const menuIcon = toggleBtn.querySelector('.material-icons-round');
    const links = mobileMenu.querySelectorAll('.mobile-nav-link');

    toggleBtn.addEventListener('click', () => {
        const isActive = mobileMenu.classList.contains('active');
        if (isActive) {
            mobileMenu.classList.remove('active');
            menuIcon.textContent = 'menu';
            document.body.style.overflow = '';
        } else {
            mobileMenu.classList.add('active');
            menuIcon.textContent = 'close';
            document.body.style.overflow = 'hidden';
        }
    });

    links.forEach(link => {
        link.addEventListener('click', () => {
            mobileMenu.classList.remove('active');
            menuIcon.textContent = 'menu';
            document.body.style.overflow = '';
        });
    });
}

// Animations
function initAnimations() {
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Select elements to animate
    const animatedElements = document.querySelectorAll('.section-header, .card, .experience-item, .about-content-wrapper, .contact-wrapper');
    animatedElements.forEach(el => {
        el.classList.add('fade-in-up');
        observer.observe(el);
    });
}

// UI Enhancements (Scroll Progress, Back to Top)
function initUIEnhancements() {
    const progressBar = document.getElementById('scroll-progress-bar');
    const backToTopBtn = document.getElementById('back-to-top');

    window.addEventListener('scroll', () => {
        // Scroll Progress
        const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
        const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
        const scrolled = (winScroll / height) * 100;
        if (progressBar) {
            progressBar.style.width = scrolled + "%";
        }

        // Back to Top Button
        if (backToTopBtn) {
            if (winScroll > 300) {
                backToTopBtn.classList.add('visible');
            } else {
                backToTopBtn.classList.remove('visible');
            }
        }
    });

    if (backToTopBtn) {
        backToTopBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
}

// Toast Notification
function showToast(message, type = 'default') {
    const container = document.getElementById('toast-container');
    if (!container) return;

    const toast = document.createElement('div');
    toast.className = `toast ${type}`;

    let icon = 'info';
    if (type === 'success') icon = 'check_circle';
    if (type === 'error') icon = 'error';

    toast.innerHTML = `<span class="material-icons-round">${icon}</span> ${message}`;
    container.appendChild(toast);

    // Trigger animation
    requestAnimationFrame(() => {
        toast.classList.add('visible');
    });

    // Remove after 3s
    setTimeout(() => {
        toast.classList.remove('visible');
        setTimeout(() => {
            toast.remove();
        }, 300);
    }, 3000);
}

// Contact Form Handling (AJAX)
function initContactForm() {
    const form = document.getElementById('contact-form');
    if (!form) return;

    form.addEventListener('submit', async function (event) {
        event.preventDefault();
        const button = form.querySelector('button[type="submit"]');
        const originalText = button.innerHTML;

        // Show loading state
        button.disabled = true;
        button.innerHTML = 'Sending... <span class="material-icons-round spin">sync</span>';

        const data = new FormData(event.target);

        try {
            const response = await fetch(event.target.action, {
                method: form.method,
                body: data,
                headers: {
                    'Accept': 'application/json'
                }
            });

            if (response.ok) {
                showToast("Message sent successfully!", "success");
                form.reset();
            } else {
                const errorData = await response.json();
                if (Object.hasOwn(errorData, 'errors')) {
                    showToast(errorData["errors"].map(error => error["message"]).join(", "), "error");
                } else {
                    showToast("Oops! There was a problem submitting your form.", "error");
                }
            }
        } catch (error) {
            showToast("Oops! Network error. Please try again.", "error");
        } finally {
            // Restore button state
            button.disabled = false;
            button.innerHTML = originalText;
        }
    });
}


// Rendering Functions
function renderAbout() {
    const container = document.querySelector('#about .container');

    // Split description into paragraphs
    const paragraphs = aboutData.description.split('\n\n').map(p => `<p class="body-medium text-muted" style="margin-bottom: 1rem;">${p}</p>`).join('');

    container.innerHTML = `
    <div class="section-header fade-in-up">
        <h2 class="heading-large">About Me</h2>
        <p class="body-medium text-muted">Get to know my background and what drives me</p>
    </div>
    <div class="about-content-wrapper fade-in-up">
        <div class="profile-container">
             <!-- Profile Column (Image + Resume) -->
            <div class="profile-column">
                <div class="profile-image-wrapper">
                     <div class="profile-image-glow"></div>
                     <img src="assets/images/profile.png" alt="Profile" class="profile-image" onerror="this.onerror=null; this.parentElement.innerHTML='<div class=\\'profile-placeholder\\'>ME</div>'">
                </div>
                <a href="assets/docs/Mohamed_El_Adnani_Resume.pdf" target="_blank" class="btn btn-outline">
                    Download Resume <span class="material-icons-round">download</span>
                </a>
            </div>

            <!-- About Content -->
            <div class="card about-text-card">
                <h3 class="heading-medium" style="margin-bottom: 1rem;">${aboutData.title}</h3>
                ${paragraphs}
                <div class="about-highlights">
                    ${aboutData.highlights.map(h => `
                        <div class="highlight-item">
                            <span class="material-icons-round text-accent" style="font-size: 18px;">${h.icon}</span>
                            <span class="body-small" style="font-weight: 500;">${h.label}</span>
                        </div>
                    `).join('')}
                </div>
            </div>
        </div>

        <!-- Stats -->
        <div class="card stats-card">
            ${aboutData.stats.map(s => `
                <div class="text-center">
                    <h4 class="heading-medium text-accent">${s.value}</h4>
                    <p class="caption text-muted">${s.label}</p>
                </div>
            `).join('')}
        </div>
    </div>
  `;
}

function renderContact() {
    const sectionContainer = document.querySelector('#contact .container');

    sectionContainer.innerHTML = `
        <div class="section-header fade-in-up">
            <h2 class="heading-large">Get In Touch</h2>
            <p class="body-medium text-muted">Let's discuss your project or just say hello</p>
        </div>
        <div class="contact-wrapper fade-in-up">
            <!-- Contact Info -->
            <div class="contact-info">
                <h3 class="heading-medium" style="margin-bottom: 1rem;">${contactData.header}</h3>
                <p class="body-medium text-muted" style="margin-bottom: 2rem;">${contactData.description}</p>
                
                <div class="contact-details">
                    <div class="contact-item" onclick="window.location.href='mailto:${contactData.email}'" style="cursor: pointer;">
                        <div class="contact-item-icon">
                            <span class="material-icons-round">email</span>
                        </div>
                        <div>
                            <div class="caption text-muted">Email</div>
                            <div class="body-medium">${contactData.email}</div>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-item-icon">
                            <span class="material-icons-round">location_on</span>
                        </div>
                        <div>
                            <div class="caption text-muted">Location</div>
                            <div class="body-medium">${contactData.location}</div>
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-item-icon">
                            <span class="material-icons-round">schedule</span>
                        </div>
                        <div>
                            <div class="caption text-muted">Availability</div>
                            <div class="body-medium">${contactData.availability}</div>
                        </div>
                    </div>
                </div>

                <div class="contact-socials">
                    ${contactData.socials.map(s => `
                        <a href="${s.url}" target="_blank" class="btn btn-outline" style="gap: 0.5rem;">
                            <i class="${s.icon}"></i> ${s.platform}
                        </a>
                    `).join('')}
                </div>
            </div>

            <!-- Contact Form -->
            <!-- Contact Form -->
            <div class="card contact-form-card">
                <h3 class="heading-small" style="margin-bottom: 1.5rem;">Send a message</h3>
                <form id="contact-form" action="https://formspree.io/f/mykgroeo" method="POST" class="form-group">
                    <div class="form-group">
                        <label class="caption">Name</label>
                        <input type="text" name="name" placeholder="Your name" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="caption">Email</label>
                        <input type="email" name="email" placeholder="your@email.com" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="caption">Message</label>
                        <textarea name="message" placeholder="Tell me about your project..." rows="5" class="form-input form-textarea" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg" style="margin-top: 0.5rem;">
                        Send Message <span class="material-icons-round">send</span>
                    </button>
                </form>
            </div>
        </div>
    `;
}

function renderSkills() {
    const container = document.getElementById('skills-grid');

    skillsData.forEach(category => {
        const card = document.createElement('div');
        card.className = 'card fade-in-up';
        card.innerHTML = `
      <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1rem;">
        <span class="material-icons-round text-accent" style="font-size: 24px;">${category.icon}</span>
        <div>
          <h3 class="heading-small">${category.name}</h3>
          <p class="caption text-muted">${category.description}</p>
        </div>
      </div>
      <div style="display: flex; flex-wrap: wrap; gap: 0.5rem;">
        ${category.skills.map(skill => `<span class="badge badge-accent">${skill}</span>`).join('')}
      </div>
    `;
        container.appendChild(card);
    });
}

function renderProjects(filter) {
    const container = document.getElementById('projects-grid');
    container.innerHTML = '';

    const filteredProjects = filter === 'all'
        ? projectsData
        : projectsData.filter(p => p.category === filter);

    if (filteredProjects.length === 0) {
        container.innerHTML = '<p class="text-muted text-center" style="grid-column: 1/-1;">No projects in this category yet.</p>';
        return;
    }

    filteredProjects.forEach(project => {
        // Determine icon based on category
        let icon = 'apps';
        if (project.category === 'mobile') icon = 'smartphone';
        else if (project.category === 'web') icon = 'web';
        else if (project.category === 'package') icon = 'inventory_2';

        // Use placeholder if no image (though we handled this in CSS/HTML structure generally)
        const imageHtml = project.imageUrl
            ? `<img src="${project.imageUrl}" alt="${project.title}" loading="lazy" onerror="this.parentElement.innerHTML='<div style=\\'width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:rgba(99,102,241,0.1);color:var(--accent)\\'><span class=\\'material-icons-round\\' style=\\'font-size:48px\\'>${icon}</span></div>'">`
            : `<div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:rgba(99,102,241,0.1);color:var(--accent)"><span class="material-icons-round" style="font-size: 48px;">${icon}</span></div>`;

        const card = document.createElement('div');
        card.className = 'card project-card fade-in-up';
        card.innerHTML = `
      <div class="project-image">
        ${imageHtml}
      </div>
      <h3 class="heading-small" style="margin-bottom: 0.25rem;">${project.title}</h3>
      <p class="body-small text-muted" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 1rem;">
        ${project.description}
      </p>
      <div class="project-tags">
        ${project.technologies.slice(0, 3).map(tech => `<span class="badge badge-accent">${tech}</span>`).join('')}
      </div>
      <div style="display: flex; gap: 0.5rem; margin-top: 1rem;">
        ${project.githubUrl ? `<a href="${project.githubUrl}" target="_blank" class="btn btn-ghost" style="padding: 0.25rem 0.5rem; font-size: 12px;"><i class="fab fa-github"></i> GitHub</a>` : ''}
        ${project.demoUrl ? `<a href="${project.demoUrl}" target="_blank" class="btn btn-ghost" style="padding: 0.25rem 0.5rem; font-size: 12px;"><i class="fas fa-globe"></i> Demo</a>` : ''}
      </div>
    `;
        container.appendChild(card);
    });

    // Re-run animations for new elements
    if (typeof initAnimations === 'function') {
        // This is a bit tricky because initAnimations adds observers. doing it again might duplicate.
        // Actually, the observers are only added to elements that exist.
        // But the observer instance is local to initAnimations.
        // A better way is to attach the observer to the new elements.
        // For simplicity, let's just manually trigger fade-in for now or let the global observer handle if we made it global.
        // Since we can't easily make it global without more refactoring, let's just make sure they have the class
        // and rely on a timeout hack or just let them be visible.
        // Wait, I can just select them and add 'visible' closely after creation for now.
        setTimeout(() => {
            document.querySelectorAll('.project-card').forEach(c => c.classList.add('visible'));
        }, 100);
    }
}

function renderExperience() {
    const container = document.getElementById('experience-list');

    experienceData.forEach(exp => {
        const item = document.createElement('div');
        item.className = 'experience-item fade-in-up';
        item.innerHTML = `
      <div class="experience-dot"></div>
      <div class="experience-header">
        <h3 class="heading-medium">${exp.role}</h3>
        <div style="display: flex; justify-content: space-between; align-items: baseline; flex-wrap: wrap;">
          <h4 class="body-large text-accent">${exp.company}</h4>
          <span class="caption text-muted">${exp.duration} | ${exp.location}</span>
        </div>
      </div>
      <p class="body-medium text-muted">${exp.description}</p>
      <ul class="experience-responsibilities body-small">
        ${exp.responsibilities.map(r => `<li>${r}</li>`).join('')}
      </ul>
      <div style="margin-top: 1rem; display: flex; flex-wrap: wrap; gap: 0.5rem;">
        ${exp.technologies.map(tech => `<span class="tech-badge">${tech}</span>`).join('')}
      </div>
    `;
        container.appendChild(item);
    });
}

function initTabs() {
    const tabs = document.querySelectorAll('.tab-btn');
    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            // Remove active class from all
            tabs.forEach(t => t.classList.remove('active'));
            // Add active to current
            tab.classList.add('active');
            // Filter functionality
            renderProjects(tab.dataset.category);
        });
    });
}

function initScrollSpy() {
    const sections = document.querySelectorAll('section');
    const navLinks = document.querySelectorAll('.nav-link');

    window.addEventListener('scroll', () => {
        let current = '';

        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            if (scrollY >= (sectionTop - 150)) {
                current = section.getAttribute('id');
            }
        });

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href').includes(current)) {
                link.classList.add('active');
            }
        });
    });
}
