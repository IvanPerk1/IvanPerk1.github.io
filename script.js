document.addEventListener('DOMContentLoaded', () => {
    // --- Анимация появления секций при скролле ---
    const observerOptions = {
        threshold: 0.15, // Секция считается видимой, когда показано 15%
        rootMargin: '0px 0px -50px 0px' // Немного смещаем точку срабатывания вверх
    };

    const sectionObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                // Можно прекратить наблюдение после появления, если не нужна анимация исчезновения
                // sectionObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);

    document.querySelectorAll('.reveal-section').forEach(section => {
        sectionObserver.observe(section);
    });

    // --- Изменение навбара при скролле ---
    const navbar = document.querySelector('.navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // --- Мобильное меню ---
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navLinksContainer = document.querySelector('.nav-links-container');
    const navLinks = document.querySelectorAll('.nav-links a');

    mobileMenuBtn.addEventListener('click', () => {
        navLinksContainer.classList.toggle('active');
    });

    // Закрываем меню при клике на ссылку
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            navLinksContainer.classList.remove('active');
        });
    });

    // --- Переключение языков (Логика отображения) ---
    // Основная логика переводов находится в translations.js,
    // здесь мы только управляем визуальным состоянием кнопок.
    const langBtns = document.querySelectorAll('.lang-btn');
    langBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Убираем активный класс у всех кнопок
            langBtns.forEach(b => b.classList.remove('active'));
            // Добавляем активный класс нажатой кнопке
            btn.classList.add('active');
            
            // Вызываем функцию смены языка из translations.js
            const lang = btn.getAttribute('data-lang');
            if (typeof setLanguage === 'function') {
                setLanguage(lang);
            }
        });
    });

    // Плавный скролл для якорей (для старых браузеров, хотя CSS scroll-behavior обычно справляется)
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                const navHeight = document.querySelector('.navbar').offsetHeight;
                const targetPosition = targetElement.getBoundingClientRect().top + window.scrollY - navHeight - 20;
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
});
