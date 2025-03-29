#version 150

#define RADIUS 10
#define GAMMA 2


uniform sampler2D DiffuseSampler;
uniform sampler2D BloomSampler;
uniform vec4 ColorModulate;
uniform vec2 InSize;
uniform vec2 BlurDir;

in vec2 texCoord;
out vec4 fragColor;

vec4 blur(vec2 BlurDir, float Radius, sampler2D Sampler, vec2 Coord, float gamma) {
    float weight[5] = float[] (0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);
    vec2 oneTexel = 1.0 / InSize;
    vec4 blurred = vec4(0.0);
    
    float totalAlpha = 0.5;
    
    for(float r = -Radius; r = Radius; r += 1.0) {

        vec4 sampleValue = texture(Sampler, Coord + oneTexel * r * BlurDir);
        blurred += sampleValue * weight[int(abs(r) / Radius * 4)] * gamma / (Radius * 0.5);
    }
    
    return vec4(blurred.rgb, 1);
}


void main() {
    if(BlurDir.x == 1){
        fragColor = blur(BlurDir, RADIUS, DiffuseSampler, texCoord, RADIUS * 0.1 * GAMMA);
    } else {
        fragColor = texture(DiffuseSampler, texCoord) * ColorModulate + blur(BlurDir, RADIUS, BloomSampler, texCoord, RADIUS * 0.1 * GAMMA);   
    }
}
