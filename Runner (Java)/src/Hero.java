import javafx.geometry.Rectangle2D;
import javafx.scene.image.ImageView;

public class Hero extends AnimatedThing { // extends permet à Hero d'hériter de toutes les caractéristiques de AnimatedThing

    public Hero() {
        super(30, 250); // Position de l'origine
        this.getSpriteSheet().setViewport(new Rectangle2D(0,0,120,120));
    }

//abstract méthode
    @Override
    public ImageView getSpriteSheet() {
        return this.spriteSheet_hero;
    }
}
