#version 460 core
in vec3 result;

out vec4 FragColor;


void main()
{
   
    FragColor = vec4(result, 1.0);

}