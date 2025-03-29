#version 150
#define GLOW_COLORS 12

uniform sampler2D DiffuseSampler;

uniform vec4 ColorModulate;
uniform vec2 InSize;

in vec2 texCoord;

out vec4 fragColor;

void main(){
    vec4 checkColor = texture(DiffuseSampler, texCoord) * ColorModulate;
    vec4 outColor = vec4(0);
    ivec3[GLOW_COLORS] glowColorList = ivec3[](
        ivec3(0,48,255),
        ivec3(255,252,252),
        ivec3(238,50,115),
        ivec3(43,216,147),
        ivec3(255,14,14),
        ivec3(51,220,255),
        ivec3(52,55,229),
        ivec3(195,0,255),
        ivec3(147,0,237),
        ivec3(116,0,228),
        ivec3(105,218,82),
        ivec3(255,142,50)
    );
    
    for(int i = 0; i  GLOW_COLORS; i++) {
        if (ivec3(checkColor.xyz * 255) == glowColorList[i]) {
            outColor += checkColor;
        }
    }
    fragColor = outColor;
}
