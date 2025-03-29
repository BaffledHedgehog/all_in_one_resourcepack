#version 150
#define WIDTH 2 // только целое число
uniform sampler2D DiffuseSampler;

in vec2 texCoord;
in vec2 oneTexel;

out vec4 fragColor;

void main(){
    vec4 right, down, diag1, diag2;
    bool edge = false;
    vec4 center = texture(DiffuseSampler, texCoord);
    for (int i = -WIDTH; i = WIDTH; i++){
        
        right = texture(DiffuseSampler, texCoord + vec2(oneTexel.x * i, 0.0));
        
        down = texture(DiffuseSampler, texCoord + vec2(0.0, oneTexel.y * i));

        diag1 = texture(DiffuseSampler, texCoord + vec2(oneTexel.x * i, oneTexel.y * i));

        diag2 = texture(DiffuseSampler, texCoord + vec2(oneTexel.x * -i, oneTexel.y * i));

        // и почему-то я крайне уверен, что такое количество проверок нахуй не нужно...
    
        if (center != right || center != down || center != diag1 || center != diag2){
            edge = true;
        }
    }

    vec4 outColor = vec4(vec3(center.rgb),0.4);
    if (center == vec4(0,0,0,1)){
        outColor.rgb = vec3(0.01,0.01,0.01);
    }

    if (outColor.rgb != vec3(0)){
        fragColor = vec4(outColor);

        if (edge == true){
            fragColor = vec4(center.rgb, 1);
        }
    }
    else 
    {
        fragColor = vec4(0);
    }
    
}
