public class Highscore{
    String name = "";
    Table table;
    boolean keyIsPressed = false;

    public Highscore(){
        this.table = new Table();
        table.addColumn("name");
        table.addColumn("waves");    
    }

    void display(){
        fill(0);
        text("Name:"+name, 100, height/2);
    }

    void keyPressed(){
        if(currentState == GameState.END && !keyIsPressed){
            if(key == BACKSPACE && name.length() >0 ){
                name = name.substring(0, name.length()-1);
            } else if(key == ENTER){
                println("Speichern:"+ name +":"+ waveManager.waveNumber);
                TableRow newRow = table.addRow();
                newRow.setString("name", name);
                newRow.setInt("waves", waveManager.waveNumber);
                saveTable(table,"data/score.csv");
            } else {
                if(name.length()< 10 && keyCode >= 65 && keyCode <= 154){
                    name+=key;
                }
            }
            this.keyIsPressed = true;
        }

    }

    void keyReleased(){
        this.keyIsPressed = false;
    }
}
