
uniform vec4 LMa; // Light-Material ambient
uniform vec4 LMd; // Light-Material diffuse
uniform vec4 LMs; // Light-Material specular
uniform float shininess;

uniform sampler2D normalMap;
uniform sampler2D decal;
uniform sampler2D heightField;
uniform samplerCube envmap;

uniform mat3 objectToWorld;

varying vec2 normalMapTexCoord;
varying vec3 lightDirection;
varying vec3 eyeDirection;
varying vec3 halfAngle;
varying vec3 c0, c1, c2;
varying mat3 inverseMatrix;

void main()
{
    
    vec3 I = normalize(eyeDirection);
    
    vec3 refractVector = normalize(refract(-I, vec3(0.0, 0.0, 1.0), 1.1));
    
    refractVector = inverseMatrix * refractVector;
    
    refractVector = objectToWorld * refractVector;
    
    gl_FragColor = textureCube(envmap, refractVector);
    
}
