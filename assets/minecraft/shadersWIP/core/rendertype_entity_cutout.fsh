#version 150

#moj_import fog.glsl

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

void main() {

    vec4 color;
    vec4 rawColor = texture(Sampler0, texCoord0);
    
    
    int checkAlpha = int(rawColor.a * 255);
    
    if (checkAlpha == 254) {
        color = rawColor;
    } else {
        color = rawColor * vertexColor * ColorModulator;
        color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
        color *= lightMapColor;
    }

    if (color.a  0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
