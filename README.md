# ✈️ Egzaminy-ULC  

**Egzaminy-ULC** is an iOS application designed to help users prepare for theoretical aviation exams conducted by the Polish Civil Aviation Authority (Urząd Lotnictwa Cywilnego - ULC).  

📚 **Exam Categories**:  
- 🛩️ PPL(A)  
- 🚁 PPL(H)  
- 🪂 PPL(B)  
- 🚁 PPL(H) ENG  
- 🪁 SPL  


## 🌟 Project Overview  

This application was built with the goal of making exam preparation more efficient by offering an interactive platform. The questions were sourced from ULC's official PDFs and converted into JSON format using a Python script.  

> **🎨 Inspired by "The Ugly Sketchbook" by [Tawnie Jeanne Studios](https://www.instagram.com/tawniejeannestudios?igshid=Y3l3aXltZ3NrNXN3)**  
This app was created as a learning project. While it has bugs and some imperfect code, it reflects the philosophy that it's better to create and improve something imperfect than to do nothing.  

**Note**: Some features are still in development and are not yet available in the public version of this project. The application code is currently in a private repository.  


## 🛠️ Features (Partially Implemented)  

- 🎯 **Comprehensive Question Bank**:  
   Access a wide range of questions tailored to ULC's requirements. (In-progress)  
- 📝 **Exam Simulation**:  
   Practice under real exam-like conditions. (In-progress)  
- 📊 **Progress Tracking**:  
   Monitor your performance to identify strengths and areas for improvement. (In-progress)  
- 🛠️ **Feature Flags**:  
   Controlled feature rollouts powered by LaunchDarkly.  


## 🖥️ Supporting Ecosystem  

This project includes the following supporting components:  

1. **🖥️ macOS Application**:  
   A lightweight macOS application was created to manage questions, providing an easy way to add, update, or delete entries in the JSON dataset. (Not yet released)  

2. **🌐 Backend API**:  
   A backend built with [Vapor](https://vapor.codes/) is hosted on [Fly.io](https://fly.io/). It serves as the central hub for syncing question data and managing updates. (Not yet released)  


## 🛠️ Built With  

### 🧑‍💻 **Technologies**  

- 🦸‍♂️ **Swift 6**  
- 🎨 **SwiftUI**  
- 🧩 **TCA (The Composable Architecture)**  
- 🚀 **Swift Concurrency**  
- 🏗️ **Fully Modularized Project Architecture**  
  - The project template is from [SwiftyStack](https://www.swiftystack.com) and app is inspired [Point-Free's isowords](https://github.com/pointfreeco/isowords).  

### 📦 **Dependencies**  

- [Inject](https://github.com/krzysztofzablocki/Inject) (v1.5.2)  
- [Difference](https://github.com/krzysztofzablocki/Difference) (v1.0.2)  
- [Swift Snapshot Testing](https://github.com/pointfreeco/swift-snapshot-testing) (v1.12.0)  
- [Swift Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) (v1.15.1)  
- [Swift Dependencies](https://github.com/pointfreeco/swift-dependencies) (v1.1.0)  
- [SwiftLint Plugins](https://github.com/SimplyDanny/SwiftLintPlugins) (v0.57.0)  
- [LaunchDarkly iOS Client SDK](https://github.com/launchdarkly/ios-client-sdk.git) (v9.12.0)  


## 📚 Learning Inspiration  

This project was developed while learning from courses and resources provided by:  

- 🌐 [SwiftyStack](https://www.swiftystack.com)  
- 🧠 [PointFree](https://www.pointfree.co)  

Their teachings significantly influenced the architectural decisions and implementation strategies used in this app.  


## 📸 Screenshots  

Here’s a preview of the app in action:  

![🏠 Home Screen](path-to-home-screen-image)  
*The home screen provides easy navigation through exam categories.*  

![📝 Question View](path-to-question-view-image)  
*The question view offers a clean and user-friendly interface for answering questions.*  

![📊 Progress Tracking](path-to-progress-tracking-image)  
*Track your progress*
