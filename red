<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>REACH NG - WxDecode Dashboard</title>

    <style>
      :root {
        --light-grey: #f2f4f7;
        --medium-grey: #e6e9ee;
        --dark-grey: #d0d5dd;
        --text-color: #1a1a1a;
        --text-light: #667085;
        --status-green: #27ae60;
        --status-orange: #f39c12;
        --status-red: #e74c3c;
      }

      body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background-color: var(--light-grey);
        color: var(--text-color);
        display: flex;
        flex-direction: column;
        height: 100vh;
        overflow: hidden;
      }

      header {
        padding: 20px;
        text-align: center;
        font-size: 22px;
        font-weight: 600;
        background-color: var(--medium-grey);
        border-bottom: 1px solid var(--dark-grey);
        flex-shrink: 0;
      }

      .main-container {
        display: flex;
        flex-grow: 1;
        overflow: hidden;
      }

      /* Left Menu Section */
      .left-menu {
        flex: 0 0 20%;
        min-width: 250px;
        background-color: var(--medium-grey);
        padding: 20px;
        border-right: 1px solid var(--dark-grey);
        display: flex;
        flex-direction: column;
        gap: 20px;
      }

      .left-menu h3 {
        margin: 0 0 10px 0;
        font-size: 18px;
        color: #344054;
        font-weight: 600;
        padding-bottom: 10px;
        border-bottom: 1px solid var(--dark-grey);
      }

      .airport-adder {
        display: flex;
      }

      #airport-input {
        padding: 8px;
        border: 1px solid var(--dark-grey);
        border-radius: 6px;
        font-size: 14px;
        background: white;
        flex-grow: 1;
        border-radius: 6px 0 0 6px;
        border-right: none;
      }

      #add-favourite-btn {
        padding: 10px;
        border: none;
        border-radius: 0 6px 6px 0;
        background-color: var(--text-light);
        color: white;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s;
      }

      #add-favourite-btn:hover {
        background-color: #4d5761;
      }

      .favourites-container {
        display: flex;
        flex-direction: column;
        flex-grow: 1;
        min-height: 0;
      }

      #favourites-list {
        list-style: none;
        padding: 5px 2px;
        margin: 0;
        overflow-y: auto;
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        align-content: flex-start;
      }

      #favourites-list li {
        display: inline-flex;
        align-items: center;
        background-color: #dfe3e8;
        border-radius: 16px;
        padding: 4px 10px;
        font-size: 14px;
        font-weight: 500;
        color: var(--text-light);
        cursor: default;
      }

      .remove-fav-btn {
        cursor: pointer;
        color: #98a2b3;
        font-size: 16px;
        margin-left: 8px;
        font-weight: bold;
        transition: color 0.2s ease;
      }
      .remove-fav-btn:hover {
        color: var(--status-red);
      }

      /* Right Content Section */
      .right-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        padding: 30px;
        gap: 30px;
        overflow: hidden;
      }

      .top-section {
        flex: 3; /* 60% */
        min-height: 0;
      }

      .bottom-section {
        flex: 2; /* 40% */
        display: flex;
        flex-direction: column;
        min-height: 0;
        overflow: hidden; /* To clip the scrolling carousel */
      }

      .bottom-section h4 {
        margin: 0 0 15px 0;
        font-size: 18px;
        font-weight: 600;
        flex-shrink: 0;
      }

      /* Large Airport Panels */
      .dashboard {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
        height: 100%;
      }

      .card {
        background-color: var(--medium-grey);
        border-radius: 16px;
        padding: 20px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
        border: 1px solid var(--dark-grey);
        display: flex;
        flex-direction: column;
        position: relative;
        transition: all 0.2s ease;
      }

      .card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.12);
      }

      .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;
      }

      .controls {
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .toggle-group {
        display: flex;
        border: 1px solid var(--dark-grey);
        border-radius: 6px;
        overflow: hidden;
        background: var(--light-grey);
      }

      .toggle-btn {
        border: none;
        padding: 4px 8px;
        font-size: 10px;
        cursor: pointer;
        background: transparent;
        color: var(--text-light);
        font-weight: 600;
      }

      .toggle-btn.active {
        background-color: #667085;
        color: white;
      }

      .delete-btn {
        cursor: pointer;
        color: #98a2b3;
        font-size: 18px;
      }

      .horizon-select {
        font-size: 10px;
        border: 1px solid var(--dark-grey);
        border-radius: 4px;
        background: white;
        color: var(--text-light);
        outline: none;
      }

      .airport {
        font-size: 18px;
        font-weight: 600;
      }

      .airport-name {
        font-size: 12px;
        color: var(--text-light);
        font-weight: 500;
        margin-bottom: 8px;
      }

      .label {
        font-size: 11px;
        color: var(--text-light);
        text-transform: uppercase;
        margin-bottom: 6px;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .valid-time {
        font-size: 10px;
        text-transform: none;
        font-weight: normal;
      }

      .weather {
        font-size: 13px;
        line-height: 1.4;
        font-family: monospace;
        white-space: pre-line;
        overflow-y: auto;
      }

      .weather b {
        font-weight: 600;
        color: #344054;
      }

      /* --- CHANGE START: Added styles for red and yellow out-of-spec parameters --- */
      .weather .out-of-spec-red {
        color: var(--status-red);
        font-weight: 600;
      }
      .weather .out-of-spec-yellow {
        color: var(--status-orange); /* Using the orange variable for yellow */
        font-weight: 600;
      }
      /* --- CHANGE END --- */

      .add-card {
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        background-color: #dfe3e8;
      }

      .add-card:hover {
        background-color: var(--dark-grey);
      }

      .plus {
        font-size: 40px;
        color: var(--text-light);
      }

      @keyframes marquee {
        from {
          transform: translateX(0);
        }
        to {
          transform: translateX(-50%);
        }
      }

      /* Mini Carousel Panels */
      .carousel-container {
        display: flex;
        gap: 15px;
        width: fit-content;
      }
      .carousel-container.is-scrolling {
        animation: marquee 40s linear infinite;
      }
      .carousel-container.is-scrolling:hover {
        animation-play-state: paused;
      }

      .mini-card {
        background-color: var(--medium-grey);
        border-radius: 12px;
        padding: 15px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.06);
        border: 1px solid var(--dark-grey);
        flex: 0 0 220px; /* Fixed width for carousel items */
        display: flex;
        flex-direction: column;
        position: relative;
      }

      .mini-card .airport {
        font-size: 16px;
        font-weight: 600;
      }

      .mini-card .weather {
        font-size: 11px;
        margin-top: 8px;
        font-family: monospace;
        white-space: pre-line;
        line-height: 1.5;
        color: var(--text-light);
      }

      .delete-fav-btn {
        position: absolute;
        top: 5px;
        right: 8px;
        cursor: pointer;
        color: #98a2b3;
        font-size: 22px;
        font-weight: 600;
        transition: color 0.2s;
      }

      .delete-fav-btn:hover {
        color: var(--status-red);
      }

      .past-alarms-container {
        flex-shrink: 0; /* Prevent this container from shrinking */
      }

      #past-alarms-list {
        list-style: none;
        padding: 0;
        margin: 0;
        font-family: monospace;
        font-size: 11px;
        color: var(--text-light);
        display: flex;
        flex-direction: column;
        gap: 8px;
      }

      #past-alarms-list li {
        background-color: #dfe3e8;
        padding: 6px 8px;
        border-radius: 4px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        cursor: help;
      }
    </style>
  </head>

  <body>
    <header>SkyNet Aviation — WxDecode Dashboard</header>

    <div class="main-container">
      <aside class="left-menu">
        <div>
          <h3>Add a Favourite</h3>
          <div class="airport-adder">
            <input
              type="text"
              id="airport-input"
              placeholder="Enter ICAO Code (e.g. YBBN)"
            />
            <button id="add-favourite-btn">Add Favourite</button>
          </div>
        </div>
        <div class="favourites-container">
          <h3>Favourites</h3>
          <ul id="favourites-list">
            <!-- Favourites will be dynamically inserted here -->
          </ul>
        </div>
        <div class="past-alarms-container">
          <h3>Past alarms</h3>
          <ul id="past-alarms-list">
            <!-- Alarms will be dynamically inserted here from backend -->
          </ul>
        </div>
      </aside>

      <main class="right-content">
        <div class="top-section">
          <div class="dashboard" id="dashboard">
            <!-- Large airport panels will be rendered here -->
          </div>
        </div>
        <div class="bottom-section">
          <h4>Favourites Overview</h4>
          <div class="carousel-container" id="favourites-carousel">
            <!-- Mini condensed panels will be rendered here -->
          </div>
        </div>
      </main>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", () => {
        // --- STATE ---
        let favouriteAirports = []; // This will be loaded from API
        let dashboardSlots = [null, null, null];
        let allWeatherData = {}; // Stores all fetched METAR/TAF data

        // --- CONTENT CREATION FUNCTIONS ---
        // --- CHANGE START: Modified function to handle multiple TAFs ---
        function createLargeWeatherContent(code, type = "METAR", tafIndex = 0) {
          // Changed 'horizon' param to 'tafIndex'
          const airportData = allWeatherData[code] || {};
          let weatherContent = "No data available.";
          let rawData = "";
          let airportName = (airportData.METAR && airportData.METAR.name) || "";
          let validTime = "";
          let weatherInfo; // This will hold the specific METAR or TAF object

          // When type is TAF, we now expect an array of TAFs.
          // We select the one specified by tafIndex.
          if (type === "TAF" && Array.isArray(airportData.TAF)) {
            // In a real app, you might filter for the latest issue time here.
            // For our dummy data, we assume the whole array is the latest set.
            const tafs = airportData.TAF;
            weatherInfo = tafs[tafIndex] || tafs[0]; // Get selected TAF, or default to the first one.
          } else {
            // METAR or old-format data is handled as before.
            weatherInfo = airportData[type];
          }

          if (weatherInfo) {
            rawData = weatherInfo.raw || "";

            if (weatherInfo.valid_from && weatherInfo.valid_to) {
              validTime = `Valid: ${weatherInfo.valid_from} – ${weatherInfo.valid_to}`;
            }

            // Display structured METAR data if available
            if (type === "METAR" && weatherInfo.display_items) {
              // --- CHANGE START: Handle 'red' and 'yellow' out-of-spec flags ---
              weatherContent = Object.entries(weatherInfo.display_items)
                .map(([label, item]) => {
                  const isObjectFormat =
                    typeof item === "object" &&
                    item !== null &&
                    "value" in item;
                  const value = isObjectFormat ? item.value : item;
                  const specStatus = isObjectFormat ? item.out_of_spec : false;

                  // Check the spec status and apply the correct color class.
                  // Also handles the old boolean `true` for backward compatibility (as red).
                  if (specStatus === "red" || specStatus === true) {
                    return `<b>${label}:</b> <span class="out-of-spec-red">${value}</span>`;
                  }
                  if (specStatus === "yellow") {
                    return `<b>${label}:</b> <span class="out-of-spec-yellow">${value}</span>`;
                  }
                  return `<b>${label}:</b> ${value}`;
                })
                .join("\n");
              // --- CHANGE END ---
            } else if (weatherInfo.display) {
              // Fallback for TAF or older METAR format
              weatherContent = weatherInfo.display;
            }
          }

          // This dropdown is only shown if there are multiple TAFs for the airport.
          let tafSelectorHtml = "";
          if (
            type === "TAF" &&
            Array.isArray(airportData.TAF) &&
            airportData.TAF.length > 1
          ) {
            const tafCount = airportData.TAF.length;
            tafSelectorHtml = `<select class="horizon-select" onchange="updateTafSelection(this, '${code}')">`;
            for (let i = 0; i < tafCount; i++) {
              tafSelectorHtml += `<option value="${i}" ${i == tafIndex ? "selected" : ""}>TAF ${i + 1} of ${tafCount}</option>`;
            }
            tafSelectorHtml += `</select>`;
          }

          return `
            <div class="card-header">
              <div>
                <div class="airport">${code}</div>
                <div class="airport-name">${airportName}</div>
              </div>
              <div class="controls">
                ${tafSelectorHtml}
                <div class="toggle-group">
                  <button class="toggle-btn ${type === "METAR" ? "active" : ""}" onclick="toggleType(this, '${code}', 'METAR')">METAR</button>
                  <button class="toggle-btn ${type === "TAF" ? "active" : ""}" onclick="toggleType(this, '${code}', 'TAF')">TAF</button>
                </div>
                <div class="delete-btn" onclick="clearDashboardSlot(this)" title="Remove from dashboard">×</div>
              </div>
            </div>
            <div class="label" title="${rawData}">${type} Data <span class="valid-time">${validTime}</span></div>
            <div class="weather">${weatherContent}</div>
          `;
        }
        // --- CHANGE END ---

        function createMiniWeatherContent(code) {
          const airportData = allWeatherData[code];
          let displayData = "No data.";
          let rawData = "";

          if (airportData && airportData.METAR) {
            rawData = airportData.METAR.raw || "";
            if (airportData.METAR.display_items) {
              // --- CHANGE START: Handle 'red' and 'yellow' flags for mini-cards ---
              const items = airportData.METAR.display_items;

              // Helper function to get the value and apply styling if out of spec.
              const formatMiniItem = (item) => {
                if (
                  typeof item === "object" &&
                  item !== null &&
                  "value" in item
                ) {
                  const specStatus = item.out_of_spec;
                  if (specStatus === "red" || specStatus === true) {
                    return `<span class="out-of-spec-red">${item.value}</span>`;
                  }
                  if (specStatus === "yellow") {
                    return `<span class="out-of-spec-yellow">${item.value}</span>`;
                  }
                  return item.value;
                }
                return item || "N/A"; // Fallback for old format or missing item
              };

              // Use the helper to format each item for display
              displayData = `Vis: ${formatMiniItem(items["Visibility"])}, Wind: ${formatMiniItem(items["Wind"])}\nTemp: ${formatMiniItem(items["Temperature"])}, Clds: ${formatMiniItem(items["Clouds"])}`;
              // --- CHANGE END ---
            } else if (airportData.METAR.display) {
              // Fallback for old format
              displayData = airportData.METAR.display.replace(/\\n/g, ", ");
            }
          }

          return `
                <div class="delete-fav-btn" onclick="removeFavourite('${code}')" title="Remove Favourite">×</div>
                <div class="airport">${code}</div>
                <div class="weather" title="${rawData}">${displayData}</div>
            `;
        }

        // --- RENDER FUNCTIONS ---
        function renderFavouritesList() {
          const list = document.getElementById("favourites-list");
          list.innerHTML = "";
          favouriteAirports.forEach((code) => {
            const li = document.createElement("li");
            li.innerHTML = `
                <span>${code}</span>
                <span class="remove-fav-btn" onclick="removeFavourite('${code}')" title="Remove Favourite">×</span>
              `;
            list.appendChild(li);
          });
        }

        function renderPastAlarms(alarms = []) {
          const list = document.getElementById("past-alarms-list");
          list.innerHTML = "";
          alarms.slice(0, 5).forEach((metar) => {
            // Ensure max 5 entries
            const li = document.createElement("li");
            li.title = metar;
            li.textContent = metar;
            list.appendChild(li);
          });
        }
        function renderFavouritesCarousel() {
          const carousel = document.getElementById("favourites-carousel");
          // Create a document fragment to build the items off-screen
          const fragment = document.createDocumentFragment();
          const items = favouriteAirports.map((code) => {
            const miniCard = document.createElement("div");
            miniCard.className = "mini-card";
            miniCard.innerHTML = createMiniWeatherContent(code);
            return miniCard;
          });

          // Append items once to measure
          items.forEach((item) => fragment.appendChild(item));

          carousel.innerHTML = ""; // Clear previous content
          carousel.appendChild(fragment); // Append all new items at once

          const isOverflowing =
            carousel.scrollWidth > carousel.parentElement.clientWidth;

          if (isOverflowing && items.length > 0) {
            carousel.classList.add("is-scrolling");
            // If overflowing, clone and append for seamless scroll
            items
              .map((item) => item.cloneNode(true))
              .forEach((item) => carousel.appendChild(item));
          } else {
            carousel.classList.remove("is-scrolling");
          }
        }

        function renderDashboard() {
          const dashboard = document.getElementById("dashboard");
          dashboard.innerHTML = "";
          dashboardSlots.forEach((code, index) => {
            const card = document.createElement("div");
            card.dataset.index = index;
            if (code) {
              card.className = "card";
              card.innerHTML = createLargeWeatherContent(code);
            } else {
              card.className = "card add-card";
              card.innerHTML = `<div class="plus">+</div>`;
              card.title = "Click to add an airport";
              card.onclick = () => promptAndAddAirport(index);
            }
            dashboard.appendChild(card);
          });
        }

        function renderAll(pastAlarms = []) {
          renderFavouritesList();
          renderFavouritesCarousel();
          renderDashboard();
          renderPastAlarms(pastAlarms);
        }

        // --- EVENT HANDLERS & ACTIONS (attached to window for inline onclick) ---
        window.toggleType = function (btn, code, type) {
          const card = btn.closest(".card");
          const index = card.dataset.index;
          card.innerHTML = createLargeWeatherContent(code, type);
          card.dataset.index = index; // Re-apply dataset
        };

        // --- CHANGE START: New function to handle TAF selection from dropdown ---
        window.updateTafSelection = function (select, code) {
          const card = select.closest(".card");
          const index = card.dataset.index;
          const tafIndex = select.value; // The value of the option is the TAF array index.
          card.innerHTML = createLargeWeatherContent(code, "TAF", tafIndex);
          card.dataset.index = index; // Re-apply dataset
        };
        // --- CHANGE END ---

        window.clearDashboardSlot = function (button) {
          const card = button.closest(".card");
          const index = card.dataset.index;
          if (index !== undefined && dashboardSlots[index] !== null) {
            dashboardSlots[index] = null;
            renderDashboard();
          }
        };

        window.removeFavourite = function (codeToRemove) {
          favouriteAirports = favouriteAirports.filter(
            (code) => code !== codeToRemove,
          );
          dashboardSlots = dashboardSlots.map((code) =>
            code === codeToRemove ? null : code,
          );
          renderAll();
        };

        const promptAndAddAirport = (index) => {
          const code = prompt("Enter ICAO Airport Code (e.g. YBBN):");
          if (!code || code.trim().length < 3) {
            return; // Exit if prompt is cancelled or input is too short
          }
          const upperCode = code.trim().toUpperCase();

          if (dashboardSlots.includes(upperCode)) {
            alert(`${upperCode} is already on the dashboard.`);
            return;
          }

          dashboardSlots[index] = upperCode;
          renderDashboard(); // Only re-render the dashboard
        };

        // --- INITIALIZATION ---
        const addFavBtn = document.getElementById("add-favourite-btn");
        const favInput = document.getElementById("airport-input");

        const addFavouriteAction = () => {
          const code = favInput.value.trim().toUpperCase();
          if (code && code.length >= 3) {
            if (!favouriteAirports.includes(code)) {
              favouriteAirports.push(code);
              favouriteAirports.sort();
              favInput.value = "";
              renderAll();
            } else {
              alert(`${code} is already in your favourites.`);
            }
          }
        };

        addFavBtn.addEventListener("click", addFavouriteAction);
        favInput.addEventListener("keypress", (e) => {
          if (e.key === "Enter") {
            addFavouriteAction();
          }
        });

        // --- DATA LOADING ---
        async function loadInitialData() {
          try {
            // Fetch data from our new PHP api script
            const response = await fetch("api.php");
            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }
            const data = await response.json();

            // Update the state with data from the server
            favouriteAirports = data.favouriteAirports || [];
            allWeatherData = data.weatherData || {};

            // Render everything with the new data
            renderAll(data.pastAlarms);
          } catch (error) {
            console.error("Could not load initial data:", error);
            alert(
              "Error: Could not connect to the server to load data. Please try again later.",
            );
            // Render the page in a default empty state
            renderAll();
          }
        }

        // Re-check carousel on window resize
        window.addEventListener("resize", renderFavouritesCarousel);

        // Load data from the server when the page starts
        loadInitialData();
      });
    </script>
  </body>
</html>
kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk

        <?php

// This header tells the browser that the response is JSON.
header('Content-Type: application/json');

/**
 * In a real application, you would connect to your database here.
 *
 * Example (using PDO):
 * $pdo = new PDO('mysql:host=localhost;dbname=your_db', 'user', 'pass');
 *
 * // Query for favourites
 * $stmt = $pdo->query("SELECT icao_code FROM user_favourites WHERE user_id = 1");
 * $favourites = $stmt->fetchAll(PDO::FETCH_COLUMN);
 *
 * // Query for past alarms
 * $stmt = $pdo->query("SELECT metar_string FROM past_alarms WHERE user_id = 1 ORDER BY timestamp DESC LIMIT 5");
 * $alarms = $stmt->fetchAll(PDO::FETCH_COLUMN);
 *
 * // Query for weather data (METAR/TAF) for relevant airports
 * // This would typically involve fetching from a weather data source
 * // and parsing it into a structured format.
 * // For example, if you have a table 'airport_weather' with columns:
 * // icao_code, type (METAR/TAF), raw_data, display_data
 * // $stmt = $pdo->query("SELECT icao_code, type, raw_data, display_data FROM airport_weather WHERE icao_code IN ('YBBN', 'YSSY', ...)");
 * // $weather_results = $stmt->fetchAll(PDO::FETCH_ASSOC);
 * // Then process $weather_results into the $weatherData structure below.
 *
 */

// --- For now, we will use dummy data ---
$favourites = ["YBBN", "YSSY", "EGLL", "KJFK", "OMDB"];
$alarms = [
    "METAR YBBN 230400Z 12012KT 9999 FEW020 26/19 Q1018",
    "METAR YSSY 230330Z 14010KT 9999 SCT030 24/18 Q1019",
    "METAR YMML 230300Z 10008KT 8000 -RA BKN015 19/17 Q1020",
    "METAR YPPH 230230Z 09015G25KT 9999 CLR 30/12 Q1015",
    "METAR NZAA 230200Z 22005KT 9999 FEW035 21/16 Q1022"
];

// Dummy weather data for various airports
$weatherData = [
    "YBBN" => [
        "METAR" => [
            "raw" => "YBBN 230400Z 12012KT 9999 -SHRA FEW020 SCT040 26/19 Q1018",
            "name" => "Brisbane International",
            "valid_from" => "230400Z",
            "valid_to" => "230500Z", // --- CHANGE START: out_of_spec can now be 'red' or 'yellow' ---
            "display_items" => [
                "Visibility" => ["value" => "10km+", "out_of_spec" => false],
                "Wind" => ["value" => "120/12kt", "out_of_spec" => false],
                "Temperature" => ["value" => "26°C", "out_of_spec" => false],
                "Dew Point" => ["value" => "19°C", "out_of_spec" => false],
                "QNH" => ["value" => "1018 hPa", "out_of_spec" => false],
                "Clouds" => ["value" => "FEW at 2000ft, SCT at 4000ft", "out_of_spec" => false],
                "Phenomena" => ["value" => "Light Rain Showers", "out_of_spec" => 'yellow'],
                "Flight Rules" => ["value" => "VFR", "out_of_spec" => false],
            ]
        ],
        "TAF" => [
            [
                "raw" => "TAF YBBN 230400Z 2306/2412 12010KT 9999 FEW030",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 1/3: Period: Next 24 Hours\nWind: 120/10kt\nVisibility: >10km\nClouds: FEW030"
            ],
            [
                "raw" => "TAF AMD YBBN 230400Z 2306/2412 14015KT 9999 SCT035",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 2/3 (AMD): Period: Next 24 Hours\nWind: 140/15kt\nVisibility: >10km\nClouds: SCT035"
            ],
            [
                "raw" => "TAF AMD YBBN 230400Z 2306/2412 14015G25KT 9999 SCT035 TEMPO 2308/2312 4000 SHRA",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 3/3 (AMD): Period: Next 24 Hours\nWind: 140/15G25kt\nVisibility: >10km\nClouds: SCT035\nTempo: Showers/Rain"
            ]
        ]
    ],
    "YSSY" => [
        "METAR" => [
            "raw" => "YSSY 230400Z 14010KT 9999 SCT030 24/18 Q1019",
            "name" => "Sydney Kingsford Smith",
            "valid_from" => "230400Z",
            "valid_to" => "230500Z", // This airport has no out-of-spec items for demonstration.
            "display_items" => [
                "Visibility" => ["value" => "10km+", "out_of_spec" => false],
                "Wind" => ["value" => "140/10kt", "out_of_spec" => false],
                "Temperature" => ["value" => "24°C", "out_of_spec" => false],
                "Dew Point" => ["value" => "18°C", "out_of_spec" => false],
                "QNH" => ["value" => "1019 hPa", "out_of_spec" => false],
                "Clouds" => ["value" => "SCT at 3000ft", "out_of_spec" => false],
                "Phenomena" => ["value" => "Nil", "out_of_spec" => false],
                "Flight Rules" => ["value" => "VFR", "out_of_spec" => false],
            ]
        ],
        "TAF" => [
            [
                "raw" => "TAF YSSY 230400Z 2306/2412 14010KT 9999 SCT030",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "Period: Next 24 Hours\nWind: 140/10kt\nVisibility: 10km\nClouds: SCT030"
            ]
        ]
    ],
    "YMML" => [
        "METAR" => [
            "raw" => "YMML 230300Z 10008KT 8000 -RA BKN015 19/17 Q1020",
            "name" => "Melbourne Tullamarine",
            "valid_from" => "230300Z",
            "valid_to" => "230400Z", // This airport has multiple out-of-spec items (red and yellow).
            "display_items" => [
                "Visibility" => ["value" => "8km", "out_of_spec" => 'red'],
                "Wind" => ["value" => "100/8kt", "out_of_spec" => false],
                "Temperature" => ["value" => "19°C", "out_of_spec" => false],
                "Dew Point" => ["value" => "17°C", "out_of_spec" => false],
                "QNH" => ["value" => "1020 hPa", "out_of_spec" => false],
                "Clouds" => ["value" => "BKN at 1500ft", "out_of_spec" => 'yellow'],
                "Phenomena" => ["value" => "Light Rain", "out_of_spec" => 'red'],
                "Flight Rules" => ["value" => "IFR", "out_of_spec" => 'yellow'],
            ]
        ],
        "TAF" => [
            [
                "raw" => "TAF YMML 230400Z 2306/2412 10008KT 8000 -RA BKN015",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 1/2: Period: Next 24 Hours\nWind: 100/8kt\nVisibility: 8km\nClouds: BKN015"
            ],
            [
                "raw" => "TAF AMD YMML 230400Z 2306/2412 10012KT 9999 NSW BKN020",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 2/2 (AMD): Period: Next 24 Hours\nWind: 100/12kt\nVisibility: >10km\nClouds: BKN020"
            ]
        ]
    ],
    "EGLL" => [
        "METAR" => [
            "name" => "London Heathrow",
            "raw" => "EGLL 230400Z AUTO 27005KT 9999 NCD 15/12 Q1012",
            "valid_from" => "230400Z",
            "valid_to" => "230500Z", // All items are within spec.
            "display_items" => [
                "Visibility" => ["value" => "10km+", "out_of_spec" => false],
                "Wind" => ["value" => "270/5kt", "out_of_spec" => false],
                "Temperature" => ["value" => "15°C", "out_of_spec" => false],
                "Dew Point" => ["value" => "12°C", "out_of_spec" => false],
                "QNH" => ["value" => "1012 hPa", "out_of_spec" => false],
                "Clouds" => ["value" => "No Cloud Detected", "out_of_spec" => false],
                "Phenomena" => ["value" => "Nil", "out_of_spec" => false],
                "Flight Rules" => ["value" => "VFR", "out_of_spec" => false],
            ]
        ],
        "TAF" => [
            [
                "raw" => "TAF EGLL 230400Z 2306/2412 27008KT 9999 SCT025",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "Period: Next 24 Hours\nWind: 270/8kt\nVisibility: >10km\nClouds: SCT025"
            ]
        ]
    ],
    "KJFK" => [
        "METAR" => [
            "name" => "JFK International",
            "raw" => "KJFK 230351Z 18008KT 10SM FEW050 SCT250 22/17 A2992",
            "valid_from" => "230351Z",
            "valid_to" => "230451Z", // All items are within spec.
            "display_items" => [
                "Visibility" => ["value" => "10SM", "out_of_spec" => false],
                "Wind" => ["value" => "180/8kt", "out_of_spec" => false],
                "Temperature" => ["value" => "22°C", "out_of_spec" => false],
                "Dew Point" => ["value" => "17°C", "out_of_spec" => false],
                "QNH" => ["value" => "29.92 inHg", "out_of_spec" => false],
                "Clouds" => ["value" => "FEW at 5000ft, SCT at 25000ft", "out_of_spec" => false],
                "Phenomena" => ["value" => "Nil", "out_of_spec" => false],
                "Flight Rules" => ["value" => "VFR", "out_of_spec" => false],
            ]
        ],
        "TAF" => [
            [
                "raw" => "TAF KJFK 230351Z 2306/2412 18010KT P6SM SCT040",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 1/4: Period: Next 24 Hours\nWind: 180/10kt\nVisibility: >6SM\nClouds: SCT040"
            ],
            [
                "raw" => "TAF AMD KJFK 230351Z 2306/2412 19012KT P6SM BKN030",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 2/4 (AMD): Period: Next 24 Hours\nWind: 190/12kt\nVisibility: >6SM\nClouds: BKN030"
            ],
            [
                "raw" => "TAF AMD KJFK 230351Z 2306/2412 19015G22KT P6SM BKN030 TEMPO 2310/2314 5SM -TSRA",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 3/4 (AMD): Period: Next 24 Hours\nWind: 190/15G22kt\nVisibility: >6SM\nClouds: BKN030\nTempo: Thunderstorms/Rain"
            ],
            [
                "raw" => "TAF COR KJFK 230351Z 2306/2412 18010KT P6SM SCT040",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "TAF 4/4 (COR): Period: Next 24 Hours\nWind: 180/10kt\nVisibility: >6SM\nClouds: SCT040 (Corrected)"
            ]
        ]
    ],
    "OMDB" => [
        "METAR" => [
            "name" => "Dubai International",
            "raw" => "OMDB 230400Z 13004KT 8000 NSC 35/24 Q1005",
            "valid_from" => "230400Z",
            "valid_to" => "230500Z", // Visibility is out of spec (yellow).
            "display_items" => [
                "Visibility" => ["value" => "8km", "out_of_spec" => 'yellow'],
                "Wind" => ["value" => "130/4kt", "out_of_spec" => false],
                "Temperature" => ["value" => "35°C", "out_of_spec" => false],
                "Dew Point" => ["value" => "24°C", "out_of_spec" => false],
                "QNH" => ["value" => "1005 hPa", "out_of_spec" => false],
                "Clouds" => ["value" => "No Significant Cloud", "out_of_spec" => false],
                "Phenomena" => ["value" => "Nil", "out_of_spec" => false],
                "Flight Rules" => ["value" => "VFR", "out_of_spec" => false],
            ]
        ],
        "TAF" => [
            [
                "raw" => "TAF OMDB 230400Z 2306/2412 14008KT 9000 NSC",
                "valid_from" => "230600Z",
                "valid_to" => "241200Z",
                "display" => "Period: Next 24 Hours\nWind: 140/8kt\nVisibility: 9km\nClouds: NSC"
            ]
        ]
    ]
];

// We package all our data into a single associative array.
$data = [
    'favouriteAirports' => $favourites,
    'pastAlarms' => $alarms,
    'weatherData' => $weatherData
];

// Finally, we encode the array into a JSON string and echo it.
echo json_encode($data);
