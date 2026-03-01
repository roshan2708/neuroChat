# NeuroChat

A minimalist, sophisticated AI Chat application built with Flutter, Firebase Authentication, and the Gemini API.

---

## 🚀 Interview Questions for Avyxon AI Labs

### Why did you choose this challenge?
I chose this challenge because it perfectly intersects with my passion for building elegant, user-centric interfaces and integrating powerful AI models like Gemini. It provided an excellent opportunity to demonstrate my ability to architect a robust Flutter application from scratch while focusing on a minimalist, highly functional design language. 

### What architecture / state management did you use and why?
The application adheres to a clean architecture pattern, separating concerns into Core (theme/constants), Models, Providers (state management), Services (API/Firebase infrastructure), and UI Components/Screens. I chose **`Provider`** for state management due to its simplicity, efficiency, and seamless integration with Flutter's widget tree. For an application of this scale, `Provider` offers an ideal balance—it allows reactive UI updates without the boilerplate overhead of more complex solutions like BLoC or Riverpod, making the codebase highly maintainable, readable, and perfectly suited for this project's requirements.

### If this app scaled to 100K users, what would you improve?
To robustly scale to 100K users, I would implement the following improvements:
1. **Message Pagination & Local Caching:** Introduce local persistent caching (using `sqflite` or `hive`) to store chat history on the device, reducing redundant API calls. I would also implement pagination and infinite scrolling for the chat interface to heavily optimize memory usage.
2. **Backend Infrastructure & Proxy:** Migrate direct Gemini API calls from the client to a dedicated backend microservice (e.g., using Node.js, Firebase Cloud Functions, or Go) to securely handle the API keys, manage strict rate limiting, and implement unified queueing and robust error handling.
3. **State Management Migration:** Consider a migration to Riverpod to handle the increasingly complex global states and side effects, and to provide stronger compile-time safety and dependency injection capabilities.
4. **Performance Tuning:** Optimize widget rebuilds profoundly (using `const` constructors aggressively), lazy-load heavier graphical assets, and implement more sophisticated list chunking to ensure a buttery smooth 60/120FPS on lower-end devices.

### Why do you want to intern at Avyxon AI Labs?
I am incredibly excited about Avyxon AI Labs because of the company's commitment to pushing the boundaries of AI-driven user experiences. I want to intern here to collaborate with a team of forward-thinking engineers, tackle complex real-world challenges at scale, and contribute to products that make AI accessible and intuitive. My goal is to work in a challenging environment that accelerates my growth as a functional and impactful software engineer.

### What are you hoping to learn in the next 6 months?
Over the next 6 months, I aim to deepen my understanding of scalable cloud architectures, learn effective techniques for optimizing AI interactions (such as advanced prompt engineering and effectively integrating streaming web sockets for real-time AI responses), and heavily refine my skills in writing production-grade, highly testable, and deeply performant code. I also want to gain significant hands-on experience in cross-functional collaboration within a fast-paced, agile production team.
# neuroChat
