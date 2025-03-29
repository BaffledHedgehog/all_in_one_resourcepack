#version 150

#moj_import fog.glsl
#moj_import light.glsl

#define TEXTURE_SCALE 256 

#define BRIGHT 1.2
#define CORRECT_TEX texelFetch(Sampler0,(0, 1), 0) == vec4(1)
#define ARMOR_COUNT vec2(textureSize(Sampler0, 0).x / TEXTURE_SCALE * 4 - 1, textureSize(Sampler0, 0).y / TEXTURE_SCALE * 2 -1)
#define TEX_LAYOUT vec2(1,0.5) / (textureSize(Sampler0, 0) / vec2(TEXTURE_SCALE * 4))
//#define LIGHT minecraft_mix_light(Light0_Direction, Light1_Direction, Normal1, vec4(1)) * vec4(texelFetch(Sampler2, uv2 / 16, 0)) + vec4(vec3(1 - FetchedColor.a).rgb,0) * vec4(FetchedColor.rgb,1.0);

/* Находясь первый раз в гей-клубе, бафлед подбросил монету: 
если выпадет решка, то будет участвовать в групповухе, если орёл - нет. 
И знаете что у него выпало? 
Прямая кишка */

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;
uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 normal;
flat in vec4 Color1;
flat in vec3 Normal1;
flat in ivec2 uv2;
in vec4 LightF;

vec4 color;
vec2 ArmorID;

out vec4 fragColor;

vec2 offsetCoord(vec4 getColor){
   ivec4 checkColor = ivec4(getColor * 255);
   ArmorID = vec2(checkColor.y, checkColor.z);
   return vec2(checkColor.y, checkColor.z) * vec2(TEX_LAYOUT);
}

void main() {
   
      vec2 OffsetCoord = offsetCoord(Color1); 
      vec4 FetchedColor = texture(Sampler0, texCoord0 * vec2(TEX_LAYOUT) + OffsetCoord);

      if(OffsetCoord == vec2(0) || ArmorID.x  ARMOR_COUNT.x || ArmorID.y  ARMOR_COUNT.y) {
         color = texture(Sampler0, texCoord0 * vec2(TEX_LAYOUT)) * vertexColor * ColorModulator; 
      } else {
         
         //color = FetchedColor * ColorModulator * LIGHT;
         color = mix(FetchedColor * ColorModulator * minecraft_mix_light(Light0_Direction, Light1_Direction, Normal1, vec4(1)) * vec4(texelFetch(Sampler2, uv2 / 16, 0)), FetchedColor * BRIGHT, 1 - FetchedColor.a);
      }
   
   if (color.a  0.05) {
      discard;
   }

      fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);

   }

    

