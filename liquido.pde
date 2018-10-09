class Liquido {

  

  Body body;
  float r;

    Liquido(float x, float y, float r_) {
    r = r_;
    // poner el body en el mundo de Box2D
    makeBody(x,y,r);
  }


  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
    // posicion
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // parte de abajo de la pantalla
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    //posicion de los cuerpos en pantalla
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // ángulo de rotacion
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    strokeWeight(0);
    fill(random(255),random(255),random(255));
    ellipse(0,0,r*5,r*5);
    
    popMatrix();
  }

  void makeBody(float x, float y, float r) {

      BodyDef bd = new BodyDef();
    
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);
    
    
     CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
   FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parametros del liquido
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.5;
    
    body.createFixture(fd);

  body.setLinearVelocity(new Vec2(random(-10f,10f),random(5f,10f)));
    body.setAngularVelocity(random(0,10));
  }






}
