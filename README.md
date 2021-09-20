## Общее описание проекта
Приложение для владельцев домашних животных, создавайте и сохраняйте карточки с питомцами на своем устройстве.

## Схема приложения
#### Onboarding:
Показывается при первом входе в приложение, рассказывает о некоторых его возможностях

<img width="250" alt="Onboarding_1" src="https://user-images.githubusercontent.com/62261655/134069565-957d2224-bf26-47ac-ab87-077f34eddddc.png"><img width="250" alt="Onboarding_2" src="https://user-images.githubusercontent.com/62261655/134069575-14c4f3c9-5e65-448c-8c99-d9e81982d0bd.png">

#### Главный экран с погодой:
Во время загрузки данных отображается шиммер с прыгающим персонажем, после загрузки показываются погодные данные и изображение

<img width="250" alt="MainMenu_1" src="https://user-images.githubusercontent.com/62261655/134069748-491c588c-bf28-4330-b35f-1c11bc92e704.png"><img width="250" alt="MainMenu_2" src="https://user-images.githubusercontent.com/62261655/134069752-3c8ca598-698a-4e9e-8cca-33e03d63c5a6.png">

#### Экран с домашними питомцами:
Основной экран хранящий карточки питомцев, этот экран служит для перехода на экран заполнения информации о питомце, а также для просмотра карточек существующих питомцев

<img width="250" alt="PetMenu_1" src="https://user-images.githubusercontent.com/62261655/134070004-2a82e301-0a1c-4d1e-b06a-94f41e9f79fc.png"><img width="250" alt="PetMenu_2" src="https://user-images.githubusercontent.com/62261655/134070012-507fbee7-c224-4a98-974b-7134c0f6b706.png">

<img width="250" alt="PetMenu_3" src="https://user-images.githubusercontent.com/62261655/134070020-d93db609-cd6b-4fb5-9487-0cc7b338fd1f.png"><img width="250" alt="PetMenu_4" src="https://user-images.githubusercontent.com/62261655/134070026-bc841978-bad5-4b99-82cb-fbce43274a01.png">

#### Экран профиля:
Системный экран для: 
1. Удаления питомцев из списка
2. Показа Premium-экрана чтобы купить приложение и расширить возможности сохранения питомцев (стандартно доступен только 1 слот для питомца, после "покупки" Premium можно сохранять любое количество питомцев)
3. Можно связаться со мной через нативный почтовый клиент (работает только на реальном устройстве, для симулятора и устройств не поддерживающих нативную почту установлен информационное всплывающее окно)
4. Всплывающее окно отображающее версию приложения
5. Системное меню через которое можно сбросить статус покупки приложения и статус первого входа в приложение

<img width="250" alt="ProfileMenu_1" src="https://user-images.githubusercontent.com/62261655/134070569-5f8e2260-aca8-4cd4-b21e-9c6e2d2c201a.png"><img width="250" alt="ProfileMenu_2" src="https://user-images.githubusercontent.com/62261655/134070574-78d97350-67e7-4dd4-ac15-b72b11d1c5a1.png">

<img width="250" alt="ProfileMenu_3" src="https://user-images.githubusercontent.com/62261655/134070583-1b51e425-437b-454c-8fb2-c5421d90e7d1.png"><img width="250" alt="ProfileMenu_4" src="https://user-images.githubusercontent.com/62261655/134070587-bc6e7fae-dadc-4ace-8372-c4aa29319b6a.png">

## Требования к проекту
#### Обязательные:
- [X] - Исппользовать CoreData для хранения моделей
* Данные о питомце хранятся в CoreData
* Объект сохраняется когда пользователь переходит из экрана заполнения информации о питомце на экран со списком питомцев
* Перед тем как закрыть экран настройки питомца, питомец проверяется с пустым объектом чтобы не сохранять его в случае отсутствия информации
* Изображения сохраняются в директорию на устройстве и их название соответствует UUID который присваивается объекту при создании DTO

- [X] - Использовать KeyChain/UserDefaults для пользовательских настроек
* Добавил UserDefaultsService для удобной работы
* В UserDefaults хранится флаг первого запуска приложения, он активируется нажатием на кнопку "Пропустить"/"Приступим!" в процессе показа возможностей приложения
* В UserDefaults хранится флаг статуса покупки приложения, активируется нажатием на кнопку "Получить Premium" на экране покупки Premium-подписки
* Настройки первого запуска и статуса покупки приложения можно сбросить на экране "Профиль" в меню "Для разработчиков"

- [X] - Использовать Swift styleguides (Google styleguides)
* Старался максимально придерживаться стиля написания кода по Swift styleguides

- [X] - Не использовать стороние библиотеки (кроме snapshot-тестов)
* Из сторонних библиотек используется [Swiftlint](https://github.com/realm/SwiftLint) и [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing)

- [X] - Использовать сеть
* Для работы с сетью используется погодное [API](https://openweathermap.org/api)
* Так же используется собственный JSON

- [X] - Отображение медиа (аудио, видео, изображения) из сети
* Для загрузки изображений используется собственный JSON размещенный на сайте [JSONBIN.io](https://jsonbin.io/), этот JSON состоит из 7 ссылок на картинки которые размещены на GitHub

- [X] - Минимальное количество экранов - 3
* Общее количество экранов более 3х

- [X] - Обязательно использовать UINavigationController/UITabBarController
* Главный экран состоит из UITabBarController'а
* Часть экранов имеет UINavigationController

- [X] - Deployment Target: iOS 13
* Минимальная поддерживаемая версия iOS 13

- [ ] - Покрытие модульными тестами 10% и более

- [X] - Хотя бы один UI-тест через page object
* Тест пользовательского маршрута через с использованием page object pattern

- [X] - Хотя бы один snapshot тест (разрешается использовать внешнюю библиотеку)
* Добавил snapshot тесты, специально "уронил" тест для наглядности

<img width="250" alt="reference_screenshot" src="https://user-images.githubusercontent.com/62261655/133247591-af5ebea5-1ea2-4b6e-a211-5339cd1f0325.png"><img width="250" alt="failure_screenshot" src="https://user-images.githubusercontent.com/62261655/133247644-ae5ae734-7e4b-4ce9-b874-bf1d2b7b8791.png"><img width="250" alt="difference_screenshot" src="https://user-images.githubusercontent.com/62261655/133247692-c3e51f30-7cbf-4f03-80e0-e99376430b26.png">

- [X] - Использование Архитектурных подходов и шаблонов проектирования
* В качестве архитектуры использую MVC
* Для стандартных кнопок (3 одинаковые кнопки в проекте) использую Builder

- [X] - Верстка UI в коде
* Весь UI приложения верстается с помощью кода
* LaunchScreen верстаеся с помощью Storyboard


- [X] - Обязательно использовать UITableView/UICollectionView
* Основная часть экранов имеет UITableView/UICollectionView


#### Необязательные:
- [X] - Кастомные анимации
* Собсвенный шиммер для скрытия загрузки

- [X] - Swiftlint
* Установил swiftlint с помощью brew, в проекте используются правила от Сбербанка с некоторыми изменениями

    * [Официальный репозиторий Swiftlint](https://github.com/realm/SwiftLint/)

- [ ] - Системы аналитики и анализа крэшей (с использованием стороних зависимостей)


![Alt-текст](https://upload.wikimedia.org/wikipedia/commons/9/9b/Sberbank_Logo_2020.svg "Сбербанк")
