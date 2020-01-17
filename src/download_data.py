# author: Tiffany Timbers
# date: 2019-12-18

"""Downloads data csv data from the web to a local filepath as either a csv or feather file format.

Usage: src/down_data.py --out_type=<out_type> --url=<url> --out_file=<out_file>

Options:
--out_type=<out_type>    Type of file to write locally (script supports either feather or csv)
--url=<url>              URL from where to download the data (must be in standard csv format)
--out_file=<out_file>    Path (including filename) of where to locally write the file
"""
  
from docopt import docopt
import os
import pandas as pd
import feather

opt = docopt(__doc__)

def main(out_type, url, out_file):
  
  data = pd.read_csv(url, header=None)
  
  if out_type == "csv":
    try:
      data.to_csv(out_file, index = False)
    except:
      os.makedirs(os.path.dirname(out_file))
      data.to_csv(out_file, index = False)
  elif out_type == "feather":
    try:  
      feather.write_dataframe(data, out_file)
    except:
      os.makedirs(os.path.dirname(out_file))
      feather.write_dataframe(data, out_file)

if __name__ == "__main__":
  main(opt["--out_type"], opt["--url"], opt["--out_file"])
