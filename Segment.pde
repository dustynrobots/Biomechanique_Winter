class Segment {
  PVector joint1;
  PVector joint2;
  float r1;
  float r2;
  int sides;

  PVector segment;
  float segmentLength;
  PVector segmentNorm;
  PVector modelOrientation;
  float angle;
  PVector axis;

  Segment (PVector joint1_, PVector joint2_, float r1_, float r2_, int sides_) {
    joint1 = joint1_;
    joint2 = joint2_;
    r1 = r1_;
    r2 = r2_;
    sides = sides_;

    segment = PVector.sub(joint1, joint2);  // note this is a static sub, woo hoo http://processing.org/learning/pvector/
    segmentLength = segment.mag();
    segmentNorm = segment.get();
    segmentNorm.normalize();
    modelOrientation = new PVector(0, 1, 0);
    angle = acos(modelOrientation.dot(segmentNorm)) + PI; // returns float angle between y axis and segment vector
    axis = modelOrientation.cross(segmentNorm); // returns PVector which is the cross of 2 vectors
  }

  void display() {
    pushMatrix();
    translate(joint1.x, joint1.y);
    rotate(angle, axis.x, axis.y, axis.z);
    noStroke();
    cylinder(r1, r2, segmentLength, sides);
    popMatrix();
  }

  // based on the "drawCylinder" code example from pg 540 of Processing by Reas & Fry
  // and http://vormplus.be/blog/article/drawing-a-cylinder-with-processing
  void cylinder(float r1, float r2, float h, int sides) {
    float angle = TWO_PI / sides;  // arc of required number of sides

      //draw body
    beginShape(QUAD_STRIP);  // connects all the sides
    for (int i = 0; i < sides; i++) {
      vertex(r1 * cos(i * angle), 0, r1 * sin(i * angle));
      vertex(r2 * cos(i * angle), h, r2 * sin(i * angle));
    }
    endShape();

    // If it is not a cone, draw the circular top cap
    if (r1 != 0) {
      beginShape(TRIANGLE_FAN);    
      vertex(0, 0, 0);  // center point
      for (int i = 0; i < sides; i++) {
        vertex(r1 * cos(i * angle), 0, r1 * sin(i * angle));
      }
      endShape();
    }

    // If it is not a cone, draw the circular bottom cap
    if (r2 != 0) {
      beginShape(TRIANGLE_FAN);
      vertex(0, h, 0);  // center point
      for (int i = 0; i < sides; i++) {
        vertex(r2 * cos(i * angle), h, r2 * sin(i * angle));
      }
      endShape();
    } // close if
  } // close void cylinder
} // close class

