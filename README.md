### README for Poizon Zoom/Nike Store SwiftUI App

This repository contains the source code for the NikeStore app, a SwiftUI-based iOS application that integrates Firebase services for real-time data handling and user authentication. The app showcases a modern e-commerce platform for Nike products, featuring product listings, image sliders, and user authentication.

#### Features

- **Firebase Integration**: Utilizes Firebase Firestore for data storage and Firebase Authentication for user management.
- **Dynamic Product Listing**: Products are fetched in real-time from Firestore and displayed using a custom SwiftUI view.
- **Image Slider**: Implements an image slider for product images using `AsyncImage`.
- **User Authentication**: Supports user login and registration through Firebase Authentication.
- **Favorites Management**: Allows users to add or remove products from their favorites.

#### Screenshots

<img src="https://github.com/user-attachments/assets/72f8588b-0b9b-40cc-beb8-37819e22b65c" width="300" />
<img src="https://github.com/user-attachments/assets/d97260f9-7852-4578-a268-6b9c3234ac32" width="300" />
<img src="https://github.com/user-attachments/assets/41cce4b0-29fb-41cf-b5a7-d57f76a8bc7c" width="300" />
<img src="https://github.com/user-attachments/assets/db88fb45-054f-4034-9adf-1269ec7b9f5e" width="300" />
<img src="https://github.com/user-attachments/assets/6675e88f-97b5-4153-811b-5f6d8850dc5c" width="300" />
<img src="https://github.com/user-attachments/assets/efc17042-63de-497b-adaa-8c02079300d5" width="300" />
<img src="https://github.com/user-attachments/assets/97fc59d5-c03b-49f2-9df4-d8a3744da4ca" width="300" />
<img src="https://github.com/user-attachments/assets/cd0cde7c-84c1-4812-b583-8c67554d0b9d" width="300" />
<img src="https://github.com/user-attachments/assets/5544d8c8-bd5f-4c56-bb16-5fcaec375830" width="300" />
<img src="https://github.com/user-attachments/assets/813cd0dc-212f-42c8-9e10-8f6297efc648" width="300" />


#### Installation

1. **Clone the repository:**

   https://github.com/Almir28/PoizonZoom
   
2. **Open the project in Xcode:**
   - Navigate to the cloned directory and open `NikeStore.xcodeproj`.

3. **Install Dependencies:**
   - Ensure you have CocoaPods installed and run `pod install` in the project directory.

4. **Setup Firebase:**
   - Create a Firebase project and add an iOS app.
   - Download the `GoogleService-Info.plist` file and add it to the project.

5. **Run the app:**
   - Select your target device and run the application.

#### Code Structure

- **AppDelegate**: Handles the Firebase app configuration.
- **NikeStore (Main App Structure)**: Defines the main structure of the app, including the initial view and environment objects.
- **Database**: Manages the fetching and updating of products from Firestore.
- **Views**:
  - `ProductCardView`: Displays individual product details.
  - `ImageSlider`: A reusable view for displaying images horizontally.
  - `ImagePicker`: Integrates with the iOS photo library or camera.

#### Contributing

Contributions are welcome! Please feel free to submit pull requests or create issues for bugs and feature requests.

---

This README provides a comprehensive overview of the Poizon Zoom / NikeStore app, guiding users through installation, features, and contribution guidelines. Adjust the repository URL and any specific installation instructions as necessary to match your project setup.






_____________________________________________________________________________________________________________________________________________________

**FOR RUSSIAN-SPEAKING USERS**



### README для приложения NikeStore SwiftUI

Этот репозиторий содержит исходный код приложения NikeStore, приложения для iOS на базе SwiftUI, которое интегрирует сервисы Firebase для обработки данных в реальном времени и аутентификации пользователей. Приложение демонстрирует современную электронную коммерческую платформу для продуктов Nike, включая список продуктов, слайдеры изображений и аутентификацию пользователей.

#### Особенности

- **Интеграция Firebase**: Использует Firebase Firestore для хранения данных и Firebase Authentication для управления пользователями.
- **Динамический список продуктов**: Продукты загружаются в реальном времени из Firestore и отображаются с помощью пользовательского представления SwiftUI.
- **Слайдер изображений**: Реализует слайдер изображений для фотографий продуктов с использованием AsyncImage.
- **Аутентификация пользователей**: Поддерживает вход в систему и регистрацию пользователей через Firebase Authentication.
- **Управление избранными**: Позволяет пользователям добавлять или удалять продукты из избранного.

#### Скриншоты 

<img src="https://github.com/user-attachments/assets/72f8588b-0b9b-40cc-beb8-37819e22b65c" width="300" />
<img src="https://github.com/user-attachments/assets/d97260f9-7852-4578-a268-6b9c3234ac32" width="300" />
<img src="https://github.com/user-attachments/assets/41cce4b0-29fb-41cf-b5a7-d57f76a8bc7c" width="300" />
<img src="https://github.com/user-attachments/assets/db88fb45-054f-4034-9adf-1269ec7b9f5e" width="300" />
<img src="https://github.com/user-attachments/assets/6675e88f-97b5-4153-811b-5f6d8850dc5c" width="300" />
<img src="https://github.com/user-attachments/assets/efc17042-63de-497b-adaa-8c02079300d5" width="300" />
<img src="https://github.com/user-attachments/assets/97fc59d5-c03b-49f2-9df4-d8a3744da4ca" width="300" />
<img src="https://github.com/user-attachments/assets/cd0cde7c-84c1-4812-b583-8c67554d0b9d" width="300" />
<img src="https://github.com/user-attachments/assets/5544d8c8-bd5f-4c56-bb16-5fcaec375830" width="300" />
<img src="https://github.com/user-attachments/assets/813cd0dc-212f-42c8-9e10-8f6297efc648" width="300" />


#### Установка

1. **Клонируйте репозиторий:**

https://github.com/Almir28/PoizonZoom
   
2. **Откройте проект в Xcode:**
   - Перейдите в клонированную директорию и откройте NikeStore.xcodeproj.

3. **Установите зависимости:**
   - Убедитесь, что у вас установлен CocoaPods, и выполните команду pod install в директории проекта.

4. **Настройте Firebase:**
   - Создайте проект Firebase и добавьте iOS-приложение.
   - Скачайте файл GoogleService-Info.plist и добавьте его в проект.

5. **Запустите приложение:**
   - Выберите ваше целевое устройство и запустите приложение.

#### Структура кода

- **AppDelegate**: Управляет конфигурацией приложения Firebase.
- **NikeStore (Основная структура приложения)**: Определяет основную структуру приложения, включая начальный вид и объекты окружения.
- **База данных**: Управляет получением и обновлением продуктов из Firestore.
- **Представления**:
  - ProductCardView: Отображает детали отдельного продукта.
  - ImageSlider: Повторно используемое представление для горизонтального отображения изображений.
  - ImagePicker: Интегрируется с фотобиблиотекой или камерой iOS.

#### Участие

Вклад приветствуется! Пожалуйста, не стесняйтесь отправлять pull-запросы или создавать проблемы для ошибок и запросов на новые функции.


---

Этот README предоставляет подробный обзор приложения Poizon Zoom / NikeStore, направляя пользователей через установку, особенности и рекомендации по вкладу. При необходимости настройте URL репозитория и любые конкретные инструкции по установке, чтобы они соответствовали вашей конфигурации проекта.

