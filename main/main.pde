import controlP5.*;

import java.util.*;
import processing.core.PApplet;

final float GRAVITATION = 0.16;

StarsList starsSparkleList = new StarsList();
StarsList starsMovingList = new StarsList();
StarsList starsList = new StarsList();

ArrayList starsSparkle = new ArrayList();
ArrayList starsMoving = new ArrayList();
ArrayList stars = new ArrayList();

Planet moon = new Planet(
      "Lune",                         // Name
      5f,                             // Diameter
      new PVector(0,0),               // Acceleration
      new PVector(0,0),               // Velocity
      new PVector(0,0),               // Gravity
      0.000123,                       // Mass
      new int[]{#8B8787,#DEDEDE});    // Fill Color / Stroke Color
      
Planet earth = new Planet("Terre",10f, new PVector(0,0), new PVector(0,2), new PVector(0,0), 0.01,new int [] {#78B4FC,#CBEFFF});
Planet mars = new Planet("Mars",10f, new PVector(0,0),new PVector(0,1.6), new PVector(0,0), 0.001,new int [] {#C64834,#FA8A79});// 0.70858809351921081542968730
Planet sun = new Planet("Soleil",100f, new PVector(0,0), new PVector(0,0), new PVector(0,0), 3333.33f,new int [] {#FFF6AF,#FFAA00});

HashMap<CelestialBody,PVector> model = new HashMap<CelestialBody,PVector>();
HashMap<CelestialBody,PVector> model2 = new HashMap<CelestialBody,PVector>();


SystemPlanets soleilTerre = new SystemPlanets(sun,model);
SystemPlanets TerreLune = new SystemPlanets(earth,model2);

void setup() {
  size(1440, 900);
  background(0);
  frameRate(60);
  for(int i=0; i < 150; i++){
    starsSparkle.add(new Star(random(width),random(height)));
  }
  starsSparkleList.addAllStarsList(starsSparkle);
  
  for(int i=0; i < 10; i++){
    starsMoving.add(new Star(random(width),random(height)));
  }
  starsMovingList.addAllStarsList(starsMoving);
  
  for(int i=0; i < 150; i++){
    stars.add(new Star(random(width),random(height)));
  }
  starsList.addAllStarsList(stars);
  
  sun.setPosition(width/2,height/2);
  mars.setPosition(528,height/2);
  earth.setPosition(592,height/2);
  moon.setPosition(600,height/2);
  
  //soleilTerre.addPlanet(earth);
  soleilTerre.addPlanet(mars);
  TerreLune.addPlanet(moon);
  soleilTerre.addPlanet(TerreLune);
  soleilTerre.setRelativePosition();
  
  Gui gui = new Gui(this);
  gui.createGroup();
  gui.upDateListBox(soleilTerre,0);
}

void draw() {
  background(0);
  pushStyle();
  stroke(random(250));
  starsSparkleList.display();
  popStyle();
  
  pushStyle();
  stroke(255);
  starsList.display();
  popStyle();

  soleilTerre.update();
  soleilTerre.display();
  soleilTerre.setAllGravity();
  soleilTerre.applyForce(null);
}
