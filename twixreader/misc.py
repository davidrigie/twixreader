from . import twixreader 
from .json_html_viewer import json_html_viewer as jview

def twix2html(twixpath, meas_num=0):
    tr = twixreader.read_twix(twixpath)

    if tr.vers() == 'VD':
        meas = tr.read_measurement(meas_num, header_only=True)
    else:
        meas = tr.read_measurement(header_only=True)

    d = meas.hdr._buffers
    
    html_writer = jview.HTML_Writer()
    html_code = html_writer.get_html(d)

    return html_code