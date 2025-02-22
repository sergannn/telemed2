flowchart LR
    Start([Начало]) --> Login[Экран входа]
    Login --> Auth{Авторизация}
    Auth -->|Успешно| Role{Выбор роли}
    Auth -->|Не успешно| Error[Ошибка авторизации]
    Error --> Login
    
    Role -->|Врач| DocReg[Регистрация врача]
    Role -->|Пациент| PatReg[Регистрация пациента]
    
    DocReg --> DocProfile[Профиль врача]
    PatReg --> PatProfile[Профиль пациента]
    
    DocProfile --> DocDash[Главная страница врача]
    PatProfile --> PatDash[Главная страница пациента]
    
    DocDash --> DocStory[Статьи/Сторис]
    DocDash --> Appointments[Записи на прием]
    DocDash --> Support[Поддержка]
    
    PatDash --> BookDoc[Поиск врача]
    PatDash --> PatStory[Статьи/Сторис]
    PatDash --> Support[Поддержка]
    
    BookDoc --> SelectTime[Выбор времени]
    SelectTime --> ConfirmApp[Подтверждение записи]
    ConfirmApp --> Session[Запись на сеанс]
    Session --> VideoRoom[Видео-комната]
    
    classDef screen fill:#f9f,stroke:#333,stroke-width:2px,color:#000
    classDef process fill:#bbf,stroke:#333,stroke-width:2px,color:#000
    classDef decision fill:#ff9,stroke:#333,stroke-width:2px,color:#000
    
    class Start,Login,DocReg,PatReg,DocProfile,PatProfile,DocDash,PatDash,DocStory,PatStory,Appointments,BookDoc,SelectTime,ConfirmApp,Session,VideoRoom screen
    class Auth,Role decision
    class Error process