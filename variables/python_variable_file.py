# https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#resource-and-variable-files
import os

USER = os.getlogin()                # current login name
# USER = 'G987452'
# ENV = 'dev' # moved to yaml file so can set static
TEMP_LOCATION_FILE = './temp_files/results_location.txt'
