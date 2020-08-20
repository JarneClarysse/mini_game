#version 460 core
struct Material {
    sampler2D diffuse;
    sampler2D specular;
    sampler2D emission;
    float shininess;
}; 



struct Light {
    vec3 position;  
    vec3  direction;
    float cutOff;
    float outerCutOff;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
	
    float constant;
    float linear;
    float quadratic;
}; 

uniform Light light;  
uniform Material material;

in vec2 TexCoords;
in vec3 Normal;
in vec3 FragPos;

out vec4 FragColor;

uniform vec3 lightColor;

void main()
{

    vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoords));

    float distance    = length(- FragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + 
    		    light.quadratic * (distance * distance));    

    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize( - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoords));  

    vec3 viewDir = normalize(- FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);  
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoords));

    float theta = dot(lightDir, vec3(0,0,1));
    float epsilon   = light.cutOff - light.outerCutOff;
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);    
    
    vec3 emission = vec3(0.0);
    if( texture(material.specular, TexCoords).r == 0){
        emission = texture(material.emission, TexCoords).rgb;
	}


    ambient  *= attenuation; 
    diffuse  *= intensity;
    specular *= intensity;   
    

    vec3 result = ( ambient + diffuse + specular + emission);
    FragColor = vec4(result, 1.0);
	
}