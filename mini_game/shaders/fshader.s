#version 460 core
struct Material {
    sampler2D texture_diffuse1;
    sampler2D texture_diffuse2;
    sampler2D texture_diffuse3;
    sampler2D texture_diffuse4;
    sampler2D texture_specular1;
    sampler2D texture_specular2;
    sampler2D texture_specular3;
    sampler2D texture_specular4;
    sampler2D texture_normal1;
    sampler2D texture_normal2;
    sampler2D texture_normal3;
    sampler2D texture_normal4;
    sampler2D texture_height1;
    sampler2D texture_height2;
    sampler2D texture_height3;
    sampler2D texture_height4;
    float shininess;
}; 
uniform Material material;
out vec4 FragColor;

in vec2 TexCoords;

uniform sampler2D texture_diffuse1;

void main()
{    
    FragColor = texture(material.texture_diffuse1, TexCoords);
}