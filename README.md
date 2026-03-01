# NeuroChat

Please paste your gemini api key in `lib/Core/Constants.dart` file a the `geminiApiKey` variable.

---

## 🚀 Interview Questions for Avyxon AI Labs

### Why did you choose this challenge?
I chose this challenge because it seemed to be a good opportunity to demonstrate my skills.

### What architecture / state management did you use and why?
I have used Clean Architecture Method. For state managment I have used `Provider` because it allows reactive UI updates without the boilerplate overhead of more complex solutions.

### If this app scaled to 100K users, what would you improve?
To robustly scale to 100K users, I would implement the following improvements:
1. **Message Pagination & Local Caching:** Introduce local persistent caching (using `hive`) to store chat history on the device to reduce API calls.
2. **Backend Infrastructure & Proxy:** Migrate to a real backend to handle API keys and managing rate limits.
3. **State Management Migration:** Consider a migration to GetX for state management.
4. **Performance Tuning:** Optimize widget rebuilds profoundly (using `const` constructors aggressively), lazy-load heavier graphical assets, and implement more sophisticated list chunking to ensure a buttery smooth 60/120FPS on lower-end devices.

### Why do you want to intern at Avyxon AI Labs?
I am incredibly excited about Avyxon AI Labs because of the company's commitment to pushing the boundaries of AI-driven user experiences. I want to intern here to collaborate with a team of forward-thinking engineers, tackle complex real-world challenges at scale, and contribute to products that make AI accessible and intuitive. My goal is to work in a challenging environment that accelerates my growth as a functional and impactful software engineer.

### What are you hoping to learn in the next 6 months?
Over the next 6 months, I aim to get more experience to Flutter and also get expericene with actual prduction grade Backend Integration Experience.
