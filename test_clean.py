import sys, time
for i in range(1, 6):
    sys.stdout.write("\rProgress: " + str(i*20) + "%")
    sys.stdout.flush()
    time.sleep(1)
print("\nFinished.")
