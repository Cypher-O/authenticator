 int hexOfRGBA(int r,int g,int b,{double opacity=1})
 {
  var  value=((((opacity * 0xff ~/ 1) & 0xff) << 24) |
   ((r                    & 0xff) << 16) |
   ((g                    & 0xff) << 8)  |
   ((b                    & 0xff) << 0)) & 0xFFFFFFFF;
  return value;
 }