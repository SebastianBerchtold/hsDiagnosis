--ip_address="10.40.39.13"
print("start")
loop(1,{
	--DiagTest.new { name="TEST_DIAG_JOB", send=Diag.new{0x22,0xf1,0x90}, expect=Diag.new{0x63,"*"}, timeout=2000, source=0xf4, target=0x40 },
	DiagTest.new { name="WRITE_BLOCK_AND_READ_AGAIN_PLAIN", send=Diag.new{ 0xbf,0x10,0x1,0x1 }, expect=Diag.new{0xff,0x10,0x01}, timeout=2000, source=0xf4, target=0x40 },
	DiagTest.new { name="WRITE_BLOCK_AND_READ_AGAIN_CRC", send=Diag.new{0xbf,0x10,0x01,0x1}, expect=Diag.new{0xFF,0x10,0x01}, timeout=2000, source=0xF4, target=0x40},
	DiagTest.new { name="WRITE_DATASET_BLOCK_AND_READ_AGAIN", send = Diag.new{0xbf,0x10,0x01,0x2}, expect = Diag.new{0xFF,0x10,0x01}, timeout = 2000, source = 0xF4, target = 0x40},
	DiagTest.new { name="WRITE_TO_LOCAL_RAM_MIRROR_AND_READ_AGAIN", send = Diag.new{0xbf,0x10,0x01,0x3}, expect = Diag.new{0xFF,0x10,0x01}, timeout = 2000, source = 0xF4, target = 0x40},
	DiagTest.new { name="DETECT_CORRUPT_NVRAM_BLOCK", send = Diag.new{0xbf,0x10,0x01,0x4}, expect = Diag.new{0xFF,0x10,0x01}, timeout = 2000, source = 0xF4, target = 0x40},
	DiagTest.new { name="RECOVERY_WITH_DEFAULT_DATA_NORMAL_BLOCK", send = Diag.new{0xbf,0x10,0x01,0x5}, expect = Diag.new{0xFF,0x10,0x01}, timeout = 2000, source = 0xF4, target = 0x40},
	DiagTest.new { name="RECOVERY_WITH_DEFAULT_DATA_DATASET_BLOCK", send = Diag.new{0xbf,0x10,0x01,0x6}, expect = Diag.new{0xFF,0x10,0x01}, timeout = 2000, source = 0xF4, target = 0x40},
	DiagTest.new { name="WRITE_BLOCK_AND_READ_AGAIN_SECRET", send = Diag.new{0xbf,0x10,0x01,0x7}, expect = Diag.new{0xFF,0x10,0x01}, timeout = 2000, source = 0xF4, target = 0x40},
	DiagTest.new { name="WRITE_BLOCK_AND_READ_AGAIN_SECRET_WITH_DEFAULT_DATA", send = Diag.new{0xbf,0x10,0x01,0x8}, expect = Diag.new{0xFF,0x10,0x01}, timeout = 2000, source = 0xF4, target = 0x40}
})
print("here")
logger:log(logging.WARN, "try to sleep...")
sleep(200)
print("woke up again!")
sleep(200)
print("up")
sleep(200)
print("again!")

