let map = L.map('map').setView([20.5937, 78.9629], 5);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        L.control.scale().addTo(map);

        let aircraftMarkers = {};
        let aircraftData = [];

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
                const true_track = aircraft[10] || 0;

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

                    // Add click event listener to the marker
                    marker.on('click', function() {
                        // Show the message
                        document.getElementById('message').style.display = 'block';

                        // Hide the message after a few seconds (optional)
                        setTimeout(() => {
                            document.getElementById('message').style.display = 'none';
                        }, 3000);
                    });

                    aircraftMarkers[id] = marker;
                } else {
                    aircraftMarkers[id].setLatLng([latitude, longitude]);
                }
            });
        }

        fetchAircraftData();
        setInterval(fetchAircraftData, 10000);