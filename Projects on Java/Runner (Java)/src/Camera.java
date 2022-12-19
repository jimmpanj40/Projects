import javafx.geometry.Rectangle2D;
import javafx.scene.image.ImageView;

public class Camera {
    private double x;
    private double y;


    public Camera(){
        this.x=0;
        this.y=0;
    }
    public Camera(double x, double y){
        this.x=x;
        this.y=y;
    }
    public double hero_x(){
        return x;
    }
    public double hero_y(){
        return y;
    }

    public void update(){

    }


    @Override
    public String toString() {
        return "("+x+","+y+")";
    }
}
