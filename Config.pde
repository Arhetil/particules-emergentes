class Config {
  int PTrace;
  
  boolean isMouseAttracting;
  float forceMouseAttraction;
  
  boolean isMouseRepulsing;
  float forceMouseRepulsion;
  
  boolean isConfigExtended;
  
  ArrayList<Integer> nParEspece;
  
  
  GImageToggleButton toggleConfig;//toggle pour etendre le paneau de configuration
  GSlider transparenceSlider;
  GCheckbox mouseAttractionCheckbox;
  GCheckbox mouseRepulsionCheckbox;
  
  
  Config(PApplet app) {
    
    
    
    //valeur de base des parametres
    PTrace = 255;
    
    isMouseAttracting = false;
    forceMouseAttraction = 100.0;
    
    isMouseRepulsing = false;
    forceMouseRepulsion = 100.0;
    
    isConfigExtended = false;

    nParEspece = new ArrayList<Integer>();
    nParEspece.add(500);
    nParEspece.add(300);
    nParEspece.add(100);
    
    
    //initialisation des controles
    toggleConfig = new GImageToggleButton(app, 57, 9, "assets/icones/toggle_config_off.bmp", "assets/icones/toggle_config_over.bmp", 2);
    toggleConfig.addEventHandler(app, "handleImageToggleButtonControlEvents");
    
    transparenceSlider = new GSlider(app, 160, 26, 170, 20, 10);
    transparenceSlider.setLimits(255 - PTrace, 0, 254);
    transparenceSlider.addEventHandler(app, "handleSliderControlEvents");
    transparenceSlider.setEnabled(false);
    transparenceSlider.setVisible(false);
    
    mouseAttractionCheckbox = new GCheckbox(app, 180, 58, 15, 15);
    mouseAttractionCheckbox.addEventHandler(app, "handleToggleControlEvents");
    mouseAttractionCheckbox.setSelected(false);
    mouseAttractionCheckbox.setEnabled(false);
    mouseAttractionCheckbox.setVisible(false);
    
    mouseRepulsionCheckbox = new GCheckbox(app, 180, 88, 15, 15);
    mouseRepulsionCheckbox.addEventHandler(app, "handleToggleControlEvents");
    mouseRepulsionCheckbox.setSelected(false);
    mouseRepulsionCheckbox.setEnabled(false);
    mouseRepulsionCheckbox.setVisible(false);
  }
  
  //affiche le texte du panneau de configuration
  void display() {
    fill(255);
    textSize(15);
    text("Config", 10, 20);
    if (isConfigExtended) {
      text("Trace des particules", 30, 40);
      text("Attraction de la souris", 30, 70);
      text("Répulsion de la souris", 30, 100);
    }
  }
}




class paramSimulation {
  
  boolean runSystem;
  
  boolean estEtendue;
  
  JSONArray presets;
  
  GImageToggleButton toggleVisible;
  
  GImageToggleButton toggleRun;
  
  GDropList listePresets;
  
  GButton usePreset;
  
  GButton savePresetButton;
  GTextField savePresetTextField;
  
  GButton relanceAleaButton;
  
  GButton relanceButton;
  
  GButton removePreset;
  
  
  paramSimulation(PApplet app) {
    runSystem = true;
    estEtendue = false;
    
    presets = loadJSONArray("data/saves.json");
    
    
    
    toggleVisible = new GImageToggleButton(app, width - 30, 8, "assets/icones/toggle_config_off.bmp", "assets/icones/toggle_config_over.bmp", 2);
    toggleVisible.addEventHandler(app, "handleImageToggleButtonControlEvents");
    
    toggleRun = new GImageToggleButton(app, width - 60, 30, "assets/icones/run_sim_off.bmp", "assets/icones/run_sim_over.bmp", 2);
    toggleRun.addEventHandler(app, "handleImageToggleButtonControlEvents");
    toggleRun.setEnabled(false);
    toggleRun.setVisible(false);
    
    listePresets = new GDropList(app, width - 130, 180, 100, 80);
    listePresets.setEnabled(false);
    listePresets.setVisible(false);
    
    ArrayList<String> listeNom = new ArrayList<String>();
    
    if (presets.size() == 0) {
      JSONObject obj = new JSONObject();
      JSONArray list = new JSONArray();
      obj.setString("name", "0");
      for (int i = 0; i < 1; i++) {
        list.append(new InfoParticule().convertJSON());
      }
      obj.setJSONArray("especes", list);
      
      presets.append(obj);
    }
    for (int i = 0; i < presets.size(); i++) {
      listeNom.add(presets.getJSONObject(i).getString("name"));
    }
    
    listePresets.setItems(listeNom, 0);
    
    usePreset = new GButton(app, width - 75, 200, 50, 50, "Utiliser le preset");
    usePreset.setEnabled(false);
    usePreset.setVisible(false);
    usePreset.addEventHandler(app, "handleButtonEvents");
    
    relanceAleaButton = new GButton(app, width - 150, 120, 130, 50, "Relancer avec des paramètres aléatoires");
    relanceAleaButton.setEnabled(false);
    relanceAleaButton.setVisible(false);
    
    relanceButton = new GButton(app, width - 150, 70, 130, 50, "Relancer la simulation");
    relanceButton.setEnabled(false);
    relanceButton.setVisible(false);
    
    savePresetButton = new GButton(app, width - 100, 310, 80, 40, "Sauvegarder la simulation");
    savePresetButton.addEventHandler(app, "handleButtonEvents");
    savePresetButton.setVisible(false);
    savePresetButton.setEnabled(false);
    
    savePresetTextField = new GTextField(app, width - 100, 350, 80, 20);
    savePresetTextField.setVisible(false);
    savePresetTextField.setEnabled(false);
    
    removePreset = new GButton(app, width - 100, 250, 80, 40, "Détruire le preset");
    removePreset.addEventHandler(app, "handleButtonEvents");
    removePreset.setEnabled(false);
    removePreset.setVisible(false);
  }
  
  void display() {
    fill(255);
    textSize(15);
    text("Simulation", width - 105, 20);
  }
  
  
  
}
