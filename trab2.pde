PImage  imagenuno,imagendos,imagenfinal,despachador;
//esta variable almacena el inicio del contador de tiempo
int inicio;

//esta variable almacena el tiempo transcurrido desde el inicio
int tiempoTranscurrido;

//este es el límite de tiempo
int limiteDeTiempo = 5000;

PFont fuente;


import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// mundo de bos2D a processing
Box2DProcessing box2d;


ArrayList<Plataforma> plataformas;

ArrayList<Liquido> liquido;

void setup() {
  size(550, 450);
   imagenuno= loadImage("imagenuno.jpg");
   imagendos= loadImage("imagendos.jpg");
    imagenfinal= loadImage("imagenfinal.jpg");
    despachador= loadImage("despachador.jpg");
   
   
   
fuente = createFont("Times New Roman",30);
  textFont(fuente);
  smooth();


  // unicializar box2D
  box2d = new Box2DProcessing(this, 20);
  box2d.createWorld();
  // gravedad
  box2d.setGravity(0, -50);

   
  liquido = new ArrayList<Liquido>();
  plataformas = new ArrayList<Plataforma>();

  

  plataformas.add(new Plataforma(150, 450, 60, 10, 0));//base1 (x,y,largo,ancho,ngulo)
  plataformas.add(new Plataforma(125, 450, 10, 170, -160));//izquierdo
  plataformas.add(new Plataforma(185, 450, 10, 170, 160));//izquierdo

  plataformas.add(new Plataforma(370, 450, 60, 10, 0));//base1 (x,y,largo,ancho,ngulo)
  plataformas.add(new Plataforma(345, 450, 10, 170, -160));//izquierdo
  plataformas.add(new Plataforma(405, 450, 10, 170, 160));//derecho

  plataformas.add(new Plataforma(200, 300, 10, 70, 150));//derechoarriba
  plataformas.add(new Plataforma(110, 300, 10, 70, 560));//izquierdoabajo

  plataformas.add(new Plataforma(425, 300, 10, 70, 150));//derechoarriba
  plataformas.add(new Plataforma(330, 300, 10, 70, 560));//izquierdoabajo

//referencia para posicionar las imágenes
  //plataformas.add(new Plataforma(150, 245, 30,30, 0));//maquina1
 // plataformas.add(new Plataforma(150, 225, 50,10, 0));//maquina1
  //plataformas.add(new Plataforma(360, 150, 150, 120, 0));//maquina2
}

void draw() {
  background(0);
 
  imagenuno.resize(150,130);
image(imagenuno,80,90);

  imagendos.resize(150,130);
image(imagendos,300,90);

despachador.resize(55,40);
image(despachador,123,220);
image(despachador,350,220);

  fill(255);
  textSize(30);
  text("q", 100, 250);
  text("w", 180, 250);
  text("o", 320, 250);
  text("p", 410, 250);
  textSize(15);
  text("",80,70);
  text("manten:",20,250);
  
  
  fill(255);
  //si no se ha hecho click en pantalla
  if (inicio == 0){
     text("selecciona tu bebida ",30,50);
  }   
  else {
    //se calcul el tiempo transcurrido
    tiempoTranscurrido = millis()-inicio;
    textSize(30);
    text("<---cronómetro",150,50);
    textSize(15);
    text("*cuando estes listo deja de presionar la tecla y espera 5 segundos",20,70);
    text("*o presiona la misma u otra tecla para reiniciar el cronómetro",70,83);
     
    //si el tiempo trascurrido es mayor que el límite, se termina el tiempo
    if (tiempoTranscurrido >= limiteDeTiempo){
      loadImage("imagenfinal.jpg");
  imagenfinal.resize(550, 450);
image(imagenfinal,0,0);
textSize(15);
text("presiona q,w,o,p para seguir llenando tu/s vasos o presiona esc para salir",35,200);
    }
    
    //si el tiempo transcurrido es menor que el límite, se imprime el tiempo en pantalla
    else{
      text(millis()-inicio,50,50);
    }
  }
  
  

  
  
  
  box2d.step();

 for (Liquido p: liquido) {
    p.display();
  }
 
 
  for (Plataforma wall : plataformas) {
    wall.display();
  }

  // Display all the people
for (int i = liquido.size()-1; i >= 0; i--) {
    Liquido p = liquido.get(i);
    if (p.done()) {
      liquido.remove(i);
    }
  }
}
  
void keyPressed(){
    switch(key) {
      case 'q':
      inicio = millis();  
    float a = random(0.20,5);
    liquido.add(new Liquido(150,260,a));
  break;
     case 'w':
     inicio = millis();  
     float s = random(0.20,5);
    liquido.add(new Liquido(150,260,s));
    break;
    case 'o':
    inicio = millis();  
    float z = random(0.20,5);
    liquido.add(new Liquido(377,260,z));
  break;
  case 'p':
  inicio = millis();  
    float x = random(0.20,5);
    liquido.add(new Liquido(377,260,x));
  break;
  }

 
     
  }
