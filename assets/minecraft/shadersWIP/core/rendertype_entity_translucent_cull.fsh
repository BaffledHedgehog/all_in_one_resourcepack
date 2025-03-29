#version 150

#moj_import fog.glsl

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 precolor = texture(Sampler0, texCoord0);
    vec4 color = precolor * vertexColor * ColorModulator;
    int alpha = int(precolor.a * 255);
    

    if (color.a  0.1) {
        discard;
    }
    
    if (alpha == 254) {
        
        fragColor = vec4(precolor.rgb,1);
      
    } else if (alpha == 129) {fragColor = vec4(precolor.rgb,0.5);
        
    } else
    
    { 
        fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    }
}
