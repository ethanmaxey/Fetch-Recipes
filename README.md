### Project Overview

A sleek and simple recipe app featuring **pull-to-refresh** functionality, built with **SwiftUI** and **async/await** for modern, efficient code.

| **Screenshots** |
|-----------------|
| <img src="https://github.com/user-attachments/assets/cef7658d-a876-40dd-a2c9-b0c225ad5710" width="200"/><img src="https://github.com/user-attachments/assets/293cecdc-e62f-4e12-96b1-ce569655a720" width="200"/> |

---

### Focus Areas

- **Interface Design**: Prioritized a clean, intuitive, and visually appealing UI using SwiftUI.
- **Modularity**: Avoided singletons and kept the codebase modular for better maintainability.
- **Testing**: Achieved near **100% test coverage** to ensure reliability and robustness.

---

### Time Spent

- **Total Time**: ~4 hours
  - **1 hour**: Services (networking, caching, etc.)
  - **1-2 hours**: SwiftUI interface and design
  - **1-2 hours**: Writing comprehensive unit tests

---

### Trade-offs and Decisions

- **Testing Approach**: While the tests are functional and achieve near 100% coverage, they are not the most elegant. I chose not to test the failure case of `URL(string:)` returning `nil` because it is not applicable in this context.
- **Pull-to-Refresh Animation**: The animation could be smoother. If I had more time, I would refine this aspect.

---

### Weakest Part of the Project

The **pull-to-refresh completion animation** is the weakest part. It works but lacks polish. With more time, I would focus on making it smoother and more visually appealing.

---

### Additional Information

- **Insights**: This project turned out to be smaller in scope than I initially anticipated. It was a great exercise in balancing design, functionality, and testing.
- **Constraints**: No major constraints were encountered, but I did get hungry while working on this (recipe apps have that effect!).

---
