Quiz App

This is a Flutter-based Quiz App that provides a gamified experience for answering multiple-choice questions. The app tracks the user's answers, calculates scores, and displays the results after the quiz ends. It also includes a countdown timer for added challenge.

Features

Multiple-choice questions: Users can select answers from predefined options.

Real-time score tracking: Correct answers increase the score, while incorrect answers decrease it.

Timer: A countdown timer ensures users answer questions within a set time limit.

Result page: Displays the final score and a summary of the user's answers.

State management: Uses the Provider package for efficient state handling.

├── lib/
│   ├── main.dart                # Entry point of the app
│   ├── providers/
│   │   └── quiz_provider.dart   # State management using Provider
│   ├── pages/
│   │   ├── start_quiz_page.dart # Starting screen
│   │   ├── quiz_page.dart       # Quiz screen
│   │   └── result_page.dart     # Result screen
│   └── services/
│       └── quiz_service.dart    # Fetches quiz data from API
├── pubspec.yaml                 # Dependencies and assets configuration


Setup Instructions

Clone the repository

git clone <repository-url>
cd quiz-app

Install dependencies
Run the following command to install the necessary dependencies:


flutter pub get

Run the app
Use the following command to start the app:

flutter run

Ensure you have a connected device or emulator.

API Integration
The app fetches quiz data from an external API. Ensure the endpoint is accessible and replace the API URL in quiz_service.dart if needed.
Screenshots

Start Quiz Page

![Screenshot 2025-01-24 210453](https://github.com/user-attachments/assets/eadae03f-bce3-4975-bca7-755dd85ac511)


Quiz Page
![Screenshot 2025-01-24 210502](https://github.com/user-attachments/assets/35ccc73e-5715-4922-be49-49fe1294495f)

![Screenshot 2025-01-24 210510](https://github.com/user-attachments/assets/2bb88ab2-d892-4160-8f7b-c9adc027fd0a)

![Screenshot 2025-01-24 210520](https://github.com/user-attachments/assets/ad30f29f-466e-4e9c-aacb-63f7de40ee0e)

Result Page
![Screenshot 2025-01-24 210542](https://github.com/user-attachments/assets/62cf25a3-4d50-42fc-ad79-310f064bb079)
