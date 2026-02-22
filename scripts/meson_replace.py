#!/bin/env python3
import pickle
import sys 

key = sys.argv[1]
new = sys.argv[2]
filename = sys.argv[3]
# print("replacing", key, "with", new, "in", filename)

try:
	with open(filename, 'rb') as f:
		obj = pickle.load(f)
	# if hasattr(obj, 'prefix'):
	# print("old ", key, getattr(obj, key))
	print("replacing", key, getattr(obj, key), "with", new, "in", filename)
	# obj.key = new
	# obj.prefix = new
	# obj.prefix = "abcd" 
	setattr(obj, key, new)
	# print(obj.prefix)
	# exit(0)
	with open(filename, 'wb') as f:
		pickle.dump(obj, f)
# except (pickle.UnpicklingError, EOFError):
except Exception as e:
	print(e)
