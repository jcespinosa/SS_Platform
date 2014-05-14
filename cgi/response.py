#!/usr/bin/python

import os
import json
import cgi
import sys
from datetime import datetime

ERR = 'err.txt'

#savein = sys.stdin
#saveout = sys.stdout
#saveerr = sys.stderr

#stdin = open('in.txt', 'a')
#stdout = open('out.txt', 'a')
#stderr = open('err.txt', 'a')

#sys.stdin = stdin
#sys.stdout = stdout
#sys.stderr = stderr

result = {}

try:
  form = cgi.FieldStorage()

  print 'Content-Type: application/json'
  print 'Access-Control-Allow-Origin: *'
  print "\n"
  print "\n"

  data = [datetime.now().strftime("%Y-%m-%d %H:%M")]
  for key in sorted(form.keys()):
    if(type(form[key]) == list):
      values = form.getlist(key)
      value = ';'.join(values)
    else:
      value = form[key].value
    data.append(value)	

  DB = 'db'

  if(not os.path.exists(DB)):
    with open(DB, 'w') as output:
      output.write('fecha|' + '|'.join(sorted(form.keys())) + "\n")

  with open(DB, 'a') as output:
    output.write('|'.join(data) + "\n")

  result = {
    'success' : True,
    'message' : 'La informacion ha sido recibida',
    'keys' : sorted(form.keys()),
    'data' : data
  }

except Exception, e:
  if(not os.path.exists(ERR)):
    with open(ERR, 'w') as output:
      output.write(e)
      output.write("\n")
  else:
    with open(ERR, 'a') as output:
      output.write(e)
      output.write("\n")

  result = {
    'success' : False,
    'message' : 'Hubo un problema procesando la informacion',
    'keys' : '',
    'data' : ''
  }

finally:
#	sys.stdin = savein
#	sys.stdout = saveout
#	sys.stderr = saveerr

#	stdin.close()
#	stdout.close()
#	stderr.close()
  print json.dumps(result, indent=1)
  print "\n"
