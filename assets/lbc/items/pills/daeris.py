for i in range(60,145):
    f=open(f"pill_{i}.json",mode='w')
    a='{"parent": "minecraft:item/generated","textures": {"layer0": "minecraft:item/pills/pill_'+str(i)+'"}}'
    f.write(a)
    f.close()
