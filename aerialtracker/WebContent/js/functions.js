let collapsed = false;
        const apiKey = '951eb03061c8fa8e0cc71c9bdee73391';
        const weatherLocations = [
            { name: 'Indira Gandhi International Airport, Delhi', lat: 28.5562, lon: 77.1000 },
            { name: 'Chhatrapati Shivaji Maharaj International Airport, Mumbai', lat: 19.0896, lon: 72.8656 },
            { name: 'Netaji Subhas Chandra Bose International Airport, Kolkata', lat: 22.6541, lon: 88.4467 },
            { name: 'Chennai International Airport, Chennai', lat: 12.9941, lon: 80.1709 },
            { name: 'Kempegowda International Airport, Bengaluru', lat: 13.1986, lon: 77.7066 },
            { name: 'Rajiv Gandhi International Airport, Hyderabad', lat: 17.2403, lon: 78.4294 },
            { name: 'Cochin International Airport, Kochi', lat: 10.1520, lon: 76.4019 },
            { name: 'Sardar Vallabhbhai Patel International Airport, Ahmedabad', lat: 23.0748, lon: 72.6319 },
            { name: 'Pune International Airport, Pune', lat: 18.5826, lon: 73.9199 },
            { name: 'Goa International Airport, Goa', lat: 15.3800, lon: 73.8315 },
            { name: 'Trivandrum International Airport, Trivandrum', lat: 8.4821, lon: 76.9206 },
            { name: 'Jaipur International Airport, Jaipur', lat: 26.8285, lon: 75.8069 },
            { name: 'Srinagar International Airport, Srinagar', lat: 33.9871, lon: 74.7745 },
            { name: 'Lal Bahadur Shastri Airport, Varanasi', lat: 25.4524, lon: 82.8590 },
            { name: 'Sri Guru Ram Dass Jee International Airport, Amritsar', lat: 31.7087, lon: 74.7973 }
        ];

        let map = L.map('map').setView([20.5937, 78.9629], 5);

        const baseLayers = {
            "OpenStreetMap": L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }),
            "Satellite": L.tileLayer('https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
                attribution: '&copy; <a href="https://www.esri.com/en-us/home">Esri</a> &copy; <a href="https://www.openstreetmap.org">OpenStreetMap</a> contributors'
            }),
            "CartoDB Positron": L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
                attribution: '&copy; <a href="https://www.carto.com/attributions">CARTO</a>'
            })
        };

        baseLayers["OpenStreetMap"].addTo(map);
        L.control.layers(baseLayers).addTo(map);
        L.control.scale().addTo(map);

        let aircraftMarkers = {};
        let aircraftPaths = {};
        let currentPolyline = null;
        let aircraftData = [];

        function formatTemperature(temp) {
            return temp.toFixed(2) + '\u00B0C';
        }

        async function fetchWeatherData() {
            try {
                const weatherData = [];

                for (const location of weatherLocations) {
                    const response = await fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.lon}&appid=${apiKey}&units=metric`);
                    const data = await response.json();
                    const temperature = data.main.temp;
                    const windSpeed = data.wind.speed;

                    weatherData.push({
                        name: location.name,
                        lat: location.lat,
                        lon: location.lon,
                        temperature,
                        windSpeed
                    });

                    L.marker([location.lat, location.lon])
                        .addTo(map)
                        .bindPopup(`
                            <b>${location.name}</b><br>
                        `);
                }

                displayWeatherCards(weatherData);

            } catch (error) {
                console.error('Error fetching weather data:', error);
            }
        }

        function displayWeatherCards(weatherData) {
            const weatherCardsContainer = document.getElementById('weather-cards');
            weatherCardsContainer.innerHTML += weatherData
                .sort((a, b) => b.windSpeed - a.windSpeed)
                .map(data => `
                    <div class="weather-card">
                        <h5>${data.name}</h5>
                        <p>Temperature: ${formatTemperature(data.temperature)}</p>
                        <p>Wind Speed: ${data.windSpeed} m/s</p>
                    </div>
                `).join('');
        }

        function fetchAircraftData() {
            const lamin = 6.0;
            const lomin = 50.0;
            const lamax = 37.1;
            const lomax = 97.5;

            const url = `/testproject/api/aircrafts?lamin=${lamin}&lomin=${lomin}&lamax=${lamax}&lomax=${lomax}`;

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        console.error('Error fetching aircraft data:', data.error);
                    } else {
                        aircraftData = data.states;
                        updateAircraftPositions(aircraftData);
                    }
                })
                .catch(error => {
                    console.error('Error fetching aircraft data:', error);
                });
        }

        function updateAircraftPositions(data) {
            data.forEach(aircraft => {
                const id = aircraft[0];
                const latitude = aircraft[6];
                const longitude = aircraft[5];
                const altitude = aircraft[7];
                const hexCode = aircraft[0];
                const origin_country = aircraft[2];
                const velocity = aircraft[9];
                const callsign = aircraft[1];
                const true_track = aircraft[10] || 0;

                getAircraftPhoto(hexCode).then(photoUrl => {
                    const iconHtml = `
                        <div class="airplane-icon" style="background-image: url(images/airplane.png); transform: rotate(${true_track}deg);"></div>
                    `;

                    if (!aircraftMarkers[id]) {
                    	const marker = L.marker([latitude, longitude], {
                    	    icon: L.divIcon({
                    	        className: 'airplane-icon-container',
                    	        html: iconHtml,
                    	        iconSize: [32, 32],
                    	        iconAnchor: [16, 16]
                    	    }),
                    	    title: `Aircraft ${id}`
                    	}).addTo(map);

                    	const infoWindowContent = `
                    	    <div class="leaflet-popup-content-wrapper">
                    	        <img src="${photoUrl || 'images/default.png'}" alt="Aircraft ${callsign}" style="width: 100%; max-height: 150px; object-fit: cover;" onerror="this.onerror=null;this.src='images/default.png';">
                    	        <div class="leaflet-popup-content">
                    	            <h5>${callsign || 'Unknown'}</h5>
                    	            <p>
                    	                <strong>Country of Origin:</strong> ${origin_country}<br>
                    	                <strong>Altitude:</strong> ${altitude} m<br>
                    	                <strong>Velocity:</strong> ${velocity} m/s<br>
                    	                <strong>Track:</strong> ${true_track}°<br>
                    	                <strong>Latitude:</strong> ${latitude}<br>
                    	                <strong>Longitude:</strong> ${longitude}<br>
                    	            </p>
                    	        </div>
                    	    </div>
                    	`;

                    	marker.bindPopup(infoWindowContent);


                        marker.on('click', function() {
                            if (currentPolyline) {
                                map.removeLayer(currentPolyline);
                            }

                            if (currentPolyline === aircraftPaths[id]) {
                                currentPolyline = null;
                            } else {
                                aircraftPaths[id].addTo(map);
                                currentPolyline = aircraftPaths[id];
                            }
                        });

                        aircraftMarkers[id] = marker;
                        aircraftPaths[id] = L.polyline([[latitude, longitude]], { color: 'red' });
                    } else {
                        aircraftMarkers[id].setLatLng([latitude, longitude]);
                        aircraftMarkers[id].getPopup().setContent(`
                            <div style="text-align: center;">
                                <img src="${photoUrl || 'images/default.png'}" alt="Aircraft ${callsign}" style="width: 100%; max-height: 150px; object-fit: cover;" onerror="this.onerror=null;this.src='images/default.png';">
                                <h5>${callsign || 'Unknown'}</h5>
                                <p>
                                    <strong>Country of Origin:</strong> ${origin_country}<br>
                                    <strong>Altitude:</strong> ${altitude} m<br>
                                    <strong>Velocity:</strong> ${velocity} m/s<br>
                                    <strong>Track:</strong> ${true_track}°<br>
                                    <strong>Latitude:</strong> ${latitude}<br>
                                    <strong>Longitude:</strong> ${longitude}<br>
                                </p>
                            </div>
                        `);

                        aircraftPaths[id].addLatLng([latitude, longitude]);
                    }
                });
            });
        }


        function getAircraftPhoto(hexCode) {
            const url = `https://api.planespotters.net/pub/photos/hex/${hexCode}`;
            return fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data.photos && data.photos.length > 0) {
                        const photo = data.photos[0];
                        const photoUrl = photo.thumbnail_large ? photo.thumbnail_large.src : photo.thumbnail.src;
                        return photoUrl;
                    } else {
                        return null;
                    }
                })
                .catch(error => {
                    console.error('Error retrieving aircraft photo:', error);
                    return null;
                });
        }

        function filterAircraft() {
            const filterValue = document.getElementById('flight-filter').value;
            for (const id in aircraftMarkers) {
                const marker = aircraftMarkers[id];
                const origin_country = aircraftData.find(aircraft => aircraft[0] === id)[2];
                if (filterValue === 'all' ||
                    (filterValue === 'domestic' && origin_country === 'India') ||
                    (filterValue === 'international' && origin_country !== 'India')) {
                    marker.addTo(map);
                } else {
                    map.removeLayer(marker);
                }
            }
        }

        fetchAircraftData();
        setInterval(fetchAircraftData, 10000);
        fetchWeatherData();
        setInterval(fetchWeatherData, 3600000);

        Object.keys(aircraftPaths).forEach(id => {
            map.removeLayer(aircraftPaths[id]);
        });

        map.on('click', function() {
            if (currentPolyline) {
                map.removeLayer(currentPolyline);
                currentPolyline = null;
            }
        });

        document.addEventListener('DOMContentLoaded', () => {
            const weatherCardsContainerElement = document.getElementById('weather-cards');
            weatherCardsContainerElement.addEventListener('click', (event) => {
                if (event.target && event.target.id === 'toggle-button') {
                    collapsed = !collapsed;
                    if (collapsed) {
                        weatherCardsContainerElement.classList.add('collapsed');
                        event.target.innerHTML = '&#x25BC;';
                    } else {
                        weatherCardsContainerElement.classList.remove('collapsed');
                        event.target.innerHTML = '&#x25B2;';
                    }
                }
            });

            const flightFilter = document.getElementById('flight-filter');
            flightFilter.addEventListener('change', filterAircraft);
        });