# Culinary Insights Discovery through Association Rule Mining

This repository contains the code, dataset, and report for a project that uses the **Apriori Algorithm** to analyze ingredient relationships in recipes from diverse cuisines. By generating association rules, the project uncovers patterns valuable for culinary innovation and personalized recipe recommendations.

---

## Project Overview

This project explores relationships between ingredients in recipes using association rule mining. Insights from this analysis can drive:

-   **Personalized Recipe Recommendations**: Suggest ingredient combinations tailored to cuisines.
-   **Culinary Innovation**: Discover unique ingredient pairings.
-   **Inventory Optimization**: Support meal kit services and food-tech businesses.

---

## Repository Structure

### 1. `code/`

Contains the R script used for the analysis:

-   **`code.r`**: Implements the Apriori algorithm for mining frequent itemsets and generating association rules. Includes data preprocessing, association rule generation, and visualizations.

### 2. `report/`

Contains the detailed project report:

-   **`Report.docx`**: Documents the methodology, analysis, and insights derived from the project.

### 3. `data/`

Contains the dataset used for the analysis:

-   **`train.json`**: A JSON file containing cuisines, recipes, and their associated ingredients.

---

## How to Use

### 1. **Prerequisites:**

No external setup is required as the script handles all necessary dependencies. Ensure you have **R** installed.

### 2. **Steps to Run:**

     Open code/code.r in RStudio or your preferred IDE.
     Run the script directly to:
         Install required libraries using pacman.
         Load and preprocess the dataset (data/train.json).
         Generate frequent itemsets and association rules using the Apriori algorithm.
         Visualize the item frequency and rule relationships.

### 3. **Project Report:**

Refer to `Report.docx` for detailed analysis and findings.

---

## Highlights

-   **Apriori Algorithm:** Utilized to uncover patterns in recipe ingredients.
-   **Self-contained:** Automatically installs required R packages.
-   **Visualizations:** Interactive graphs to display frequent items and rule associations.

---

## Dataset Overview

The dataset contains JSON objects with the following structure:

{
"id": 10259,
"cuisine": "greek",
"ingredients": [
"romaine lettuce",
"black olives",
"grape tomatoes",
"garlic",
"pepper",
"purple onion",
"seasoning",
"garbanzo beans",
"feta cheese crumbles"
]
}

---

## Insights

    Ingredient Pairing: Relationships like {garlic, onions} => {soy sauce}.
    Culinary Trends: Frequently paired spices such as cumin and coriander.
    Applications: Useful for chefs, recipe apps, or food-tech businesses.

---

## Contact

For any questions or feedback, please use the repository’s issue tracker.
