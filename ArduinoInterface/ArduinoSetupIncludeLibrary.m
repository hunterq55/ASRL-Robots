
a = arduino('com3','Mega2560','Libraries',{'I2C' 'SPI' 'rotaryEncoder'},'ForceBuild',true)
encoder = rotaryEncoder(a,'D18','D19')