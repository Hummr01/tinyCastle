class WaveManager {
    int waveNumber;
    int waveStartTime;
    int waveDuration = 600*3; // 10 seconds (assuming 60 FPS)
    int initialDelay = 600; // 5 seconds delay before first wave
    boolean waveInProgress;

    WaveManager() {
        waveNumber = 1;
        waveStartTime = frameCount;
        waveInProgress = false;
    }

    void update() {
        if (!waveInProgress && frameCount >= waveStartTime + initialDelay) {
            startWave();
            resources = new ArrayList<Resource>();
        }
        if (waveInProgress && frameCount >= waveStartTime + waveDuration || enemies.isEmpty() && waveInProgress) {
            endWave();
        }
    }

    void startWave() {
        waveInProgress = true;
        waveStartTime = frameCount;
        spawnEnemies();
    }

    void endWave() {
        waveInProgress = false;
        waveStartTime = frameCount;
        waveNumber++;
    }

    void spawnEnemies() {
        int enemyCount = waveNumber * 2; // Scale enemy count with wave number
        for (int i = 0; i < enemyCount; i++) {
            enemies.add(new Enemy(getEnemyLevel()));
        }
    }

    int getEnemyLevel() {
        return waveNumber > 5 ? 1 : 0;
    }

    int getRemainingTime() {
        int remainingFrames = waveInProgress ? (waveStartTime + waveDuration) - frameCount
                                             : (waveStartTime + initialDelay) - frameCount;
        return max(0, remainingFrames / 60);
    }

    String getWaveStatus() {
        return waveInProgress ? "Wave " + waveNumber + " -" : "Next Wave:";
    }
    
    int getWaveNumber(){
        return waveNumber; 
    }

    boolean getWaveInProgress(){
        return this.waveInProgress;
    }
}
