#version 150

#moj_import fog.glsl
#define PIXEL -0.999
#define OFFSET 10
in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec2 texCoord0;
flat out vec4 vertexColor;
float pos_z;
vec4 outColor;
ivec3 checkColor;

vec4 PositionSwitch(){

    vec4 returnPosition = vec4(0);
    switch(gl_VertexID % 4){
                case 0:
                returnPosition = vec4(PIXEL,-1,-1,1);
                break;

                case 1:
                returnPosition = vec4(PIXEL,PIXEL,-1,1);
                break;

                case 2:
                returnPosition = vec4(-1,PIXEL,-1,1);
                break;

                case 3:
                returnPosition = vec4(-1,-1,-1,1);
                break;
             }
        return returnPosition;
}

void main() {

    vec4 pre_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);

    pos_z = pre_Position.z;

    int particleType = 0;

    checkColor = ivec3(Color.rgb * 255);
    
    if (checkColor.r == 0 && checkColor.b == 0) {

    switch(checkColor.g) {

        case 1:
        outColor = vec4(vec3(20,209,255)/255,1.0);
        vertexColor = outColor;
        particleType = 1;
        pos_z = 0;
        break;

        case 2:
        outColor = vec4(vec3(255,170,0)/255,1.0);
        vertexColor = outColor;
        particleType = 1;
        pos_z = 0;
        break;    
        
        case 3:
        outColor = vec4(vec3(68,64,11)/255,1.0);
        vertexColor = outColor;
        particleType = 2;
        pos_z = 0;
        break;    
        }
    }
    
    switch(particleType){

        case 1:
        gl_Position = vec4(pre_Position.xy, pos_z, pre_Position.w);
        break;

        case 2:
        gl_Position = PositionSwitch();
        break;

        default:
        gl_Position = pre_Position;
        break;
        
    }

    vertexDistance = fog_distance(Position, FogShape);
    texCoord0 = UV0;
    
}
