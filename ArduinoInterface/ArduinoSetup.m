%a = arduino;
a = arduino('com6','Mega2560','Libraries','MatlabMotorLibrary/EncoderAddon','ForceBuild',true,'TraceOn',true);
%a = arduino('98D311FC1C8E','Mega2560','Libraries','MatlabMotorLibrary/EncoderAddon','ForceBuild',true,'TraceOn',true);
Motor1 = addon(a,'MatlabMotorLibrary/EncoderAddon',{'D2','D23'});
Motor2 = addon(a,'MatlabMotorLibrary/EncoderAddon',{'D19','D27'});
Motor3 = addon(a,'MatlabMotorLibrary/EncoderAddon',{'D18','D25'});

%Motor1.getCounts()
%Motor2.getCounts()
%Motor3.getCounts()
