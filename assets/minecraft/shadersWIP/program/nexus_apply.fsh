#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D NexusSampler;
uniform sampler2D ParticlesSampler;
uniform sampler2D BloomSampler;

uniform vec4 ColorModulate;

in vec2 texCoord;

out vec4 fragColor;

void main(){
    ivec3 checkColor = ivec3(texture(ParticlesSampler,vec2(0,0)).rgb * 255);
    if(checkColor == ivec3(72,82,25) && texture(BloomSampler, texCoord) == vec4(0)) {

        fragColor = texture(NexusSampler, texCoord) * ColorModulate;

    } else {

        fragColor = texture(DiffuseSampler, texCoord) * ColorModulate;

    }
}
