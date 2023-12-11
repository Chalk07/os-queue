# Queue System for FiveM Server (Untested)

### Overview

This queue system is designed for use with FiveM servers to manage player connections when the server is full. It places players in a priority queue, allowing for differentiated service based on configurable priority levels.

### Features

* Prioritized Queueing: Manage player connections based on priority levels. While currently set to treat all players equally (priority 0), the system is designed to accommodate different priority levels.

* Real-Time Queue Updates: Provide players in the queue with real-time updates on their position.

* Automatic Dequeueing: Automatically remove players from the queue if they cancel their connection attempt or disconnect.

### Installation

1. Place the queue.lua, utils.lua, events.lua, and any other relevant files into your resource folder.

2. Ensure your server's resource configuration file (__resource.lua or fxmanifest.lua) loads these files.

3. Restart your FiveM server or load the resource.

### Usage

* The queue system activates when the server reaches maximum capacity.

* Players attempting to join a full server are placed in a queue based on priority, and are informed of their position.

* The system removes players who disconnect or cancel their connection attempt.

### Important Notes

* **Current Status:** This system is in a developmental and untested state. Further modifications and testing are required for full functionality.

* **Server Compatibility:** Designed specifically for FiveM servers. Compatibility with other server types is not guaranteed.

* **Customization:** The system can be tailored to specific server needs, including adjusting priority levels and queue handling logic.
