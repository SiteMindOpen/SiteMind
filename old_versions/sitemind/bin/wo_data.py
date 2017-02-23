from urllib2 import Request, urlopen, URLError
import json
import sys
DOMAIN = sys.argv[1]
request = Request("http://api.mywot.com/0.4/public_link_json2?hosts=" + DOMAIN + "/&key=623307d626e1fa2747c953277e8dde55e12a62c4")
response = urlopen(request)
j = json.load(response)
print(str(j))