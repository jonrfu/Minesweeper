import de.bezier.guido.*;
int NUM_ROWS=20; 
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines= new ArrayList(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    
     buttons = new MSButton[25][25];
  for (int r = 0; r < 25; r++)
    for (int c = 0; c < 25; c++)
      buttons[r][c] = new MSButton(r, c);

    
    setMines();
}
public void setMines()
{
  for(int i=0;i<45;i++){
    int randrow=(int)(Math.random()*25);
    int randcol=(int)(Math.random()*25);
      if(!mines.contains(buttons[randrow][randcol]))
        {
            //System.out.println(ranR+", " + ranC);
            mines.add(buttons[randrow][randcol]);
        }
}
  
}
public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
  
  background( 155 );
  textSize(150);
 
    text("loser",200,200);
   noLoop();
  
}
public void displayWinningMessage()
{
              buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("YOU");
                buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("WIN!");}

public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        
        if(mouseButton==RIGHT){
         if(flagged){
         flagged = false;
         }
         else
         flagged = true;
        }else if(mouseButton==LEFT) {
          clicked = true;
          if(mines.contains(this)){
          displayLosingMessage();
        }else if(countMines(myRow,myCol)>0){
            setLabel(countMines(myRow,myCol));
         
          }     else
        {
            if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].isClicked())
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].isClicked())
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].isClicked())
                buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].isClicked())
                buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].isClicked())
                buttons[myRow+1][myCol-1].mousePressed();
            if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].isClicked())
                buttons[myRow+1][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].isClicked())
                buttons[myRow-1][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].isClicked())
                buttons[myRow-1][myCol-1].mousePressed();
        }
        }
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 ); 
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
        public boolean isClicked()
    {
        return clicked;
    }
    public boolean isValid(int r, int c)
{
     if (r>=0 && r<25 && c>=0 && c<25)
      return true;
    else
      return false;
  
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row,col+1)&& mines.contains(buttons[row][col+1])){
      numMines++;
    }
        if(isValid(row,col-1)&& mines.contains(buttons[row][col-1])){
      numMines++;
    }
        if(isValid(row+1,col+1)&& mines.contains(buttons[row+1][col+1])){
      numMines++;
    }
        if(isValid(row-1,col+1)&& mines.contains(buttons[row-1][col+1])){
      numMines++;
    }
        if(isValid(row+1,col-1)&& mines.contains(buttons[row+1][col-1])){
      numMines++;
    }
        if(isValid(row-1,col-1)&& mines.contains(buttons[row-1][col-1])){
      numMines++;
    }
        if(isValid(row+1,col)&& mines.contains(buttons[row+1][col])){
      numMines++;
    }
        if(isValid(row-1,col)&& mines.contains(buttons[row-1][col])){
      numMines++;
    }

    
  


    return numMines;
}
}
