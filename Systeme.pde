class Systeme {
  //liste qui contient toute les particules
  //divisee en liste pour chaque especes de particules
  ArrayList<ArrayList<Particule>> particules;
  
  Config config;//certains parametres modifiables par l'utilisateur


  Systeme(Config config_) {
    config = config_;
    particules = new ArrayList<ArrayList<Particule>>();
    
    InfoParticule infoPart = new InfoParticule();
    
    //initialisation de la liste des particules
    //tous les membres d'une espece ont des caracteristiques identiques
    for (int i = 0; i < config.nParEspece.size(); i++) {
      infoPart = infoPart.alea();
      particules.add(new ArrayList<Particule>());
      for (int j = 0; j < config.nParEspece.get(i); j++) {
        particules.get(i).add(new Particule(random(width), random(height)));
        particules.get(i).get(j).info = infoPart;
      }
    }
    
  }

  void update() {//upadate du systeme de particules
    PVector acceleration = new PVector(0, 0);
    float dist;
    for (ArrayList<Particule> listePart: particules) {
      for (Particule part : listePart) {

        acceleration.limit(0);
        for (ArrayList<Particule> listePart2: particules) {
          for (Particule part2 : listePart2) {
            //calcule de l'acceleration pour chaque particules
            //regles detaillees dans le compte rendu du projet
            if (part.position != part2.position) {
              dist = PVector.dist(part.position, part2.position);
              if (dist < part.info.distanceVision && dist > part.info.distanceRepulsion) {
                acceleration.add(PVector.sub(part2.position, part.position).mult(1 / pow(dist, 2)).mult((part.info.forceAttraction + part2.info.forceAttraction) / 2));
              } else if (dist <= part.info.distanceRepulsion) {
                acceleration.add(PVector.sub(part.position, part2.position).mult(1 / pow(dist, 2)).mult((part.info.forceRepulsion + part2.info.forceRepulsion)/2));// calcule l'attraction à un instant t qu'on va appliquer à part
              }
            } else {
              part.position.add(PVector.random2D().limit(0.1)); 
            }
          }
        }
        
        if (mousePressed) {
          //interaction de l'utilisateur avec les particules
          //si active, le clic gauche attire et le clic droit repousse
          dist = PVector.sub(new PVector(mouseX, mouseY), part.position).mag();
          if (config.isMouseAttracting && mouseButton == LEFT) {
            acceleration.add(PVector.sub(new PVector(mouseX, mouseY), part.position).mult(config.forceMouseAttraction / pow(dist, 1.7)));
          }
          if (config.isMouseRepulsing && mouseButton == RIGHT) {
            acceleration.add(PVector.sub(part.position, new PVector(mouseX, mouseY)).mult(config.forceMouseRepulsion / pow(dist, 1.7)));
          }
        }

        part.update(acceleration);
      }
    }
    
  }
  
  void reset(JSONObject preset) {
    InfoParticule infoPart;
    
    int size = particules.size();
    for (int i = size - 1; i >= 0; i--) {
      particules.remove(i);
    }
    
    for (int i = 0; i < preset.getJSONArray("especes").size(); i++) {
      infoPart = new InfoParticule(preset.getJSONArray("especes").getJSONObject(i));
      particules.add(new ArrayList<Particule>());
      for (int j = 0; j < preset.getJSONArray("especes").getJSONObject(i).getInt("nParticules"); j++) {
        particules.get(i).add(new Particule(random(width), random(height)));
        particules.get(i).get(j).info = infoPart;
      }
    }
  }
  
  void reset() {
    InfoParticule infoPart = new InfoParticule();
    
    int size = particules.size();
    for (int i = size - 1; i >= 0; i--) {
      particules.remove(i);
    }
    
    //initialisation de la liste des particules
    //tous les membres d'une espece ont des caracteristiques identiques
    for (int i = 0; i < config.nParEspece.size(); i++) {
      infoPart = infoPart.alea();
      particules.add(new ArrayList<Particule>());
      for (int j = 0; j < config.nParEspece.get(i); j++) {
        particules.get(i).add(new Particule(random(width), random(height)));
        particules.get(i).get(j).info = infoPart;
      }
    }
  }
  

  void display() {
    for (ArrayList<Particule> listePart: particules) {
      for (Particule part : listePart) {
        part.display();
      }
    }
  }

}
