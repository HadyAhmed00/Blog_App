# Blog App

A simple blog application built with Flutter, demonstrating Clean Architecture principles and integration with Supabase for backend services.

## Features

*   **User Authentication**: Sign up and sign in functionality using Supabase Auth.
*   **Blog Management**: Create and view blog posts.
*   **Image Uploads**: Pick images from the gallery or camera for blog posts.
*   **Clean Architecture**: The project follows Clean Architecture principles, separating business logic from UI and data layers.
*   **State Management**: Uses `flutter_bloc` for predictable state management.
*   **Dependency Injection**: Leverages `get_it` as a service locator for dependency injection.

## Architecture

The project is structured using Clean Architecture principles to ensure a separation of concerns, making the codebase scalable and maintainable.

*   **`lib/features`**: Contains the different features of the application (e.g., `auth`, `blog`). Each feature is divided into:
    *   **`data`**: Data sources (remote and local) and repository implementations.
    *   **`domain`**: Core business logic, including entities, repositories, and use cases.
    *   **`ui` (or `presentation`)**: UI components, pages, and state management (BLoCs/Cubits).
*   **`lib/core`**: Contains shared components and utilities used across multiple features, such as error handling, theme, and common widgets.

## Key Dependencies

*   [**`flutter_bloc`**](https://pub.dev/packages/flutter_bloc): For state management.
*   [**`supabase_flutter`**](https://pub.dev/packages/supabase_flutter): For backend integration (Auth, Database).
*   [**`get_it`**](https://pub.dev/packages/get_it): For dependency injection.
*   [**`fpdart`**](https://pub.dev/packages/fpdart): For functional programming patterns (e.g., `Either` for error handling).
*   [**`image_picker`**](https://pub.dev/packages/image_picker): For selecting images.

## Getting Started

### Prerequisites

*   Flutter SDK installed. You can find instructions [here](https://flutter.dev/docs/get-started/install).
*   A Supabase account and project. You can create one for free at [supabase.com](https://supabase.com).

### Installation & Configuration

1.  **Clone the repository:**
    ```sh
    git clone <repository-url>
    cd blog
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Configure Supabase:**
    *   Navigate to `lib/core/keys/SupabaseKey.dart`.
    *   Replace the placeholder values for `supabaseUrl` and `subabaseKey` with your own Supabase project URL and anon key.

    *Note: For a production application, it is recommended to use environment variables (e.g., using `flutter_dotenv`) to handle sensitive keys rather than hardcoding them.*

### Running the Application

Once the setup is complete, you can run the application on your desired device or emulator:

```sh
flutter run
```

## Project Structure

```
.
├── lib
│   ├── core
│   │   ├── common
│   │   ├── error
│   │   ├── keys
│   │   ├── theme
│   │   ├── usecase
│   │   └── utiles
│   ├── features
│   │   ├── auth
│   │   │   ├── data
│   │   │   ├── domain
│   │   │   └── ui
│   │   └── blog
│   │       ├── data
│   │       ├── domain
│   │       └── ui
│   ├── init_dependances.dart
│   └── main.dart
├── pubspec.yaml
...
```