
import javafx.animation.AnimationTimer;
import javafx.geometry.Rectangle2D;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;


public class GameScene extends Scene {
    public static int stop = 0;
    //private Camera cam1;
    private static staticThing leftBack;
    private static staticThing rightBack;
    private Hero hero; // creation d'un héro
    private foe foe;// création d'un ennemi
    private int slow = 0;

    private int numberOfLives;
    private ImageView spriteSheet_life;
    public double deltaTime=0;
    public double previousTime;
    public int invicibility=0;

    public GameScene(Parent parent, double width, double height, boolean depthBuffer) {
        super(parent, width, height, depthBuffer);
        this.leftBack = new staticThing(0, 0, "desert"); //création du BackGround de gauche
        this.rightBack = new staticThing(800, 0, "desert"); // " " de droite
        this.hero = new Hero();  // création d'un Hero
        this.foe = new foe();


        Image thisSpringSheet_life = new Image("/Images/life.png"); // Attribue à Image l'image animée (notre Hero)
        this.spriteSheet_life=new ImageView(thisSpringSheet_life);
        this.spriteSheet_life.setViewport( new Rectangle2D(0,0,300,0)); // Rectangle2D crée un cadre 2D sur spritesheet, partant de (v,v1) et longueur v3 et de hauteur v4

        numberOfLives=5; //Commence à 5 vies

        //Camera cam1 = new Camera(); // Création d'une caméra

        AnimationTimer timer = new AnimationTimer() {//création d'un Timer qui actualise les affichages

            public void handle(long time) {
                invicibility=Math.max( invicibility-1000, 0);//l'nvicibilité s'estompe
                deltaTime=(time-previousTime)/50000000; //Intervalle de temps entre chaque appel de time
                slow += 1; // Slow permet de ralentir la course du joueur
                if (slow % 5 == 0) { //On divise la vitesse de défilement par 5
                    hero.update(time,deltaTime); // actualise la position du Hero
                    GameScene.update(); // actualise le Background
                    slow = 0;
                }
                foe.foeSummoning(time);//invoque et actualise la position des ennemis

                lifePoint();//actualise les vies ainsi que l'affichage de la barre de vie
                if(numberOfLives==0){
                    hero.end(); //affichie le message "game over" quand le joueur n'a plus de vie
                    this.stop();//arrête le temps
                }
                previousTime=time;

            }
        };
        timer.start();


    }

    private Boolean isIncollision(ImageView a, ImageView b){
        return (a.getBoundsInParent().intersects(b.getBoundsInParent()) && foe.ennemi);
        }


    public void lifePoint(){
        if (numberOfLives>0 & invicibility==0) {
            if (isIncollision(getHero().getSpriteSheet(), getFoe().getSpriteSheet())) {
                numberOfLives -= 1;
                invicibility=50000;
            }
            if (numberOfLives >= 0) {
                this.spriteSheet_life.setViewport(new Rectangle2D(0, 0, (numberOfLives) * 60, 80)); // Rectangle2D crée un cadre 2D sur spritesheet, partant de (v,v1) et longueur v3 et de hauteur v4
            }


        }
    }
    public static void update() { // actualise le background
        int speed = 20;
        double x1 = leftBack.getX();
        double x2 = rightBack.getX();
        if (x1 < 30) { //prendre x<30 au lieu de 0 permet d'éviter un freeze de l'écran du au changement de background
            //Si x1<0, on affiche le back ground du début
            leftBack.getImageView().setX(800);
            leftBack.setX(800);
            rightBack.getImageView().setX(0);
            rightBack.setX(0);
        } else { // On défile background vers l'arrière
            leftBack.getImageView().setX(x1 - speed); //On modifie le x associé à l'image dans le background de gauche
            leftBack.setX((x1 - speed)); // On modifie la x associé au background de gauche qui est modifié. ligne 61 on aura x1=x1-6
            rightBack.getImageView().setX(x2 - speed); // " " gauche-->droite
            rightBack.setX((x2 - speed));
        }


    }


    // Getters
    public Hero getHero() {
        return this.hero;
    }

    public foe getFoe() {
        return this.foe;
    }

    public staticThing getLeftBack() {
        return this.leftBack;
    }

    public staticThing getRightBack() {
        return this.rightBack;
    }

    public ImageView getLife() {
        return this.spriteSheet_life;
    }
}

    // Setters



