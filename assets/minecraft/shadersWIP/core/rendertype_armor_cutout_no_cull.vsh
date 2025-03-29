#version 150

#moj_import light.glsl
#moj_import fog.glsl

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in vec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec2 texCoord1;
out vec4 normal;

flat out vec4 Color1;
flat out vec3 Normal1;
flat out ivec2 uv2;
out vec4 LightF;

void main() {
    Color1 = Color;
    Normal1 = Normal;
    uv2 = UV2;
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(Position, 0);    

    LightF = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, vec4(1)) * texelFetch(Sampler2, UV2 / 16, 0);

    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color) * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    texCoord1 = UV1;
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
}
