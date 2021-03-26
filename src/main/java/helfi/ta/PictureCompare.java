
package helfi.ta;

import java.awt.image.BufferedImage;
import java.io.File;
import com.github.romankh3.image.comparison.ImageComparison;
import com.github.romankh3.image.comparison.ImageComparisonUtil;
import com.github.romankh3.image.comparison.exception.ImageComparisonException;
import com.github.romankh3.image.comparison.model.ImageComparisonResult;
import com.github.romankh3.image.comparison.model.ImageComparisonState;
import com.github.romankh3.image.comparison.model.Rectangle;

import java.util.ArrayList;
import java.util.List;

public class PictureCompare {

	public boolean compare(String expectedpath, String actualpath, String resultpath, List<String> excludedareas){
       try {
    	   		   // load the images to be compared
		           BufferedImage expectedImage = ImageComparisonUtil.readImageFromResources(expectedpath);
		           BufferedImage actualImage = ImageComparisonUtil.readImageFromResources(actualpath);
		           File resultDestination = null;
		           // where to save the result (leave null if you want to see the result in the UI)
		           if(resultpath != null && !resultpath.isEmpty()) {
		        	   resultDestination = new File(resultpath);
		           }
		   
		           //Create ImageComparison object for it.
		           ImageComparison imageComparison = new ImageComparison( expectedImage, actualImage, resultDestination );
		   
		           //Can be used another constructor for it, without destination.
//               new ImageComparison("expectedpath", "actualpath");
		           //or
		           new ImageComparison(expectedImage, actualImage);
		   
		           //Also can be configured BEFORE comparing next properties:
		           
		           //imageComparison.setExcludedAreas()
		           //Threshold - it's the max distance between non-equal pixels. By default it's 5.
		           imageComparison.setThreshold(10);
		           imageComparison.getThreshold();
		   
		           //RectangleListWidth - Width of the line that is drawn in the rectangle. By default it's 1.
		           imageComparison.setRectangleLineWidth(2);
		           imageComparison.getRectangleLineWidth();
		   
		           //DifferenceRectangleFilling - Fill the inside the difference rectangles with a transparent fill. By default it's false and 20.0% opacity.
		           imageComparison.setDifferenceRectangleFilling(true, 20.0);
		           imageComparison.isFillDifferenceRectangles();
		           imageComparison.getPercentOpacityDifferenceRectangles();
		   
		           //ExcludedRectangleFilling - Fill the inside the excluded rectangles with a transparent fill. By default it's false and 20.0% opacity.
		           imageComparison.setExcludedRectangleFilling(true, 30.0);
		           imageComparison.isFillExcludedRectangles();
		           imageComparison.getPercentOpacityExcludedRectangles();
		   
		           //Destination. Before comparing also can be added destination file for result image.
		           imageComparison.setDestination(resultDestination);
		           imageComparison.getDestination();
		   
		           //MaximalRectangleCount - It means that would get first x biggest rectangles for drawing.
		           // by default all the rectangles would be drawn.
		           imageComparison.setMaximalRectangleCount(10);
		           imageComparison.getMaximalRectangleCount();
		   
		           //MinimalRectangleSize - The number of the minimal rectangle size. Count as (width x height).
		           // by default it's 1.
		           imageComparison.setMinimalRectangleSize(100);
		           imageComparison.getMinimalRectangleSize();

		           //Change the level of the pixel tolerance:
		           imageComparison.setPixelToleranceLevel(0.2);
		           imageComparison.getPixelToleranceLevel();
		           
		           if(excludedareas != null && !excludedareas.isEmpty()) {
		        	      List<Rectangle> excluded=  createExcludedAreaList(excludedareas);
		        		  imageComparison.setExcludedAreas(excluded);
		           }
		           
		           //After configuring the ImageComparison object, can be executed compare() method:
		           ImageComparisonResult imageComparisonResult = imageComparison.compareImages();
		           
		           //Can be found ComparisonState.
		           ImageComparisonState imageComparisonState = imageComparisonResult.getImageComparisonState();
		           
		           //if(imageComparisonResult.getImageComparisonState().equals(imageComparisonState.MISMATCH)) {
		           //	   extractRectangleData(imageComparisonResult.getRectangles());
		           //}
		           //And Result Image
		           BufferedImage resultImage = imageComparisonResult.getResult();
		           
		           //Image can be saved after comparison, using ImageComparisonUtil.
		           if(resultDestination != null && imageComparisonResult.getImageComparisonState().equals(imageComparisonState.MISMATCH)) {
		        	   	ImageComparisonUtil.saveImage(resultDestination, resultImage); 
		           }
		           
		           if(imageComparisonResult.getImageComparisonState().equals(imageComparisonState.MATCH))
		        	   return true;
		           
		           
	} catch (ImageComparisonException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	catch (NullPointerException ne) {
		// TODO Auto-generated catch block
		ne.printStackTrace();
	}
    catch (ClassCastException cce) {
   		// TODO Auto-generated catch block
    	cce.printStackTrace();
   	}
       return false;
    }
	
	private void extractRectangleData(java.util.List<Rectangle> list) {
		Rectangle rectangle= list.get(0);
		System.out.println("Rectangle coordinates (Min x,Min y, Max x, Max y) are: ("+ rectangle.getMinPoint().x + 
				","+rectangle.getMinPoint().y +","+rectangle.getMaxPoint().x+","+rectangle.getMaxPoint().y+")");
	}
	
	private List<Rectangle> createExcludedAreaList(List<String> excludedareas) {
		List<Rectangle>  excluded = new ArrayList<Rectangle>();
		for (int i = 0; i < excludedareas.size(); i++) {
			String [] temp = excludedareas.get(i).split(",");
			int minx = Integer.parseInt(temp[0]);
			int miny = Integer.parseInt(temp[1]);
			int maxx = Integer.parseInt(temp[2]);
			int maxy = Integer.parseInt(temp[3]);
			excluded.add(new Rectangle(minx,miny,maxx,maxy));
		}
		return excluded;
	}
}