import sys, os
sys.path.append("../..")
# import facerec modules
import urllib
from facerec.feature import Fisherfaces
from facerec.distance import EuclideanDistance
from facerec.classifier import NearestNeighbor
from facerec.model import PredictableModel
from facerec.validation import KFoldCrossValidation
from facerec.visual import subplot
from facerec.util import minmax_normalize
from facerec.serialization import save_model, load_model
# import numpy, matplotlib and logging
import numpy as np
from PIL import Image
import matplotlib.cm as cm
import logging

d={}
def read_images(path, sz=None):
    """Reads the images in a given folder, resizes images on the fly if size is given.

    Args:
        path: Path to a folder with subfolders representing the subjects (persons).
        sz: A tuple with the size Resizes 

    Returns:
        A list [X,y]

            X: The images, which is a Python list of numpy arrays.
            y: The corresponding labels (the unique number of the subject, person) in a Python list.
    """
    c = 0
    X,y = [], []
    for dirname, dirnames, filenames in os.walk(path):
        for subdirname in dirnames:
            subject_path = os.path.join(dirname, subdirname)
#            print subdirname
#            print str(c)
            for filename in os.listdir(subject_path):
                try:
                    im = Image.open(os.path.join(subject_path, filename))  #already rotated image here
                    im = im.convert("L")
                    # resize to given size (if given)
                    if (sz is not None):
                        im = im.resize(self.sz, Image.ANTIALIAS)
                    X.append(np.asarray(im, dtype=np.uint8))
                    y.append(c) #label as account number (folder names)
                    d[c] = str(subdirname)
#                    print str(im.size)
#                    print filename
#                    print str(c)
                except IOError, (errno, strerror):
                    print "I/O error({0}): {1}".format(errno, strerror)
                except:
                    print "Unexpected error:", sys.exc_info()[0]
                    raise
            c = c+1
    return [X,y]

if __name__=="__main__":
    [X,y] = read_images(sys.argv[1])
#    print "read images"
#    print len(X),len(y)
    # Then set up a handler for logging:
    handler = logging.StreamHandler(sys.stdout)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    # Add handler to facerec modules, so we see what's going on inside:
    logger = logging.getLogger("facerec")
    logger.addHandler(handler)
    logger.setLevel(logging.DEBUG)
    # Define the Fisherfaces as Feature Extraction method:
    feature = Fisherfaces()
    # Define a 1-NN classifier with Euclidean Distance:
    classifier = NearestNeighbor(dist_metric=EuclideanDistance(), k=1)
    # Define the model as the combination
    model = PredictableModel(feature=feature, classifier=classifier)
    # Compute the Fisherfaces on the given data (in X) and labels (in y):
#---------------------------------------------
#    print "Generating model"
    if(not os.path.exists("./temp/mymodel")):
      model.compute(X, y)
      save_model("./temp/mymodel", model)  #saving model here - CHANGE THIS
      exit()
    
#    print "loading model"
    model = load_model("./temp/mymodel")
#    print "loaded model"
    urlForImage = sys.argv[2]
    tmpfilename = "./temp/"+str(urlForImage.split('/')[-1])  #saving image here - CHANGE THIS
    urllib.urlretrieve(urlForImage, tmpfilename)
    im = Image.open(tmpfilename) #add rotate of 90? Don't think so.
    im = im.resize((648,486), Image.ANTIALIAS)
    im = im.convert("L")
#    print "hello",str(im.size)
    im.show()
    to_predict_x = np.asarray(im, dtype=np.uint8)
    li=model.predict(to_predict_x)
    if(int(li[1]['distances'])<10000):
#      print str(li)
#      print str(d)
      print str(d[li[0]])
#      print "Authenticated as ",str(li[0]),":",str(d[li[0]])," with distance : ",str(li[1]['distances']) #set threshold as 10000
    else:
      print '-1'
#      print "Could not Authenticate with distance : ",str(li[1]['distances'][0])," for ",str(li[0]),":",str(d[li[0]])
