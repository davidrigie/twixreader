import twixreader as tr

path_to_datfile = './meas1.dat'

# Create TwixReader object for accessing multi-raid-file entries
twixobj = tr.read_twix(path_to_datfile)

### FOR VD ###

# open first measurement

meas = twixobj.read_measurement(0)


### FOR VB ### (there only is one measurement per file)

meas = twixobj.read_measurement()


"""
Sometimes there will be multiple scan types within the same measurement, e.g. if there
are navigators with different read lengths. We can inspect the MDH's and select the correct
group of data
"""

# Display info about data groups
meas.group_info()  

# Create measurement buffer from first grouping
buf = meas.get_meas_buffer(0)

# The buf object behaves like a numpy array and accesses the raw k-space data from disk 
print(buf.shape)

data_part = buf[0,0,:,:]

# We can also look at the headers which have been parsed into python dictionaries
print(meas.hdr.keys())
meas_yaps = meas.hdr['MeasYaps']

# We can dump the headers to JSON, YAML, or raw TXT files as well
meas.dump_header(file_ext = 'json')
meas.dump_header(file_ext = 'yaml')
meas.dump_header(file_ext = 'txt')





