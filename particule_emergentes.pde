import g4p_controls.*;//librairie pour le GUI


Systeme sys;


ArrayList<Integer> liste;//nombre d'individus pour chaque especes

Config config;

paramSimulation sim;



void setup() {
  size(800, 600);
  
  
  
  liste = new ArrayList<>();
  
  liste.add(300);
  liste.add(300);
  liste.add(300);
  liste.add(300);
  
  config = new Config(this);
  sim = new paramSimulation(this);
  
  sys = new Systeme(config);
  
}


void draw() {
  fill(color(0, 0, 0, config.PTrace));//transparence si actif
  rect(0, 0, width, height);
  
  if (sim.runSystem) {
    sys.update();
  }
  sys.display();
  sys.config.display();
  sim.display();
  
}

//gestionnaire d'evenement pour chaque type de widget

public void handleImageToggleButtonControlEvents(GImageToggleButton button, GEvent event) {
  //gere le depliement et repliement du panneau de configuration
  if (button == config.toggleConfig && event == GEvent.CLICKED) {
    config.isConfigExtended = !config.isConfigExtended;
    
    config.transparenceSlider.setEnabled(config.isConfigExtended);
    config.transparenceSlider.setVisible(config.isConfigExtended);
    
    config.mouseAttractionCheckbox.setEnabled(config.isConfigExtended);
    config.mouseAttractionCheckbox.setVisible(config.isConfigExtended);
    
    config.mouseRepulsionCheckbox.setEnabled(config.isConfigExtended);
    config.mouseRepulsionCheckbox.setVisible(config.isConfigExtended);
  }else if (button == sim.toggleVisible) {
    sim.estEtendue = !sim.estEtendue;
    
    sim.toggleRun.setVisible(sim.estEtendue);
    sim.toggleRun.setEnabled(sim.estEtendue);
    
    sim.listePresets.setVisible(sim.estEtendue);
    sim.listePresets.setEnabled(sim.estEtendue);
    
    sim.usePreset.setVisible(sim.estEtendue);
    sim.usePreset.setEnabled(sim.estEtendue);
    
    sim.relanceAleaButton.setVisible(sim.estEtendue);
    sim.relanceAleaButton.setEnabled(sim.estEtendue);
    
    sim.relanceButton.setVisible(sim.estEtendue);
    sim.relanceButton.setEnabled(sim.estEtendue);
    
    sim.savePresetButton.setVisible(sim.estEtendue);
    sim.savePresetButton.setEnabled(sim.estEtendue);
    
    sim.savePresetTextField.setVisible(sim.estEtendue);
    sim.savePresetTextField.setEnabled(sim.estEtendue);
    
    sim.removePreset.setVisible(sim.estEtendue);
    sim.removePreset.setEnabled(sim.estEtendue);
    
  }else if (button == sim.toggleRun) {
    sim.runSystem = !sim.runSystem;
  }
}


public void handleSliderControlEvents(GSlider slider, GEvent event) {
  //gere le controle de la transparence
  if (slider == config.transparenceSlider) {
    config.PTrace = 255 - int(slider.getValueS());
  }
  
}

public void handleToggleControlEvents(GCheckbox box, GEvent event) {
  //gere l'activation de l'attraction et de la repulsion de la souris
  if (box == config.mouseAttractionCheckbox) {
    config.isMouseAttracting = config.mouseAttractionCheckbox.isSelected();
  }else if (box == config.mouseRepulsionCheckbox) {
    config.isMouseRepulsing = config.mouseRepulsionCheckbox.isSelected();
  }
}

public void handleButtonEvents(GButton button, GEvent event) {
  if (button == sim.usePreset) {
    if (sim.presets.size() > 0) {
      sys.reset(sim.presets.getJSONObject(sim.listePresets.getSelectedIndex()));
    }
  }
  else if (button == sim.relanceAleaButton) {
    sys.reset();
  }else if (button == sim.savePresetButton) {
     String nom = sim.savePresetTextField.getText();
     if (nom != "") {
        JSONObject obj = new JSONObject();
        JSONArray list = new JSONArray();
        obj.setString("name", nom);
        for (int i = 0; i < sys.particules.size(); i++) {
          list.append(sys.particules.get(i).get(0).info.convertJSON());
        }
        obj.setJSONArray("especes", list);
        
        sim.presets.append(obj);
        saveJSONArray(sim.presets, "data/saves.json");
        
        
        sim.listePresets.addItem(nom);
        
     }
     
  }else if (button == sim.removePreset) {
    if (sim.presets.size() > 0) {
      sim.presets.remove(sim.listePresets.getSelectedIndex());
      sim.listePresets.removeItem(sim.listePresets.getSelectedIndex());
      saveJSONArray(sim.presets, "data/saves.json");
    }
  }
  else if (button == sim.relanceButton) {
    for (ArrayList<Particule> L : sys.particules) {
      for (Particule p : L) {
        p.position = new PVector(random(0, width), random(0, height));
        p.vitesse = new PVector(0, 0);
      }
    }
  }
}
