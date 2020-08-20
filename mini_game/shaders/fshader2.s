#version 460 core
in vec3 LightColor;

out vec4 FragColor;

void main()
{
    FragColor = vec4(LightColor, 1.0); // set all 4 vector values to 1.0
}