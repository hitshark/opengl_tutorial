#version 330 core
out vec4 FragColor;

in vec2 TexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

vec4 temp;

void main()
{
    temp = texture(texture2, vec2(TexCoord.x, TexCoord.y));
    FragColor = mix(texture(texture1, TexCoord), temp, 0.2f);
}
