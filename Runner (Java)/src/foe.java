import javafx.geometry.Rectangle2D;
import javafx.scene.image.ImageView;

public class foe extends AnimatedThing {

    public foe() {
        super(600, 225);
        this.getSpriteSheet().setViewport(new Rectangle2D(0,0,170,500));
}



    //abstract méthode
    @Override
    public ImageView getSpriteSheet() {
        return this.spriteSheet_foe;
    }
}
