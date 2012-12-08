class Frame {
  PVector baseRibCage;
  PVector rightHip;
  PVector rightKnee;
  PVector rightFibula;
  PVector rightAnkle;
  PVector rightHeel;
  PVector rightMetatarsal;
  PVector rightToe;

  int sides = 20;

  Segment torso;
  Segment thigh;
  Segment knee;
  Segment shank;
  Segment heel;
  Segment sole;
  Segment foot;
  Segment toe;

  Frame(String csvLine) {
    String[] positions = split(csvLine, ',');

    baseRibCage = new PVector(float(positions[2]), float(positions[3]));
    rightHip = new PVector(float(positions[4]), float(positions[5]));
    rightKnee = new PVector(float(positions[6]), float(positions[7]));
    rightFibula = new PVector(float(positions[8]), float(positions[9]));
    rightAnkle = new PVector(float(positions[10]), float(positions[11]));
    rightHeel = new PVector(float(positions[12]), float(positions[13]));
    rightMetatarsal = new PVector(float(positions[14]), float(positions[15]));
    rightToe = new PVector(float(positions[16]), float(positions[17]));

    torso = new Segment(baseRibCage, rightHip, 8, 8, sides);
    thigh = new Segment(rightHip, rightKnee, 8, 5, sides);
    knee = new Segment(rightKnee, rightFibula, 5, 5, sides);
    shank = new Segment(rightFibula, rightAnkle, 5, 3, sides);
    heel = new Segment(rightAnkle, rightHeel, 3, 2, sides);
    sole = new Segment(rightHeel, rightMetatarsal, 2, 2, sides);
    foot = new Segment(rightAnkle, rightMetatarsal, 2, 2, sides);
    toe = new Segment(rightMetatarsal, rightToe, 2, 1, sides);
  }

  // create spheres at each major joint
  void drawJoint(PVector joint, int radius) {
    sphereDetail(60);
    noStroke();
    pushMatrix();
    translate(joint.x, joint.y);
    sphere(radius);
    popMatrix();
  }

  void draw() {
    strokeWeight(2);
    fill(#D01DDE);  // set color for joint centers and segments

    drawJoint(baseRibCage, 2);
    drawJoint(rightHip, 8);
    line(baseRibCage.x, baseRibCage.y, rightHip.x, rightHip.y); // lower torso
    torso.display();

    drawJoint(rightKnee, 5); 
    line(rightHip.x, rightHip.y, rightKnee.x, rightKnee.y); // right thigh
    thigh.display();

    drawJoint(rightFibula, 5);   
    line(rightKnee.x, rightKnee.y, rightFibula.x, rightFibula.y); // knee segment
    knee.display();

    drawJoint(rightAnkle, 3);  
    line(rightFibula.x, rightFibula.y, rightAnkle.x, rightAnkle.y); // shank
    shank.display();

    drawJoint(rightHeel, 2); 
    line(rightAnkle.x, rightAnkle.y, rightHeel.x, rightHeel.y);
    heel.display();

    drawJoint(rightMetatarsal, 2);   
    line(rightHeel.x, rightHeel.y, rightMetatarsal.x, rightMetatarsal.y);
    sole.display();

    //connect metatarsal to ankle for triangle foot
    line(rightAnkle.x, rightAnkle.y, rightMetatarsal.x, rightMetatarsal.y);
    foot.display();
    //toe
    line(rightMetatarsal.x, rightMetatarsal.y, rightToe.x, rightToe.y);
    toe.display();
  }
}

