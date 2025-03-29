#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D TranslucentDepthSampler;
uniform sampler2D ItemEntityDepthSampler;
uniform sampler2D ParticlesDepthSampler;


uniform vec2 InSize;
uniform vec4 ColorModulate;

in vec2 texCoord;

out vec4 fragColor;

float checkParticle = (1 - texture(ParticlesDepthSampler,texCoord).r);
float checkTranslucent = (1 - texture(TranslucentDepthSampler,texCoord).r);
float checkItemEntity = (1 - texture(ItemEntityDepthSampler,texCoord).r);

float checkMixed = (checkTranslucent + checkItemEntity + checkParticle) / 3;

vec2 oneTexel = 1.0 / InSize;

vec4 color_max = vec4(0.16,0.84,0.57,1);
vec4 color_min = vec4(1,0.14,0.44,1);

void main(){

    if(checkMixed != 0) {
        fragColor = mix(color_min,color_max,clamp(pow(checkMixed*500,4),0,1));
    } else {
        fragColor = vec4(0) * ColorModulate;  
    }
}
