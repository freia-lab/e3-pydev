# This should be a test or example startup script

require pydev

pydev("import sys")
pydev("sys.path.append('/home/konrad/modules/e3-laser/tools/carbide')")

pydev("from getStatus import GetStatus")
pydev("laser=GetStatus('http://10.1.251.2:20010/v1')")
dbLoadRecords("/home/konrad/modules/e3-laser/laser/Db/laser.db")
