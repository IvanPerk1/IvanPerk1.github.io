// Полные переводы для всего сайта
const translations = {
    en: {
        // Navigation
        nav_features: "Features",
        nav_why: "Why Wake PC?",
        nav_download: "Download",
        btn_get_started: "Get Started",
        
        // Hero Section
        hero_title_1: "Wake your PC",
        hero_title_2: "from anywhere",
        hero_subtitle: "Turn on your PC remotely for free. Upgrade to Premium for full power management, volume control, and unlimited computers.",
        hero_btn_appstore: "Download on App Store",
        hero_btn_agent: "Windows Agent",
        hero_note: "Free • No account required • Works on local network",
        
        // Why Wake PC Section
        why_title: "Why Wake PC?",
        why_subtitle: "Unlike TeamViewer, AnyDesk, or Chrome Remote Desktop",
        
        why_fast_title: "Lightning Fast",
        why_fast_desc: "Direct Wake-on-LAN packets. No cloud relay, no lag. Commands execute instantly on your local network.",
        why_fast_badge: "vs slow remote desktop protocols",
        
        why_private_title: "100% Private",
        why_private_desc: "Everything stays on YOUR network. No data sent to servers. No accounts. No tracking. Your privacy is guaranteed.",
        why_private_badge: "vs cloud-based tools that log everything",
        
        why_free_title: "Free to Start",
        why_free_desc: "Core Wake-on-LAN feature FREE FOREVER. Upgrade to Premium for shutdown, restart, sleep, volume control, multiple PCs, and all 13 themes at $2.99/month with 3-day free trial.",
        why_free_badge: "vs TeamViewer's mandatory $49/month",
        
        why_simple_title: "Simple & Focused",
        why_simple_desc: "Does one thing perfectly: power management. No bloat, no complexity, no unnecessary features.",
        why_simple_badge: "vs bloated 500MB remote desktop apps",
        
        why_native_title: "Native iOS Experience",
        why_native_desc: "Built with SwiftUI. Feels like a true iOS app. 13 beautiful themes, haptic feedback, smooth 60fps animations.",
        why_native_badge: "vs clunky web-based interfaces",
        
        why_battery_title: "Battery Friendly",
        why_battery_desc: "No background services, no constant polling. Only active when you use it.",
        why_battery_badge: "vs battery-draining remote desktop apps",
        
        // Features Section
        features_title: "Everything you need",
        features_subtitle: "Powerful features in a beautiful package",
        
        feature_wol_title: "Wake-on-LAN",
        feature_wol_desc: "Turn on your PC remotely from anywhere in your home",
        
        feature_power_title: "Power Management",
        feature_power_desc: "Shutdown, restart, or sleep with one tap",
        
        feature_volume_title: "Volume Control",
        feature_volume_desc: "Adjust system volume and mute remotely",
        
        feature_multi_title: "Multiple PCs",
        feature_multi_desc: "Manage unlimited computers with custom profiles",
        
        feature_themes_title: "13 Beautiful Themes",
        feature_themes_desc: "Ocean, Fire, Forest, Neon and more",
        
        feature_qr_title: "QR Code Setup",
        feature_qr_desc: "Scan and connect in seconds",
        
        feature_lang_title: "Multi-language",
        feature_lang_desc: "English, Russian, Ukrainian",
        
        feature_secure_title: "Secure",
        feature_secure_desc: "Token-based authentication",
        
        // Pricing Section
        pricing_title: "Simple, transparent pricing",
        pricing_subtitle: "Start free, upgrade when you need more",
        
        pricing_free_badge: "FREE",
        pricing_free_title: "Basic",
        pricing_free_price: "$0",
        pricing_free_period: "/forever",
        pricing_free_desc: "Perfect for single PC users",
        pricing_free_btn: "Download Free",
        
        pricing_free_feat1: "Wake-on-LAN (turn on PC)",
        pricing_free_feat2: "1 computer profile",
        pricing_free_feat3: "Ocean theme",
        pricing_free_feat4: "QR code setup",
        pricing_free_feat5: "Power management",
        pricing_free_feat6: "Volume control",
        pricing_free_feat7: "Multiple PCs",
        pricing_free_feat8: "All 13 themes",
        
        pricing_premium_badge: "PREMIUM",
        pricing_premium_title: "Premium",
        pricing_premium_price: "$2.99",
        pricing_premium_period: "/month",
        pricing_premium_desc: "Full control of all your computers",
        pricing_premium_btn: "Try 3 Days Free",
        pricing_premium_note: "Cancel anytime • $24.99/year option available",
        
        pricing_premium_feat1: "Everything in Basic",
        pricing_premium_feat2: "Shutdown, Restart, Sleep",
        pricing_premium_feat3: "Volume control + mute",
        pricing_premium_feat4: "Unlimited computers",
        pricing_premium_feat5: "All 13 beautiful themes",
        pricing_premium_feat6: "Priority support",
        pricing_premium_feat7: "Future features included",
        
        // Screenshots Section
        screenshots_title: "Beautiful design, powerful features",
        
        // Download Section
        download_title: "Get started in 3 easy steps",
        
        step1_number: "1",
        step1_title: "Download the app",
        step1_desc: "Get Wake PC from the App Store",
        
        step2_number: "2",
        step2_title: "Install Windows Agent",
        step2_desc: "Download and run as administrator on your PC",
        step2_btn: "Download WakeAgent.exe",
        
        step3_number: "3",
        step3_title: "Scan QR & Connect",
        step3_desc: "Open iPhone Camera, scan the QR code from agent, tap \"Open in Wake PC\"",
        
        // Footer
        footer_copyright: "Wake PC © 2025",
        footer_privacy: "Privacy Policy",
        footer_contact: "Contact"
    },
    
    ru: {
        // Navigation
        nav_features: "Возможности",
        nav_why: "Почему Wake PC?",
        nav_download: "Скачать",
        btn_get_started: "Начать",
        
        // Hero Section
        hero_title_1: "Включите компьютер",
        hero_title_2: "из любого места",
        hero_subtitle: "Включайте компьютер удалённо бесплатно. Перейдите на Premium для полного управления питанием, громкостью и неограниченным количеством ПК.",
        hero_btn_appstore: "Загрузить в App Store",
        hero_btn_agent: "Агент для Windows",
        hero_note: "Бесплатно • Без регистрации • Работает в локальной сети",
        
        // Why Wake PC Section
        why_title: "Почему Wake PC?",
        why_subtitle: "В отличие от TeamViewer, AnyDesk или Chrome Remote Desktop",
        
        why_fast_title: "Молниеносная скорость",
        why_fast_desc: "Прямые Wake-on-LAN пакеты. Без облачных серверов, без задержек. Команды выполняются мгновенно в вашей локальной сети.",
        why_fast_badge: "vs медленные протоколы удалённого рабочего стола",
        
        why_private_title: "100% Приватность",
        why_private_desc: "Всё остаётся в ВАШЕЙ сети. Никаких данных на серверы. Без аккаунтов. Без отслеживания. Ваша конфиденциальность гарантирована.",
        why_private_badge: "vs облачные инструменты которые всё логируют",
        
        why_free_title: "Бесплатный старт",
        why_free_desc: "Основная функция Wake-on-LAN БЕСПЛАТНА НАВСЕГДА. Перейдите на Premium для выключения, перезагрузки, спящего режима, управления громкостью, множественных ПК и всех 13 тем за $2.99/месяц с 3-дневной пробной версией.",
        why_free_badge: "vs обязательные $49/месяц у TeamViewer",
        
        why_simple_title: "Просто и понятно",
        why_simple_desc: "Делает одно дело идеально: управление питанием. Без лишнего, без сложностей, без ненужных функций.",
        why_simple_badge: "vs раздутые приложения на 500МБ",
        
        why_native_title: "Нативный iOS опыт",
        why_native_desc: "Создано на SwiftUI. Ощущается как настоящее iOS приложение. 13 красивых тем, тактильная отдача, плавная анимация 60fps.",
        why_native_badge: "vs неуклюжие веб-интерфейсы",
        
        why_battery_title: "Бережёт батарею",
        why_battery_desc: "Без фоновых процессов, без постоянных опросов. Активно только когда вы используете.",
        why_battery_badge: "vs приложения которые разряжают батарею",
        
        // Features Section
        features_title: "Всё что нужно",
        features_subtitle: "Мощные функции в красивой упаковке",
        
        feature_wol_title: "Wake-on-LAN",
        feature_wol_desc: "Включите ПК удалённо из любого места в доме",
        
        feature_power_title: "Управление питанием",
        feature_power_desc: "Выключение, перезагрузка или сон одним касанием",
        
        feature_volume_title: "Управление громкостью",
        feature_volume_desc: "Регулируйте системную громкость и отключайте звук удалённо",
        
        feature_multi_title: "Множественные ПК",
        feature_multi_desc: "Управляйте неограниченным количеством компьютеров с персональными профилями",
        
        feature_themes_title: "13 красивых тем",
        feature_themes_desc: "Океан, Огонь, Лес, Неон и другие",
        
        feature_qr_title: "Настройка по QR-коду",
        feature_qr_desc: "Отсканируйте и подключитесь за секунды",
        
        feature_lang_title: "Мультиязычность",
        feature_lang_desc: "Английский, Русский, Украинский",
        
        feature_secure_title: "Безопасность",
        feature_secure_desc: "Аутентификация на основе токенов",
        
        // Pricing Section
        pricing_title: "Простые и прозрачные цены",
        pricing_subtitle: "Начните бесплатно, обновитесь когда нужно больше",
        
        pricing_free_badge: "БЕСПЛАТНО",
        pricing_free_title: "Базовый",
        pricing_free_price: "$0",
        pricing_free_period: "/навсегда",
        pricing_free_desc: "Идеально для одного ПК",
        pricing_free_btn: "Скачать бесплатно",
        
        pricing_free_feat1: "Wake-on-LAN (включение ПК)",
        pricing_free_feat2: "1 профиль компьютера",
        pricing_free_feat3: "Тема Океан",
        pricing_free_feat4: "Настройка по QR-коду",
        pricing_free_feat5: "Управление питанием",
        pricing_free_feat6: "Управление громкостью",
        pricing_free_feat7: "Множественные ПК",
        pricing_free_feat8: "Все 13 тем",
        
        pricing_premium_badge: "ПРЕМИУМ",
        pricing_premium_title: "Премиум",
        pricing_premium_price: "$2.99",
        pricing_premium_period: "/месяц",
        pricing_premium_desc: "Полный контроль всех ваших компьютеров",
        pricing_premium_btn: "3 дня бесплатно",
        pricing_premium_note: "Отмена в любое время • Опция $24.99/год",
        
        pricing_premium_feat1: "Всё из Базового",
        pricing_premium_feat2: "Выключение, Перезагрузка, Сон",
        pricing_premium_feat3: "Управление громкостью + отключение звука",
        pricing_premium_feat4: "Неограниченное количество компьютеров",
        pricing_premium_feat5: "Все 13 красивых тем",
        pricing_premium_feat6: "Приоритетная поддержка",
        pricing_premium_feat7: "Будущие функции включены",
        
        // Screenshots Section
        screenshots_title: "Красивый дизайн, мощные функции",
        
        // Download Section
        download_title: "Начните за 3 простых шага",
        
        step1_number: "1",
        step1_title: "Скачайте приложение",
        step1_desc: "Получите Wake PC из App Store",
        
        step2_number: "2",
        step2_title: "Установите агент для Windows",
        step2_desc: "Скачайте и запустите от имени администратора на вашем ПК",
        step2_btn: "Скачать WakeAgent.exe",
        
        step3_number: "3",
        step3_title: "Отсканируйте QR и подключитесь",
        step3_desc: "Откройте Камеру iPhone, отсканируйте QR-код из агента, нажмите \"Открыть в Wake PC\"",
        
        // Footer
        footer_copyright: "Wake PC © 2025",
        footer_privacy: "Политика конфиденциальности",
        footer_contact: "Контакты"
    },
    
    uk: {
        // Navigation
        nav_features: "Можливості",
        nav_why: "Чому Wake PC?",
        nav_download: "Завантажити",
        btn_get_started: "Почати",
        
        // Hero Section
        hero_title_1: "Увімкніть комп'ютер",
        hero_title_2: "з будь-якого місця",
        hero_subtitle: "Вмикайте комп'ютер віддалено безкоштовно. Перейдіть на Premium для повного керування живленням, гучністю та необмеженою кількістю ПК.",
        hero_btn_appstore: "Завантажити в App Store",
        hero_btn_agent: "Агент для Windows",
        hero_note: "Безкоштовно • Без реєстрації • Працює в локальній мережі",
        
        // Why Wake PC Section
        why_title: "Чому Wake PC?",
        why_subtitle: "На відміну від TeamViewer, AnyDesk або Chrome Remote Desktop",
        
        why_fast_title: "Блискавична швидкість",
        why_fast_desc: "Прямі Wake-on-LAN пакети. Без хмарних серверів, без затримок. Команди виконуються миттєво у вашій локальній мережі.",
        why_fast_badge: "vs повільні протоколи віддаленого робочого столу",
        
        why_private_title: "100% Приватність",
        why_private_desc: "Все залишається у ВАШІЙ мережі. Жодних даних на сервери. Без акаунтів. Без відстеження. Ваша конфіденційність гарантована.",
        why_private_badge: "vs хмарні інструменти які все логують",
        
        why_free_title: "Безкоштовний старт",
        why_free_desc: "Основна функція Wake-on-LAN БЕЗКОШТОВНА НАЗАВЖДИ. Перейдіть на Premium для вимкнення, перезавантаження, сплячого режиму, керування гучністю, множинних ПК та всіх 13 тем за $2.99/місяць з 3-денною пробною версією.",
        why_free_badge: "vs обов'язкові $49/місяць у TeamViewer",
        
        why_simple_title: "Просто і зрозуміло",
        why_simple_desc: "Робить одну справу ідеально: керування живленням. Без зайвого, без складнощів, без непотрібних функцій.",
        why_simple_badge: "vs роздуті додатки на 500МБ",
        
        why_native_title: "Нативний iOS досвід",
        why_native_desc: "Створено на SwiftUI. Відчувається як справжній iOS додаток. 13 красивих тем, тактильний відгук, плавна анімація 60fps.",
        why_native_badge: "vs незграбні веб-інтерфейси",
        
        why_battery_title: "Береже батарею",
        why_battery_desc: "Без фонових процесів, без постійних опитувань. Активний лише коли ви використовуєте.",
        why_battery_badge: "vs додатки які розряджають батарею",
        
        // Features Section
        features_title: "Все що потрібно",
        features_subtitle: "Потужні функції в красивій упаковці",
        
        feature_wol_title: "Wake-on-LAN",
        feature_wol_desc: "Увімкніть ПК віддалено з будь-якого місця в будинку",
        
        feature_power_title: "Керування живленням",
        feature_power_desc: "Вимкнення, перезавантаження або сон одним дотиком",
        
        feature_volume_title: "Керування гучністю",
        feature_volume_desc: "Регулюйте системну гучність та вимикайте звук віддалено",
        
        feature_multi_title: "Множинні ПК",
        feature_multi_desc: "Керуйте необмеженою кількістю комп'ютерів з персональними профілями",
        
        feature_themes_title: "13 красивих тем",
        feature_themes_desc: "Океан, Вогонь, Ліс, Неон та інші",
        
        feature_qr_title: "Налаштування по QR-коду",
        feature_qr_desc: "Скануйте та підключайтесь за секунди",
        
        feature_lang_title: "Мультимовність",
        feature_lang_desc: "Англійська, Російська, Українська",
        
        feature_secure_title: "Безпека",
        feature_secure_desc: "Аутентифікація на основі токенів",
        
        // Pricing Section
        pricing_title: "Прості та прозорі ціни",
        pricing_subtitle: "Почніть безкоштовно, оновіться коли потрібно більше",
        
        pricing_free_badge: "БЕЗКОШТОВНО",
        pricing_free_title: "Базовий",
        pricing_free_price: "$0",
        pricing_free_period: "/назавжди",
        pricing_free_desc: "Ідеально для одного ПК",
        pricing_free_btn: "Завантажити безкоштовно",
        
        pricing_free_feat1: "Wake-on-LAN (увімкнення ПК)",
        pricing_free_feat2: "1 профіль комп'ютера",
        pricing_free_feat3: "Тема Океан",
        pricing_free_feat4: "Налаштування по QR-коду",
        pricing_free_feat5: "Керування живленням",
        pricing_free_feat6: "Керування гучністю",
        pricing_free_feat7: "Множинні ПК",
        pricing_free_feat8: "Всі 13 тем",
        
        pricing_premium_badge: "ПРЕМІУМ",
        pricing_premium_title: "Преміум",
        pricing_premium_price: "$2.99",
        pricing_premium_period: "/місяць",
        pricing_premium_desc: "Повний контроль всіх ваших комп'ютерів",
        pricing_premium_btn: "3 дні безкоштовно",
        pricing_premium_note: "Скасування в будь-який час • Опція $24.99/рік",
        
        pricing_premium_feat1: "Все з Базового",
        pricing_premium_feat2: "Вимкнення, Перезавантаження, Сон",
        pricing_premium_feat3: "Керування гучністю + вимкнення звуку",
        pricing_premium_feat4: "Необмежена кількість комп'ютерів",
        pricing_premium_feat5: "Всі 13 красивих тем",
        pricing_premium_feat6: "Пріоритетна підтримка",
        pricing_premium_feat7: "Майбутні функції включені",
        
        // Screenshots Section
        screenshots_title: "Красивий дизайн, потужні функції",
        
        // Download Section
        download_title: "Почніть за 3 прості кроки",
        
        step1_number: "1",
        step1_title: "Завантажте додаток",
        step1_desc: "Отримайте Wake PC з App Store",
        
        step2_number: "2",
        step2_title: "Встановіть агент для Windows",
        step2_desc: "Завантажте та запустіть від імені адміністратора на вашому ПК",
        step2_btn: "Завантажити WakeAgent.exe",
        
        step3_number: "3",
        step3_title: "Скануйте QR та підключайтесь",
        step3_desc: "Відкрийте Камеру iPhone, скануйте QR-код з агента, натисніть \"Відкрити в Wake PC\"",
        
        // Footer
        footer_copyright: "Wake PC © 2025",
        footer_privacy: "Політика конфіденційності",
        footer_contact: "Контакти"
    }
};
