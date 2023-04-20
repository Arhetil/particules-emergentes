class Particule {
  PVector position;
  PVector vitesse;
  
  InfoParticule info;
  
  Particule(float x, float y) {
    position = new PVector(x, y);
    vitesse = new PVector(0, 0);
    
    info = new InfoParticule();//toute les caracteristiques de la particule
    
  }
  
  void update(PVector acceleration) {
    //lois de Newton
    vitesse.add(acceleration);
    vitesse.limit(info.vitesseMax);
    position.add(vitesse);
    
    //systeme de 'rebond' sur les parois
    if (position.x < 0) {
        vitesse.x = abs(vitesse.x) + 2;
      }
      if (position.x > width) {
        vitesse.x = -abs(vitesse.x) - 2;
      }
      if (position.y < 0) {
        vitesse.y = abs(vitesse.y) + 2;
      }
      if (position.y > height) {
        vitesse.y = -abs(vitesse.y) - 2;
      }
  }
  
  void display() {
    noStroke();
    fill(info.couleur);
    circle(position.x, position.y, info.taille);
  }
  
  
}

class InfoParticule {
  
  color couleur;
  int taille;
  float vitesseMax;
  
  float distanceVision;
  float forceAttraction;
  
  float distanceRepulsion;
  float forceRepulsion;
  
  
  
  InfoParticule() {
    couleur = 0;
    taille = 0;
    vitesseMax = 0;
    distanceVision = 0;
    forceAttraction = 0;
    distanceRepulsion = 0;
    forceRepulsion = 0;
  }
  //cree les parametres à partir d'un objet stocke au format json
  InfoParticule(JSONObject obj) {
    couleur = obj.getInt("couleur");
    taille = obj.getInt("taille");
    vitesseMax = obj.getFloat("vitesseMax");
    distanceVision = obj.getFloat("distanceVision");
    forceAttraction = obj.getFloat("forceAttraction");
    distanceRepulsion = obj.getFloat("distanceRepulsion");
    forceRepulsion = obj.getFloat("forceRepulsion");
  }
  
  //permet de définir avec précision chacune de caracteristiques de la particule
  //inutilisee dans le code
  void defPrecision(color couleur_, int taille_, float vitesseMax_,
                float distanceVision_, float forceAttraction_,
                float distanceRepulsion_, float forceRepulsion_) {
                  couleur = couleur_;
                  taille = taille_;
                  vitesseMax = vitesseMax_;
                  distanceVision = distanceVision_;
                  forceAttraction = forceAttraction_;
                  distanceRepulsion = distanceRepulsion_;
                  forceRepulsion = forceRepulsion_;
                  
                }
                
    //distribue aléatoirement les caracteristiques de la particule     
    InfoParticule alea() {
      InfoParticule ret = new InfoParticule();
      ret.couleur = color(random(255), random(255), random(255));
      ret.taille = int(random(2, 5));
      ret.vitesseMax = limitGaussian(0.1, 7, 3, 3);
      ret.distanceVision = limitGaussian(0, 100, 20, 20);
      ret.forceAttraction = limitGaussian(0, 15, 3, 9);
      ret.distanceRepulsion = limitGaussian(0, distanceVision, 10, 10);
      ret.forceRepulsion = limitGaussian(1, 17, 10, 8);
      return ret;
    }
    
    JSONObject convertJSON() {
      JSONObject obj = new JSONObject();
      obj.setInt("couleur", couleur);
      obj.setInt("taille", taille);
      obj.setFloat("vitesseMax", vitesseMax);
      obj.setFloat("distanceVision", distanceVision);
      obj.setFloat("forceAttraction", forceAttraction);
      obj.setFloat("distanceRepulsion", distanceRepulsion);
      obj.setFloat("forceRepulsion", forceRepulsion);
      obj.setInt("nParticules", 300);
      return obj;
    }
  
}

//distrubution gausienne avec les valeurs extremes coupees

float limitGaussian(float valMin, float  valMax, float mean, float deviation) {
  float val = randomGaussian() * deviation + mean;
  val = constrain(val, valMin, valMax);
  return val;
}
