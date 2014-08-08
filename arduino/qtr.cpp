#include "Arduino.h"
#include "qtr.h"

#define limit(x,min_v,max_v) (max(min(x,max_v),min_v))

uint16_t calibration_min[5] = {32, 40, 40, 40, 32};
uint16_t calibration_max[5] = {960, 920, 920, 920, 960};

