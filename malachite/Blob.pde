class Blob
{
  Circles circles;
  float noiseSeed;
  float noiseX, noiseY, noiseMax;
  float phase;
  Float[] offset;
  HashMap<Float, Float[]> offsets;
  float centerX, centerY;
  float dn, x, y, r;
  int i;

  Blob(Circles _circles)
  {
    circles = _circles;
    dn = 0;
    noiseMax = 0.5;

    offsets = new HashMap<Float, Float[]>();
    i = 0;
  }

  void drawBlob()
  {
    for ( var circle : circles.circles)
    {
      noiseSeed = int(random(10));
      //float dx = random(-20, 20);
      //float dy = random(-20, 20);
      float dx = 0;
      float dy = 0;
      
      loadPixels();
      // blobs inside another blobs
      if(red(pixels[round(circle.y+dy)*width+round(circle.x+dx)]) != BCOL)
        continue;
      
      float prevx, prevy;

      offsets.clear();
      float start = random(2,3)*circle.radius;
      float end = noise(noiseX, noiseY)*10;
      // blobs with decreasing radii
      for (float j = start; j>=end; j-=random(0.01,0.4)*j)
      {
        beginShape();
        // update the pixels table
        loadPixels();
        stroke(colors[round(hash(j, 255))%COLS][0], colors[round(hash(j, 255))%COLS][1], colors[round(hash(j, 255))%COLS][2]);
        fill(colors[round(hash(j, 255))%COLS][0], colors[round(hash(j, 255))%COLS][1], colors[round(hash(j, 255))%COLS][2]);
        // around the blob
        for (float i=0; i<=TWO_PI; i+=0.025)
        {
          // calculate the place of the vertex
          noiseX = noiseSeed+map(sin(i), 0, 1, 0, noiseMax);
          noiseY = noiseSeed+map(cos(i), 0, 1, 0, noiseMax);
          r = map(noise(noiseX, noiseY), 0, 1, j/10, j);
          
          x = circle.x+dx+sin(i)*r;
          x = constrain(x, 0, width-1);
          
          y = circle.y+dy+cos(i)*r;
          y = constrain(y, 0, height-1);
          

          // overlap
          if (j==start && red(pixels[round(y)*width+round(x)]) != BCOL)
          {
            offset = calculateOffset(circle, x, y);
            if (offset != null)
            {
              offsets.put(i, offset);
              x -= offset[0];
              y -= offset[1];
            }
            else{
              continue;
            }
          } 
          else if (offsets.containsKey(i))
          {
            offset = offsets.get(i);
            offset[0] /= 2;
            offset[1] /= 2;
            x -= offset[0];
            y -= offset[1];
            offsets.put(i, offset);
          }

          prevx = x;
          prevy = y;
          vertex(x, y);
        }
        endShape(CLOSE);
      }
      dn += DN;
      //phase += PH;
      println("CICRLE "+i);
      i++;
    }
  }

  Float[] calculateOffset(Circle c, float x, float y)
  {
    float cx = (c.x);
    float cy = (c.y);
    Float[] ret = null;
   
    ret = binarySearch(cx, cy, x, y);

    if (ret == null)
      return null;

    float dx = x - ret[0];
    float dy = y - ret[1];
    return new Float[]{1.1 * dx, 1.1 * dy};
  }

  Float[] binarySearch(float x1, float y1, float x2, float y2)
  {
    float midx, midy;
    //println(x1, x2, y1, y2);
    if (x1 <= x2)
    {
      if (y1 <= y2)
      {
        while (x1 <= x2 && y1 <= y2)
        {
          midx = x1 + (x2 - x1) / 2;
          midy = y1 + (y2 - y1) / 2;

          if (red(pixels[round(midy)*width+round(midx)]) == BCOL)
          {
            x1 = midx+1;
            y1 = midy+1;
          } 
          else
          {
            x2 = midx-1;
            y2 = midy-1;
          }
        }
        return new Float[] {x1, y1};
      }
      else
      {
        while (x1 <= x2 && y1 >= y2)
        {
          midx = x1 + (x2 - x1) / 2;
          midy = y2 + (y1 - y2) / 2;

          if (red(pixels[round(midy)*width+round(midx)]) == BCOL)
          {
            x1 = midx+1;
            y1 = midy-1;
          } 
          else
          {
            x2 = midx-1;
            y2 = midy+1;
          }
        }
        return new Float[] {x1, y2};
      }
    }
    else
    {
      if (y1 <= y2)
      {
        while (x1 >= x2 && y1 <= y2)
        {
          midx = x2 + (x1 - x2) / 2;
          midy = y1 + (y2 - y1) / 2;

          if (red(pixels[round(midy)*width+round(midx)]) == BCOL)
          {
            x1 = midx-1;
            y1 = midy+1;
          } else
          {
            x2 = midx+1;
            y2 = midy-1;
          }
        }
        return new Float[] {x2, y1};
      }
      else
      {
        while (x1 >= x2 && y1 >= y2)
        {
          midx = x2 + (x1 - x2) / 2;
          midy = y2 + (y1 - y2) / 2;

          if (red(pixels[round(midy)*width+round(midx)]) == BCOL)
          {
            x1 = midx-1;
            y1 = midy-1;
          } else
          {
            x2 = midx+1;
            y2 = midy+1;
          }
        }
        return new Float[] {x2, y2};
      }
    }
  }
}
