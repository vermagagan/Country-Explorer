# 🌍 CountryExplorer — iOS Country Explorer App

> App #5 of my iOS Development Journey | Built with Swift + UIKit | Zero Storyboards

---

## 📱 Overview

CountryExplorer is a fully programmatic iOS app that fetches live country data from a free REST API and lets users browse flags, capitals, populations, and more. Built as part of my structured iOS curriculum to master `URLSession`, `Codable`, async image loading, and real-world JSON decoding.

---

## 🖥️ Screens

### 🏠 Country List Screen
- `UITableView` with custom `CountryCell` showing flag, country name, capital, and population
- `UIActivityIndicatorView` while data loads
- Error state if network fetch fails
- Countries sorted alphabetically by name
- `UISearchController` for real-time name filtering
- Empty state message when no results found

### 🌐 Country Detail Screen
- Pushed via `UINavigationController` on row tap
- Large flag image at the top
- Full details — name, capital, population, region, subregion, languages, currencies
- Clean card layout with section dividers

---

## ⚙️ Features

| Feature | Detail |
|---|---|
| Live API data | Fetched from `restcountries.com/v3.1/all` — no hardcoding |
| Codable JSON decoding | Nested structs for complex API response |
| Async image loading | Flag images fetched on background thread, UI updated on main |
| Image caching | Flags cached to avoid re-downloading on scroll |
| Real-time search | `UISearchController` with dual array filtering |
| Loading indicator | `UIActivityIndicatorView` shown during fetch |
| Error state | Friendly message if network request fails |
| Cool Atlas palette | Clean, cool-toned travel-app styling |

---

## 🛠️ Tech Stack

- **Language:** Swift
- **Framework:** UIKit
- **UI Approach:** 100% Programmatic — Zero Storyboards
- **Layout:** `NSLayoutConstraint` + `UIStackView`
- **Networking:** `URLSession.shared.dataTask`
- **Decoding:** `JSONDecoder` + `Codable`
- **Threading:** `DispatchQueue.main.async`
- **Architecture:** Singleton pattern (`NetworkManager`)
- **Navigation:** `UINavigationController` (push)
- **Search:** `UISearchController`
- **Custom Cells:** `UITableViewCell` subclass (`CountryCell`)

---

## 🧠 Concepts Practiced

| Concept | Where Used |
|---|---|
| `Codable` / `Decodable` | `Country.swift` |
| Nested JSON decoding | `CountryName`, `CountryFlag` structs |
| `URLSession.dataTask` | `NetworkManager.swift` |
| `JSONDecoder` | `NetworkManager.swift` |
| `DispatchQueue.main.async` | `CountryListVC.swift` |
| Async remote image loading | `CountryCell.swift` |
| Image caching | `CountryCell.swift` |
| `UIActivityIndicatorView` | `CountryListVC.swift` |
| `UISearchController` | `CountryListVC.swift` |
| Dual array filtering | `allCountries` + `filteredCountries` |
| Data passing to detail VC | `CountryListVC` → `CountryDetailVC` |
| Error + empty state | `CountryListVC.swift` |

---

## 📁 Project Structure

```
CountryExplorer/
├── Models/
│   └── Country.swift
├── Managers/
│   └── NetworkManager.swift
├── Controllers/
│   ├── CountryListVC.swift
│   └── CountryDetailVC.swift
├── Cells/
│   └── CountryCell.swift
└── Utilities/
    └── AppColors.swift
```

---

## 🌐 API

Free, no API key required:
```
https://restcountries.com/v3.1/all
```

Fields used — `name`, `capital`, `population`, `flags`, `region`, `subregion`, `languages`, `currencies`

---

## 🚀 Getting Started

1. Clone the repo
   ```bash
   git clone https://github.com/vermagagan/CountryExplorer-iOS.git
   ```
2. Open `CountryExplorer.xcodeproj` in Xcode
3. Run on Simulator (iOS 16+)

> No third-party dependencies. No CocoaPods. Pure UIKit + URLSession.

---

## 🗺️ iOS Journey Series

| # | App | Key Concepts |
|---|---|---|
| 1 | Personal Business Card App | Programmatic UI, Auto Layout, UserDefaults, Modals |
| 2 | FitLife Onboarding App | UIPageViewController, UITabBarController, SceneDelegate, CATransition |
| 3 | GroceryMart | UITableView, UICollectionView, Diffable Data Source, Singleton |
| 4 | NotesApp | CoreData, UISearchController, Dual-mode VC, UITextView |
| **5** | **CountryExplorer** | **URLSession, Codable, Async Image Loading, REST API** |

---

## 👨‍💻 Author

**vermagagan**
Aspiring iOS Developer | Building in public

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com/in/vermagagan)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/vermagagan)

---

> *"Every app in this series is more complex than the last. This one fetched live data from a REST API, decoded nested JSON with Codable, loaded images asynchronously, and had zero storyboards."*
