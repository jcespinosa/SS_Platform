#!/usr/bin/python

import cgi
import traceback

#SERVER = 'http://elisa.dyndns-web.com/~juancarlos/ss'
SERVER = 'http://0.0.0.0:3000/assets'

def printDB():
  try:
    with open('db', 'r') as input:
      keys = list()
      counter, count = 1, 0
      for a, line in enumerate(input):
        data = dict()

        if(a == 0):
          keys = line.rstrip("\n").split('|')
        else:
          line = line.rstrip("\n").split('|')
          if(len(line) < 2):
            print '</div>'
            return counter
          for a, key in enumerate(keys):
            data[key] = line[a]

          if(count == 0):
            print '<div class="block" id="block' + str(counter) + '" style="display:none;">'

          print '  <div class="row">'            
          print '    <div class="well col-md-5">'
          print '      <table>'
          print '        <tr><td class="myLabel">Fecha: </td><td>' + data['fecha'] + '</td></tr>'
          print '        <tr><td class="myLabel">Nombre: </td><td>' + data['nombre'] + '</td></tr>'
          print '        <tr><td class="myLabel">Ocupacion: </td><td>' + data['ocupacion'] + '</td></tr>'
          print '        <tr><td class="myLabel">Lugar: </td><td>' + data['lugar'] + '</td></tr>'
          print '        <tr><td class="myLabel">Correo: </td><td>' + data['correo'] + '</td></tr>'
          print '        <tr><td class="myLabel">Intereses: </td><td>' + data['intereses'].replace(';', ', ') + '</td></tr>'
          print '        <tr><td class="myLabel">Casos: </td><td>' + data['casos'].replace(';', ', ') + '</td></tr>'
          print '        <tr><td class="myLabel">Comentario: </td><td>' + data['comentarios'] + '</td></tr>'
          print '      </table>'
          print '    </div>'
          print '    <div class="well col-md-offset-1 col-md-6">'
          print '      <p><strong>Caso de uso</strong></p>'
          print '      <p>' + data['caso'] + '</p>'
          print '    </div>'
          print '  </div>'

          count += 1

          if(count == 10):
            print '</div>'
            count = 0
            counter += 1
            
  except Exception, e:
    print '<div class="jumbotron centered">'
    print '  <p>Nada</p>'
    counter = 0

  print '</div>'
  return counter

def printPagination(pages):
  if(pages > 0):
    print '<div class="centered">'
    print '  <ul class="pagination">'
    #print '    <li><a href="#">Prev</a></li>'

    for i in range(pages):
      classes = 'pages page' + str(i+1)
      if(i == 0):
        classes = 'pages page' + str(i+1) + ' active'
      print '    <li class="' + classes + '"><a class="page" id="' + str(i+1) + '" href="#">' + str(i+1) + '</a></li>'

    #print '    <li><a href="#">Next</a></li>'
    print '  </ul>'
    print '</div>'

  return

print 'Content-Type: text/html' + "\n\n"
print '<html>'
print '  <head>'
print '    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">'
print '    <meta name="viewport" content="width=device-width, initial-scale=1.0">'

print '    <title>Proyecto</title>'

#print '    <link href="' + SERVER + '/bootstrap.css" rel="stylesheet" media="screen">'
print '    <link href="' + SERVER + '/bootstrap_flaty.min.css" rel="stylesheet" media="screen">'
print '    <link href="' + SERVER + '/style.css" rel="stylesheet" media="screen">'

print '    <script src="' + SERVER + '/jquery.js"></script>'
print '    <script src="' + SERVER + '/events.js"></script>'
print '    <script>'
print '      $(document).ready(function(){'
print '        pagination("1");'
print '        $(".page").click(function(){'
print '          var id = $(this).attr("id");'
print '          if($("li.page" + id).hasClass("active") == false){'
print '            pagination(id);'
print '          }'
print '        /*return false;*/'
print '        });'
print '      });'
print '    </script>'
print '  </head>'

print '  <body>'
print '    <div class="navbar navbar-inverse navbar-fixed-top">'
print '      <div class="container">'
print '        <div class="navbar-header">'
print '          <a class="navbar-brand" href="#">...</a>'
print '        </div>'
print '        <div class="navbar-collapse collapse"></div>'
print '      </div>'
print '    </div>'

print '    <div class="container">'
print '      <div class="page-header">'
print '        <h1>Encuestas</h1>'
print '      </div>'
print '      <div class="container">'

pages = printDB()

print '      </div>'

printPagination(pages)

print '      </div>'

print '      <div class="navbar navbar-inverse navbar-fixed-bottom">'
print '      <br/>'
print '      <div class="container">'
print '        <footer>'
print '          <p class="pull-right"><a href="#">Back to top</a></p>'
print '          <p>2013 Company, Inc.<!--  <a href="#">Privacy</a>  <a href="#">Terms</a></p>-->'
print '        </footer>'
print '      </div>'
print '    </div>'
   
print '    <script src="' + SERVER + '/bootstrap.min.js"></script>'

print '  </body>'
print '</html>'
