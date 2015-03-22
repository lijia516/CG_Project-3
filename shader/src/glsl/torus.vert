
attribute vec2 parametric;

uniform vec3 lightPosition;  // Object-space
uniform vec3 eyePosition;    // Object-space
uniform vec2 torusInfo;

varying vec2 normalMapTexCoord;

varying vec3 lightDirection;
varying vec3 halfAngle;
varying vec3 eyeDirection;
varying vec3 c0, c1, c2;
varying mat3 inverseMatrix;

void main()
{
    
  float pi = 3.1415926;
    
  normalMapTexCoord = parametric * vec2(-6, 2);
    
  vec4 position = vec4( (torusInfo[0] + torusInfo[1] * cos(parametric.y * 2.0 * 3.1415926)) * cos(parametric.x * 2.0 * 3.1415926), (torusInfo[0] + torusInfo[1] * cos(parametric.y * 2.0 * 3.1415926)) * sin(parametric.x * 2.0 * 3.1415926), torusInfo[1] * sin(parametric.y * 2.0 * 3.1415926), 1);
    
  gl_Position = gl_ModelViewProjectionMatrix * position;
    
    
    vec3 Du = vec3(-2.0 * pi * sin(2.0 * pi * parametric[0]) * (torusInfo[1] * cos(2.0 * pi * parametric[1]) + torusInfo[0]), 2.0 * pi * cos(2.0 * pi * parametric[0]) * (torusInfo[1] * cos(2.0 * pi * parametric[1]) + torusInfo[0]), 0);
    
    
    vec3 Dv = vec3(-2.0 * pi * torusInfo[1] * cos(2.0 * pi * parametric[0]) * sin(2.0 * pi * parametric[1]), -2.0 * pi * torusInfo[1] * sin(2.0 * pi * parametric[0]) * sin(2.0 * pi * parametric[1]), 2.0 * pi *torusInfo[1] * cos(2.0 * pi * parametric[1]));
    
    
    vec3 tangent = normalize(Du);
    vec3 n_Dv = normalize(Dv);
    
    vec3 normalSurface = cross(tangent, n_Dv);
    
    vec3 binormal = cross(normalSurface, tangent);
    
    mat3 M = mat3(tangent, binormal, normalSurface);
    
    vec3 lightVectorObj = lightPosition - position.xyz;
    vec3 lightVectorSurface = lightVectorObj * M;
    
    
    vec3 eyeVectorObj = eyePosition - position.xyz;
    vec3 eyeVectorSurface = eyeVectorObj * M;
    
    
    lightDirection = lightVectorSurface;
    eyeDirection = eyeVectorSurface;
    
    halfAngle = normalize(lightVectorSurface) + normalize(eyeVectorSurface);
    
    inverseMatrix = M;
    
  c0 = vec3(0);  // XXX fix me
  c1 = vec3(0);  // XXX fix me
  c2 = vec3(0);  // XXX fix me
}

