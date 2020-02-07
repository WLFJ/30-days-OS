default :
	make run

# 创建文件规则

ipl10.bin : ipl10.nas Makefile
	nasm ipl10.nas -o ipl10.bin

helloos.img : ipl10.bin haribote.sys  Makefile
	cp ./raw_file/raw_1440.img helloos.img
	dd if=ipl10.bin of=helloos.img conv=notrunc
	dd if=haribote.sys of=helloos.img bs=512 seek=33 count=1 conv=notrunc


haribote.sys : haribote.nas
	nasm haribote.nas -o haribote.sys

# 命令行快捷方式

img :
	make -r helloos.img

asm :
	make -r ipl10.bin

run : helloos.img
	qemu-system-i386 -fda helloos.img

clean :
	rm haribote.sys
	rm ipl10.bin

src_only :
	make clean
	rm helloos.img


