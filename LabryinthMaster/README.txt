STAR LABRYINTH
a game by Michael Biggs (u0413046) and Garin Richards (u0738045)

Developed for the CS 4962 Mobile Programming Course - Final Project

Star Labryinth is a labryinth game with a space theme. Featuring high scores, audio effects, and background music! Tilt the device to maneuver the Earth towards the black hole to continue onto the next level. Keep playing until you encounter an alien!

To install and play the game, do the following:

    1) Load this project file.
        NOTE: This game was developed with Xcode 7.3 and Swift 2.2 and these are required in order to build the project
    2) Attach an iOS device, iPad or iPhone. iPad PREFERRED.
        NOTE: You must make sure that your "Team" is selected under the "Team" dropdown field
        in the LabryinthMaster project settings on the top most level of the hierarchy on the
        left

    3) Build and Run the game on your device.
    NOTE: There is a well known xcode bug concerning the latency of the keyboard popping up when entering your name in the New Mission name field. This is only present when running in "Debug" mode (When you install and launch the game via xcode) but not when you run it in "RELEASE" mode.
    NOTE 2: To enter RELEASE MODE, build and run the game once via XCODE, and then quit the application. Than, going back to your iDevice and launching the game like you would run any other iOS application. The important part is to NOT RUN THE GAME VIA XCODE!

    4) Ta da! Star Labyrinth should now be up and running on your device.

Rules of the game:
    Star Labyrinth is a typical labryinth game, where you must avoid the aliens, collect stars, and also beat the timer! Star Labryinth is designed to be an endless game where you can only lose if time runs out, or you encounter an alien.
    Each time that you complete a level, or mission, the timer slightly decreases, the amount of aliens increases (up to a max of 10), and the maze gets more complex!
    There are two difficulties to play Star Labryinth, Easy and Hard. Easy is your typical increasing difficulty game, but the enemies wander around aimlessly. On Hard, the enemies will attempt to find you and come after you!

    NOTE! HARD DIFFICULTY DOES NOT WORK! There is a major latency issue when it comes to computing the pathfinding needed for the enemies to find the player. It is recommended to play the game on the easy difficulty only. HOWEVER, you can find the code related to the implementation of A* in the "moveTowardPlayer" function in EnemyView.swift.

    You can check out high scores, saved across app launches, via the "High Scores" button in the main menu.

If you have ANY ISSUES launching or building the application, please contact the developers at:

Garin Richards : Garin2010@gmail.com
Michael Biggs : eraserhead@gmail.com