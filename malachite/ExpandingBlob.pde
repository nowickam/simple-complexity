class ExpandingBlob
{
  Circles circles;
  float noiseSeed;
  float noiseX, noiseY, noiseMax;
  float phase;
  Float[] offset;
  TreeMap<Float, Float> offsets;
  HashMap<Float, Float> maxRadii;
  float centerX, centerY;
  float dn, x, y, r, newRadius;
  float angle, radius;
  float radDiff;

  PVector[] centers;
  float maxRadius, minRadius, avgRadius, expandingMin;
  float inc, margin;

  ExpandingBlob(int n)
  {
    noiseMax = 0.4;
    
    noiseX = random(10);
    noiseY = random(10);
    stroke(0);
    centers = new PVector[n];
    for (int i=0; i<n; i++)
    {
      centers[i] = new PVector(random(100, width-100), random(100, height-100));
      //centers[i] = new PVector(noise(noiseX)*width, noise(noiseY)*height);
      noiseX += 0.3;
      noiseY += 0.4;
      //ellipse(centers[i].x, centers[i].y, 5, 5);
    }
    avgRadius = 500;
    margin = 10;
    
    radDiff = avgRadius/10;


    offsets = new TreeMap<Float, Float>();
    maxRadii = new HashMap<Float, Float>();
    inc = TWO_PI/40;
  }

  void drawBlob()
  {
    for ( var center : centers)
    {
      // get different noise sample
      noiseSeed = int(random(10));

      // update the pixels data
      loadPixels();
      // blobs inside another blobs
      if (red(pixels[round(center.y)*width+round(center.x)]) != BCOL)
        continue;

      offsets.clear();
      // calculate the maximum radii of every angle
      maxRadius = random(0.1, 1)*avgRadius;
      for (float i=0; i<=TWO_PI; i+=inc)
      {
        // calculate the place of the vertex
        noiseX = noiseSeed+map(sin(i), -1, 1, 0, noiseMax);
        noiseY = noiseSeed+map(cos(i), -1, 1, 0, noiseMax);
        r = map(noise(noiseX, noiseY), 0, 1, maxRadius/10, maxRadius);

        maxRadii.put(i, r);
      }
      minRadius = noise(noiseX, noiseY)*10;
      float currentRadius = minRadius, validRadius = minRadius;
      expandingMin = -1;

      // expand the blobs
      while (offsets.size() < TWO_PI/inc)
      {
        // around the blob
        for (float i=0; i<=TWO_PI; i+=inc)
        {
          if (!offsets.containsKey(i))
          {
            // calculate the place of the vertex
            noiseX = noiseSeed+map(sin(i), -1, 1, 0, noiseMax);
            noiseY = noiseSeed+map(cos(i), -1, 1, 0, noiseMax);
            newRadius = min(maxRadii.get(i), noise(noiseX, noiseY)*currentRadius);

            x = center.x+cos(i)*newRadius;
            x = constrain(x, margin, width-margin);

            y = center.y+sin(i)*newRadius;
            y = constrain(y, margin, height-margin);

            // overlap or the last iteration
            if (red(pixels[round(y)*width+round(x)]) != BCOL)
            {
              offsets.put(i, validRadius);
              
              if(expandingMin == -1)
                expandingMin = validRadius;
            // exceeds the maximal value for this angle
            } else if (newRadius == maxRadii.get(i))
            {
              offsets.put(i, newRadius);
              
              if(expandingMin == -1)
                expandingMin = newRadius;
            // exceeds the difference between the shortest ang longest radius
            //} else if(newRadius-expandingMin > radDiff)
            //{
            //  offsets.put(i, newRadius);
            //}
          }
            // expand
            else
            {
              validRadius = newRadius;
            }
          }
        }
        currentRadius += 10;
      }
      

      float j;
      // increase the amount subtracted from the radius
      for (float i=0; i<1; i+=random(0.001, 0.1))
      {
        j = random(255);
        float prevRadius = -1;
        beginShape();
        // update the pixels table
        loadPixels();
        stroke(colors[round(hash(j, 255))%COLS][0], colors[round(hash(j, 255))%COLS][1], colors[round(hash(j, 255))%COLS][2]);
        fill(colors[round(hash(j, 255))%COLS][0], colors[round(hash(j, 255))%COLS][1], colors[round(hash(j, 255))%COLS][2]);
        // around the blob
        for (Map.Entry<Float, Float> e : offsets.entrySet())
        {
          angle = e.getKey();
          radius = e.getValue();

          float ii = map(random(i), 0, 0.2, 0.01, 0.3);
          radius -= i*radius;
          
          if(prevRadius == -1)
            prevRadius = radius;
            
          radius = 0.5*prevRadius+(1-0.5)*radius;

          x = center.x+cos(angle)*radius;
          x = constrain(x, 0, width-1);

          y = center.y+sin(angle)*radius;
          y = constrain(y, 0, height-1);

          curveVertex(x, y);
          
        }
        endShape();
      }
      println("CICRLE "+circlesDrawn);
      circlesDrawn++;
    }
  }

}
