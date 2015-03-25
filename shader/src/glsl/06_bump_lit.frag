
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

void main()
{
    
    
    vec4 ambient = LMa;
    
    vec3 lightDirectionNormalized = normalize(lightDirection);
    
    vec3 normal = texture2D(normalMap, normalMapTexCoord).rgb * 2.0 - 1.0;
    
    normal = normalize (vec3(0, 0, 1) + normal);
    
    float kd = clamp(max(dot(lightDirectionNormalized, normal), 0.0), 0.0, 1.0);
    vec4 diffuse = kd * LMd;
    
    
    
    vec3 halfAngleNormalized = normalize(halfAngle);
    float ks = clamp(pow(max(dot(halfAngleNormalized, normal), 0.0), shininess), 0.0, 1.0);
    vec4  specular = ks * LMs;
    
    if (dot(lightDirectionNormalized, normal) == 0.0 || dot(halfAngleNormalized, normal) < 0.0) {
        
        specular = vec4(0,0,0,1);
    }
    
    
   vec4 textColor = texture2D(decal, normalMapTexCoord);
    
   gl_FragColor = clamp(ambient + diffuse * textColor + specular, 0.0, 1.0);
}
