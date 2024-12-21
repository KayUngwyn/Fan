<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="FanControl.WebForm1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fan Control</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f4f4f4;
        }
        .container {
            display: inline-block;
            position: relative;
            margin-top: 30px;
        }
        .fan {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: #ccc;
            position: relative;
            border: 5px solid #333;
            margin: 20px;
        }
        .fan-blade {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 10px;
            height: 60px;
            background-color: #333;
            transform-origin: top center;
            transform: translate(-50%, -100%);
            animation-timing-function: linear;
        }
        .controls {
            margin-top: 30px;
        }
        .slider-container {
            margin: 10px 0;
        }
        button, input[type=range] {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <h1>Fan Control</h1>

    <div class="container">
        <div class="fan" id="fan">
            <div class="fan-blade" id="fan-blade"></div>
        </div>
    </div>

    <div class="controls">
        <button id="fanToggleButton" onclick="toggleFan()">Turn On/Off Fan</button>
        <div class="slider-container">
            <label for="speedSlider">Speed (1-5): </label>
            <input type="range" id="speedSlider" min="1" max="5" value="1" />
            <span id="speedValue">1</span>
        </div>
    </div>

    <script type="text/javascript">
        let isFanOn = false;
        let speed = 1;
        const fanBlade = document.getElementById('fan-blade');
        const fan = document.getElementById('fan');
        const speedSlider = document.getElementById('speedSlider');
        const speedValue = document.getElementById('speedValue');
        const fanToggleButton = document.getElementById('fanToggleButton');

        // Function to toggle fan state
        function toggleFan() {
            isFanOn = !isFanOn;
            if (isFanOn) {
                fanBlade.style.animationPlayState = 'running';
                fanToggleButton.textContent = 'Turn Off Fan';
            } else {
                fanBlade.style.animationPlayState = 'paused';
                fanToggleButton.textContent = 'Turn On Fan';
            }
        }

        // Function to change speed
        function updateSpeed() {
            speed = speedSlider.value;
            speedValue.textContent = speed;
            if (isFanOn) {
                updateFanSpeed();
            }
        }

        // Update fan speed based on slider
        function updateFanSpeed() {
            // Decrease the animation time to make the fan faster
            const speedInSeconds = 60 / (speed * 3);  // This makes it super fast as the factor increases
            fanBlade.style.animation = `spin ${speedInSeconds}s infinite linear`;
        }

        // Add event listener to speed slider
        speedSlider.addEventListener('input', updateSpeed);

        // Initial fan state
        updateSpeed(); // Set initial speed
        fanBlade.style.animation = `spin ${60 / (speed * 3)}s infinite linear`;

        // Fan spin animation
        const style = document.createElement('style');
        style.innerHTML = `
            @keyframes spin {
                0% { transform: translate(-50%, -100%) rotate(0deg); }
                100% { transform: translate(-50%, -100%) rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
    </script>

</body>
</html>