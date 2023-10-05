/* Generated from: ../mega65-core/iomap.txt */
/* Date: 2022-06-11 */

/* Immediately stop transmitting the current ethernet frame. Will cause a partially sent frame to be received, most likely resulting in the loss of that frame. */
#define ETHCOMMAND_STOPTX 0x00
/* Immediately stop transmitting the current ethernet frame. Will cause a partially sent frame to be received, most likely resulting in the loss of that frame. */
#define STOPTX 0x00
/* 6510/45GS10 CPU port DDR */
#define CPU_PORTDDR 0x0000000
/* 6510/45GS10 CPU port DDR */
#define PORTDDR 0x0000000
/* 6510/45GS10 CPU port data */
#define CPU_PORT 0x0000001
/* 6510/45GS10 CPU port data */
#define PORT 0x0000001
/* Transmit packet */
#define ETHCOMMAND_STARTTX 0x01
/* Transmit packet */
#define STARTTX 0x01
/* Disable the effects of RXONLYONE */
#define ETHCOMMAND_RXNORMAL 0xD0
/* Disable the effects of RXONLYONE */
#define RXNORMAL 0xD0
/* sprite N horizontal position */
#define VIC2_S0X 0xD000
/* sprite N horizontal position */
#define S0X 0xD000
/* sprite N vertical position */
#define VIC2_S0Y 0xD001
/* sprite N vertical position */
#define S0Y 0xD001
/* @SNX */
#define VIC2_S1X 0xD002
/* @SNX */
#define S1X 0xD002
/* @SNY */
#define VIC2_S1Y 0xD003
/* @SNY */
#define S1Y 0xD003
/* @SNX */
#define VIC2_S2X 0xD004
/* @SNX */
#define S2X 0xD004
/* @SNY */
#define VIC2_S2Y 0xD005
/* @SNY */
#define S2Y 0xD005
/* @SNX */
#define VIC2_S3X 0xD006
/* @SNX */
#define S3X 0xD006
/* @SNY */
#define VIC2_S3Y 0xD007
/* @SNY */
#define S3Y 0xD007
/* @SNX */
#define VIC2_S4X 0xD008
/* @SNX */
#define S4X 0xD008
/* @SNY */
#define VIC2_S4Y 0xD009
/* @SNY */
#define S4Y 0xD009
/* @SNX */
#define VIC2_S5X 0xD00A
/* @SNX */
#define S5X 0xD00A
/* @SNY */
#define VIC2_S5Y 0xD00B
/* @SNY */
#define S5Y 0xD00B
/* @SNX */
#define VIC2_S6X 0xD00C
/* @SNX */
#define S6X 0xD00C
/* @SNY */
#define VIC2_S6Y 0xD00D
/* @SNY */
#define S6Y 0xD00D
/* @SNX */
#define VIC2_S7X 0xD00E
/* @SNX */
#define S7X 0xD00E
/* @SNY */
#define VIC2_S7Y 0xD00F
/* @SNY */
#define S7Y 0xD00F
/* sprite horizontal position MSBs */
#define VIC2_SXMSB 0xD010
/* sprite horizontal position MSBs */
#define SXMSB 0xD010
/* 24/25 vertical smooth scroll (address) */
#define VIC2_YSCL_ADDR 0xD011
/* 24/25 vertical smooth scroll (address) */
#define YSCL_ADDR 0xD011
/* 24/25 vertical smooth scroll (bit mask) */
#define VIC2_YSCL_MASK 0b00000111
/* 24/25 vertical smooth scroll (bit mask) */
#define YSCL_MASK 0b00000111
/* 24/25 row select (address) */
#define VIC2_RSEL_ADDR 0xD011
/* 24/25 row select (address) */
#define RSEL_ADDR 0xD011
/* 24/25 row select (bit mask) */
#define VIC2_RSEL_MASK 0b00001000
/* 24/25 row select (bit mask) */
#define RSEL_MASK 0b00001000
/* disable display (address) */
#define VIC2_BLNK_ADDR 0xD011
/* disable display (address) */
#define BLNK_ADDR 0xD011
/* disable display (bit mask) */
#define VIC2_BLNK_MASK 0b00010000
/* disable display (bit mask) */
#define BLNK_MASK 0b00010000
/* bitmap mode (address) */
#define VIC2_BMM_ADDR 0xD011
/* bitmap mode (address) */
#define BMM_ADDR 0xD011
/* bitmap mode (bit mask) */
#define VIC2_BMM_MASK 0b00100000
/* bitmap mode (bit mask) */
#define BMM_MASK 0b00100000
/* extended background mode (address) */
#define VIC2_ECM_ADDR 0xD011
/* extended background mode (address) */
#define ECM_ADDR 0xD011
/* extended background mode (bit mask) */
#define VIC2_ECM_MASK 0b01000000
/* extended background mode (bit mask) */
#define ECM_MASK 0b01000000
/* raster compare bit 8 (address) */
#define VIC2_RC_ADDR 0xD011
/* raster compare bit 8 (address) */
#define RC_ADDR 0xD011
/* raster compare bit 8 (bit mask) */
#define VIC2_RC_MASK 0b10000000
/* raster compare bit 8 (bit mask) */
#define RC_MASK 0b10000000
/* raster compare bits 0 to 7 */
#define VIC2_RC 0xD012
/* raster compare bits 0 to 7 */
#define RC 0xD012
/* Coarse horizontal beam position (was lightpen X) */
#define VIC2_LPX 0xD013
/* Coarse horizontal beam position (was lightpen X) */
#define LPX 0xD013
/* Coarse vertical beam position (was lightpen Y) */
#define VIC2_LPY 0xD014
/* Coarse vertical beam position (was lightpen Y) */
#define LPY 0xD014
/* sprite enable bits */
#define VIC2_SE 0xD015
/* sprite enable bits */
#define SE 0xD015
/* horizontal smooth scroll (address) */
#define VIC2_XSCL_ADDR 0xD016
/* horizontal smooth scroll (address) */
#define XSCL_ADDR 0xD016
/* horizontal smooth scroll (bit mask) */
#define VIC2_XSCL_MASK 0b00000111
/* horizontal smooth scroll (bit mask) */
#define XSCL_MASK 0b00000111
/* 38/40 column select (address) */
#define VIC2_CSEL_ADDR 0xD016
/* 38/40 column select (address) */
#define CSEL_ADDR 0xD016
/* 38/40 column select (bit mask) */
#define VIC2_CSEL_MASK 0b00001000
/* 38/40 column select (bit mask) */
#define CSEL_MASK 0b00001000
/* Multi-colour mode (address) */
#define VIC2_MCM_ADDR 0xD016
/* Multi-colour mode (address) */
#define MCM_ADDR 0xD016
/* Multi-colour mode (bit mask) */
#define VIC2_MCM_MASK 0b00010000
/* Multi-colour mode (bit mask) */
#define MCM_MASK 0b00010000
/* Disables video output on MAX Machine(tm) VIC-II 6566. Ignored on normal C64s and the MEGA65 (address) */
#define VIC2_RST_ADDR 0xD016
/* Disables video output on MAX Machine(tm) VIC-II 6566. Ignored on normal C64s and the MEGA65 (bit mask) */
#define VIC2_RST_MASK 0b00100000
/* sprite vertical expansion enable bits */
#define VIC2_SEXY 0xD017
/* sprite vertical expansion enable bits */
#define SEXY 0xD017
/* character set address location ($\times$ 1KiB) (address) */
#define VIC2_CB_ADDR 0xD018
/* character set address location ($\times$ 1KiB) (address) */
#define CB_ADDR 0xD018
/* character set address location ($\times$ 1KiB) (bit mask) */
#define VIC2_CB_MASK 0b00001110
/* character set address location ($\times$ 1KiB) (bit mask) */
#define CB_MASK 0b00001110
/* screen address ($\times$ 1KiB) (address) */
#define VIC2_VS_ADDR 0xD018
/* screen address ($\times$ 1KiB) (address) */
#define VS_ADDR 0xD018
/* screen address ($\times$ 1KiB) (bit mask) */
#define VIC2_VS_MASK 0b11110000
/* screen address ($\times$ 1KiB) (bit mask) */
#define VS_MASK 0b11110000
/* raster compare indicate or acknowledge (address) */
#define VIC2_RIRQ_ADDR 0xD019
/* raster compare indicate or acknowledge (address) */
#define RIRQ_ADDR 0xD019
/* raster compare indicate or acknowledge (bit mask) */
#define VIC2_RIRQ_MASK 0b00000001
/* raster compare indicate or acknowledge (bit mask) */
#define RIRQ_MASK 0b00000001
/* sprite:bitmap collision indicate or acknowledge (address) */
#define VIC2_ISBC_ADDR 0xD019
/* sprite:bitmap collision indicate or acknowledge (address) */
#define ISBC_ADDR 0xD019
/* sprite:bitmap collision indicate or acknowledge (bit mask) */
#define VIC2_ISBC_MASK 0b00000010
/* sprite:bitmap collision indicate or acknowledge (bit mask) */
#define ISBC_MASK 0b00000010
/* sprite:sprite collision indicate or acknowledge (address) */
#define VIC2_ISSC_ADDR 0xD019
/* sprite:sprite collision indicate or acknowledge (address) */
#define ISSC_ADDR 0xD019
/* sprite:sprite collision indicate or acknowledge (bit mask) */
#define VIC2_ISSC_MASK 0b00000100
/* sprite:sprite collision indicate or acknowledge (bit mask) */
#define ISSC_MASK 0b00000100
/* light pen indicate or acknowledge (address) */
#define VIC2_ILP_ADDR 0xD019
/* light pen indicate or acknowledge (address) */
#define ILP_ADDR 0xD019
/* light pen indicate or acknowledge (bit mask) */
#define VIC2_ILP_MASK 0b00001000
/* light pen indicate or acknowledge (bit mask) */
#define ILP_MASK 0b00001000
/* mask raster IRQ (address) */
#define VIC2_MRIRQ_ADDR 0xD01A
/* mask raster IRQ (address) */
#define MRIRQ_ADDR 0xD01A
/* mask raster IRQ (bit mask) */
#define VIC2_MRIRQ_MASK 0b00000001
/* mask raster IRQ (bit mask) */
#define MRIRQ_MASK 0b00000001
/* mask sprite:bitmap collision IRQ (address) */
#define VIC2_MISBC_ADDR 0xD01A
/* mask sprite:bitmap collision IRQ (address) */
#define MISBC_ADDR 0xD01A
/* mask sprite:bitmap collision IRQ (bit mask) */
#define VIC2_MISBC_MASK 0b00000010
/* mask sprite:bitmap collision IRQ (bit mask) */
#define MISBC_MASK 0b00000010
/* mask sprite:sprite collision IRQ (address) */
#define VIC2_MISSC_ADDR 0xD01A
/* mask sprite:sprite collision IRQ (address) */
#define MISSC_ADDR 0xD01A
/* mask sprite:sprite collision IRQ (bit mask) */
#define VIC2_MISSC_MASK 0b00000100
/* mask sprite:sprite collision IRQ (bit mask) */
#define MISSC_MASK 0b00000100
/* sprite background priority bits */
#define VIC2_BSP 0xD01B
/* sprite background priority bits */
#define BSP 0xD01B
/* sprite multicolour enable bits */
#define VIC2_SCM 0xD01C
/* sprite multicolour enable bits */
#define SCM 0xD01C
/* sprite horizontal expansion enable bits */
#define VIC2_SEXX 0xD01D
/* sprite horizontal expansion enable bits */
#define SEXX 0xD01D
/* sprite/sprite collision indicate bits */
#define VIC2_SSC 0xD01E
/* sprite/sprite collision indicate bits */
#define SSC 0xD01E
/* sprite/foreground collision indicate bits */
#define VIC2_SBC 0xD01F
/* sprite/foreground collision indicate bits */
#define _SBC 0xD01F
/* display border colour (16 colour) (address) */
#define VIC2_BORDERCOL_ADDR 0xD020
/* display border colour (16 colour) (bit mask) */
#define VIC2_BORDERCOL_MASK 0b00001111
/* display border colour (256 colour) (address) */
#define VIC3_BORDERCOL_ADDR 0xD020
/* display border colour (256 colour) (bit mask) */
#define VIC3_BORDERCOL_MASK 0b11111111
/* display border colour (256 colour) (address) */
#define VIC4_BORDERCOL_ADDR 0xD020
/* display border colour (256 colour) (bit mask) */
#define VIC4_BORDERCOL_MASK 0b11111111
/* screen colour (16 colour) (address) */
#define VIC2_SCREENCOL_ADDR 0xD021
/* screen colour (16 colour) (bit mask) */
#define VIC2_SCREENCOL_MASK 0b00001111
/* screen colour (256 colour) (address) */
#define VIC3_SCREENCOL_ADDR 0xD021
/* screen colour (256 colour) (bit mask) */
#define VIC3_SCREENCOL_MASK 0b11111111
/* screen colour (256 colour) (address) */
#define VIC4_SCREENCOL_ADDR 0xD021
/* screen colour (256 colour) (bit mask) */
#define VIC4_SCREENCOL_MASK 0b11111111
/* multi-colour 1 (16 colour) (address) */
#define VIC2_MC1_ADDR 0xD022
/* multi-colour 1 (16 colour) (bit mask) */
#define VIC2_MC1_MASK 0b00001111
/* multi-colour 1 (256 colour) (address) */
#define VIC3_MC1_ADDR 0xD022
/* multi-colour 1 (256 colour) (bit mask) */
#define VIC3_MC1_MASK 0b11111111
/* multi-colour 1 (256 colour) (address) */
#define VIC4_MC1_ADDR 0xD022
/* multi-colour 1 (256 colour) (bit mask) */
#define VIC4_MC1_MASK 0b11111111
/* multi-colour 2 (16 colour) (address) */
#define VIC2_MC2_ADDR 0xD023
/* multi-colour 2 (16 colour) (bit mask) */
#define VIC2_MC2_MASK 0b00001111
/* multi-colour 2 (256 colour) (address) */
#define VIC3_MC2_ADDR 0xD023
/* multi-colour 2 (256 colour) (bit mask) */
#define VIC3_MC2_MASK 0b11111111
/* multi-colour 2 (256 colour) (address) */
#define VIC4_MC2_ADDR 0xD023
/* multi-colour 2 (256 colour) (bit mask) */
#define VIC4_MC2_MASK 0b11111111
/* multi-colour 3 (16 colour) (address) */
#define VIC2_MC3_ADDR 0xD024
/* multi-colour 3 (16 colour) (bit mask) */
#define VIC2_MC3_MASK 0b00001111
/* multi-colour 3 (256 colour) (address) */
#define VIC3_MC3_ADDR 0xD024
/* multi-colour 3 (256 colour) (bit mask) */
#define VIC3_MC3_MASK 0b11111111
/* multi-colour 3 (256 colour) (address) */
#define VIC4_MC3_ADDR 0xD024
/* multi-colour 3 (256 colour) (bit mask) */
#define VIC4_MC3_MASK 0b11111111
/* Sprite multi-colour 0 */
#define VIC2_SPRMC0 0xD025
/* Sprite multi-colour 0 (8-bit for selection of any palette colour) */
#define VIC3_SPRMC0 0xD025
/* Sprite multi-colour 0 (8-bit for selection of any palette colour) */
#define VIC4_SPRMC0 0xD025
/* Sprite multi-colour 1 */
#define VIC2_SPRMC1 0xD026
/* Sprite multi-colour 1 (8-bit for selection of any palette colour) */
#define VIC3_SPRMC1 0xD026
/* Sprite multi-colour 1 (8-bit for selection of any palette colour) */
#define VIC4_SPRMC1 0xD026
/* sprite N colour / 16-colour sprite transparency colour (lower nybl) */
#define VIC2_SPR0COL 0xD027
/* sprite N colour / 16-colour sprite transparency colour (lower nybl) */
#define SPR0COL 0xD027
/* @SPRNCOL */
#define VIC2_SPR1COL 0xD028
/* @SPRNCOL */
#define SPR1COL 0xD028
/* @SPRNCOL */
#define VIC2_SPR2COL 0xD029
/* @SPRNCOL */
#define SPR2COL 0xD029
/* @SPRNCOL */
#define VIC2_SPR3COL 0xD02A
/* @SPRNCOL */
#define SPR3COL 0xD02A
/* @SPRNCOL */
#define VIC2_SPR4COL 0xD02B
/* @SPRNCOL */
#define SPR4COL 0xD02B
/* @SPRNCOL */
#define VIC2_SPR5COL 0xD02C
/* @SPRNCOL */
#define SPR5COL 0xD02C
/* @SPRNCOL */
#define VIC2_SPR6COL 0xD02D
/* @SPRNCOL */
#define SPR6COL 0xD02D
/* @SPRNCOL */
#define VIC2_SPR7COL 0xD02E
/* @SPRNCOL */
#define SPR7COL 0xD02E
/* Write $A5 then $96 to enable C65/VIC-III IO registers */
#define VIC3_KEY 0xD02F
/* Write $45 then $54 to map 45E100 ethernet controller buffers to $D000-$DFFF */
#define VIC4_KEY 0xD02F
/* Write $47 then $53 to enable C65GS/VIC-IV IO registers */
#define GS_VIC4_KEY 0xD02F
/* Control Register A */
#define SUMMARY_VIC_III 0xD030
/* 2MHz select (for C128 2MHz emulation) (address) */
#define VIC2_C128_FAST_ADDR 0xD030
/* 2MHz select (for C128 2MHz emulation) (address) */
#define C128_FAST_ADDR 0xD030
/* 2MHz select (for C128 2MHz emulation) (bit mask) */
#define VIC2_C128_FAST_MASK 0b00000001
/* 2MHz select (for C128 2MHz emulation) (bit mask) */
#define C128_FAST_MASK 0b00000001
/* Map 2nd KB of colour RAM @ $DC00-$DFFF (address) */
#define VIC3_CRAM2K_ADDR 0xD030
/* Map 2nd KB of colour RAM @ $DC00-$DFFF (address) */
#define CRAM2K_ADDR 0xD030
/* Map 2nd KB of colour RAM @ $DC00-$DFFF (bit mask) */
#define VIC3_CRAM2K_MASK 0b00000001
/* Map 2nd KB of colour RAM @ $DC00-$DFFF (bit mask) */
#define CRAM2K_MASK 0b00000001
/* Enable external video sync (genlock input) (address) */
#define VIC3_EXTSYNC_ADDR 0xD030
/* Enable external video sync (genlock input) (address) */
#define EXTSYNC_ADDR 0xD030
/* Enable external video sync (genlock input) (bit mask) */
#define VIC3_EXTSYNC_MASK 0b00000010
/* Enable external video sync (genlock input) (bit mask) */
#define EXTSYNC_MASK 0b00000010
/* Use PALETTE ROM (0) or RAM (1) entries for colours 0 - 15 (address) */
#define VIC3_PAL_ADDR 0xD030
/* Use PALETTE ROM (0) or RAM (1) entries for colours 0 - 15 (address) */
#define PAL_ADDR 0xD030
/* Use PALETTE ROM (0) or RAM (1) entries for colours 0 - 15 (bit mask) */
#define VIC3_PAL_MASK 0b00000100
/* Use PALETTE ROM (0) or RAM (1) entries for colours 0 - 15 (bit mask) */
#define PAL_MASK 0b00000100
/* Map C65 ROM @ $8000 (address) */
#define VIC3_ROM8_ADDR 0xD030
/* Map C65 ROM @ $8000 (address) */
#define ROM8_ADDR 0xD030
/* Map C65 ROM @ $8000 (bit mask) */
#define VIC3_ROM8_MASK 0b00001000
/* Map C65 ROM @ $8000 (bit mask) */
#define ROM8_MASK 0b00001000
/* Map C65 ROM @ $A000 (address) */
#define VIC3_ROMA_ADDR 0xD030
/* Map C65 ROM @ $A000 (address) */
#define ROMA_ADDR 0xD030
/* Map C65 ROM @ $A000 (bit mask) */
#define VIC3_ROMA_MASK 0b00010000
/* Map C65 ROM @ $A000 (bit mask) */
#define ROMA_MASK 0b00010000
/* Map C65 ROM @ $C000 (address) */
#define VIC3_ROMC_ADDR 0xD030
/* Map C65 ROM @ $C000 (address) */
#define ROMC_ADDR 0xD030
/* Map C65 ROM @ $C000 (bit mask) */
#define VIC3_ROMC_MASK 0b00100000
/* Map C65 ROM @ $C000 (bit mask) */
#define ROMC_MASK 0b00100000
/* Select between C64 and C65 charset. (address) */
#define VIC3_CROM9_ADDR 0xD030
/* Select between C64 and C65 charset. (address) */
#define CROM9_ADDR 0xD030
/* Select between C64 and C65 charset. (bit mask) */
#define VIC3_CROM9_MASK 0b01000000
/* Select between C64 and C65 charset. (bit mask) */
#define CROM9_MASK 0b01000000
/* Map C65 ROM @ $E000 (address) */
#define VIC3_ROME_ADDR 0xD030
/* Map C65 ROM @ $E000 (address) */
#define ROME_ADDR 0xD030
/* Map C65 ROM @ $E000 (bit mask) */
#define VIC3_ROME_MASK 0b10000000
/* Map C65 ROM @ $E000 (bit mask) */
#define ROME_MASK 0b10000000
/* Control Register B */
#define C65_SUMMARY_VIC_III 0xD031
/* Enable VIC-III interlaced mode (address) */
#define VIC3_INT_ADDR 0xD031
/* Enable VIC-III interlaced mode (address) */
#define INT_ADDR 0xD031
/* Enable VIC-III interlaced mode (bit mask) */
#define VIC3_INT_MASK 0b00000001
/* Enable VIC-III interlaced mode (bit mask) */
#define INT_MASK 0b00000001
/* Enable VIC-III MONO video output (not implemented) (address) */
#define VIC3_MONO_ADDR 0xD031
/* Enable VIC-III MONO video output (not implemented) (address) */
#define MONO_ADDR 0xD031
/* Enable VIC-III MONO video output (not implemented) (bit mask) */
#define VIC3_MONO_MASK 0b00000010
/* Enable VIC-III MONO video output (not implemented) (bit mask) */
#define MONO_MASK 0b00000010
/* Enable 1280 horizontal pixels (not implemented) (address) */
#define VIC3_H1280_ADDR 0xD031
/* Enable 1280 horizontal pixels (not implemented) (address) */
#define H1280_ADDR 0xD031
/* Enable 1280 horizontal pixels (not implemented) (bit mask) */
#define VIC3_H1280_MASK 0b00000100
/* Enable 1280 horizontal pixels (not implemented) (bit mask) */
#define H1280_MASK 0b00000100
/* Enable 400 vertical pixels (address) */
#define VIC3_V400_ADDR 0xD031
/* Enable 400 vertical pixels (address) */
#define V400_ADDR 0xD031
/* Enable 400 vertical pixels (bit mask) */
#define VIC3_V400_MASK 0b00001000
/* Enable 400 vertical pixels (bit mask) */
#define V400_MASK 0b00001000
/* Bit-Plane Mode (address) */
#define VIC3_BPM_ADDR 0xD031
/* Bit-Plane Mode (address) */
#define BPM_ADDR 0xD031
/* Bit-Plane Mode (bit mask) */
#define VIC3_BPM_MASK 0b00010000
/* Bit-Plane Mode (bit mask) */
#define BPM_MASK 0b00010000
/* Enable extended attributes and 8 bit colour entries (address) */
#define VIC3_ATTR_ADDR 0xD031
/* Enable extended attributes and 8 bit colour entries (address) */
#define ATTR_ADDR 0xD031
/* Enable extended attributes and 8 bit colour entries (bit mask) */
#define VIC3_ATTR_MASK 0b00100000
/* Enable extended attributes and 8 bit colour entries (bit mask) */
#define ATTR_MASK 0b00100000
/* Enable C65 FAST mode (~3.5MHz) (address) */
#define VIC3_FAST_ADDR 0xD031
/* Enable C65 FAST mode (~3.5MHz) (address) */
#define FAST_ADDR 0xD031
/* Enable C65 FAST mode (~3.5MHz) (bit mask) */
#define VIC3_FAST_MASK 0b01000000
/* Enable C65 FAST mode (~3.5MHz) (bit mask) */
#define FAST_MASK 0b01000000
/* Enable C64 640 horizontal pixels / 80 column mode (address) */
#define VIC3_H640_ADDR 0xD031
/* Enable C64 640 horizontal pixels / 80 column mode (address) */
#define H640_ADDR 0xD031
/* Enable C64 640 horizontal pixels / 80 column mode (bit mask) */
#define VIC3_H640_MASK 0b10000000
/* Enable C64 640 horizontal pixels / 80 column mode (bit mask) */
#define H640_MASK 0b10000000
/* Bitplane X address, even lines (address) */
#define VIC3_B0ADEVN_ADDR 0xD033
/* Bitplane X address, even lines (address) */
#define B0ADEVN_ADDR 0xD033
/* Bitplane X address, even lines (bit mask) */
#define VIC3_B0ADEVN_MASK 0b00001110
/* Bitplane X address, even lines (bit mask) */
#define B0ADEVN_MASK 0b00001110
/* Bitplane X address, odd lines (address) */
#define VIC3_B0ADODD_ADDR 0xD033
/* Bitplane X address, odd lines (address) */
#define B0ADODD_ADDR 0xD033
/* Bitplane X address, odd lines (bit mask) */
#define VIC3_B0ADODD_MASK 0b11100000
/* Bitplane X address, odd lines (bit mask) */
#define B0ADODD_MASK 0b11100000
/* @BXADEVN (address) */
#define VIC3_B1ADEVN_ADDR 0xD034
/* @BXADEVN (address) */
#define B1ADEVN_ADDR 0xD034
/* @BXADEVN (bit mask) */
#define VIC3_B1ADEVN_MASK 0b00001110
/* @BXADEVN (bit mask) */
#define B1ADEVN_MASK 0b00001110
/* @BXADODD (address) */
#define VIC3_B1ADODD_ADDR 0xD034
/* @BXADODD (address) */
#define B1ADODD_ADDR 0xD034
/* @BXADODD (bit mask) */
#define VIC3_B1ADODD_MASK 0b11100000
/* @BXADODD (bit mask) */
#define B1ADODD_MASK 0b11100000
/* @BXADEVN (address) */
#define VIC3_B2ADEVN_ADDR 0xD035
/* @BXADEVN (address) */
#define B2ADEVN_ADDR 0xD035
/* @BXADEVN (bit mask) */
#define VIC3_B2ADEVN_MASK 0b00001110
/* @BXADEVN (bit mask) */
#define B2ADEVN_MASK 0b00001110
/* @BXADODD (address) */
#define VIC3_B2ADODD_ADDR 0xD035
/* @BXADODD (address) */
#define B2ADODD_ADDR 0xD035
/* @BXADODD (bit mask) */
#define VIC3_B2ADODD_MASK 0b11100000
/* @BXADODD (bit mask) */
#define B2ADODD_MASK 0b11100000
/* @BXADEVN (address) */
#define VIC3_B3ADEVN_ADDR 0xD036
/* @BXADEVN (address) */
#define B3ADEVN_ADDR 0xD036
/* @BXADEVN (bit mask) */
#define VIC3_B3ADEVN_MASK 0b00001110
/* @BXADEVN (bit mask) */
#define B3ADEVN_MASK 0b00001110
/* @BXADODD (address) */
#define VIC3_B3ADODD_ADDR 0xD036
/* @BXADODD (address) */
#define B3ADODD_ADDR 0xD036
/* @BXADODD (bit mask) */
#define VIC3_B3ADODD_MASK 0b11100000
/* @BXADODD (bit mask) */
#define B3ADODD_MASK 0b11100000
/* @BXADEVN (address) */
#define VIC3_B4ADEVN_ADDR 0xD037
/* @BXADEVN (address) */
#define B4ADEVN_ADDR 0xD037
/* @BXADEVN (bit mask) */
#define VIC3_B4ADEVN_MASK 0b00001110
/* @BXADEVN (bit mask) */
#define B4ADEVN_MASK 0b00001110
/* @BXADODD (address) */
#define VIC3_B4ADODD_ADDR 0xD037
/* @BXADODD (address) */
#define B4ADODD_ADDR 0xD037
/* @BXADODD (bit mask) */
#define VIC3_B4ADODD_MASK 0b11100000
/* @BXADODD (bit mask) */
#define B4ADODD_MASK 0b11100000
/* @BXADEVN (address) */
#define VIC3_B5ADEVN_ADDR 0xD038
/* @BXADEVN (address) */
#define B5ADEVN_ADDR 0xD038
/* @BXADEVN (bit mask) */
#define VIC3_B5ADEVN_MASK 0b00001110
/* @BXADEVN (bit mask) */
#define B5ADEVN_MASK 0b00001110
/* @BXADODD (address) */
#define VIC3_B5ADODD_ADDR 0xD038
/* @BXADODD (address) */
#define B5ADODD_ADDR 0xD038
/* @BXADODD (bit mask) */
#define VIC3_B5ADODD_MASK 0b11100000
/* @BXADODD (bit mask) */
#define B5ADODD_MASK 0b11100000
/* @BXADEVN (address) */
#define VIC3_B6ADEVN_ADDR 0xD039
/* @BXADEVN (address) */
#define B6ADEVN_ADDR 0xD039
/* @BXADEVN (bit mask) */
#define VIC3_B6ADEVN_MASK 0b00001110
/* @BXADEVN (bit mask) */
#define B6ADEVN_MASK 0b00001110
/* @BXADODD (address) */
#define VIC3_B6ADODD_ADDR 0xD039
/* @BXADODD (address) */
#define B6ADODD_ADDR 0xD039
/* @BXADODD (bit mask) */
#define VIC3_B6ADODD_MASK 0b11100000
/* @BXADODD (bit mask) */
#define B6ADODD_MASK 0b11100000
/* @BXADEVN (address) */
#define VIC3_B7ADEVN_ADDR 0xD03A
/* @BXADEVN (address) */
#define B7ADEVN_ADDR 0xD03A
/* @BXADEVN (bit mask) */
#define VIC3_B7ADEVN_MASK 0b00001110
/* @BXADEVN (bit mask) */
#define B7ADEVN_MASK 0b00001110
/* @BXADODD (address) */
#define VIC3_B7ADODD_ADDR 0xD03A
/* @BXADODD (address) */
#define B7ADODD_ADDR 0xD03A
/* @BXADODD (bit mask) */
#define VIC3_B7ADODD_MASK 0b11100000
/* @BXADODD (bit mask) */
#define B7ADODD_MASK 0b11100000
/* Complement bitplane flags */
#define VIC3_BPCOMP 0xD03B
/* Complement bitplane flags */
#define BPCOMP 0xD03B
/* Bitplane X */
#define VIC3_BPX 0xD03C
/* Bitplane X */
#define BPX 0xD03C
/* Bitplane Y */
#define VIC3_BPY 0xD03D
/* Bitplane Y */
#define BPY 0xD03D
/* Bitplane X Offset */
#define VIC3_HPOS 0xD03E
/* Bitplane X Offset */
#define HPOS 0xD03E
/* Bitplane Y Offset */
#define VIC3_VPOS 0xD03F
/* Bitplane Y Offset */
#define VPOS 0xD03F
/* Display Address Translater (DAT) Bitplane N port */
#define VIC3_B0PIX 0xD040
/* Display Address Translater (DAT) Bitplane N port */
#define B0PIX 0xD040
/* @BNPIX */
#define VIC3_B1PIX 0xD041
/* @BNPIX */
#define B1PIX 0xD041
/* @BNPIX */
#define VIC3_B2PIX 0xD042
/* @BNPIX */
#define B2PIX 0xD042
/* @BNPIX */
#define VIC3_B3PIX 0xD043
/* @BNPIX */
#define B3PIX 0xD043
/* @BNPIX */
#define VIC3_B4PIX 0xD044
/* @BNPIX */
#define B4PIX 0xD044
/* @BNPIX */
#define VIC3_B5PIX 0xD045
/* @BNPIX */
#define B5PIX 0xD045
/* @BNPIX */
#define VIC3_B6PIX 0xD046
/* @BNPIX */
#define B6PIX 0xD046
/* @BNPIX */
#define VIC3_B7PIX 0xD047
/* @BNPIX */
#define B7PIX 0xD047
/* top border position */
#define VIC4_TBDRPOS 0xD048
/* top border position */
#define TBDRPOS 0xD048
/* top border position MSB (address) */
#define VIC4_TBDRPOS_ADDR 0xD049
/* top border position MSB (address) */
#define TBDRPOS_ADDR 0xD049
/* top border position MSB (bit mask) */
#define VIC4_TBDRPOS_MASK 0b00001111
/* top border position MSB (bit mask) */
#define TBDRPOS_MASK 0b00001111
/* Sprite bitplane-modify-mode enables (address) */
#define VIC4_SPRBPMEN_ADDR 0xD049
/* Sprite bitplane-modify-mode enables (bit mask) */
#define VIC4_SPRBPMEN_MASK 0b11110000
/* bottom border position */
#define VIC4_BBDRPOS 0xD04A
/* bottom border position */
#define BBDRPOS 0xD04A
/* bottom border position (address) */
#define VIC4_BBDRPOS_ADDR 0xD04B
/* bottom border position (address) */
#define BBDRPOS_ADDR 0xD04B
/* bottom border position (bit mask) */
#define VIC4_BBDRPOS_MASK 0b00001111
/* bottom border position (bit mask) */
#define BBDRPOS_MASK 0b00001111
/* Sprite bitplane-modify-mode enables (address) */
#define GS_VIC4_SPRBPMEN_ADDR 0xD04B
/* Sprite bitplane-modify-mode enables (bit mask) */
#define GS_VIC4_SPRBPMEN_MASK 0b11110000
/* character generator horizontal position */
#define VIC4_TEXTXPOS 0xD04C
/* character generator horizontal position */
#define TEXTXPOS 0xD04C
/* character generator horizontal position (address) */
#define VIC4_TEXTXPOS_ADDR 0xD04D
/* character generator horizontal position (address) */
#define TEXTXPOS_ADDR 0xD04D
/* character generator horizontal position (bit mask) */
#define VIC4_TEXTXPOS_MASK 0b00001111
/* character generator horizontal position (bit mask) */
#define TEXTXPOS_MASK 0b00001111
/* Sprite horizontal tile enables. (address) */
#define VIC4_SPRTILEN_ADDR 0xD04D
/* Sprite horizontal tile enables. (bit mask) */
#define VIC4_SPRTILEN_MASK 0b11110000
/* Character generator vertical position */
#define VIC4_TEXTYPOS 0xD04E
/* Character generator vertical position */
#define TEXTYPOS 0xD04E
/* Character generator vertical position (address) */
#define VIC4_TEXTYPOS_ADDR 0xD04F
/* Character generator vertical position (address) */
#define TEXTYPOS_ADDR 0xD04F
/* Character generator vertical position (bit mask) */
#define VIC4_TEXTYPOS_MASK 0b00001111
/* Character generator vertical position (bit mask) */
#define TEXTYPOS_MASK 0b00001111
/* Sprite 7-4 horizontal tile enables (address) */
#define GS_VIC4_SPRTILEN_ADDR 0xD04F
/* Sprite 7-4 horizontal tile enables (bit mask) */
#define GS_VIC4_SPRTILEN_MASK 0b11110000
/* Read horizontal raster scan position LSB */
#define VIC4_XPOSLSB 0xD050
/* Read horizontal raster scan position LSB */
#define XPOSLSB 0xD050
/* Read horizontal raster scan position MSB (address) */
#define VIC4_XPOSMSB_ADDR 0xD051
/* Read horizontal raster scan position MSB (address) */
#define XPOSMSB_ADDR 0xD051
/* Read horizontal raster scan position MSB (bit mask) */
#define VIC4_XPOSMSB_MASK 0b00111111
/* Read horizontal raster scan position MSB (bit mask) */
#define XPOSMSB_MASK 0b00111111
/* When set, the Raster Rewrite Buffer is only updated every 2nd raster line, limiting resolution to V200, but allowing more cycles for Raster-Rewrite actions. (address) */
#define VIC4_DBLRR_ADDR 0xD051
/* When set, the Raster Rewrite Buffer is only updated every 2nd raster line, limiting resolution to V200, but allowing more cycles for Raster-Rewrite actions. (address) */
#define DBLRR_ADDR 0xD051
/* When set, the Raster Rewrite Buffer is only updated every 2nd raster line, limiting resolution to V200, but allowing more cycles for Raster-Rewrite actions. (bit mask) */
#define VIC4_DBLRR_MASK 0b01000000
/* When set, the Raster Rewrite Buffer is only updated every 2nd raster line, limiting resolution to V200, but allowing more cycles for Raster-Rewrite actions. (bit mask) */
#define DBLRR_MASK 0b01000000
/* When clear, raster rewrite double buffering is used (address) */
#define VIC4_NORRDEL_ADDR 0xD051
/* When clear, raster rewrite double buffering is used (address) */
#define NORRDEL_ADDR 0xD051
/* When clear, raster rewrite double buffering is used (bit mask) */
#define VIC4_NORRDEL_MASK 0b10000000
/* When clear, raster rewrite double buffering is used (bit mask) */
#define NORRDEL_MASK 0b10000000
/* Read physical raster position */
#define VIC4_FNRASTERLSB 0xD052
/* Read physical raster position */
#define FNRASTERLSB 0xD052
/* Read physical raster position (address) */
#define VIC4_FN_RASTER_MSB_ADDR 0xD053
/* Read physical raster position (address) */
#define FN_RASTER_MSB_ADDR 0xD053
/* Read physical raster position (bit mask) */
#define VIC4_FN_RASTER_MSB_MASK 0b00000111
/* Read physical raster position (bit mask) */
#define FN_RASTER_MSB_MASK 0b00000111
/* Enable simulated shadow-mask (PALEMU must also be enabled) (address) */
#define VIC4_SHDEMU_ADDR 0xD053
/* Enable simulated shadow-mask (PALEMU must also be enabled) (address) */
#define SHDEMU_ADDR 0xD053
/* Enable simulated shadow-mask (PALEMU must also be enabled) (bit mask) */
#define VIC4_SHDEMU_MASK 0b01000000
/* Enable simulated shadow-mask (PALEMU must also be enabled) (bit mask) */
#define SHDEMU_MASK 0b01000000
/* Raster compare source (0=VIC-IV fine raster, 1=VIC-II raster) (address) */
#define VIC4_FNRST_ADDR 0xD053
/* Raster compare source (0=VIC-IV fine raster, 1=VIC-II raster) (address) */
#define FNRST_ADDR 0xD053
/* Raster compare source (0=VIC-IV fine raster, 1=VIC-II raster) (bit mask) */
#define VIC4_FNRST_MASK 0b10000000
/* Raster compare source (0=VIC-IV fine raster, 1=VIC-II raster) (bit mask) */
#define FNRST_MASK 0b10000000
/* Control register C */
#define SUMMARY_VIC_IV 0xD054
/* Control register C */
#define VIC_IV 0xD054
/* enable 16-bit character numbers (two screen bytes per character) (address) */
#define VIC4_CHR16_ADDR 0xD054
/* enable 16-bit character numbers (two screen bytes per character) (address) */
#define CHR16_ADDR 0xD054
/* enable 16-bit character numbers (two screen bytes per character) (bit mask) */
#define VIC4_CHR16_MASK 0b00000001
/* enable 16-bit character numbers (two screen bytes per character) (bit mask) */
#define CHR16_MASK 0b00000001
/* enable full-colour mode for character numbers <=$FF (address) */
#define VIC4_FCLRLO_ADDR 0xD054
/* enable full-colour mode for character numbers <=$FF (address) */
#define FCLRLO_ADDR 0xD054
/* enable full-colour mode for character numbers <=$FF (bit mask) */
#define VIC4_FCLRLO_MASK 0b00000010
/* enable full-colour mode for character numbers <=$FF (bit mask) */
#define FCLRLO_MASK 0b00000010
/* enable full-colour mode for character numbers >$FF (address) */
#define VIC4_FCLRHI_ADDR 0xD054
/* enable full-colour mode for character numbers >$FF (address) */
#define FCLRHI_ADDR 0xD054
/* enable full-colour mode for character numbers >$FF (bit mask) */
#define VIC4_FCLRHI_MASK 0b00000100
/* enable full-colour mode for character numbers >$FF (bit mask) */
#define FCLRHI_MASK 0b00000100
/* video output horizontal smoothing enable (address) */
#define VIC4_SMTH_ADDR 0xD054
/* video output horizontal smoothing enable (address) */
#define SMTH_ADDR 0xD054
/* video output horizontal smoothing enable (bit mask) */
#define VIC4_SMTH_MASK 0b00001000
/* video output horizontal smoothing enable (bit mask) */
#define SMTH_MASK 0b00001000
/* Sprite H640 enable; (address) */
#define VIC4_SPR640_ADDR 0xD054
/* Sprite H640 enable; (address) */
#define SPR640_ADDR 0xD054
/* Sprite H640 enable; (bit mask) */
#define VIC4_SPR640_MASK 0b00010000
/* Sprite H640 enable; (bit mask) */
#define SPR640_MASK 0b00010000
/* Enable PAL CRT-like scan-line emulation (address) */
#define VIC4_PALEMU_ADDR 0xD054
/* Enable PAL CRT-like scan-line emulation (address) */
#define PALEMU_ADDR 0xD054
/* Enable PAL CRT-like scan-line emulation (bit mask) */
#define VIC4_PALEMU_MASK 0b00100000
/* Enable PAL CRT-like scan-line emulation (bit mask) */
#define PALEMU_MASK 0b00100000
/* C65GS FAST mode (48MHz) (address) */
#define VIC4_VFAST_ADDR 0xD054
/* C65GS FAST mode (48MHz) (address) */
#define VFAST_ADDR 0xD054
/* C65GS FAST mode (48MHz) (bit mask) */
#define VIC4_VFAST_MASK 0b01000000
/* C65GS FAST mode (48MHz) (bit mask) */
#define VFAST_MASK 0b01000000
/* Alpha compositor enable (address) */
#define VIC4_ALPHEN_ADDR 0xD054
/* Alpha compositor enable (address) */
#define ALPHEN_ADDR 0xD054
/* Alpha compositor enable (bit mask) */
#define VIC4_ALPHEN_MASK 0b10000000
/* Alpha compositor enable (bit mask) */
#define ALPHEN_MASK 0b10000000
/* sprite extended height enable (one bit per sprite) */
#define VIC4_SPRHGTEN 0xD055
/* sprite extended height enable (one bit per sprite) */
#define SPRHGTEN 0xD055
/* Sprite extended height size (sprite pixels high) */
#define VIC4_SPRHGHT 0xD056
/* Sprite extended height size (sprite pixels high) */
#define SPRHGHT 0xD056
/* Sprite extended width enables (8 bytes per sprite row = 64 pixels wide for normal sprites or 16 pixels wide for 16-colour sprite mode) */
#define VIC4_SPRX64EN 0xD057
/* Sprite extended width enables (8 bytes per sprite row = 64 pixels wide for normal sprites or 16 pixels wide for 16-colour sprite mode) */
#define SPRX64EN 0xD057
/* number of bytes to advance between each text row (LSB) */
#define VIC4_LINESTEPLSB 0xD058
/* number of bytes to advance between each text row (LSB) */
#define LINESTEPLSB 0xD058
/* number of bytes to advance between each text row (MSB) */
#define VIC4_LINESTEPMSB 0xD059
/* number of bytes to advance between each text row (MSB) */
#define LINESTEPMSB 0xD059
/* Horizontal hardware scale of text mode (pixel 120ths per pixel) */
#define VIC4_CHRXSCL 0xD05A
/* Horizontal hardware scale of text mode (pixel 120ths per pixel) */
#define CHRXSCL 0xD05A
/* Vertical scaling of text mode (number of physical rasters per char text row) */
#define VIC4_CHRYSCL 0xD05B
/* Vertical scaling of text mode (number of physical rasters per char text row) */
#define CHRYSCL 0xD05B
/* Width of single side border (LSB) */
#define VIC4_SDBDRWD_LSB 0xD05C
/* Width of single side border (LSB) */
#define SDBDRWD_LSB 0xD05C
/* side border width (MSB) (address) */
#define VIC4_SDBDRWD_MSB_ADDR 0xD05D
/* side border width (MSB) (address) */
#define SDBDRWD_MSB_ADDR 0xD05D
/* side border width (MSB) (bit mask) */
#define VIC4_SDBDRWD_MSB_MASK 0b00111111
/* side border width (MSB) (bit mask) */
#define SDBDRWD_MSB_MASK 0b00111111
/* Enable raster delay (delays raster counter and interrupts by one line to match output pipeline latency) (address) */
#define VIC4_RST_DELEN_ADDR 0xD05D
/* Enable raster delay (delays raster counter and interrupts by one line to match output pipeline latency) (address) */
#define RST_DELEN_ADDR 0xD05D
/* Enable raster delay (delays raster counter and interrupts by one line to match output pipeline latency) (bit mask) */
#define VIC4_RST_DELEN_MASK 0b01000000
/* Enable raster delay (delays raster counter and interrupts by one line to match output pipeline latency) (bit mask) */
#define RST_DELEN_MASK 0b01000000
/* Enable VIC-II hot registers. When enabled, touching many VIC-II registers causes the VIC-IV to recalculate display parameters, such as border positions and sizes (address) */
#define VIC4_HOTREG_ADDR 0xD05D
/* Enable VIC-II hot registers. When enabled, touching many VIC-II registers causes the VIC-IV to recalculate display parameters, such as border positions and sizes (address) */
#define HOTREG_ADDR 0xD05D
/* Enable VIC-II hot registers. When enabled, touching many VIC-II registers causes the VIC-IV to recalculate display parameters, such as border positions and sizes (bit mask) */
#define VIC4_HOTREG_MASK 0b10000000
/* Enable VIC-II hot registers. When enabled, touching many VIC-II registers causes the VIC-IV to recalculate display parameters, such as border positions and sizes (bit mask) */
#define HOTREG_MASK 0b10000000
/* Number of characters to display per row (LSB) */
#define VIC4_CHRCOUNT 0xD05E
/* Number of characters to display per row (LSB) */
#define CHRCOUNT 0xD05E
/* Sprite H640 X Super-MSBs */
#define VIC4_SPRXSMSBS 0xD05F
/* Sprite H640 X Super-MSBs */
#define SPRXSMSBS 0xD05F
/* screen RAM precise base address (bits 0 - 7) */
#define VIC4_SCRNPTRLSB 0xD060
/* screen RAM precise base address (bits 0 - 7) */
#define SCRNPTRLSB 0xD060
/* screen RAM precise base address (bits 15 - 8) */
#define VIC4_SCRNPTRMSB 0xD061
/* screen RAM precise base address (bits 15 - 8) */
#define SCRNPTRMSB 0xD061
/* screen RAM precise base address (bits 23 - 16) */
#define VIC4_SCRNPTRBNK 0xD062
/* screen RAM precise base address (bits 23 - 16) */
#define SCRNPTRBNK 0xD062
/* screen RAM precise base address (bits 31 - 24) (address) */
#define VIC4_SCRNPTRMB_ADDR 0xD063
/* screen RAM precise base address (bits 31 - 24) (address) */
#define SCRNPTRMB_ADDR 0xD063
/* screen RAM precise base address (bits 31 - 24) (bit mask) */
#define VIC4_SCRNPTRMB_MASK 0b00001111
/* screen RAM precise base address (bits 31 - 24) (bit mask) */
#define SCRNPTRMB_MASK 0b00001111
/* Number of characters to display per (address) */
#define VIC4_CHRCOUNT_ADDR 0xD063
/* Number of characters to display per (address) */
#define CHRCOUNT_ADDR 0xD063
/* Number of characters to display per (bit mask) */
#define VIC4_CHRCOUNT_MASK 0b00110000
/* Number of characters to display per (bit mask) */
#define CHRCOUNT_MASK 0b00110000
/* source full-colour character data from expansion RAM (address) */
#define VIC4_EXGLYPH_ADDR 0xD063
/* source full-colour character data from expansion RAM (address) */
#define EXGLYPH_ADDR 0xD063
/* source full-colour character data from expansion RAM (bit mask) */
#define VIC4_EXGLYPH_MASK 0b10000000
/* source full-colour character data from expansion RAM (bit mask) */
#define EXGLYPH_MASK 0b10000000
/* colour RAM base address (bits 0 - 7) */
#define VIC4_COLPTRLSB 0xD064
/* colour RAM base address (bits 0 - 7) */
#define COLPTRLSB 0xD064
/* colour RAM base address (bits 15 - 8) */
#define VIC4_COLPTRMSB 0xD065
/* colour RAM base address (bits 15 - 8) */
#define COLPTRMSB 0xD065
/* Sprite/bitplane first X DEBUG WILL BE REMOVED */
#define DEBUG_SBPDEBUG 0xD067
/* Sprite/bitplane first X DEBUG WILL BE REMOVED */
#define SBPDEBUG 0xD067
/* Character set precise base address (bits 0 - 7) */
#define VIC4_CHARPTRLSB 0xD068
/* Character set precise base address (bits 0 - 7) */
#define CHARPTRLSB 0xD068
/* Character set precise base address (bits 15 - 8) */
#define VIC4_CHARPTRMSB 0xD069
/* Character set precise base address (bits 15 - 8) */
#define CHARPTRMSB 0xD069
/* Character set precise base address (bits 23 - 16) */
#define VIC4_CHARPTRBNK 0xD06A
/* Character set precise base address (bits 23 - 16) */
#define CHARPTRBNK 0xD06A
/* sprite 16-colour mode enables */
#define VIC4_SPR16EN 0xD06B
/* sprite 16-colour mode enables */
#define SPR16EN 0xD06B
/* sprite pointer address (bits 7 - 0) */
#define VIC4_SPRPTRADRLSB 0xD06C
/* sprite pointer address (bits 7 - 0) */
#define SPRPTRADRLSB 0xD06C
/* sprite pointer address (bits 15 - 8) */
#define VIC4_SPRPTRADRMSB 0xD06D
/* sprite pointer address (bits 15 - 8) */
#define SPRPTRADRMSB 0xD06D
/* sprite pointer address (bits 23 - 16) (address) */
#define VIC4_SPRPTRBNK_ADDR 0xD06E
/* sprite pointer address (bits 23 - 16) (address) */
#define SPRPTRBNK_ADDR 0xD06E
/* sprite pointer address (bits 23 - 16) (bit mask) */
#define VIC4_SPRPTRBNK_MASK 0b01111111
/* sprite pointer address (bits 23 - 16) (bit mask) */
#define SPRPTRBNK_MASK 0b01111111
/* 16-bit sprite pointer mode (allows sprites to be located on any 64 byte boundary in chip RAM) (address) */
#define VIC4_SPR_PTR16_ADDR 0xD06E
/* 16-bit sprite pointer mode (allows sprites to be located on any 64 byte boundary in chip RAM) (address) */
#define SPR_PTR16_ADDR 0xD06E
/* 16-bit sprite pointer mode (allows sprites to be located on any 64 byte boundary in chip RAM) (bit mask) */
#define VIC4_SPR_PTR16_MASK 0b10000000
/* 16-bit sprite pointer mode (allows sprites to be located on any 64 byte boundary in chip RAM) (bit mask) */
#define SPR_PTR16_MASK 0b10000000
/* first VIC-II raster line (address) */
#define VIC4_RASLINE0_ADDR 0xD06F
/* first VIC-II raster line (address) */
#define RASLINE0_ADDR 0xD06F
/* first VIC-II raster line (bit mask) */
#define VIC4_RASLINE0_MASK 0b00111111
/* first VIC-II raster line (bit mask) */
#define RASLINE0_MASK 0b00111111
/* Select more VGA-compatible mode if set, instead of HDMI/HDTV VIC-II cycle-exact frame timing. May help to produce a functional display on older VGA monitors. (address) */
#define VIC4_VGAHDTV_ADDR 0xD06F
/* Select more VGA-compatible mode if set, instead of HDMI/HDTV VIC-II cycle-exact frame timing. May help to produce a functional display on older VGA monitors. (address) */
#define VGAHDTV_ADDR 0xD06F
/* Select more VGA-compatible mode if set, instead of HDMI/HDTV VIC-II cycle-exact frame timing. May help to produce a functional display on older VGA monitors. (bit mask) */
#define VIC4_VGAHDTV_MASK 0b01000000
/* Select more VGA-compatible mode if set, instead of HDMI/HDTV VIC-II cycle-exact frame timing. May help to produce a functional display on older VGA monitors. (bit mask) */
#define VGAHDTV_MASK 0b01000000
/* NTSC emulation mode (max raster = 262) (address) */
#define VIC4_PALNTSC_ADDR 0xD06F
/* NTSC emulation mode (max raster = 262) (address) */
#define PALNTSC_ADDR 0xD06F
/* NTSC emulation mode (max raster = 262) (bit mask) */
#define VIC4_PALNTSC_MASK 0b10000000
/* NTSC emulation mode (max raster = 262) (bit mask) */
#define PALNTSC_MASK 0b10000000
/* VIC-IV bitmap/text palette bank (alternate palette) (address) */
#define VIC4_ABTPALSEL_ADDR 0xD070
/* VIC-IV bitmap/text palette bank (alternate palette) (address) */
#define ABTPALSEL_ADDR 0xD070
/* VIC-IV bitmap/text palette bank (alternate palette) (bit mask) */
#define VIC4_ABTPALSEL_MASK 0b00000011
/* VIC-IV bitmap/text palette bank (alternate palette) (bit mask) */
#define ABTPALSEL_MASK 0b00000011
/* sprite palette bank (address) */
#define VIC4_SPRPALSEL_ADDR 0xD070
/* sprite palette bank (address) */
#define SPRPALSEL_ADDR 0xD070
/* sprite palette bank (bit mask) */
#define VIC4_SPRPALSEL_MASK 0b00001100
/* sprite palette bank (bit mask) */
#define SPRPALSEL_MASK 0b00001100
/* bitmap/text palette bank (address) */
#define VIC4_BTPALSEL_ADDR 0xD070
/* bitmap/text palette bank (address) */
#define BTPALSEL_ADDR 0xD070
/* bitmap/text palette bank (bit mask) */
#define VIC4_BTPALSEL_MASK 0b00110000
/* bitmap/text palette bank (bit mask) */
#define BTPALSEL_MASK 0b00110000
/* palette bank mapped at $D100-$D3FF (address) */
#define VIC4_MAPEDPAL_ADDR 0xD070
/* palette bank mapped at $D100-$D3FF (address) */
#define MAPEDPAL_ADDR 0xD070
/* palette bank mapped at $D100-$D3FF (bit mask) */
#define VIC4_MAPEDPAL_MASK 0b11000000
/* palette bank mapped at $D100-$D3FF (bit mask) */
#define MAPEDPAL_MASK 0b11000000
/* VIC-IV 16-colour bitplane enable flags */
#define VIC4_BP16ENS 0xD071
/* VIC-IV 16-colour bitplane enable flags */
#define BP16ENS 0xD071
/* Sprite Y position adjustment */
#define VIC4_SPRYADJ 0xD072
/* Sprite Y position adjustment */
#define SPRYADJ 0xD072
/* Alpha delay for compositor (address) */
#define VIC4_ALPHADELAY_ADDR 0xD073
/* Alpha delay for compositor (address) */
#define ALPHADELAY_ADDR 0xD073
/* Alpha delay for compositor (bit mask) */
#define VIC4_ALPHADELAY_MASK 0b00001111
/* Alpha delay for compositor (bit mask) */
#define ALPHADELAY_MASK 0b00001111
/* physical rasters per VIC-II raster (1 to 16) (address) */
#define VIC4_RASTERHEIGHT_ADDR 0xD073
/* physical rasters per VIC-II raster (1 to 16) (address) */
#define RASTERHEIGHT_ADDR 0xD073
/* physical rasters per VIC-II raster (1 to 16) (bit mask) */
#define VIC4_RASTERHEIGHT_MASK 0b11110000
/* physical rasters per VIC-II raster (1 to 16) (bit mask) */
#define RASTERHEIGHT_MASK 0b11110000
/* Sprite alpha-blend enable */
#define VIC4_SPRENALPHA 0xD074
/* Sprite alpha-blend enable */
#define SPRENALPHA 0xD074
/* Sprite alpha-blend value */
#define VIC4_SPRALPHAVAL 0xD075
/* Sprite alpha-blend value */
#define SPRALPHAVAL 0xD075
/* Sprite V400 enables */
#define VIC4_SPRENV400 0xD076
/* Sprite V400 enables */
#define SPRENV400 0xD076
/* Sprite V400 Y position MSBs */
#define VIC4_SRPYMSBS 0xD077
/* Sprite V400 Y position MSBs */
#define SRPYMSBS 0xD077
/* Sprite V400 Y position super MSBs */
#define VIC4_SPRYSMSBS 0xD078
/* Sprite V400 Y position super MSBs */
#define SPRYSMSBS 0xD078
/* Raster compare value */
#define VIC4_RSTCOMP 0xD079
/* Raster compare value */
#define RSTCOMP 0xD079
/* Raster compare value MSB (address) */
#define VIC4_RSTCMP_ADDR 0xD07A
/* Raster compare value MSB (address) */
#define RSTCMP_ADDR 0xD07A
/* Raster compare value MSB (bit mask) */
#define VIC4_RSTCMP_MASK 0b00000111
/* Raster compare value MSB (bit mask) */
#define RSTCMP_MASK 0b00000111
/* Continuously monitor sprite pointer, to allow changing sprite data source while a sprite is being drawn (address) */
#define VIC4_SPTR_CONT_ADDR 0xD07A
/* Continuously monitor sprite pointer, to allow changing sprite data source while a sprite is being drawn (address) */
#define SPTR_CONT_ADDR 0xD07A
/* Continuously monitor sprite pointer, to allow changing sprite data source while a sprite is being drawn (bit mask) */
#define VIC4_SPTR_CONT_MASK 0b00001000
/* Continuously monitor sprite pointer, to allow changing sprite data source while a sprite is being drawn (bit mask) */
#define SPTR_CONT_MASK 0b00001000
/* Reserved. (address) */
#define VIC4_RESV_ADDR 0xD07A
/* Reserved. (bit mask) */
#define VIC4_RESV_MASK 0b00110000
/* Enable additional IRQ sources, e.g., raster X position. (address) */
#define VIC4_EXTIRQS_ADDR 0xD07A
/* Enable additional IRQ sources, e.g., raster X position. (address) */
#define EXTIRQS_ADDR 0xD07A
/* Enable additional IRQ sources, e.g., raster X position. (bit mask) */
#define VIC4_EXTIRQS_MASK 0b01000000
/* Enable additional IRQ sources, e.g., raster X position. (bit mask) */
#define EXTIRQS_MASK 0b01000000
/* Raster compare is in physical rasters if set, or VIC-II raster if clear (address) */
#define VIC4_FNRST_CMP_ADDR 0xD07A
/* Raster compare is in physical rasters if set, or VIC-II raster if clear (address) */
#define FNRST_CMP_ADDR 0xD07A
/* Raster compare is in physical rasters if set, or VIC-II raster if clear (bit mask) */
#define VIC4_FNRST_CMP_MASK 0b10000000
/* Raster compare is in physical rasters if set, or VIC-II raster if clear (bit mask) */
#define FNRST_CMP_MASK 0b10000000
/* of text rows to display */
#define VIC4_Number 0xD07B
/* of text rows to display */
#define Number 0xD07B
/* Set which 128KB bank bitplanes (address) */
#define VIC4_BIT_PBANK_ADDR 0xD07C
/* Set which 128KB bank bitplanes (address) */
#define BIT_PBANK_ADDR 0xD07C
/* Set which 128KB bank bitplanes (bit mask) */
#define VIC4_BIT_PBANK_MASK 0b00000111
/* Set which 128KB bank bitplanes (bit mask) */
#define BIT_PBANK_MASK 0b00000111
/* @RESV (address) */
#define GS_VIC4_RESV_ADDR 0xD07C
/* @RESV (bit mask) */
#define GS_VIC4_RESV_MASK 0b00001000
/* hsync polarity (address) */
#define VIC4_HSYNCP_ADDR 0xD07C
/* hsync polarity (address) */
#define HSYNCP_ADDR 0xD07C
/* hsync polarity (bit mask) */
#define VIC4_HSYNCP_MASK 0b00010000
/* hsync polarity (bit mask) */
#define HSYNCP_MASK 0b00010000
/* vsync polarity (address) */
#define VIC4_VSYNCP_ADDR 0xD07C
/* vsync polarity (address) */
#define VSYNCP_ADDR 0xD07C
/* vsync polarity (bit mask) */
#define VIC4_VSYNCP_MASK 0b00100000
/* vsync polarity (bit mask) */
#define VSYNCP_MASK 0b00100000
/* VIC-IV debug pixel select red(01), green(10) or blue(11) channel visible in $D07D (address) */
#define VIC4_DEBUGC_ADDR 0xD07C
/* VIC-IV debug pixel select red(01), green(10) or blue(11) channel visible in $D07D (address) */
#define DEBUGC_ADDR 0xD07C
/* VIC-IV debug pixel select red(01), green(10) or blue(11) channel visible in $D07D (bit mask) */
#define VIC4_DEBUGC_MASK 0b11000000
/* VIC-IV debug pixel select red(01), green(10) or blue(11) channel visible in $D07D (bit mask) */
#define DEBUGC_MASK 0b11000000
/* VIC-IV debug value read-back (read only) */
#define DEBUG_DEBUGOUT 0xD07D
/* VIC-IV debug value read-back (read only) */
#define DEBUGOUT 0xD07D
/* VIC-IV debug X position (LSB) (write only) */
#define DEBUG_DEBUGX 0xD07D
/* VIC-IV debug X position (LSB) (write only) */
#define DEBUGX 0xD07D
/* VIC-IV debug Y position (LSB) */
#define DEBUG_DEBUGY 0xD07E
/* VIC-IV debug Y position (LSB) */
#define DEBUGY 0xD07E
/* VIC-IV debug X position (MSB) (address) */
#define DEBUG_DEBUGX_ADDR 0xD07F
/* VIC-IV debug X position (MSB) (address) */
#define DEBUGX_ADDR 0xD07F
/* VIC-IV debug X position (MSB) (bit mask) */
#define DEBUG_DEBUGX_MASK 0b00001111
/* VIC-IV debug X position (MSB) (bit mask) */
#define DEBUGX_MASK 0b00001111
/* VIC-IV debug Y position (MSB) (address) */
#define DEBUG_DEBUGY_ADDR 0xD07F
/* VIC-IV debug Y position (MSB) (address) */
#define DEBUGY_ADDR 0xD07F
/* VIC-IV debug Y position (MSB) (bit mask) */
#define DEBUG_DEBUGY_MASK 0b11110000
/* VIC-IV debug Y position (MSB) (bit mask) */
#define DEBUGY_MASK 0b11110000
/* VIC-IV debug out-of-frame signal enable (address) */
#define DEBUG_DEBUGOOF_ADDR 0xD07F
/* VIC-IV debug out-of-frame signal enable (address) */
#define DEBUGOOF_ADDR 0xD07F
/* VIC-IV debug out-of-frame signal enable (bit mask) */
#define DEBUG_DEBUGOOF_MASK 0b10000000
/* VIC-IV debug out-of-frame signal enable (bit mask) */
#define DEBUGOOF_MASK 0b10000000
/* Drive select (0 to 7). Internal drive is 0. Second floppy drive on internal cable is 1. Other values reserved for C1565 external drive interface. (address) */
#define FDC_DS_ADDR 0xD080
/* Drive select (0 to 7). Internal drive is 0. Second floppy drive on internal cable is 1. Other values reserved for C1565 external drive interface. (address) */
#define DS_ADDR 0xD080
/* Drive select (0 to 7). Internal drive is 0. Second floppy drive on internal cable is 1. Other values reserved for C1565 external drive interface. (bit mask) */
#define FDC_DS_MASK 0b00000111
/* Drive select (0 to 7). Internal drive is 0. Second floppy drive on internal cable is 1. Other values reserved for C1565 external drive interface. (bit mask) */
#define DS_MASK 0b00000111
/* Directly controls the SIDE signal to the floppy drive, i.e., selecting which side of the media is active. (address) */
#define FDC_SIDE_ADDR 0xD080
/* Directly controls the SIDE signal to the floppy drive, i.e., selecting which side of the media is active. (address) */
#define SIDE_ADDR 0xD080
/* Directly controls the SIDE signal to the floppy drive, i.e., selecting which side of the media is active. (bit mask) */
#define FDC_SIDE_MASK 0b00001000
/* Directly controls the SIDE signal to the floppy drive, i.e., selecting which side of the media is active. (bit mask) */
#define SIDE_MASK 0b00001000
/* Swap upper and lower halves of data buffer (i.e. invert bit 8 of the sector buffer) (address) */
#define FDC_SWAP_ADDR 0xD080
/* Swap upper and lower halves of data buffer (i.e. invert bit 8 of the sector buffer) (address) */
#define SWAP_ADDR 0xD080
/* Swap upper and lower halves of data buffer (i.e. invert bit 8 of the sector buffer) (bit mask) */
#define FDC_SWAP_MASK 0b00010000
/* Swap upper and lower halves of data buffer (i.e. invert bit 8 of the sector buffer) (bit mask) */
#define SWAP_MASK 0b00010000
/* Activates drive motor and LED (unless LED signal is also set, causing the drive LED to blink) (address) */
#define FDC_MOTOR_ADDR 0xD080
/* Activates drive motor and LED (unless LED signal is also set, causing the drive LED to blink) (address) */
#define MOTOR_ADDR 0xD080
/* Activates drive motor and LED (unless LED signal is also set, causing the drive LED to blink) (bit mask) */
#define FDC_MOTOR_MASK 0b00100000
/* Activates drive motor and LED (unless LED signal is also set, causing the drive LED to blink) (bit mask) */
#define MOTOR_MASK 0b00100000
/* Drive LED blinks when set (address) */
#define FDC_LED_ADDR 0xD080
/* Drive LED blinks when set (bit mask) */
#define FDC_LED_MASK 0b01000000
/* When set, enables interrupts to occur. Clearing clears any pending interrupt and disables interrupts until set again. (address) */
#define FDC_IRQ_ADDR 0xD080
/* When set, enables interrupts to occur. Clearing clears any pending interrupt and disables interrupts until set again. (bit mask) */
#define FDC_IRQ_MASK 0b10000000
/* F011 FDC command register */
#define FDC_COMMAND 0xD081
/* Reset the sector buffer read/write pointers (address) */
#define FDC_NOBUF_ADDR 0xD081
/* Reset the sector buffer read/write pointers (address) */
#define NOBUF_ADDR 0xD081
/* Reset the sector buffer read/write pointers (bit mask) */
#define FDC_NOBUF_MASK 0b00000001
/* Reset the sector buffer read/write pointers (bit mask) */
#define NOBUF_MASK 0b00000001
/* Selects alternate DPLL read recovery method (not implemented) (address) */
#define FDC_ALT_ADDR 0xD081
/* Selects alternate DPLL read recovery method (not implemented) (address) */
#define ALT_ADDR 0xD081
/* Selects alternate DPLL read recovery method (not implemented) (bit mask) */
#define FDC_ALT_MASK 0b00000010
/* Selects alternate DPLL read recovery method (not implemented) (bit mask) */
#define ALT_MASK 0b00000010
/* Selects reading and writing algorithm (currently ignored). (address) */
#define FDC_ALGO_ADDR 0xD081
/* Selects reading and writing algorithm (currently ignored). (address) */
#define ALGO_ADDR 0xD081
/* Selects reading and writing algorithm (currently ignored). (bit mask) */
#define FDC_ALGO_MASK 0b00000100
/* Selects reading and writing algorithm (currently ignored). (bit mask) */
#define ALGO_MASK 0b00000100
/* Sets the stepping direction (inward vs (address) */
#define FDC_DIR_ADDR 0xD081
/* Sets the stepping direction (inward vs (address) */
#define DIR_ADDR 0xD081
/* Sets the stepping direction (inward vs (bit mask) */
#define FDC_DIR_MASK 0b00001000
/* Sets the stepping direction (inward vs (bit mask) */
#define DIR_MASK 0b00001000
/* Writing 1 causes the head to step in the indicated direction (address) */
#define FDC_STEP_ADDR 0xD081
/* Writing 1 causes the head to step in the indicated direction (address) */
#define STEP_ADDR 0xD081
/* Writing 1 causes the head to step in the indicated direction (bit mask) */
#define FDC_STEP_MASK 0b00010000
/* Writing 1 causes the head to step in the indicated direction (bit mask) */
#define STEP_MASK 0b00010000
/* Command is a free-format (low level) operation (address) */
#define FDC_FREE_ADDR 0xD081
/* Command is a free-format (low level) operation (address) */
#define FREE_ADDR 0xD081
/* Command is a free-format (low level) operation (bit mask) */
#define FDC_FREE_MASK 0b00100000
/* Command is a free-format (low level) operation (bit mask) */
#define FREE_MASK 0b00100000
/* Command is a read operation if set (address) */
#define FDC_RDCMD_ADDR 0xD081
/* Command is a read operation if set (address) */
#define RDCMD_ADDR 0xD081
/* Command is a read operation if set (bit mask) */
#define FDC_RDCMD_MASK 0b01000000
/* Command is a read operation if set (bit mask) */
#define RDCMD_MASK 0b01000000
/* Command is a write operation if set (address) */
#define FDC_WRCMD_ADDR 0xD081
/* Command is a write operation if set (address) */
#define WRCMD_ADDR 0xD081
/* Command is a write operation if set (bit mask) */
#define FDC_WRCMD_MASK 0b10000000
/* Command is a write operation if set (bit mask) */
#define WRCMD_MASK 0b10000000
/* F011 Head is over track 0 flag (read only) (address) */
#define FDC_TK0_ADDR 0xD082
/* F011 Head is over track 0 flag (read only) (address) */
#define TK0_ADDR 0xD082
/* F011 Head is over track 0 flag (read only) (bit mask) */
#define FDC_TK0_MASK 0b00000001
/* F011 Head is over track 0 flag (read only) (bit mask) */
#define TK0_MASK 0b00000001
/* F011 Disk write protect flag (read only) (address) */
#define FDC_PROT_ADDR 0xD082
/* F011 Disk write protect flag (read only) (address) */
#define PROT_ADDR 0xD082
/* F011 Disk write protect flag (read only) (bit mask) */
#define FDC_PROT_MASK 0b00000010
/* F011 Disk write protect flag (read only) (bit mask) */
#define PROT_MASK 0b00000010
/* F011 LOST flag (data was lost during transfer, i.e., CPU did not read data fast enough) (read only) (address) */
#define FDC_LOST_ADDR 0xD082
/* F011 LOST flag (data was lost during transfer, i.e., CPU did not read data fast enough) (read only) (address) */
#define LOST_ADDR 0xD082
/* F011 LOST flag (data was lost during transfer, i.e., CPU did not read data fast enough) (read only) (bit mask) */
#define FDC_LOST_MASK 0b00000100
/* F011 LOST flag (data was lost during transfer, i.e., CPU did not read data fast enough) (read only) (bit mask) */
#define LOST_MASK 0b00000100
/* F011 FDC CRC check failure flag (read only) (address) */
#define FDC_CRC_ADDR 0xD082
/* F011 FDC CRC check failure flag (read only) (address) */
#define CRC_ADDR 0xD082
/* F011 FDC CRC check failure flag (read only) (bit mask) */
#define FDC_CRC_MASK 0b00001000
/* F011 FDC CRC check failure flag (read only) (bit mask) */
#define CRC_MASK 0b00001000
/* F011 FDC Request Not Found (RNF), i.e., a sector read or write operation did not find the requested sector (read only) (address) */
#define FDC_RNF_ADDR 0xD082
/* F011 FDC Request Not Found (RNF), i.e., a sector read or write operation did not find the requested sector (read only) (address) */
#define RNF_ADDR 0xD082
/* F011 FDC Request Not Found (RNF), i.e., a sector read or write operation did not find the requested sector (read only) (bit mask) */
#define FDC_RNF_MASK 0b00010000
/* F011 FDC Request Not Found (RNF), i.e., a sector read or write operation did not find the requested sector (read only) (bit mask) */
#define RNF_MASK 0b00010000
/* F011 FDC CPU and disk pointers to sector buffer are equal, indicating that the sector buffer is either full or empty. (read only) (address) */
#define FDC_EQ_ADDR 0xD082
/* F011 FDC CPU and disk pointers to sector buffer are equal, indicating that the sector buffer is either full or empty. (read only) (address) */
#define EQ_ADDR 0xD082
/* F011 FDC CPU and disk pointers to sector buffer are equal, indicating that the sector buffer is either full or empty. (read only) (bit mask) */
#define FDC_EQ_MASK 0b00100000
/* F011 FDC CPU and disk pointers to sector buffer are equal, indicating that the sector buffer is either full or empty. (read only) (bit mask) */
#define EQ_MASK 0b00100000
/* F011 FDC DRQ flag (one or more bytes of data are ready) (read only) (address) */
#define FDC_DRQ_ADDR 0xD082
/* F011 FDC DRQ flag (one or more bytes of data are ready) (read only) (address) */
#define DRQ_ADDR 0xD082
/* F011 FDC DRQ flag (one or more bytes of data are ready) (read only) (bit mask) */
#define FDC_DRQ_MASK 0b01000000
/* F011 FDC DRQ flag (one or more bytes of data are ready) (read only) (bit mask) */
#define DRQ_MASK 0b01000000
/* F011 FDC busy flag (command is being executed) (read only) (address) */
#define FDC_BUSY_ADDR 0xD082
/* F011 FDC busy flag (command is being executed) (read only) (address) */
#define BUSY_ADDR 0xD082
/* F011 FDC busy flag (command is being executed) (read only) (bit mask) */
#define FDC_BUSY_MASK 0b10000000
/* F011 FDC busy flag (command is being executed) (read only) (bit mask) */
#define BUSY_MASK 0b10000000
/* F011 disk change sense (read only) (address) */
#define FDC_DSKCHG_ADDR 0xD083
/* F011 disk change sense (read only) (address) */
#define DSKCHG_ADDR 0xD083
/* F011 disk change sense (read only) (bit mask) */
#define FDC_DSKCHG_MASK 0b00000001
/* F011 disk change sense (read only) (bit mask) */
#define DSKCHG_MASK 0b00000001
/* The floppy controller has generated an interrupt (read only). Note that interrupts are not currently implemented on the 45GS27. (address) */
#define C65_FDC_IRQ_ADDR 0xD083
/* The floppy controller has generated an interrupt (read only). Note that interrupts are not currently implemented on the 45GS27. (bit mask) */
#define C65_FDC_IRQ_MASK 0b00000010
/* F011 Index hole sense (read only) (address) */
#define FDC_INDEX_ADDR 0xD083
/* F011 Index hole sense (read only) (address) */
#define INDEX_ADDR 0xD083
/* F011 Index hole sense (read only) (bit mask) */
#define FDC_INDEX_MASK 0b00000100
/* F011 Index hole sense (read only) (bit mask) */
#define INDEX_MASK 0b00000100
/* F011 Disk sense (read only) (address) */
#define FDC_DISKIN_ADDR 0xD083
/* F011 Disk sense (read only) (address) */
#define DISKIN_ADDR 0xD083
/* F011 Disk sense (read only) (bit mask) */
#define FDC_DISKIN_MASK 0b00001000
/* F011 Disk sense (read only) (bit mask) */
#define DISKIN_MASK 0b00001000
/* F011 write gate flag. Indicates that the drive is currently writing to media. Bad things may happen if a write transaction is aborted (read only) (address) */
#define FDC_WGATE_ADDR 0xD083
/* F011 write gate flag. Indicates that the drive is currently writing to media. Bad things may happen if a write transaction is aborted (read only) (address) */
#define WGATE_ADDR 0xD083
/* F011 write gate flag. Indicates that the drive is currently writing to media. Bad things may happen if a write transaction is aborted (read only) (bit mask) */
#define FDC_WGATE_MASK 0b00010000
/* F011 write gate flag. Indicates that the drive is currently writing to media. Bad things may happen if a write transaction is aborted (read only) (bit mask) */
#define WGATE_MASK 0b00010000
/* F011 Successive match. A synonym of RDREQ on the 45IO47 (read only) (address) */
#define FDC_RUN_ADDR 0xD083
/* F011 Successive match. A synonym of RDREQ on the 45IO47 (read only) (address) */
#define RUN_ADDR 0xD083
/* F011 Successive match. A synonym of RDREQ on the 45IO47 (read only) (bit mask) */
#define FDC_RUN_MASK 0b00100000
/* F011 Successive match. A synonym of RDREQ on the 45IO47 (read only) (bit mask) */
#define RUN_MASK 0b00100000
/* F011 Write Request flag, i.e., the requested sector was found during a write operation (read only) (address) */
#define FDC_WTREQ_ADDR 0xD083
/* F011 Write Request flag, i.e., the requested sector was found during a write operation (read only) (address) */
#define WTREQ_ADDR 0xD083
/* F011 Write Request flag, i.e., the requested sector was found during a write operation (read only) (bit mask) */
#define FDC_WTREQ_MASK 0b01000000
/* F011 Write Request flag, i.e., the requested sector was found during a write operation (read only) (bit mask) */
#define WTREQ_MASK 0b01000000
/* F011 Read Request flag, i.e., the requested sector was found during a read operation (read only) (address) */
#define FDC_RDREQ_ADDR 0xD083
/* F011 Read Request flag, i.e., the requested sector was found during a read operation (read only) (address) */
#define RDREQ_ADDR 0xD083
/* F011 Read Request flag, i.e., the requested sector was found during a read operation (read only) (bit mask) */
#define FDC_RDREQ_MASK 0b10000000
/* F011 Read Request flag, i.e., the requested sector was found during a read operation (read only) (bit mask) */
#define RDREQ_MASK 0b10000000
/* F011 FDC track selection register */
#define FDC_TRACK 0xD084
/* F011 FDC track selection register */
#define TRACK 0xD084
/* F011 FDC sector selection register */
#define FDC_SECTOR 0xD085
/* F011 FDC sector selection register */
#define SECTOR 0xD085
/* F011 FDC side selection register */
#define FDC_SIDE 0xD086
/* F011 FDC side selection register */
#define SIDE 0xD086
/* F011 FDC data register (read/write) for accessing the floppy controller's 512 byte sector buffer */
#define FDC_DATA 0xD087
/* Set or read the clock pattern to be used when writing address and data marks. Should normally be left $FF */
#define FDC_CLOCK 0xD088
/* Set or read the clock pattern to be used when writing address and data marks. Should normally be left $FF */
#define CLOCK 0xD088
/* Set or read the track stepping rate in 62.5 microsecond steps (normally 128, i.e., 8 milliseconds). */
#define FDC_STEP 0xD089
/* Set or read the track stepping rate in 62.5 microsecond steps (normally 128, i.e., 8 milliseconds). */
#define STEP 0xD089
/* (Read only) returns the protection code of the most recently read sector. Was intended for rudimentary copy protection. Not implemented. */
#define FDC_PCODE 0xD08A
/* (Read only) returns the protection code of the most recently read sector. Was intended for rudimentary copy protection. Not implemented. */
#define PCODE 0xD08A
/* Reserved for C65 RAM Expansion Controller. */
#define SUMMARY_REC 0xD0A0
/* Reserved for C65 RAM Expansion Controller. */
#define REC 0xD0A0
/* red palette values (reversed nybl order) */
#define VIC3_PALRED 0xD100
/* red palette values (reversed nybl order) */
#define PALRED 0xD100
/* green palette values (reversed nybl order) */
#define VIC3_PALGREEN 0xD200
/* green palette values (reversed nybl order) */
#define PALGREEN 0xD200
/* blue palette values (reversed nybl order) */
#define VIC3_PALBLUE 0xD300
/* blue palette values (reversed nybl order) */
#define PALBLUE 0xD300
/* Select VIC-IV debug stream via ethernet when \$D6E1.3 is set */
#define ETHCOMMAND_DEBUGVIC 0xD4
/* Select VIC-IV debug stream via ethernet when \$D6E1.3 is set */
#define DEBUGVIC 0xD4
/* UART data register (read or write) */
#define UART_DATA 0xD600
/* UART RX byte ready flag (clear by reading \$D600) (address) */
#define UART_RXRDY_ADDR 0xD601
/* UART RX byte ready flag (clear by reading \$D600) (address) */
#define RXRDY_ADDR 0xD601
/* UART RX byte ready flag (clear by reading \$D600) (bit mask) */
#define UART_RXRDY_MASK 0b00000001
/* UART RX byte ready flag (clear by reading \$D600) (bit mask) */
#define RXRDY_MASK 0b00000001
/* UART RX overrun flag (clear by reading \$D600) (address) */
#define UART_RXOVRRUN_ADDR 0xD601
/* UART RX overrun flag (clear by reading \$D600) (address) */
#define RXOVRRUN_ADDR 0xD601
/* UART RX overrun flag (clear by reading \$D600) (bit mask) */
#define UART_RXOVRRUN_MASK 0b00000010
/* UART RX overrun flag (clear by reading \$D600) (bit mask) */
#define RXOVRRUN_MASK 0b00000010
/* UART RX parity error flag (clear by reading \$D600) (address) */
#define UART_PTYERR_ADDR 0xD601
/* UART RX parity error flag (clear by reading \$D600) (address) */
#define PTYERR_ADDR 0xD601
/* UART RX parity error flag (clear by reading \$D600) (bit mask) */
#define UART_PTYERR_MASK 0b00000100
/* UART RX parity error flag (clear by reading \$D600) (bit mask) */
#define PTYERR_MASK 0b00000100
/* UART RX framing error flag (clear by reading \$D600) (address) */
#define UART_FRMERR_ADDR 0xD601
/* UART RX framing error flag (clear by reading \$D600) (address) */
#define FRMERR_ADDR 0xD601
/* UART RX framing error flag (clear by reading \$D600) (bit mask) */
#define UART_FRMERR_MASK 0b00001000
/* UART RX framing error flag (clear by reading \$D600) (bit mask) */
#define FRMERR_MASK 0b00001000
/* UART Parity: 1=even, 0=odd (address) */
#define UART_PTYEVEN_ADDR 0xD602
/* UART Parity: 1=even, 0=odd (address) */
#define PTYEVEN_ADDR 0xD602
/* UART Parity: 1=even, 0=odd (bit mask) */
#define UART_PTYEVEN_MASK 0b00000001
/* UART Parity: 1=even, 0=odd (bit mask) */
#define PTYEVEN_MASK 0b00000001
/* UART Parity enable: 1=enabled (address) */
#define UART_PTYEN_ADDR 0xD602
/* UART Parity enable: 1=enabled (address) */
#define PTYEN_ADDR 0xD602
/* UART Parity enable: 1=enabled (bit mask) */
#define UART_PTYEN_MASK 0b00000010
/* UART Parity enable: 1=enabled (bit mask) */
#define PTYEN_MASK 0b00000010
/* UART character size: 00=8, 01=7, 10=6, 11=5 bits per byte (address) */
#define UART_CHARSZ_ADDR 0xD602
/* UART character size: 00=8, 01=7, 10=6, 11=5 bits per byte (address) */
#define CHARSZ_ADDR 0xD602
/* UART character size: 00=8, 01=7, 10=6, 11=5 bits per byte (bit mask) */
#define UART_CHARSZ_MASK 0b00001100
/* UART character size: 00=8, 01=7, 10=6, 11=5 bits per byte (bit mask) */
#define CHARSZ_MASK 0b00001100
/* UART synchronisation mode flags (00=RX \& TX both async, 01=RX sync, TX async, 1x=TX sync, RX async (unused on the MEGA65) (address) */
#define UART_SYNCMOD_ADDR 0xD602
/* UART synchronisation mode flags (00=RX \& TX both async, 01=RX sync, TX async, 1x=TX sync, RX async (unused on the MEGA65) (address) */
#define SYNCMOD_ADDR 0xD602
/* UART synchronisation mode flags (00=RX \& TX both async, 01=RX sync, TX async, 1x=TX sync, RX async (unused on the MEGA65) (bit mask) */
#define UART_SYNCMOD_MASK 0b00110000
/* UART synchronisation mode flags (00=RX \& TX both async, 01=RX sync, TX async, 1x=TX sync, RX async (unused on the MEGA65) (bit mask) */
#define SYNCMOD_MASK 0b00110000
/* UART enable receive (address) */
#define UART_RXEN_ADDR 0xD602
/* UART enable receive (address) */
#define RXEN_ADDR 0xD602
/* UART enable receive (bit mask) */
#define UART_RXEN_MASK 0b01000000
/* UART enable receive (bit mask) */
#define RXEN_MASK 0b01000000
/* UART enable transmit (address) */
#define UART_TXEN_ADDR 0xD602
/* UART enable transmit (address) */
#define TXEN_ADDR 0xD602
/* UART enable transmit (bit mask) */
#define UART_TXEN_MASK 0b10000000
/* UART enable transmit (bit mask) */
#define TXEN_MASK 0b10000000
/* UART baud rate divisor (16 bit). Baud rate = 7.09375MHz / DIVISOR, unless MEGA65 fast UART mode is enabled, in which case baud rate = 80MHz / DIVISOR */
#define UART_DIVISOR 0xD603
/* UART baud rate divisor (16 bit). Baud rate = 7.09375MHz / DIVISOR, unless MEGA65 fast UART mode is enabled, in which case baud rate = 80MHz / DIVISOR */
#define C65_UART_DIVISOR 0xD604
/* UART interrupt mask: NMI on RX (not yet implemented on the MEGA65) (address) */
#define UART_IMRXNMI_ADDR 0xD605
/* UART interrupt mask: NMI on RX (not yet implemented on the MEGA65) (address) */
#define IMRXNMI_ADDR 0xD605
/* UART interrupt mask: NMI on RX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IMRXNMI_MASK 0b00010000
/* UART interrupt mask: NMI on RX (not yet implemented on the MEGA65) (bit mask) */
#define IMRXNMI_MASK 0b00010000
/* UART interrupt mask: NMI on TX (not yet implemented on the MEGA65) (address) */
#define UART_IMTXNMI_ADDR 0xD605
/* UART interrupt mask: NMI on TX (not yet implemented on the MEGA65) (address) */
#define IMTXNMI_ADDR 0xD605
/* UART interrupt mask: NMI on TX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IMTXNMI_MASK 0b00100000
/* UART interrupt mask: NMI on TX (not yet implemented on the MEGA65) (bit mask) */
#define IMTXNMI_MASK 0b00100000
/* UART interrupt mask: IRQ on RX (not yet implemented on the MEGA65) (address) */
#define UART_IMRXIRQ_ADDR 0xD605
/* UART interrupt mask: IRQ on RX (not yet implemented on the MEGA65) (address) */
#define IMRXIRQ_ADDR 0xD605
/* UART interrupt mask: IRQ on RX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IMRXIRQ_MASK 0b01000000
/* UART interrupt mask: IRQ on RX (not yet implemented on the MEGA65) (bit mask) */
#define IMRXIRQ_MASK 0b01000000
/* UART interrupt mask: IRQ on TX (not yet implemented on the MEGA65) (address) */
#define UART_IMTXIRQ_ADDR 0xD605
/* UART interrupt mask: IRQ on TX (not yet implemented on the MEGA65) (address) */
#define IMTXIRQ_ADDR 0xD605
/* UART interrupt mask: IRQ on TX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IMTXIRQ_MASK 0b10000000
/* UART interrupt mask: IRQ on TX (not yet implemented on the MEGA65) (bit mask) */
#define IMTXIRQ_MASK 0b10000000
/* UART interrupt flag: NMI on RX (not yet implemented on the MEGA65) (address) */
#define UART_IFRXNMI_ADDR 0xD606
/* UART interrupt flag: NMI on RX (not yet implemented on the MEGA65) (address) */
#define IFRXNMI_ADDR 0xD606
/* UART interrupt flag: NMI on RX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IFRXNMI_MASK 0b00010000
/* UART interrupt flag: NMI on RX (not yet implemented on the MEGA65) (bit mask) */
#define IFRXNMI_MASK 0b00010000
/* UART interrupt flag: NMI on TX (not yet implemented on the MEGA65) (address) */
#define UART_IFTXNMI_ADDR 0xD606
/* UART interrupt flag: NMI on TX (not yet implemented on the MEGA65) (address) */
#define IFTXNMI_ADDR 0xD606
/* UART interrupt flag: NMI on TX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IFTXNMI_MASK 0b00100000
/* UART interrupt flag: NMI on TX (not yet implemented on the MEGA65) (bit mask) */
#define IFTXNMI_MASK 0b00100000
/* UART interrupt flag: IRQ on RX (not yet implemented on the MEGA65) (address) */
#define UART_IFRXIRQ_ADDR 0xD606
/* UART interrupt flag: IRQ on RX (not yet implemented on the MEGA65) (address) */
#define IFRXIRQ_ADDR 0xD606
/* UART interrupt flag: IRQ on RX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IFRXIRQ_MASK 0b01000000
/* UART interrupt flag: IRQ on RX (not yet implemented on the MEGA65) (bit mask) */
#define IFRXIRQ_MASK 0b01000000
/* UART interrupt flag: IRQ on TX (not yet implemented on the MEGA65) (address) */
#define UART_IFTXIRQ_ADDR 0xD606
/* UART interrupt flag: IRQ on TX (not yet implemented on the MEGA65) (address) */
#define IFTXIRQ_ADDR 0xD606
/* UART interrupt flag: IRQ on TX (not yet implemented on the MEGA65) (bit mask) */
#define UART_IFTXIRQ_MASK 0b10000000
/* UART interrupt flag: IRQ on TX (not yet implemented on the MEGA65) (bit mask) */
#define IFTXIRQ_MASK 0b10000000
/* C65 capslock key sense (address) */
#define UART_CAPLOCK_ADDR 0xD607
/* C65 capslock key sense (address) */
#define CAPLOCK_ADDR 0xD607
/* C65 capslock key sense (bit mask) */
#define UART_CAPLOCK_MASK 0b00000001
/* C65 capslock key sense (bit mask) */
#define CAPLOCK_MASK 0b00000001
/* C65 keyboard column 8 select (address) */
#define UART_KEYCOL8_ADDR 0xD607
/* C65 keyboard column 8 select (address) */
#define KEYCOL8_ADDR 0xD607
/* C65 keyboard column 8 select (bit mask) */
#define UART_KEYCOL8_MASK 0b00000010
/* C65 keyboard column 8 select (bit mask) */
#define KEYCOL8_MASK 0b00000010
/* C65 keyboard extra lines Data Direction Register (DDR) (address) */
#define UART_PORTEDDR_ADDR 0xD608
/* C65 keyboard extra lines Data Direction Register (DDR) (address) */
#define PORTEDDR_ADDR 0xD608
/* C65 keyboard extra lines Data Direction Register (DDR) (bit mask) */
#define UART_PORTEDDR_MASK 0b00000011
/* C65 keyboard extra lines Data Direction Register (DDR) (bit mask) */
#define PORTEDDR_MASK 0b00000011
/* C65 UART BAUD clock source: 1 = 7.09375MHz, 0 = 80MHz (VIC-IV pixel clock) (address) */
#define UARTMISC_UFAST_ADDR 0xD609
/* C65 UART BAUD clock source: 1 = 7.09375MHz, 0 = 80MHz (VIC-IV pixel clock) (address) */
#define UFAST_ADDR 0xD609
/* C65 UART BAUD clock source: 1 = 7.09375MHz, 0 = 80MHz (VIC-IV pixel clock) (bit mask) */
#define UARTMISC_UFAST_MASK 0b00000001
/* C65 UART BAUD clock source: 1 = 7.09375MHz, 0 = 80MHz (VIC-IV pixel clock) (bit mask) */
#define UFAST_MASK 0b00000001
/* PMOD port A on FPGA board (data) (Nexys4 boards only) (address) */
#define UARTMISC_PORTF_ADDR 0xD60B
/* PMOD port A on FPGA board (data) (Nexys4 boards only) (address) */
#define PORTF_ADDR 0xD60B
/* PMOD port A on FPGA board (data) (Nexys4 boards only) (bit mask) */
#define UARTMISC_PORTF_MASK 0b00111111
/* PMOD port A on FPGA board (data) (Nexys4 boards only) (bit mask) */
#define PORTF_MASK 0b00111111
/* Display hardware zoom of region under first touch point always (address) */
#define UARTMISC_OSKZON_ADDR 0xD60B
/* Display hardware zoom of region under first touch point always (address) */
#define OSKZON_ADDR 0xD60B
/* Display hardware zoom of region under first touch point always (bit mask) */
#define UARTMISC_OSKZON_MASK 0b01000000
/* Display hardware zoom of region under first touch point always (bit mask) */
#define OSKZON_MASK 0b01000000
/* Display hardware zoom of region under first touch point for on-screen keyboard (address) */
#define UARTMISC_OSKZEN_ADDR 0xD60B
/* Display hardware zoom of region under first touch point for on-screen keyboard (address) */
#define OSKZEN_ADDR 0xD60B
/* Display hardware zoom of region under first touch point for on-screen keyboard (bit mask) */
#define UARTMISC_OSKZEN_MASK 0b10000000
/* Display hardware zoom of region under first touch point for on-screen keyboard (bit mask) */
#define OSKZEN_MASK 0b10000000
/* PMOD port A on FPGA board (DDR) (address) */
#define UARTMISC_PORTFDDR_ADDR 0xD60C
/* PMOD port A on FPGA board (DDR) (bit mask) */
#define UARTMISC_PORTFDDR_MASK 0b00111111
/* On Screen Keyboard (OSK) Zoom Control Data Direction Register (DDR). Must be set to output to control these features. (address) */
#define GS_UARTMISC_PORTFDDR_ADDR 0xD60C
/* On Screen Keyboard (OSK) Zoom Control Data Direction Register (DDR). Must be set to output to control these features. (bit mask) */
#define GS_UARTMISC_PORTFDDR_MASK 0b11000000
/* Internal 1541 drive connect (1=connect internal 1541 drive to IEC bus) (address) */
#define UARTMISC_CONN41_ADDR 0xD60D
/* Internal 1541 drive connect (1=connect internal 1541 drive to IEC bus) (address) */
#define CONN41_ADDR 0xD60D
/* Internal 1541 drive connect (1=connect internal 1541 drive to IEC bus) (bit mask) */
#define UARTMISC_CONN41_MASK 0b00000001
/* Internal 1541 drive connect (1=connect internal 1541 drive to IEC bus) (bit mask) */
#define CONN41_MASK 0b00000001
/* Internal 1541 drive reset (1=reset, 0=operate) (address) */
#define UARTMISC_RST41_ADDR 0xD60D
/* Internal 1541 drive reset (1=reset, 0=operate) (address) */
#define RST41_ADDR 0xD60D
/* Internal 1541 drive reset (1=reset, 0=operate) (bit mask) */
#define UARTMISC_RST41_MASK 0b00000010
/* Internal 1541 drive reset (1=reset, 0=operate) (bit mask) */
#define RST41_MASK 0b00000010
/* SD card MOSI/MISO (address) */
#define UARTMISC_SDDATA_ADDR 0xD60D
/* SD card MOSI/MISO (address) */
#define SDDATA_ADDR 0xD60D
/* SD card MOSI/MISO (bit mask) */
#define UARTMISC_SDDATA_MASK 0b00000100
/* SD card MOSI/MISO (bit mask) */
#define SDDATA_MASK 0b00000100
/* SD card SCLK (address) */
#define UARTMISC_SDCLK_ADDR 0xD60D
/* SD card SCLK (address) */
#define SDCLK_ADDR 0xD60D
/* SD card SCLK (bit mask) */
#define UARTMISC_SDCLK_MASK 0b00001000
/* SD card SCLK (bit mask) */
#define SDCLK_MASK 0b00001000
/* SD card CS_BO (address) */
#define UARTMISC_SDCS_ADDR 0xD60D
/* SD card CS_BO (address) */
#define SDCS_ADDR 0xD60D
/* SD card CS_BO (bit mask) */
#define UARTMISC_SDCS_MASK 0b00010000
/* SD card CS_BO (bit mask) */
#define SDCS_MASK 0b00010000
/* Enable SD card bitbash mode (address) */
#define UARTMISC_SDBSH_ADDR 0xD60D
/* Enable SD card bitbash mode (address) */
#define SDBSH_ADDR 0xD60D
/* Enable SD card bitbash mode (bit mask) */
#define UARTMISC_SDBSH_MASK 0b00100000
/* Enable SD card bitbash mode (bit mask) */
#define SDBSH_MASK 0b00100000
/* HDMI I2C control interface SDA data line (address) */
#define UARTMISC_HDSDA_ADDR 0xD60D
/* HDMI I2C control interface SDA data line (address) */
#define HDSDA_ADDR 0xD60D
/* HDMI I2C control interface SDA data line (bit mask) */
#define UARTMISC_HDSDA_MASK 0b01000000
/* HDMI I2C control interface SDA data line (bit mask) */
#define HDSDA_MASK 0b01000000
/* HDMI I2C control interface SCL clock (address) */
#define UARTMISC_HDSCL_ADDR 0xD60D
/* HDMI I2C control interface SCL clock (address) */
#define HDSCL_ADDR 0xD60D
/* HDMI I2C control interface SCL clock (bit mask) */
#define UARTMISC_HDSCL_MASK 0b10000000
/* HDMI I2C control interface SCL clock (bit mask) */
#define HDSCL_MASK 0b10000000
/* Data Direction Register (DDR) for \$D60D bit bashing port. */
#define UARTMISC_BASHDDR 0xD60E
/* Data Direction Register (DDR) for \$D60D bit bashing port. */
#define BASHDDR 0xD60E
/* Directly read C65 Cursor left key (address) */
#define UARTMISC_KEYLEFT_ADDR 0xD60F
/* Directly read C65 Cursor left key (address) */
#define KEYLEFT_ADDR 0xD60F
/* Directly read C65 Cursor left key (bit mask) */
#define UARTMISC_KEYLEFT_MASK 0b00000001
/* Directly read C65 Cursor left key (bit mask) */
#define KEYLEFT_MASK 0b00000001
/* Directly read C65 Cursor up key (address) */
#define UARTMISC_KEYUP_ADDR 0xD60F
/* Directly read C65 Cursor up key (address) */
#define KEYUP_ADDR 0xD60F
/* Directly read C65 Cursor up key (bit mask) */
#define UARTMISC_KEYUP_MASK 0b00000010
/* Directly read C65 Cursor up key (bit mask) */
#define KEYUP_MASK 0b00000010
/* Set to 1 if the MEGA65 is running on real hardware, set to 0 if emulated (Xemu) or simulated (ghdl) (address) */
#define UARTMISC_REALHW_ADDR 0xD60F
/* Set to 1 if the MEGA65 is running on real hardware, set to 0 if emulated (Xemu) or simulated (ghdl) (address) */
#define REALHW_ADDR 0xD60F
/* Set to 1 if the MEGA65 is running on real hardware, set to 0 if emulated (Xemu) or simulated (ghdl) (bit mask) */
#define UARTMISC_REALHW_MASK 0b00100000
/* Set to 1 if the MEGA65 is running on real hardware, set to 0 if emulated (Xemu) or simulated (ghdl) (bit mask) */
#define REALHW_MASK 0b00100000
/* Light or heavy dimming of background material behind on-screen keyboard (address) */
#define UARTMISC_OSKDIM_ADDR 0xD60F
/* Light or heavy dimming of background material behind on-screen keyboard (address) */
#define OSKDIM_ADDR 0xD60F
/* Light or heavy dimming of background material behind on-screen keyboard (bit mask) */
#define UARTMISC_OSKDIM_MASK 0b01000000
/* Light or heavy dimming of background material behind on-screen keyboard (bit mask) */
#define OSKDIM_MASK 0b01000000
/* Enable accessible keyboard input via joystick port 2 fire button (address) */
#define UARTMISC_ACCESSKEY_ADDR 0xD60F
/* Enable accessible keyboard input via joystick port 2 fire button (address) */
#define ACCESSKEY_ADDR 0xD60F
/* Enable accessible keyboard input via joystick port 2 fire button (bit mask) */
#define UARTMISC_ACCESSKEY_MASK 0b10000000
/* Enable accessible keyboard input via joystick port 2 fire button (bit mask) */
#define ACCESSKEY_MASK 0b10000000
/* Last key press as ASCII (hardware accelerated keyboard scanner). Write to clear event ready for next. */
#define UARTMISC_ASCIIKEY 0xD610
/* Last key press as ASCII (hardware accelerated keyboard scanner). Write to clear event ready for next. */
#define ASCIIKEY 0xD610
/* Right shift key state (hardware accelerated keyboard scanner). (address) */
#define UARTMISC_MRSHFT_ADDR 0xD611
/* Right shift key state (hardware accelerated keyboard scanner). (address) */
#define MRSHFT_ADDR 0xD611
/* Right shift key state (hardware accelerated keyboard scanner). (bit mask) */
#define UARTMISC_MRSHFT_MASK 0b00000001
/* Right shift key state (hardware accelerated keyboard scanner). (bit mask) */
#define MRSHFT_MASK 0b00000001
/* Left shift key state (hardware accelerated keyboard scanner). (address) */
#define UARTMISC_MLSHFT_ADDR 0xD611
/* Left shift key state (hardware accelerated keyboard scanner). (address) */
#define MLSHFT_ADDR 0xD611
/* Left shift key state (hardware accelerated keyboard scanner). (bit mask) */
#define UARTMISC_MLSHFT_MASK 0b00000010
/* Left shift key state (hardware accelerated keyboard scanner). (bit mask) */
#define MLSHFT_MASK 0b00000010
/* CTRL key state (hardware accelerated keyboard scanner). (address) */
#define UARTMISC_MCTRL_ADDR 0xD611
/* CTRL key state (hardware accelerated keyboard scanner). (address) */
#define MCTRL_ADDR 0xD611
/* CTRL key state (hardware accelerated keyboard scanner). (bit mask) */
#define UARTMISC_MCTRL_MASK 0b00000100
/* CTRL key state (hardware accelerated keyboard scanner). (bit mask) */
#define MCTRL_MASK 0b00000100
/* MEGA/C= key state (hardware accelerated keyboard scanner). (address) */
#define UARTMISC_MMEGA_ADDR 0xD611
/* MEGA/C= key state (hardware accelerated keyboard scanner). (address) */
#define MMEGA_ADDR 0xD611
/* MEGA/C= key state (hardware accelerated keyboard scanner). (bit mask) */
#define UARTMISC_MMEGA_MASK 0b00001000
/* MEGA/C= key state (hardware accelerated keyboard scanner). (bit mask) */
#define MMEGA_MASK 0b00001000
/* ALT key state (hardware accelerated keyboard scanner). (address) */
#define UARTMISC_MALT_ADDR 0xD611
/* ALT key state (hardware accelerated keyboard scanner). (address) */
#define MALT_ADDR 0xD611
/* ALT key state (hardware accelerated keyboard scanner). (bit mask) */
#define UARTMISC_MALT_MASK 0b00010000
/* ALT key state (hardware accelerated keyboard scanner). (bit mask) */
#define MALT_MASK 0b00010000
/* NOSCRL key state (hardware accelerated keyboard scanner). (address) */
#define UARTMISC_MSCRL_ADDR 0xD611
/* NOSCRL key state (hardware accelerated keyboard scanner). (address) */
#define MSCRL_ADDR 0xD611
/* NOSCRL key state (hardware accelerated keyboard scanner). (bit mask) */
#define UARTMISC_MSCRL_MASK 0b00100000
/* NOSCRL key state (hardware accelerated keyboard scanner). (bit mask) */
#define MSCRL_MASK 0b00100000
/* CAPS LOCK key state (hardware accelerated keyboard scanner). (address) */
#define UARTMISC_MCAPS_ADDR 0xD611
/* CAPS LOCK key state (hardware accelerated keyboard scanner). (address) */
#define MCAPS_ADDR 0xD611
/* CAPS LOCK key state (hardware accelerated keyboard scanner). (bit mask) */
#define UARTMISC_MCAPS_MASK 0b01000000
/* CAPS LOCK key state (hardware accelerated keyboard scanner). (bit mask) */
#define MCAPS_MASK 0b01000000
/* Enable widget board keyboard/joystick input (address) */
#define UARTMISC_WGTKEY_ADDR 0xD612
/* Enable widget board keyboard/joystick input (address) */
#define WGTKEY_ADDR 0xD612
/* Enable widget board keyboard/joystick input (bit mask) */
#define UARTMISC_WGTKEY_MASK 0b00000001
/* Enable widget board keyboard/joystick input (bit mask) */
#define WGTKEY_MASK 0b00000001
/* Enable ps2 keyboard/joystick input (address) */
#define UARTMISC_PS2KEY_ADDR 0xD612
/* Enable ps2 keyboard/joystick input (address) */
#define PS2KEY_ADDR 0xD612
/* Enable ps2 keyboard/joystick input (bit mask) */
#define UARTMISC_PS2KEY_MASK 0b00000010
/* Enable ps2 keyboard/joystick input (bit mask) */
#define PS2KEY_MASK 0b00000010
/* Enable physical keyboard input (address) */
#define UARTMISC_PHYKEY_ADDR 0xD612
/* Enable physical keyboard input (address) */
#define PHYKEY_ADDR 0xD612
/* Enable physical keyboard input (bit mask) */
#define UARTMISC_PHYKEY_MASK 0b00000100
/* Enable physical keyboard input (bit mask) */
#define PHYKEY_MASK 0b00000100
/* Enable virtual/snythetic keyboard input (address) */
#define UARTMISC_VRTKEY_ADDR 0xD612
/* Enable virtual/snythetic keyboard input (address) */
#define VRTKEY_ADDR 0xD612
/* Enable virtual/snythetic keyboard input (bit mask) */
#define UARTMISC_VRTKEY_MASK 0b00001000
/* Enable virtual/snythetic keyboard input (bit mask) */
#define VRTKEY_MASK 0b00001000
/* Debug OSK overlay (WRITE ONLY) (address) */
#define UARTMISC_OSKDEBUG_ADDR 0xD612
/* Debug OSK overlay (WRITE ONLY) (address) */
#define OSKDEBUG_ADDR 0xD612
/* Debug OSK overlay (WRITE ONLY) (bit mask) */
#define UARTMISC_OSKDEBUG_MASK 0b00010000
/* Debug OSK overlay (WRITE ONLY) (bit mask) */
#define OSKDEBUG_MASK 0b00010000
/* Enable PS/2 / USB keyboard simulated joystick input (address) */
#define UARTMISC_PS2JOY_ADDR 0xD612
/* Enable PS/2 / USB keyboard simulated joystick input (address) */
#define PS2JOY_ADDR 0xD612
/* Enable PS/2 / USB keyboard simulated joystick input (bit mask) */
#define UARTMISC_PS2JOY_MASK 0b00010000
/* Enable PS/2 / USB keyboard simulated joystick input (bit mask) */
#define PS2JOY_MASK 0b00010000
/* Exchange joystick ports 1 \& 2 (address) */
#define UARTMISC_JOYSWAP_ADDR 0xD612
/* Exchange joystick ports 1 \& 2 (address) */
#define JOYSWAP_ADDR 0xD612
/* Exchange joystick ports 1 \& 2 (bit mask) */
#define UARTMISC_JOYSWAP_MASK 0b00100000
/* Exchange joystick ports 1 \& 2 (bit mask) */
#define JOYSWAP_MASK 0b00100000
/* Rotate inputs of joystick A by 180 degrees (for left handed use) (address) */
#define UARTMISC_LJOYA_ADDR 0xD612
/* Rotate inputs of joystick A by 180 degrees (for left handed use) (address) */
#define LJOYA_ADDR 0xD612
/* Rotate inputs of joystick A by 180 degrees (for left handed use) (bit mask) */
#define UARTMISC_LJOYA_MASK 0b01000000
/* Rotate inputs of joystick A by 180 degrees (for left handed use) (bit mask) */
#define LJOYA_MASK 0b01000000
/* Rotate inputs of joystick B by 180 degrees (for left handed use) (address) */
#define UARTMISC_LJOYB_ADDR 0xD612
/* Rotate inputs of joystick B by 180 degrees (for left handed use) (address) */
#define LJOYB_ADDR 0xD612
/* Rotate inputs of joystick B by 180 degrees (for left handed use) (bit mask) */
#define UARTMISC_LJOYB_MASK 0b10000000
/* Rotate inputs of joystick B by 180 degrees (for left handed use) (bit mask) */
#define LJOYB_MASK 0b10000000
/* Count of cartridge port memory accesses (read only) */
#define DEBUG_CRTACSCNT 0xD613
/* Count of cartridge port memory accesses (read only) */
#define CRTACSCNT 0xD613
/* 8-bit segment of combined keyboard matrix (READ) */
#define DEBUG_KEYMATRIXPEEK 0xD614
/* 8-bit segment of combined keyboard matrix (READ) */
#define KEYMATRIXPEEK 0xD614
/* Set to \$7F for no key down, else specify virtual key press. (address) */
#define UARTMISC_VIRTKEY1_ADDR 0xD615
/* Set to \$7F for no key down, else specify virtual key press. (address) */
#define VIRTKEY1_ADDR 0xD615
/* Set to \$7F for no key down, else specify virtual key press. (bit mask) */
#define UARTMISC_VIRTKEY1_MASK 0b01111111
/* Set to \$7F for no key down, else specify virtual key press. (bit mask) */
#define VIRTKEY1_MASK 0b01111111
/* Enable display of on-screen keyboard composited overlay (address) */
#define UARTMISC_OSKEN_ADDR 0xD615
/* Enable display of on-screen keyboard composited overlay (address) */
#define OSKEN_ADDR 0xD615
/* Enable display of on-screen keyboard composited overlay (bit mask) */
#define UARTMISC_OSKEN_MASK 0b10000000
/* Enable display of on-screen keyboard composited overlay (bit mask) */
#define OSKEN_MASK 0b10000000
/* Set to \$7F for no key down, else specify 2nd virtual key press. (address) */
#define UARTMISC_VIRTKEY2_ADDR 0xD616
/* Set to \$7F for no key down, else specify 2nd virtual key press. (address) */
#define VIRTKEY2_ADDR 0xD616
/* Set to \$7F for no key down, else specify 2nd virtual key press. (bit mask) */
#define UARTMISC_VIRTKEY2_MASK 0b01111111
/* Set to \$7F for no key down, else specify 2nd virtual key press. (bit mask) */
#define VIRTKEY2_MASK 0b01111111
/* Display alternate on-screen keyboard layout (typically dial pad for MEGA65 telephone) (address) */
#define UARTMISC_OSKALT_ADDR 0xD616
/* Display alternate on-screen keyboard layout (typically dial pad for MEGA65 telephone) (address) */
#define OSKALT_ADDR 0xD616
/* Display alternate on-screen keyboard layout (typically dial pad for MEGA65 telephone) (bit mask) */
#define UARTMISC_OSKALT_MASK 0b10000000
/* Display alternate on-screen keyboard layout (typically dial pad for MEGA65 telephone) (bit mask) */
#define OSKALT_MASK 0b10000000
/* Set to \$7F for no key down, else specify 3nd virtual key press. (address) */
#define UARTMISC_VIRTKEY3_ADDR 0xD617
/* Set to \$7F for no key down, else specify 3nd virtual key press. (address) */
#define VIRTKEY3_ADDR 0xD617
/* Set to \$7F for no key down, else specify 3nd virtual key press. (bit mask) */
#define UARTMISC_VIRTKEY3_MASK 0b01111111
/* Set to \$7F for no key down, else specify 3nd virtual key press. (bit mask) */
#define VIRTKEY3_MASK 0b01111111
/* 1=Display on-screen keyboard at top, 0=Disply on-screen keyboard at bottom of screen. (address) */
#define UARTMISC_OSKTOP_ADDR 0xD617
/* 1=Display on-screen keyboard at top, 0=Disply on-screen keyboard at bottom of screen. (address) */
#define OSKTOP_ADDR 0xD617
/* 1=Display on-screen keyboard at top, 0=Disply on-screen keyboard at bottom of screen. (bit mask) */
#define UARTMISC_OSKTOP_MASK 0b10000000
/* 1=Display on-screen keyboard at top, 0=Disply on-screen keyboard at bottom of screen. (bit mask) */
#define OSKTOP_MASK 0b10000000
/* Physical keyboard scan rate (\$00=50MHz, \$FF=~200KHz) */
#define UARTMISC_KSCNRATE 0xD618
/* Physical keyboard scan rate (\$00=50MHz, \$FF=~200KHz) */
#define KSCNRATE 0xD618
/* port o output value */
#define UARTMISC_UNUSED 0xD619
/* port o output value */
#define UNUSED 0xD619
/* System control flags (target specific) */
#define UARTMISC_SYSCTL 0xD61A
/* System control flags (target specific) */
#define SYSCTL 0xD61A
/* Mute digital video audio (MEGA65 R2 only) (address) */
#define SYSCTL_AUDMUTE_ADDR 0xD61A
/* Mute digital video audio (MEGA65 R2 only) (address) */
#define AUDMUTE_ADDR 0xD61A
/* Mute digital video audio (MEGA65 R2 only) (bit mask) */
#define SYSCTL_AUDMUTE_MASK 0b00000001
/* Mute digital video audio (MEGA65 R2 only) (bit mask) */
#define AUDMUTE_MASK 0b00000001
/* Control digital video as DVI (disables audio) (address) */
#define SYSCTL_DVI_ADDR 0xD61A
/* Control digital video as DVI (disables audio) (address) */
#define DVI_ADDR 0xD61A
/* Control digital video as DVI (disables audio) (bit mask) */
#define SYSCTL_DVI_MASK 0b00000010
/* Control digital video as DVI (disables audio) (bit mask) */
#define DVI_MASK 0b00000010
/* Visualise audio samples (DEBUG) (address) */
#define SYSCTL_AUDDBG_ADDR 0xD61A
/* Visualise audio samples (DEBUG) (address) */
#define AUDDBG_ADDR 0xD61A
/* Visualise audio samples (DEBUG) (bit mask) */
#define SYSCTL_AUDDBG_MASK 0b00000100
/* Visualise audio samples (DEBUG) (bit mask) */
#define AUDDBG_MASK 0b00000100
/* Select 48KHz or 44.1KHz digital video audio sample rate (address) */
#define SYSCTL_AUD48K_ADDR 0xD61A
/* Select 48KHz or 44.1KHz digital video audio sample rate (address) */
#define AUD48K_ADDR 0xD61A
/* Select 48KHz or 44.1KHz digital video audio sample rate (bit mask) */
#define SYSCTL_AUD48K_MASK 0b00001000
/* Select 48KHz or 44.1KHz digital video audio sample rate (bit mask) */
#define AUD48K_MASK 0b00001000
/* Control LED next to U1 on mother board (address) */
#define SYSCTL_LED_ADDR 0xD61A
/* Control LED next to U1 on mother board (bit mask) */
#define SYSCTL_LED_MASK 0b00010000
/* Invert digital video audio sample values (address) */
#define SYSCTL_AUDINV_ADDR 0xD61A
/* Invert digital video audio sample values (address) */
#define AUDINV_ADDR 0xD61A
/* Invert digital video audio sample values (bit mask) */
#define SYSCTL_AUDINV_MASK 0b10000000
/* Invert digital video audio sample values (bit mask) */
#define AUDINV_MASK 0b10000000
/* READ 1351/amiga mouse auto detection DEBUG */
#define DEBUG_AMIMOUSDETECT 0xD61B
/* READ 1351/amiga mouse auto detection DEBUG */
#define AMIMOUSDETECT 0xD61B
/* internal 1541 PC LSB */
#define DEBUG__1541PCLSB 0xD61C
/* internal 1541 PC LSB */
#define _1541PCLSB 0xD61C
/* LED register select (R,G,B channels x 4 = 0 to 11) (address) */
#define UARTMISC_Keyboard_ADDR 0xD61D
/* LED register select (R,G,B channels x 4 = 0 to 11) (bit mask) */
#define UARTMISC_Keyboard_MASK 0b01111111
/* LED control enable (address) */
#define GS_UARTMISC_Keyboard_ADDR 0xD61D
/* LED control enable (bit mask) */
#define GS_UARTMISC_Keyboard_MASK 0b10000000
/* register value (write only) */
#define UARTMISC_Keyboard 0xD61E
/* register value (write only) */
#define Keyboard 0xD61E
/* DUPLICATE Modifier key state (hardware accelerated keyboard scanner). */
#define DEBUG_BUCKYCOPY 0xD61F
/* DUPLICATE Modifier key state (hardware accelerated keyboard scanner). */
#define BUCKYCOPY 0xD61F
/* Read Port A paddle X, without having to fiddle with SID/CIA settings. */
#define UARTMISC_POTAX 0xD620
/* Read Port A paddle X, without having to fiddle with SID/CIA settings. */
#define POTAX 0xD620
/* Read Port A paddle Y, without having to fiddle with SID/CIA settings. */
#define UARTMISC_POTAY 0xD621
/* Read Port A paddle Y, without having to fiddle with SID/CIA settings. */
#define POTAY 0xD621
/* Read Port B paddle X, without having to fiddle with SID/CIA settings. */
#define UARTMISC_POTBX 0xD622
/* Read Port B paddle X, without having to fiddle with SID/CIA settings. */
#define POTBX 0xD622
/* Read Port B paddle Y, without having to fiddle with SID/CIA settings. */
#define UARTMISC_POTBY 0xD623
/* Read Port B paddle Y, without having to fiddle with SID/CIA settings. */
#define POTBY 0xD623
/* READ ONLY flags for paddles. See c65uart.vhdl for more information. */
#define DEBUG_POTDEBUG 0xD624
/* READ ONLY flags for paddles. See c65uart.vhdl for more information. */
#define POTDEBUG 0xD624
/* J21 pins 1 -- 6, 9 -- 10 input/output values */
#define UARTMISC_J21L 0xD625
/* J21 pins 1 -- 6, 9 -- 10 input/output values */
#define J21L 0xD625
/* J21 pins 11 -- 14 input/output values */
#define UARTMISC_J21H 0xD626
/* J21 pins 11 -- 14 input/output values */
#define J21H 0xD626
/* J21 pins 1 -- 6, 9 -- 10 data direction register */
#define UARTMISC_J21LDDR 0xD627
/* J21 pins 1 -- 6, 9 -- 10 data direction register */
#define J21LDDR 0xD627
/* J21 pins 11 -- 14 data direction register */
#define UARTMISC_J21HDDR 0xD628
/* J21 pins 11 -- 14 data direction register */
#define J21HDDR 0xD628
/* MEGA65 model ID. Can be used to determine the model of MEGA65 a programme is running on, e.g., to enable touch controls on MEGAphone. */
#define UARTMISC_M65MODEL 0xD629
/* MEGA65 model ID. Can be used to determine the model of MEGA65 a programme is running on, e.g., to enable touch controls on MEGAphone. */
#define M65MODEL 0xD629
/* LSB of keyboard firmware date stamp (days since 1 Jan 2020) */
#define KBD_FWDATEL 0xD62A
/* MSB of keyboard firmware date stamp (days since 1 Jan 2020) */
#define KBD_FWDATEH 0xD62B
/* LSB of keyboard firmware git commit */
#define KBD_FWGIT0 0xD62C
/* 2nd byte of keyboard firmware git commit */
#define GS_KBD_FWGIT0 0xD62D
/* 3rd byte of keyboard firmware git commit */
#define GS_KBD_FWGIT0_2 0xD62E
/* MSB of keyboard firmware git commit */
#define GS_KBD_FWGIT0_3 0xD62F
/* LSB of MEGA65 FPGA design date stamp (days since 1 Jan 2020) */
#define FPGA_FWDATEL 0xD630
/* MSB of MEGA65 FPGA design date stamp (days since 1 Jan 2020) */
#define FPGA_FWDATEH 0xD631
/* LSB of MEGA65 FPGA design git commit */
#define FPGA_FWGIT0 0xD632
/* 2nd byte of MEGA65 FPGA design git commit */
#define GS_FPGA_FWGIT0 0xD633
/* 3rd byte of MEGA65 FPGA design git commit */
#define GS_FPGA_FWGIT0_2 0xD634
/* MSB of MEGA65 FPGA design git commit */
#define GS_FPGA_FWGIT0_3 0xD635
/* LSB of Auxilliary (MAX10) FPGA design date stamp (days since 1 Jan 2020) */
#define AUXFPGA_FWDATEL 0xD636
/* MSB of Auxilliary (MAX10) FPGA design date stamp (days since 1 Jan 2020) */
#define AUXFPGA_MFWDATEH 0xD637
/* MSB of Auxilliary (MAX10) FPGA design date stamp (days since 1 Jan 2020) */
#define MFWDATEH 0xD637
/* LSB of Auxilliary (MAX10) FPGA design git commit */
#define AUXFPGA_FWGIT0 0xD638
/* 2nd byte of Auxilliary (MAX10) FPGA design git commit */
#define GS_AUXFPGA_FWGIT0 0xD639
/* 3rd byte of Auxilliary (MAX10) FPGA design git commit */
#define GS_AUXFPGA_FWGIT0_2 0xD63A
/* MSB of Auxilliary (MAX10) FPGA design git commit */
#define GS_AUXFPGA_FWGIT0_3 0xD63B
/* Select SID mode: 0=6581, 1=8580 (address) */
#define SID_SIDMODE_ADDR 0xD63C
/* Select SID mode: 0=6581, 1=8580 (address) */
#define SIDMODE_ADDR 0xD63C
/* Select SID mode: 0=6581, 1=8580 (bit mask) */
#define SID_SIDMODE_MASK 0b00001111
/* Select SID mode: 0=6581, 1=8580 (bit mask) */
#define SIDMODE_MASK 0b00001111
/* Enable DC offset subtraction in audio mixer (address) */
#define AUDIOMIX_DCTRKEN_ADDR 0xD63C
/* Enable DC offset subtraction in audio mixer (address) */
#define DCTRKEN_ADDR 0xD63C
/* Enable DC offset subtraction in audio mixer (bit mask) */
#define AUDIOMIX_DCTRKEN_MASK 0b00010000
/* Enable DC offset subtraction in audio mixer (bit mask) */
#define DCTRKEN_MASK 0b00010000
/* Source of last CPU reset (address) */
#define DEBUG_RESETSRC_ADDR 0xD63C
/* Source of last CPU reset (address) */
#define RESETSRC_ADDR 0xD63C
/* Source of last CPU reset (bit mask) */
#define DEBUG_RESETSRC_MASK 0b11100000
/* Source of last CPU reset (bit mask) */
#define RESETSRC_MASK 0b11100000
/* Audio mixer DC-estimation time step. Lower values = faster updating of DC estimation, at the cost of making low-frequencies quieter. */
#define AUDIOMIX_DCTIME 0xD63D
/* Audio mixer DC-estimation time step. Lower values = faster updating of DC estimation, at the cost of making low-frequencies quieter. */
#define DCTIME 0xD63D
/* Writing triggers hypervisor trap \$XX */
#define CPU_HTRAP00 0xD640
/* Writing triggers hypervisor trap \$XX */
#define HTRAP00 0xD640
/* Hypervisor A register storage */
#define HCPU_REGA 0xD640
/* Hypervisor A register storage */
#define REGA 0xD640
/* @HTRAPXX */
#define CPU_HTRAP01 0xD641
/* @HTRAPXX */
#define HTRAP01 0xD641
/* Hypervisor X register storage */
#define HCPU_REGX 0xD641
/* Hypervisor X register storage */
#define REGX 0xD641
/* @HTRAPXX */
#define CPU_HTRAP02 0xD642
/* @HTRAPXX */
#define HTRAP02 0xD642
/* @HTRAPXX */
#define CPU_HTRAP03 0xD643
/* @HTRAPXX */
#define HTRAP03 0xD643
/* Hypervisor Z register storage */
#define HCPU_REGZ 0xD643
/* Hypervisor Z register storage */
#define REGZ 0xD643
/* @HTRAPXX */
#define CPU_HTRAP04 0xD644
/* @HTRAPXX */
#define HTRAP04 0xD644
/* Hypervisor B register storage */
#define HCPU_REGB 0xD644
/* Hypervisor B register storage */
#define REGB 0xD644
/* @HTRAPXX */
#define CPU_HTRAP05 0xD645
/* @HTRAPXX */
#define HTRAP05 0xD645
/* Hypervisor SPL register storage */
#define HCPU_SPL 0xD645
/* Hypervisor SPL register storage */
#define SPL 0xD645
/* @HTRAPXX */
#define CPU_HTRAP06 0xD646
/* @HTRAPXX */
#define HTRAP06 0xD646
/* Hypervisor SPH register storage */
#define HCPU_SPH 0xD646
/* Hypervisor SPH register storage */
#define SPH 0xD646
/* @HTRAPXX */
#define CPU_HTRAP07 0xD647
/* @HTRAPXX */
#define HTRAP07 0xD647
/* Hypervisor P register storage */
#define HCPU_PFLAGS 0xD647
/* Hypervisor P register storage */
#define PFLAGS 0xD647
/* @HTRAPXX */
#define CPU_HTRAP08 0xD648
/* @HTRAPXX */
#define HTRAP08 0xD648
/* Hypervisor PC-low register storage */
#define HCPU_PCL 0xD648
/* Hypervisor PC-low register storage */
#define PCL 0xD648
/* @HTRAPXX */
#define CPU_HTRAP09 0xD649
/* @HTRAPXX */
#define HTRAP09 0xD649
/* Hypervisor PC-high register storage */
#define HCPU_PCH 0xD649
/* Hypervisor PC-high register storage */
#define PCH 0xD649
/* @HTRAPXX */
#define CPU_HTRAP0A 0xD64A
/* @HTRAPXX */
#define HTRAP0A 0xD64A
/* Hypervisor MAPLO register storage (high bits) */
#define HCPU_MAPLO 0xD64A
/* @HTRAPXX */
#define CPU_HTRAP0B 0xD64B
/* @HTRAPXX */
#define HTRAP0B 0xD64B
/* Hypervisor MAPLO register storage (low bits) */
#define GS_HCPU_MAPLO 0xD64B
/* @HTRAPXX */
#define CPU_HTRAP0C 0xD64C
/* @HTRAPXX */
#define HTRAP0C 0xD64C
/* Hypervisor MAPHI register storage (high bits) */
#define HCPU_MAPHI 0xD64C
/* @HTRAPXX */
#define CPU_HTRAP0D 0xD64D
/* @HTRAPXX */
#define HTRAP0D 0xD64D
/* Hypervisor MAPHI register storage (low bits) */
#define GS_HCPU_MAPHI 0xD64D
/* @HTRAPXX */
#define CPU_HTRAP0E 0xD64E
/* @HTRAPXX */
#define HTRAP0E 0xD64E
/* Hypervisor MAPLO mega-byte number register storage */
#define HCPU_MAPLOMB 0xD64E
/* Hypervisor MAPLO mega-byte number register storage */
#define MAPLOMB 0xD64E
/* @HTRAPXX */
#define CPU_HTRAP0F 0xD64F
/* @HTRAPXX */
#define HTRAP0F 0xD64F
/* Hypervisor MAPHI mega-byte number register storage */
#define HCPU_MAPHIMB 0xD64F
/* Hypervisor MAPHI mega-byte number register storage */
#define MAPHIMB 0xD64F
/* @HTRAPXX */
#define CPU_HTRAP10 0xD650
/* @HTRAPXX */
#define HTRAP10 0xD650
/* Hypervisor CPU port \$00 value */
#define HCPU_PORT00 0xD650
/* Hypervisor CPU port \$00 value */
#define PORT00 0xD650
/* @HTRAPXX */
#define CPU_HTRAP11 0xD651
/* @HTRAPXX */
#define HTRAP11 0xD651
/* Hypervisor CPU port \$01 value */
#define HCPU_PORT01 0xD651
/* Hypervisor CPU port \$01 value */
#define PORT01 0xD651
/* @HTRAPXX */
#define CPU_HTRAP12 0xD652
/* @HTRAPXX */
#define HTRAP12 0xD652
/* VIC-II/VIC-III/VIC-IV mode select (address) */
#define HCPU_VICMODE_ADDR 0xD652
/* VIC-II/VIC-III/VIC-IV mode select (address) */
#define VICMODE_ADDR 0xD652
/* VIC-II/VIC-III/VIC-IV mode select (bit mask) */
#define HCPU_VICMODE_MASK 0b00000011
/* VIC-II/VIC-III/VIC-IV mode select (bit mask) */
#define VICMODE_MASK 0b00000011
/* 0=Use internal SIDs, 1=Use external(1) SIDs (address) */
#define HCPU_EXSID_ADDR 0xD652
/* 0=Use internal SIDs, 1=Use external(1) SIDs (address) */
#define EXSID_ADDR 0xD652
/* 0=Use internal SIDs, 1=Use external(1) SIDs (bit mask) */
#define HCPU_EXSID_MASK 0b00000100
/* 0=Use internal SIDs, 1=Use external(1) SIDs (bit mask) */
#define EXSID_MASK 0b00000100
/* @HTRAPXX */
#define CPU_HTRAP13 0xD653
/* @HTRAPXX */
#define HTRAP13 0xD653
/* Hypervisor DMAgic source MB */
#define HCPU_DMASRCMB 0xD653
/* Hypervisor DMAgic source MB */
#define DMASRCMB 0xD653
/* @HTRAPXX */
#define CPU_HTRAP14 0xD654
/* @HTRAPXX */
#define HTRAP14 0xD654
/* Hypervisor DMAgic destination MB */
#define HCPU_DMADSTMB 0xD654
/* Hypervisor DMAgic destination MB */
#define DMADSTMB 0xD654
/* @HTRAPXX */
#define CPU_HTRAP15 0xD655
/* @HTRAPXX */
#define HTRAP15 0xD655
/* Hypervisor DMAGic list address bits 0-7 */
#define HCPU_DMALADDR 0xD655
/* @HTRAPXX */
#define CPU_HTRAP16 0xD656
/* @HTRAPXX */
#define HTRAP16 0xD656
/* Hypervisor DMAGic list address bits 15-8 */
#define GS_HCPU_DMALADDR 0xD656
/* @HTRAPXX */
#define CPU_HTRAP17 0xD657
/* @HTRAPXX */
#define HTRAP17 0xD657
/* Hypervisor DMAGic list address bits 23-16 */
#define GS_HCPU_DMALADDR_2 0xD657
/* @HTRAPXX */
#define CPU_HTRAP18 0xD658
/* @HTRAPXX */
#define HTRAP18 0xD658
/* Hypervisor DMAGic list address bits 27-24 */
#define GS_HCPU_DMALADDR_3 0xD658
/* @HTRAPXX */
#define CPU_HTRAP19 0xD659
/* @HTRAPXX */
#define HTRAP19 0xD659
/* 1=Virtualise SD/Floppy0 access (usually for access via serial debugger interface) (address) */
#define HCPU_VFLOP_ADDR 0xD659
/* 1=Virtualise SD/Floppy0 access (usually for access via serial debugger interface) (bit mask) */
#define HCPU_VFLOP_MASK 0b00000001
/* 1=Virtualise SD/Floppy1 access (usually for access via serial debugger interface) (address) */
#define GS_HCPU_VFLOP_ADDR 0xD659
/* 1=Virtualise SD/Floppy1 access (usually for access via serial debugger interface) (bit mask) */
#define GS_HCPU_VFLOP_MASK 0b00000010
/* @HTRAPXX */
#define CPU_HTRAP1A 0xD65A
/* @HTRAPXX */
#define HTRAP1A 0xD65A
/* @HTRAPXX */
#define CPU_HTRAP1B 0xD65B
/* @HTRAPXX */
#define HTRAP1B 0xD65B
/* @HTRAPXX */
#define CPU_HTRAP1C 0xD65C
/* @HTRAPXX */
#define HTRAP1C 0xD65C
/* @HTRAPXX */
#define CPU_HTRAP1D 0xD65D
/* @HTRAPXX */
#define HTRAP1D 0xD65D
/* @HTRAPXX */
#define CPU_HTRAP1E 0xD65E
/* @HTRAPXX */
#define HTRAP1E 0xD65E
/* @HTRAPXX */
#define CPU_HTRAP1F 0xD65F
/* @HTRAPXX */
#define HTRAP1F 0xD65F
/* @HTRAPXX */
#define CPU_HTRAP20 0xD660
/* @HTRAPXX */
#define HTRAP20 0xD660
/* @HTRAPXX */
#define CPU_HTRAP21 0xD661
/* @HTRAPXX */
#define HTRAP21 0xD661
/* @HTRAPXX */
#define CPU_HTRAP22 0xD662
/* @HTRAPXX */
#define HTRAP22 0xD662
/* @HTRAPXX */
#define CPU_HTRAP23 0xD663
/* @HTRAPXX */
#define HTRAP23 0xD663
/* @HTRAPXX */
#define CPU_HTRAP24 0xD664
/* @HTRAPXX */
#define HTRAP24 0xD664
/* @HTRAPXX */
#define CPU_HTRAP25 0xD665
/* @HTRAPXX */
#define HTRAP25 0xD665
/* @HTRAPXX */
#define CPU_HTRAP26 0xD666
/* @HTRAPXX */
#define HTRAP26 0xD666
/* @HTRAPXX */
#define CPU_HTRAP27 0xD667
/* @HTRAPXX */
#define HTRAP27 0xD667
/* @HTRAPXX */
#define CPU_HTRAP28 0xD668
/* @HTRAPXX */
#define HTRAP28 0xD668
/* @HTRAPXX */
#define CPU_HTRAP29 0xD669
/* @HTRAPXX */
#define HTRAP29 0xD669
/* @HTRAPXX */
#define CPU_HTRAP2A 0xD66A
/* @HTRAPXX */
#define HTRAP2A 0xD66A
/* @HTRAPXX */
#define CPU_HTRAP2B 0xD66B
/* @HTRAPXX */
#define HTRAP2B 0xD66B
/* @HTRAPXX */
#define CPU_HTRAP2C 0xD66C
/* @HTRAPXX */
#define HTRAP2C 0xD66C
/* @HTRAPXX */
#define CPU_HTRAP2D 0xD66D
/* @HTRAPXX */
#define HTRAP2D 0xD66D
/* @HTRAPXX */
#define CPU_HTRAP2E 0xD66E
/* @HTRAPXX */
#define HTRAP2E 0xD66E
/* @HTRAPXX */
#define CPU_HTRAP2F 0xD66F
/* @HTRAPXX */
#define HTRAP2F 0xD66F
/* @HTRAPXX */
#define CPU_HTRAP30 0xD670
/* @HTRAPXX */
#define HTRAP30 0xD670
/* Hypervisor GeoRAM base address (x MB) */
#define HCPU_GEORAMBASE 0xD670
/* Hypervisor GeoRAM base address (x MB) */
#define GEORAMBASE 0xD670
/* @HTRAPXX */
#define CPU_HTRAP31 0xD671
/* @HTRAPXX */
#define HTRAP31 0xD671
/* Hypervisor GeoRAM address mask (applied to GeoRAM block register) */
#define HCPU_GEORAMMASK 0xD671
/* Hypervisor GeoRAM address mask (applied to GeoRAM block register) */
#define GEORAMMASK 0xD671
/* @HTRAPXX */
#define CPU_HTRAP32 0xD672
/* @HTRAPXX */
#define HTRAP32 0xD672
/* Enable composited Matrix Mode, and disable UART access to serial monitor. (address) */
#define HCPU_MATRIXEN_ADDR 0xD672
/* Enable composited Matrix Mode, and disable UART access to serial monitor. (address) */
#define MATRIXEN_ADDR 0xD672
/* Enable composited Matrix Mode, and disable UART access to serial monitor. (bit mask) */
#define HCPU_MATRIXEN_MASK 0b01000000
/* Enable composited Matrix Mode, and disable UART access to serial monitor. (bit mask) */
#define MATRIXEN_MASK 0b01000000
/* @HTRAPXX */
#define CPU_HTRAP33 0xD673
/* @HTRAPXX */
#define HTRAP33 0xD673
/* @HTRAPXX */
#define CPU_HTRAP34 0xD674
/* @HTRAPXX */
#define HTRAP34 0xD674
/* @HTRAPXX */
#define CPU_HTRAP35 0xD675
/* @HTRAPXX */
#define HTRAP35 0xD675
/* @HTRAPXX */
#define CPU_HTRAP36 0xD676
/* @HTRAPXX */
#define HTRAP36 0xD676
/* @HTRAPXX */
#define CPU_HTRAP37 0xD677
/* @HTRAPXX */
#define HTRAP37 0xD677
/* @HTRAPXX */
#define CPU_HTRAP38 0xD678
/* @HTRAPXX */
#define HTRAP38 0xD678
/* @HTRAPXX */
#define CPU_HTRAP39 0xD679
/* @HTRAPXX */
#define HTRAP39 0xD679
/* @HTRAPXX */
#define CPU_HTRAP3A 0xD67A
/* @HTRAPXX */
#define HTRAP3A 0xD67A
/* @HTRAPXX */
#define CPU_HTRAP3B 0xD67B
/* @HTRAPXX */
#define HTRAP3B 0xD67B
/* @HTRAPXX */
#define CPU_HTRAP3C 0xD67C
/* @HTRAPXX */
#define HTRAP3C 0xD67C
/* (write) Hypervisor write serial output to UART monitor (address) */
#define HCPU_UARTDATA_ADDR 0xD67C
/* (write) Hypervisor write serial output to UART monitor (address) */
#define UARTDATA_ADDR 0xD67C
/* (write) Hypervisor write serial output to UART monitor (bit mask) */
#define HCPU_UARTDATA_MASK 0b11111111
/* (write) Hypervisor write serial output to UART monitor (bit mask) */
#define UARTDATA_MASK 0b11111111
/* @HTRAPXX */
#define CPU_HTRAP3D 0xD67D
/* @HTRAPXX */
#define HTRAP3D 0xD67D
/* Hypervisor watchdog register: writing any value clears the watch dog */
#define HCPU_WATCHDOG 0xD67D
/* Hypervisor watchdog register: writing any value clears the watch dog */
#define WATCHDOG 0xD67D
/* RESERVED (address) */
#define HCPU_RSVD_ADDR 0xD67D
/* RESERVED (address) */
#define RSVD_ADDR 0xD67D
/* RESERVED (bit mask) */
#define HCPU_RSVD_MASK 0b00000001
/* RESERVED (bit mask) */
#define RSVD_MASK 0b00000001
/* Hypervisor enable 32-bit JMP/JSR etc (address) */
#define HCPU_JMP32EN_ADDR 0xD67D
/* Hypervisor enable 32-bit JMP/JSR etc (address) */
#define JMP32EN_ADDR 0xD67D
/* Hypervisor enable 32-bit JMP/JSR etc (bit mask) */
#define HCPU_JMP32EN_MASK 0b00000010
/* Hypervisor enable 32-bit JMP/JSR etc (bit mask) */
#define JMP32EN_MASK 0b00000010
/* Hypervisor write protect C65 ROM \$20000-\$3FFFF (address) */
#define HCPU_ROMPROT_ADDR 0xD67D
/* Hypervisor write protect C65 ROM \$20000-\$3FFFF (address) */
#define ROMPROT_ADDR 0xD67D
/* Hypervisor write protect C65 ROM \$20000-\$3FFFF (bit mask) */
#define HCPU_ROMPROT_MASK 0b00000100
/* Hypervisor write protect C65 ROM \$20000-\$3FFFF (bit mask) */
#define ROMPROT_MASK 0b00000100
/* Hypervisor enable ASC/DIN CAPS LOCK key to enable/disable CPU slow-down in C64/C128/C65 modes (address) */
#define HCPU_ASCFAST_ADDR 0xD67D
/* Hypervisor enable ASC/DIN CAPS LOCK key to enable/disable CPU slow-down in C64/C128/C65 modes (address) */
#define ASCFAST_ADDR 0xD67D
/* Hypervisor enable ASC/DIN CAPS LOCK key to enable/disable CPU slow-down in C64/C128/C65 modes (bit mask) */
#define HCPU_ASCFAST_MASK 0b00001000
/* Hypervisor enable ASC/DIN CAPS LOCK key to enable/disable CPU slow-down in C64/C128/C65 modes (bit mask) */
#define ASCFAST_MASK 0b00001000
/* Hypervisor force CPU to 48MHz for userland (userland can override via POKE0) (address) */
#define HCPU_CPUFAST_ADDR 0xD67D
/* Hypervisor force CPU to 48MHz for userland (userland can override via POKE0) (address) */
#define CPUFAST_ADDR 0xD67D
/* Hypervisor force CPU to 48MHz for userland (userland can override via POKE0) (bit mask) */
#define HCPU_CPUFAST_MASK 0b00010000
/* Hypervisor force CPU to 48MHz for userland (userland can override via POKE0) (bit mask) */
#define CPUFAST_MASK 0b00010000
/* Hypervisor force CPU to 4502 personality, even in C64 IO mode. (address) */
#define HCPU_F4502_ADDR 0xD67D
/* Hypervisor force CPU to 4502 personality, even in C64 IO mode. (address) */
#define F4502_ADDR 0xD67D
/* Hypervisor force CPU to 4502 personality, even in C64 IO mode. (bit mask) */
#define HCPU_F4502_MASK 0b00100000
/* Hypervisor force CPU to 4502 personality, even in C64 IO mode. (bit mask) */
#define F4502_MASK 0b00100000
/* Hypervisor flag to indicate if an IRQ is pending on exit from the hypervisor / set 1 to force IRQ/NMI deferal for 1,024 cycles on exit from hypervisor. (address) */
#define HCPU_PIRQ_ADDR 0xD67D
/* Hypervisor flag to indicate if an IRQ is pending on exit from the hypervisor / set 1 to force IRQ/NMI deferal for 1,024 cycles on exit from hypervisor. (address) */
#define PIRQ_ADDR 0xD67D
/* Hypervisor flag to indicate if an IRQ is pending on exit from the hypervisor / set 1 to force IRQ/NMI deferal for 1,024 cycles on exit from hypervisor. (bit mask) */
#define HCPU_PIRQ_MASK 0b01000000
/* Hypervisor flag to indicate if an IRQ is pending on exit from the hypervisor / set 1 to force IRQ/NMI deferal for 1,024 cycles on exit from hypervisor. (bit mask) */
#define PIRQ_MASK 0b01000000
/* Hypervisor flag to indicate if an NMI is pending on exit from the hypervisor. (address) */
#define HCPU_PNMI_ADDR 0xD67D
/* Hypervisor flag to indicate if an NMI is pending on exit from the hypervisor. (address) */
#define PNMI_ADDR 0xD67D
/* Hypervisor flag to indicate if an NMI is pending on exit from the hypervisor. (bit mask) */
#define HCPU_PNMI_MASK 0b10000000
/* Hypervisor flag to indicate if an NMI is pending on exit from the hypervisor. (bit mask) */
#define PNMI_MASK 0b10000000
/* @HTRAPXX */
#define CPU_HTRAP3E 0xD67E
/* @HTRAPXX */
#define HTRAP3E 0xD67E
/* Hypervisor already-upgraded bit (writing sets permanently) */
#define HCPU_HICKED 0xD67E
/* Hypervisor already-upgraded bit (writing sets permanently) */
#define HICKED 0xD67E
/* @HTRAPXX */
#define CPU_HTRAP3F 0xD67F
/* @HTRAPXX */
#define HTRAP3F 0xD67F
/* Writing trigger return from hypervisor */
#define HCPU_ENTEREXIT 0xD67F
/* Writing trigger return from hypervisor */
#define ENTEREXIT 0xD67F
/* SD controller status/command */
#define SD_CMDANDSTAT 0xD680
/* SD controller status/command */
#define CMDANDSTAT 0xD680
/* SD controller SD sector address (LSB) */
#define SD_SECTOR0 0xD681
/* SD controller SD sector address (LSB) */
#define SECTOR0 0xD681
/* SD controller SD sector address (2nd byte) */
#define SD_SECTOR1 0xD682
/* SD controller SD sector address (2nd byte) */
#define SECTOR1 0xD682
/* SD controller SD sector address (3rd byte) */
#define SD_SECTOR2 0xD683
/* SD controller SD sector address (3rd byte) */
#define SECTOR2 0xD683
/* SD controller SD sector address (MSB) */
#define SD_SECTOR3 0xD684
/* SD controller SD sector address (MSB) */
#define SECTOR3 0xD684
/* WRITE ONLY set fill byte for use in fill mode, instead of SD buffer data */
#define SD_FILLVAL 0xD686
/* WRITE ONLY set fill byte for use in fill mode, instead of SD buffer data */
#define FILLVAL 0xD686
/* (read only) reads bit 8 of the sector buffer pointer (address) */
#define SD_BUFBIT8_ADDR 0xD689
/* (read only) reads bit 8 of the sector buffer pointer (address) */
#define BUFBIT8_ADDR 0xD689
/* (read only) reads bit 8 of the sector buffer pointer (bit mask) */
#define SD_BUFBIT8_MASK 0b00000001
/* (read only) reads bit 8 of the sector buffer pointer (bit mask) */
#define BUFBIT8_MASK 0b00000001
/* (read only) if set, indicates that the sector buffer is full and has not yet been read (address) */
#define SD_BUFFFULL_ADDR 0xD689
/* (read only) if set, indicates that the sector buffer is full and has not yet been read (address) */
#define BUFFFULL_ADDR 0xD689
/* (read only) if set, indicates that the sector buffer is full and has not yet been read (bit mask) */
#define SD_BUFFFULL_MASK 0b00000010
/* (read only) if set, indicates that the sector buffer is full and has not yet been read (bit mask) */
#define BUFFFULL_MASK 0b00000010
/* Set/read SD card sd_handshake signal (address) */
#define SD_HNDSHK_ADDR 0xD689
/* Set/read SD card sd_handshake signal (address) */
#define HNDSHK_ADDR 0xD689
/* Set/read SD card sd_handshake signal (bit mask) */
#define SD_HNDSHK_MASK 0b00000100
/* Set/read SD card sd_handshake signal (bit mask) */
#define HNDSHK_MASK 0b00000100
/* SD Card Data Ready indication (address) */
#define SD_DRDY_ADDR 0xD689
/* SD Card Data Ready indication (address) */
#define DRDY_ADDR 0xD689
/* SD Card Data Ready indication (bit mask) */
#define SD_DRDY_MASK 0b00001000
/* SD Card Data Ready indication (bit mask) */
#define DRDY_MASK 0b00001000
/* Reserved (address) */
#define SD_RESERVED_ADDR 0xD689
/* Reserved (bit mask) */
#define SD_RESERVED_MASK 0b00010000
/* Set to swap floppy drive 0 (the internal drive) and drive 1 (the drive on the 2nd position on the internal floppy cable). (address) */
#define SD_FDCSWAP_ADDR 0xD689
/* Set to swap floppy drive 0 (the internal drive) and drive 1 (the drive on the 2nd position on the internal floppy cable). (address) */
#define FDCSWAP_ADDR 0xD689
/* Set to swap floppy drive 0 (the internal drive) and drive 1 (the drive on the 2nd position on the internal floppy cable). (bit mask) */
#define SD_FDCSWAP_MASK 0b00100000
/* Set to swap floppy drive 0 (the internal drive) and drive 1 (the drive on the 2nd position on the internal floppy cable). (bit mask) */
#define FDCSWAP_MASK 0b00100000
/* Set to switch sector buffer to view SD card direct access, clear for access to the F011 FDC sector buffer. (address) */
#define SD_BUFFSEL_ADDR 0xD689
/* Set to switch sector buffer to view SD card direct access, clear for access to the F011 FDC sector buffer. (address) */
#define BUFFSEL_ADDR 0xD689
/* Set to switch sector buffer to view SD card direct access, clear for access to the F011 FDC sector buffer. (bit mask) */
#define SD_BUFFSEL_MASK 0b10000000
/* Set to switch sector buffer to view SD card direct access, clear for access to the F011 FDC sector buffer. (bit mask) */
#define BUFFSEL_MASK 0b10000000
/* (read only) Set if colour RAM at $DC00 (address) */
#define SD_CDC00_ADDR 0xD68A
/* (read only) Set if colour RAM at $DC00 (address) */
#define CDC00_ADDR 0xD68A
/* (read only) Set if colour RAM at $DC00 (bit mask) */
#define SD_CDC00_MASK 0b00000001
/* (read only) Set if colour RAM at $DC00 (bit mask) */
#define CDC00_MASK 0b00000001
/* (read only) Set if VIC-IV or ethernet IO bank visible (address) */
#define SD_VICIII_ADDR 0xD68A
/* (read only) Set if VIC-IV or ethernet IO bank visible (address) */
#define VICIII_ADDR 0xD68A
/* (read only) Set if VIC-IV or ethernet IO bank visible (bit mask) */
#define SD_VICIII_MASK 0b00000010
/* (read only) Set if VIC-IV or ethernet IO bank visible (bit mask) */
#define VICIII_MASK 0b00000010
/* (read only) Set if drive 0 is virtualised (sectors delivered via serial monitor interface) (address) */
#define SD_VFDC0_ADDR 0xD68A
/* (read only) Set if drive 0 is virtualised (sectors delivered via serial monitor interface) (address) */
#define VFDC0_ADDR 0xD68A
/* (read only) Set if drive 0 is virtualised (sectors delivered via serial monitor interface) (bit mask) */
#define SD_VFDC0_MASK 0b00000100
/* (read only) Set if drive 0 is virtualised (sectors delivered via serial monitor interface) (bit mask) */
#define VFDC0_MASK 0b00000100
/* (read only) Set if drive 1 is virtualised (sectors delivered via serial monitor interface) (address) */
#define SD_VFDC1_ADDR 0xD68A
/* (read only) Set if drive 1 is virtualised (sectors delivered via serial monitor interface) (address) */
#define VFDC1_ADDR 0xD68A
/* (read only) Set if drive 1 is virtualised (sectors delivered via serial monitor interface) (bit mask) */
#define SD_VFDC1_MASK 0b00001000
/* (read only) Set if drive 1 is virtualised (sectors delivered via serial monitor interface) (bit mask) */
#define VFDC1_MASK 0b00001000
/* F011 drive 0 use disk image if set, otherwise use real floppy drive. (address) */
#define SDFDC_D0IMG_ADDR 0xD68B
/* F011 drive 0 use disk image if set, otherwise use real floppy drive. (address) */
#define D0IMG_ADDR 0xD68B
/* F011 drive 0 use disk image if set, otherwise use real floppy drive. (bit mask) */
#define SDFDC_D0IMG_MASK 0b00000001
/* F011 drive 0 use disk image if set, otherwise use real floppy drive. (bit mask) */
#define D0IMG_MASK 0b00000001
/* F011 drive 0 media present (address) */
#define SDFDC_D0P_ADDR 0xD68B
/* F011 drive 0 media present (address) */
#define D0P_ADDR 0xD68B
/* F011 drive 0 media present (bit mask) */
#define SDFDC_D0P_MASK 0b00000010
/* F011 drive 0 media present (bit mask) */
#define D0P_MASK 0b00000010
/* Write enable F011 drive 0 (address) */
#define SDFDC_D0WP_ADDR 0xD68B
/* Write enable F011 drive 0 (address) */
#define D0WP_ADDR 0xD68B
/* Write enable F011 drive 0 (bit mask) */
#define SDFDC_D0WP_MASK 0b00000100
/* Write enable F011 drive 0 (bit mask) */
#define D0WP_MASK 0b00000100
/* F011 drive 1 use disk image if set, otherwise use real floppy drive. (address) */
#define SDFDC_D1IMG_ADDR 0xD68B
/* F011 drive 1 use disk image if set, otherwise use real floppy drive. (address) */
#define D1IMG_ADDR 0xD68B
/* F011 drive 1 use disk image if set, otherwise use real floppy drive. (bit mask) */
#define SDFDC_D1IMG_MASK 0b00001000
/* F011 drive 1 use disk image if set, otherwise use real floppy drive. (bit mask) */
#define D1IMG_MASK 0b00001000
/* F011 drive 1 media present (address) */
#define SDFDC_D1P_ADDR 0xD68B
/* F011 drive 1 media present (address) */
#define D1P_ADDR 0xD68B
/* F011 drive 1 media present (bit mask) */
#define SDFDC_D1P_MASK 0b00010000
/* F011 drive 1 media present (bit mask) */
#define D1P_MASK 0b00010000
/* Write enable F011 drive 1 (address) */
#define SDFDC_D1WP_ADDR 0xD68B
/* Write enable F011 drive 1 (address) */
#define D1WP_ADDR 0xD68B
/* Write enable F011 drive 1 (bit mask) */
#define SDFDC_D1WP_MASK 0b00100000
/* Write enable F011 drive 1 (bit mask) */
#define D1WP_MASK 0b00100000
/* Enable 64MiB ``MEGA Disk'' for F011 emulated drive 0 (address) */
#define F011_MDISK0_ADDR 0xD68B
/* Enable 64MiB ``MEGA Disk'' for F011 emulated drive 0 (bit mask) */
#define F011_MDISK0_MASK 0b01000000
/* F011 drive 0 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (address) */
#define SDFDC_D0MD_ADDR 0xD68B
/* F011 drive 0 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (address) */
#define D0MD_ADDR 0xD68B
/* F011 drive 0 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (bit mask) */
#define SDFDC_D0MD_MASK 0b01000000
/* F011 drive 0 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (bit mask) */
#define D0MD_MASK 0b01000000
/* Enable 64MiB ``MEGA Disk'' for F011 emulated drive 1 (address) */
#define GS_F011_MDISK0_ADDR 0xD68B
/* Enable 64MiB ``MEGA Disk'' for F011 emulated drive 1 (bit mask) */
#define GS_F011_MDISK0_MASK 0b10000000
/* F011 drive 1 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (address) */
#define SDFDC_D1MD_ADDR 0xD68B
/* F011 drive 1 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (address) */
#define D1MD_ADDR 0xD68B
/* F011 drive 1 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (bit mask) */
#define SDFDC_D1MD_MASK 0b10000000
/* F011 drive 1 disk image is 64MiB mega image if set (otherwise 800KiB 1581 image) (bit mask) */
#define D1MD_MASK 0b10000000
/* Diskimage sector number (bits 0-7) */
#define F011_DISKADDR0 0xD68C
/* Diskimage sector number (bits 0-7) */
#define DISKADDR0 0xD68C
/* F011 drive 0 disk image address on SD card (LSB) */
#define SDFDC_D0STARTSEC0 0xD68C
/* F011 drive 0 disk image address on SD card (LSB) */
#define D0STARTSEC0 0xD68C
/* Diskimage sector number (bits 8-15) */
#define F011_DISKADDR1 0xD68D
/* Diskimage sector number (bits 8-15) */
#define DISKADDR1 0xD68D
/* F011 drive 0 disk image address on SD card (2nd byte) */
#define SDFDC_D0STARTSEC1 0xD68D
/* F011 drive 0 disk image address on SD card (2nd byte) */
#define D0STARTSEC1 0xD68D
/* Diskimage sector number (bits 16-23) */
#define F011_DISKADDR2 0xD68E
/* Diskimage sector number (bits 16-23) */
#define DISKADDR2 0xD68E
/* F011 drive 0 disk image address on SD card (3rd byte) */
#define SDFDC_D0STARTSEC2 0xD68E
/* F011 drive 0 disk image address on SD card (3rd byte) */
#define D0STARTSEC2 0xD68E
/* Diskimage sector number (bits 24-31) */
#define F011_DISKADDR3 0xD68F
/* Diskimage sector number (bits 24-31) */
#define DISKADDR3 0xD68F
/* F011 drive 0 disk image address on SD card (MSB) */
#define SDFDC_D0STARTSEC3 0xD68F
/* F011 drive 0 disk image address on SD card (MSB) */
#define D0STARTSEC3 0xD68F
/* Diskimage 2 sector number (bits 0-7) */
#define F011_DISK2ADDR0 0xD690
/* Diskimage 2 sector number (bits 0-7) */
#define DISK2ADDR0 0xD690
/* F011 drive 1 disk image address on SD card (LSB) */
#define SDFDC_D1STARTSEC0 0xD690
/* F011 drive 1 disk image address on SD card (LSB) */
#define D1STARTSEC0 0xD690
/* Diskimage 2 sector number (bits 8-15) */
#define F011_DISK2ADDR1 0xD691
/* Diskimage 2 sector number (bits 8-15) */
#define DISK2ADDR1 0xD691
/* F011 drive 1 disk image address on SD card (2nd byte) */
#define SDFDC_D1STARTSEC1 0xD691
/* F011 drive 1 disk image address on SD card (2nd byte) */
#define D1STARTSEC1 0xD691
/* Diskimage 2 sector number (bits 16-23) */
#define F011_DISK2ADDR2 0xD692
/* Diskimage 2 sector number (bits 16-23) */
#define DISK2ADDR2 0xD692
/* F011 drive 1 disk image address on SD card (3rd byte) */
#define SDFDC_D1STARTSEC2 0xD692
/* F011 drive 1 disk image address on SD card (3rd byte) */
#define D1STARTSEC2 0xD692
/* Diskimage 2 sector number (bits 24-31) */
#define F011_DISK2ADDR3 0xD693
/* Diskimage 2 sector number (bits 24-31) */
#define DISK2ADDR3 0xD693
/* F011 drive 1 disk image address on SD card (MSB) */
#define SDFDC_D1STARTSEC3 0xD693
/* F011 drive 1 disk image address on SD card (MSB) */
#define D1STARTSEC3 0xD693
/* Enable automatic track seeking for sector reads and writes */
#define F011_AUTOTUNE 0xD696
/* Enable automatic track seeking for sector reads and writes */
#define AUTOTUNE 0xD696
/* Status of M65 R3 J21 pins */
#define DEBUG_J21INL 0xD69B
/* Status of M65 R3 J21 pins */
#define J21INL 0xD69B
/* Status of M65 R3 J21 pins */
#define DEBUG_J21INH 0xD69C
/* Status of M65 R3 J21 pins */
#define J21INH 0xD69C
/* Status of M65 R3 DIP switches */
#define DEBUG_DIPSW 0xD69D
/* Status of M65 R3 DIP switches */
#define DIPSW 0xD69D
/* Status of switches 0 to 7 */
#define DEBUG_SWSTATUS 0xD69E
/* Status of switches 8 to 15 */
#define GS_DEBUG_SWSTATUS 0xD69F
/* Control floppy drive SIDE1 line (address) */
#define FDC_DBGWGATE_ADDR 0xD6A0
/* Control floppy drive SIDE1 line (bit mask) */
#define FDC_DBGWGATE_MASK 0b00000001
/* Control floppy drive WGATE line (address) */
#define GS_FDC_DBGWGATE_ADDR 0xD6A0
/* Control floppy drive WGATE line (bit mask) */
#define GS_FDC_DBGWGATE_MASK 0b00000010
/* Control floppy drive WDATA line (address) */
#define FDC_DBGWDATA_ADDR 0xD6A0
/* Control floppy drive WDATA line (address) */
#define DBGWDATA_ADDR 0xD6A0
/* Control floppy drive WDATA line (bit mask) */
#define FDC_DBGWDATA_MASK 0b00000100
/* Control floppy drive WDATA line (bit mask) */
#define DBGWDATA_MASK 0b00000100
/* Control floppy drive STEP line (address) */
#define FDC_DBGDIR_ADDR 0xD6A0
/* Control floppy drive STEP line (bit mask) */
#define FDC_DBGDIR_MASK 0b00001000
/* Control floppy drive STEPDIR line (address) */
#define GS_FDC_DBGDIR_ADDR 0xD6A0
/* Control floppy drive STEPDIR line (bit mask) */
#define GS_FDC_DBGDIR_MASK 0b00010000
/* Control floppy drive SELECT line (address) */
#define FDC_DBGMOTORA_ADDR 0xD6A0
/* Control floppy drive SELECT line (bit mask) */
#define FDC_DBGMOTORA_MASK 0b00100000
/* Control floppy drive MOTOR line (address) */
#define GS_FDC_DBGMOTORA_ADDR 0xD6A0
/* Control floppy drive MOTOR line (bit mask) */
#define GS_FDC_DBGMOTORA_MASK 0b01000000
/* Control floppy drive density select line (address) */
#define FDC_DENSITY_ADDR 0xD6A0
/* Control floppy drive density select line (address) */
#define DENSITY_ADDR 0xD6A0
/* Control floppy drive density select line (bit mask) */
#define FDC_DENSITY_MASK 0b10000000
/* Control floppy drive density select line (bit mask) */
#define DENSITY_MASK 0b10000000
/* Use real floppy drive instead of SD card for 1st floppy drive (address) */
#define F011_DRV0EN_ADDR 0xD6A1
/* Use real floppy drive instead of SD card for 1st floppy drive (address) */
#define DRV0EN_ADDR 0xD6A1
/* Use real floppy drive instead of SD card for 1st floppy drive (bit mask) */
#define F011_DRV0EN_MASK 0b00000001
/* Use real floppy drive instead of SD card for 1st floppy drive (bit mask) */
#define DRV0EN_MASK 0b00000001
/* Use real floppy drive for drive 0 if set (read-only, except for from hypervisor) (address) */
#define SDFDC_USEREAL0_ADDR 0xD6A1
/* Use real floppy drive for drive 0 if set (read-only, except for from hypervisor) (address) */
#define USEREAL0_ADDR 0xD6A1
/* Use real floppy drive for drive 0 if set (read-only, except for from hypervisor) (bit mask) */
#define SDFDC_USEREAL0_MASK 0b00000001
/* Use real floppy drive for drive 0 if set (read-only, except for from hypervisor) (bit mask) */
#define USEREAL0_MASK 0b00000001
/* Read next sector under head if set, ignoring the requested side, track and sector number. (address) */
#define SDFDC_TARGANY_ADDR 0xD6A1
/* Read next sector under head if set, ignoring the requested side, track and sector number. (address) */
#define TARGANY_ADDR 0xD6A1
/* Read next sector under head if set, ignoring the requested side, track and sector number. (bit mask) */
#define SDFDC_TARGANY_MASK 0b00000010
/* Read next sector under head if set, ignoring the requested side, track and sector number. (bit mask) */
#define TARGANY_MASK 0b00000010
/* Use real floppy drive instead of SD card for 2nd floppy drive (address) */
#define F011_DRV2EN_ADDR 0xD6A1
/* Use real floppy drive instead of SD card for 2nd floppy drive (address) */
#define DRV2EN_ADDR 0xD6A1
/* Use real floppy drive instead of SD card for 2nd floppy drive (bit mask) */
#define F011_DRV2EN_MASK 0b00000100
/* Use real floppy drive instead of SD card for 2nd floppy drive (bit mask) */
#define DRV2EN_MASK 0b00000100
/* Use real floppy drive for drive 1 if set (read-only, except for from hypervisor) (address) */
#define SDFDC_USEREAL1_ADDR 0xD6A1
/* Use real floppy drive for drive 1 if set (read-only, except for from hypervisor) (address) */
#define USEREAL1_ADDR 0xD6A1
/* Use real floppy drive for drive 1 if set (read-only, except for from hypervisor) (bit mask) */
#define SDFDC_USEREAL1_MASK 0b00000100
/* Use real floppy drive for drive 1 if set (read-only, except for from hypervisor) (bit mask) */
#define USEREAL1_MASK 0b00000100
/* Disable floppy spinning and tracking for SD card operations. (address) */
#define SDFDC_SILENT_ADDR 0xD6A1
/* Disable floppy spinning and tracking for SD card operations. (address) */
#define SILENT_ADDR 0xD6A1
/* Disable floppy spinning and tracking for SD card operations. (bit mask) */
#define SDFDC_SILENT_MASK 0b00001000
/* Disable floppy spinning and tracking for SD card operations. (bit mask) */
#define SILENT_MASK 0b00001000
/* Set number of bus cycles per floppy magnetic interval (decrease to increase data rate) */
#define FDC_DATARATE 0xD6A2
/* Set number of bus cycles per floppy magnetic interval (decrease to increase data rate) */
#define DATARATE 0xD6A2
/* Select audio channel volume to be set by thumb wheel #3 (address) */
#define MISCIO_WHEEL3TARGET_ADDR 0xD6AC
/* Select audio channel volume to be set by thumb wheel #3 (address) */
#define WHEEL3TARGET_ADDR 0xD6AC
/* Select audio channel volume to be set by thumb wheel #3 (bit mask) */
#define MISCIO_WHEEL3TARGET_MASK 0b00001111
/* Select audio channel volume to be set by thumb wheel #3 (bit mask) */
#define WHEEL3TARGET_MASK 0b00001111
/* Enable control of LCD panel brightness via thumb wheel (address) */
#define MISCIO_WHEELBRIGHTEN_ADDR 0xD6AC
/* Enable control of LCD panel brightness via thumb wheel (address) */
#define WHEELBRIGHTEN_ADDR 0xD6AC
/* Enable control of LCD panel brightness via thumb wheel (bit mask) */
#define MISCIO_WHEELBRIGHTEN_MASK 0b10000000
/* Enable control of LCD panel brightness via thumb wheel (bit mask) */
#define WHEELBRIGHTEN_MASK 0b10000000
/* Select audio channel volume to be set by thumb wheel #1 (address) */
#define MISCIO_WHEEL1TARGET_ADDR 0xD6AD
/* Select audio channel volume to be set by thumb wheel #1 (address) */
#define WHEEL1TARGET_ADDR 0xD6AD
/* Select audio channel volume to be set by thumb wheel #1 (bit mask) */
#define MISCIO_WHEEL1TARGET_MASK 0b00001111
/* Select audio channel volume to be set by thumb wheel #1 (bit mask) */
#define WHEEL1TARGET_MASK 0b00001111
/* Select audio channel volume to be set by thumb wheel #2 (address) */
#define MISCIO_WHEEL2TARGET_ADDR 0xD6AD
/* Select audio channel volume to be set by thumb wheel #2 (address) */
#define WHEEL2TARGET_ADDR 0xD6AD
/* Select audio channel volume to be set by thumb wheel #2 (bit mask) */
#define MISCIO_WHEEL2TARGET_MASK 0b11110000
/* Select audio channel volume to be set by thumb wheel #2 (bit mask) */
#define WHEEL2TARGET_MASK 0b11110000
/* Select floppy encoding (0=MFM, 1=RLL2,7, F=Raw encoding) (address) */
#define SD_FDC_ENC_ADDR 0xD6AE
/* Select floppy encoding (0=MFM, 1=RLL2,7, F=Raw encoding) (address) */
#define FDC_ENC_ADDR 0xD6AE
/* Select floppy encoding (0=MFM, 1=RLL2,7, F=Raw encoding) (bit mask) */
#define SD_FDC_ENC_MASK 0b00001111
/* Select floppy encoding (0=MFM, 1=RLL2,7, F=Raw encoding) (bit mask) */
#define FDC_ENC_MASK 0b00001111
/* Automatically select DD or HD decoder for last sector display (address) */
#define SD_AUTO_2XSEL_ADDR 0xD6AE
/* Automatically select DD or HD decoder for last sector display (address) */
#define AUTO_2XSEL_ADDR 0xD6AE
/* Automatically select DD or HD decoder for last sector display (bit mask) */
#define SD_AUTO_2XSEL_MASK 0b00010000
/* Automatically select DD or HD decoder for last sector display (bit mask) */
#define AUTO_2XSEL_MASK 0b00010000
/* Enable automatic variable speed selection for floppy controller using Track Information Blocks on MEGA65 HD floppies (address) */
#define SD_FDC_VARSPD_ADDR 0xD6AE
/* Enable automatic variable speed selection for floppy controller using Track Information Blocks on MEGA65 HD floppies (address) */
#define FDC_VARSPD_ADDR 0xD6AE
/* Enable automatic variable speed selection for floppy controller using Track Information Blocks on MEGA65 HD floppies (bit mask) */
#define SD_FDC_VARSPD_MASK 0b00100000
/* Enable automatic variable speed selection for floppy controller using Track Information Blocks on MEGA65 HD floppies (bit mask) */
#define FDC_VARSPD_MASK 0b00100000
/* Select HD decoder for last sector display (address) */
#define SD_FDC_2XSEL_ADDR 0xD6AE
/* Select HD decoder for last sector display (address) */
#define FDC_2XSEL_ADDR 0xD6AE
/* Select HD decoder for last sector display (bit mask) */
#define SD_FDC_2XSEL_MASK 0b01000000
/* Select HD decoder for last sector display (bit mask) */
#define FDC_2XSEL_MASK 0b01000000
/* Enable use of Track Info Block settings (address) */
#define SD_FDC_TIBEN_ADDR 0xD6AE
/* Enable use of Track Info Block settings (address) */
#define FDC_TIBEN_ADDR 0xD6AE
/* Enable use of Track Info Block settings (bit mask) */
#define SD_FDC_TIBEN_MASK 0b10000000
/* Enable use of Track Info Block settings (bit mask) */
#define FDC_TIBEN_MASK 0b10000000
/* Manually set f011_rsector_found signal (indented for virtual F011 mode only) (address) */
#define SD_VR_FOUND_ADDR 0xD6AF
/* Manually set f011_rsector_found signal (indented for virtual F011 mode only) (address) */
#define VR_FOUND_ADDR 0xD6AF
/* Manually set f011_rsector_found signal (indented for virtual F011 mode only) (bit mask) */
#define SD_VR_FOUND_MASK 0b00000001
/* Manually set f011_rsector_found signal (indented for virtual F011 mode only) (bit mask) */
#define VR_FOUND_MASK 0b00000001
/* Manually set f011_wsector_found signal (indented for virtual F011 mode only) (address) */
#define SD_VW_FOUND_ADDR 0xD6AF
/* Manually set f011_wsector_found signal (indented for virtual F011 mode only) (address) */
#define VW_FOUND_ADDR 0xD6AF
/* Manually set f011_wsector_found signal (indented for virtual F011 mode only) (bit mask) */
#define SD_VW_FOUND_MASK 0b00000010
/* Manually set f011_wsector_found signal (indented for virtual F011 mode only) (bit mask) */
#define VW_FOUND_MASK 0b00000010
/* Manually set f011_eq_inhibit signal (indented for virtual F011 mode only) (address) */
#define SD_VEQ_INH_ADDR 0xD6AF
/* Manually set f011_eq_inhibit signal (indented for virtual F011 mode only) (address) */
#define VEQ_INH_ADDR 0xD6AF
/* Manually set f011_eq_inhibit signal (indented for virtual F011 mode only) (bit mask) */
#define SD_VEQ_INH_MASK 0b00000100
/* Manually set f011_eq_inhibit signal (indented for virtual F011 mode only) (bit mask) */
#define VEQ_INH_MASK 0b00000100
/* Manually set f011_rnf signal (indented for virtual F011 mode only) (address) */
#define SD_VRNF_ADDR 0xD6AF
/* Manually set f011_rnf signal (indented for virtual F011 mode only) (address) */
#define VRNF_ADDR 0xD6AF
/* Manually set f011_rnf signal (indented for virtual F011 mode only) (bit mask) */
#define SD_VRNF_MASK 0b00001000
/* Manually set f011_rnf signal (indented for virtual F011 mode only) (bit mask) */
#define VRNF_MASK 0b00001000
/* Manually set f011_drq signal (indented for virtual F011 mode only) (address) */
#define SD_VDRQ_ADDR 0xD6AF
/* Manually set f011_drq signal (indented for virtual F011 mode only) (address) */
#define VDRQ_ADDR 0xD6AF
/* Manually set f011_drq signal (indented for virtual F011 mode only) (bit mask) */
#define SD_VDRQ_MASK 0b00010000
/* Manually set f011_drq signal (indented for virtual F011 mode only) (bit mask) */
#define VDRQ_MASK 0b00010000
/* Manually set f011_lost signal (indented for virtual F011 mode only) (address) */
#define SD_VLOST_ADDR 0xD6AF
/* Manually set f011_lost signal (indented for virtual F011 mode only) (address) */
#define VLOST_ADDR 0xD6AF
/* Manually set f011_lost signal (indented for virtual F011 mode only) (bit mask) */
#define SD_VLOST_MASK 0b00100000
/* Manually set f011_lost signal (indented for virtual F011 mode only) (bit mask) */
#define VLOST_MASK 0b00100000
/* Touch event 1 is valid (address) */
#define TOUCH_EV1_ADDR 0xD6B0
/* Touch event 1 is valid (address) */
#define EV1_ADDR 0xD6B0
/* Touch event 1 is valid (bit mask) */
#define TOUCH_EV1_MASK 0b00000001
/* Touch event 1 is valid (bit mask) */
#define EV1_MASK 0b00000001
/* Touch event 2 is valid (address) */
#define TOUCH_EV2_ADDR 0xD6B0
/* Touch event 2 is valid (address) */
#define EV2_ADDR 0xD6B0
/* Touch event 2 is valid (bit mask) */
#define TOUCH_EV2_MASK 0b00000010
/* Touch event 2 is valid (bit mask) */
#define EV2_MASK 0b00000010
/* Touch event 1 up/down state (address) */
#define TOUCH_UPDN1_ADDR 0xD6B0
/* Touch event 1 up/down state (address) */
#define UPDN1_ADDR 0xD6B0
/* Touch event 1 up/down state (bit mask) */
#define TOUCH_UPDN1_MASK 0b00001100
/* Touch event 1 up/down state (bit mask) */
#define UPDN1_MASK 0b00001100
/* Touch event 2 up/down state (address) */
#define TOUCH_UPDN2_ADDR 0xD6B0
/* Touch event 2 up/down state (address) */
#define UPDN2_ADDR 0xD6B0
/* Touch event 2 up/down state (bit mask) */
#define TOUCH_UPDN2_MASK 0b00110000
/* Touch event 2 up/down state (bit mask) */
#define UPDN2_MASK 0b00110000
/* Flip X axis of touch interface if set (address) */
#define MISCIO_TCHFLX_ADDR 0xD6B0
/* Flip X axis of touch interface if set (bit mask) */
#define MISCIO_TCHFLX_MASK 0b01000000
/* Invert horizontal axis (address) */
#define TOUCH_XINV_ADDR 0xD6B0
/* Invert horizontal axis (address) */
#define XINV_ADDR 0xD6B0
/* Invert horizontal axis (bit mask) */
#define TOUCH_XINV_MASK 0b01000000
/* Invert horizontal axis (bit mask) */
#define XINV_MASK 0b01000000
/* Flip Y axis of touch interface if set (address) */
#define GS_MISCIO_TCHFLX_ADDR 0xD6B0
/* Flip Y axis of touch interface if set (bit mask) */
#define GS_MISCIO_TCHFLX_MASK 0b10000000
/* Invert vertical axis (address) */
#define TOUCH_YINV_ADDR 0xD6B0
/* Invert vertical axis (address) */
#define YINV_ADDR 0xD6B0
/* Invert vertical axis (bit mask) */
#define TOUCH_YINV_MASK 0b10000000
/* Invert vertical axis (bit mask) */
#define YINV_MASK 0b10000000
/* Set X scale value for touch interface (LSB) */
#define MISCIO_TCHXSCALE 0xD6B1
/* Touch pad X scaling LSB */
#define TOUCH_CALXSCALELSB 0xD6B1
/* Touch pad X scaling LSB */
#define CALXSCALELSB 0xD6B1
/* Set X scale value for touch interface (MSB) */
#define GS_MISCIO_TCHXSCALE 0xD6B2
/* Touch pad X scaling MSB */
#define TOUCH_CALXSCALEMSB 0xD6B2
/* Touch pad X scaling MSB */
#define CALXSCALEMSB 0xD6B2
/* Set Y scale value for touch interface (LSB) */
#define MISCIO_TCHYSCALE 0xD6B3
/* Touch pad Y scaling LSB */
#define TOUCH_CALYSCALELSB 0xD6B3
/* Touch pad Y scaling LSB */
#define CALYSCALELSB 0xD6B3
/* Set Y scale value for touch interface (MSB) */
#define GS_MISCIO_TCHYSCALE 0xD6B4
/* Touch pad Y scaling MSB */
#define TOUCH_CALYSCALEMSB 0xD6B4
/* Touch pad Y scaling MSB */
#define CALYSCALEMSB 0xD6B4
/* Set X delta value for touch interface (LSB) */
#define MISCIO_TCHXDELTA 0xD6B5
/* Touch pad X delta LSB */
#define TOUCH_CALXDELTALSB 0xD6B5
/* Touch pad X delta LSB */
#define CALXDELTALSB 0xD6B5
/* Set Y delta value for touch interface (LSB) */
#define MISCIO_TCHYDELTA 0xD6B7
/* Touch pad Y delta LSB */
#define TOUCH_CALYDELTALSB 0xD6B7
/* Touch pad Y delta LSB */
#define CALYDELTALSB 0xD6B7
/* Set Y delta value for touch interface (MSB) */
#define GS_MISCIO_TCHYDELTA 0xD6B8
/* Touch pad Y delta MSB */
#define TOUCH_CALYDELTAMSB 0xD6B8
/* Touch pad Y delta MSB */
#define CALYDELTAMSB 0xD6B8
/* Touch pad touch #1 X LSB */
#define TOUCH_TOUCH1XLSB 0xD6B9
/* Touch pad touch #1 X LSB */
#define TOUCH1XLSB 0xD6B9
/* Touch pad touch #1 Y LSB */
#define TOUCH_TOUCH1YLSB 0xD6BA
/* Touch pad touch #1 Y LSB */
#define TOUCH1YLSB 0xD6BA
/* Set X delta value for touch interface (MSB) */
#define GS_MISCIO_TCHXDELTA 0xD6BB
/* Touch pad touch \#1 X MSBs (address) */
#define TOUCH_TOUCH1XMSB_ADDR 0xD6BB
/* Touch pad touch \#1 X MSBs (address) */
#define TOUCH1XMSB_ADDR 0xD6BB
/* Touch pad touch \#1 X MSBs (bit mask) */
#define TOUCH_TOUCH1XMSB_MASK 0b00000011
/* Touch pad touch \#1 X MSBs (bit mask) */
#define TOUCH1XMSB_MASK 0b00000011
/* Touch pad touch \#1 Y MSBs (address) */
#define TOUCH_TOUCH1YMSB_ADDR 0xD6BB
/* Touch pad touch \#1 Y MSBs (address) */
#define TOUCH1YMSB_ADDR 0xD6BB
/* Touch pad touch \#1 Y MSBs (bit mask) */
#define TOUCH_TOUCH1YMSB_MASK 0b00110000
/* Touch pad touch \#1 Y MSBs (bit mask) */
#define TOUCH1YMSB_MASK 0b00110000
/* Touch pad touch \#2 X LSB */
#define TOUCH_TOUCH2XLSB 0xD6BC
/* Touch pad touch \#2 X LSB */
#define TOUCH2XLSB 0xD6BC
/* Touch pad touch \#2 Y LSB */
#define TOUCH_TOUCH2YLSB 0xD6BD
/* Touch pad touch \#2 Y LSB */
#define TOUCH2YLSB 0xD6BD
/* Touch pad touch \#2 X MSBs (address) */
#define TOUCH_TOUCH2XMSB_ADDR 0xD6BE
/* Touch pad touch \#2 X MSBs (address) */
#define TOUCH2XMSB_ADDR 0xD6BE
/* Touch pad touch \#2 X MSBs (bit mask) */
#define TOUCH_TOUCH2XMSB_MASK 0b00000011
/* Touch pad touch \#2 X MSBs (bit mask) */
#define TOUCH2XMSB_MASK 0b00000011
/* Touch pad touch \#2 Y MSBs (address) */
#define TOUCH_TOUCH2YMSB_ADDR 0xD6BE
/* Touch pad touch \#2 Y MSBs (address) */
#define TOUCH2YMSB_ADDR 0xD6BE
/* Touch pad touch \#2 Y MSBs (bit mask) */
#define TOUCH_TOUCH2YMSB_MASK 0b00110000
/* Touch pad touch \#2 Y MSBs (bit mask) */
#define TOUCH2YMSB_MASK 0b00110000
/* Select byte number for touch panel communications instrumentation (address) */
#define MISCIO_TCHBYTENUM_ADDR 0xD6BF
/* Select byte number for touch panel communications instrumentation (address) */
#define TCHBYTENUM_ADDR 0xD6BF
/* Select byte number for touch panel communications instrumentation (bit mask) */
#define MISCIO_TCHBYTENUM_MASK 0b01111111
/* Select byte number for touch panel communications instrumentation (bit mask) */
#define TCHBYTENUM_MASK 0b01111111
/* Enable/disable touch panel I2C communications (address) */
#define MISCIO_TCHI2CEN_ADDR 0xD6BF
/* Enable/disable touch panel I2C communications (address) */
#define TCHI2CEN_ADDR 0xD6BF
/* Enable/disable touch panel I2C communications (bit mask) */
#define MISCIO_TCHI2CEN_MASK 0b10000000
/* Enable/disable touch panel I2C communications (bit mask) */
#define TCHI2CEN_MASK 0b10000000
/* Touch pad gesture directions (left,right,up,down) (address) */
#define TOUCH_GESTUREDIR_ADDR 0xD6C0
/* Touch pad gesture directions (left,right,up,down) (address) */
#define GESTUREDIR_ADDR 0xD6C0
/* Touch pad gesture directions (left,right,up,down) (bit mask) */
#define TOUCH_GESTUREDIR_MASK 0b00001111
/* Touch pad gesture directions (left,right,up,down) (bit mask) */
#define GESTUREDIR_MASK 0b00001111
/* Touch pad gesture ID (address) */
#define TOUCH_GESTUREID_ADDR 0xD6C0
/* Touch pad gesture ID (address) */
#define GESTUREID_ADDR 0xD6C0
/* Touch pad gesture ID (bit mask) */
#define TOUCH_GESTUREID_MASK 0b11110000
/* Touch pad gesture ID (bit mask) */
#define GESTUREID_MASK 0b11110000
/* Select ICAPE2 FPGA configuration register for reading WRITE ONLY */
#define FPGA_REGNUM 0xD6C4
/* Select ICAPE2 FPGA configuration register for reading WRITE ONLY */
#define REGNUM 0xD6C4
/* Value of selected ICAPE2 register (least significant byte) */
#define FPGA_REGVAL 0xD6C4
/* Value of selected ICAPE2 register */
#define GS_FPGA_REGVAL 0xD6C5
/* Value of selected ICAPE2 register */
#define GS_FPGA_REGVAL_2 0xD6C6
/* Value of selected ICAPE2 register (most significant byte) */
#define GS_FPGA_REGVAL_3 0xD6C7
/* Address of bitstream in boot flash for reconfiguration (least significant byte) */
#define FPGA_BOOTADDR0 0xD6C8
/* Address of bitstream in boot flash for reconfiguration (least significant byte) */
#define BOOTADDR0 0xD6C8
/* Address of bitstream in boot flash for reconfiguration */
#define FPGA_BOOTADDR1 0xD6C9
/* Address of bitstream in boot flash for reconfiguration */
#define BOOTADDR1 0xD6C9
/* Address of bitstream in boot flash for reconfiguration */
#define FPGA_BOOTADDR2 0xD6CA
/* Address of bitstream in boot flash for reconfiguration */
#define BOOTADDR2 0xD6CA
/* Address of bitstream in boot flash for reconfiguration (most significant byte) */
#define FPGA_BOOTADDR3 0xD6CB
/* Address of bitstream in boot flash for reconfiguration (most significant byte) */
#define BOOTADDR3 0xD6CB
/* Data bits for QSPI flash interface (read/write) (address) */
#define QSPI_DB_ADDR 0xD6CC
/* Data bits for QSPI flash interface (read/write) (address) */
#define DB_ADDR 0xD6CC
/* Data bits for QSPI flash interface (read/write) (bit mask) */
#define QSPI_DB_MASK 0b00001111
/* Data bits for QSPI flash interface (read/write) (bit mask) */
#define DB_MASK 0b00001111
/* (set to 0) (address) */
#define QSPI_RESERVED_ADDR 0xD6CC
/* (set to 0) (bit mask) */
#define QSPI_RESERVED_MASK 0b00010000
/* Clock output line for QSPI flash (address) */
#define QSPI_CLOCK_ADDR 0xD6CC
/* Clock output line for QSPI flash (bit mask) */
#define QSPI_CLOCK_MASK 0b00100000
/* Active-low chip-select for QSPI flash (address) */
#define QSPI_CSN_ADDR 0xD6CC
/* Active-low chip-select for QSPI flash (address) */
#define CSN_ADDR 0xD6CC
/* Active-low chip-select for QSPI flash (bit mask) */
#define QSPI_CSN_MASK 0b01000000
/* Active-low chip-select for QSPI flash (bit mask) */
#define CSN_MASK 0b01000000
/* Tristate DB0-3 (address) */
#define QSPI_TRI_ADDR 0xD6CC
/* Tristate DB0-3 (address) */
#define TRI_ADDR 0xD6CC
/* Tristate DB0-3 (bit mask) */
#define QSPI_TRI_MASK 0b10000000
/* Tristate DB0-3 (bit mask) */
#define TRI_MASK 0b10000000
/* Set to cause QSPI clock to free run at CPU clock frequency. (address) */
#define QSPI_CLOCKRUN_ADDR 0xD6CD
/* Set to cause QSPI clock to free run at CPU clock frequency. (address) */
#define CLOCKRUN_ADDR 0xD6CD
/* Set to cause QSPI clock to free run at CPU clock frequency. (bit mask) */
#define QSPI_CLOCKRUN_MASK 0b00000001
/* Set to cause QSPI clock to free run at CPU clock frequency. (bit mask) */
#define CLOCKRUN_MASK 0b00000001
/* Alternate address for direct manipulation of QSPI CLOCK (address) */
#define GS_QSPI_CLOCK_ADDR 0xD6CD
/* Alternate address for direct manipulation of QSPI CLOCK (bit mask) */
#define GS_QSPI_CLOCK_MASK 0b00000010
/* Write $42 to Trigger FPGA reconfiguration to switch to alternate bitstream. */
#define FPGA_RECONFTRIG 0xD6CF
/* Write $42 to Trigger FPGA reconfiguration to switch to alternate bitstream. */
#define RECONFTRIG 0xD6CF
/* I2C bus select (bus 0 = temp sensor on Nexys4 boardS) */
#define MISC_I2CBUSSELECT 0xD6D0
/* I2C bus select (bus 0 = temp sensor on Nexys4 boardS) */
#define I2CBUSSELECT 0xD6D0
/* Select I2C bus number (I2C busses vary between MEGA65 and MEGAphone variants) */
#define MISCIO_I2CBUSSEL 0xD6D0
/* Select I2C bus number (I2C busses vary between MEGA65 and MEGAphone variants) */
#define I2CBUSSEL 0xD6D0
/* I2C reset (address) */
#define MISCIO_I2CRST_ADDR 0xD6D1
/* I2C reset (address) */
#define I2CRST_ADDR 0xD6D1
/* I2C reset (bit mask) */
#define MISCIO_I2CRST_MASK 0b00000001
/* I2C reset (bit mask) */
#define I2CRST_MASK 0b00000001
/* I2C command latch write strobe (write 1 to trigger command) (address) */
#define MISCIO_I2CL_ADDR 0xD6D1
/* I2C command latch write strobe (write 1 to trigger command) (address) */
#define I2CL_ADDR 0xD6D1
/* I2C command latch write strobe (write 1 to trigger command) (bit mask) */
#define MISCIO_I2CL_MASK 0b00000010
/* I2C command latch write strobe (write 1 to trigger command) (bit mask) */
#define I2CL_MASK 0b00000010
/* I2C Select read (1) or write (0) (address) */
#define MISCIO_I2CRW_ADDR 0xD6D1
/* I2C Select read (1) or write (0) (address) */
#define I2CRW_ADDR 0xD6D1
/* I2C Select read (1) or write (0) (bit mask) */
#define MISCIO_I2CRW_MASK 0b00000100
/* I2C Select read (1) or write (0) (bit mask) */
#define I2CRW_MASK 0b00000100
/* I2C bus 1 swap SDA/SCL pins (address) */
#define MISCIO_I2CSW_ADDR 0xD6D1
/* I2C bus 1 swap SDA/SCL pins (address) */
#define I2CSW_ADDR 0xD6D1
/* I2C bus 1 swap SDA/SCL pins (bit mask) */
#define MISCIO_I2CSW_MASK 0b00100000
/* I2C bus 1 swap SDA/SCL pins (bit mask) */
#define I2CSW_MASK 0b00100000
/* I2C busy flag (address) */
#define MISCIO_I2CBSY_ADDR 0xD6D1
/* I2C busy flag (address) */
#define I2CBSY_ADDR 0xD6D1
/* I2C busy flag (bit mask) */
#define MISCIO_I2CBSY_MASK 0b01000000
/* I2C busy flag (bit mask) */
#define I2CBSY_MASK 0b01000000
/* I2C ack error (address) */
#define MISCIO_I2CERR_ADDR 0xD6D1
/* I2C ack error (address) */
#define I2CERR_ADDR 0xD6D1
/* I2C ack error (bit mask) */
#define MISCIO_I2CERR_MASK 0b10000000
/* I2C ack error (bit mask) */
#define I2CERR_MASK 0b10000000
/* I2C address (address) */
#define MISCIO_I2CADDR_ADDR 0xD6D2
/* I2C address (address) */
#define I2CADDR_ADDR 0xD6D2
/* I2C address (bit mask) */
#define MISCIO_I2CADDR_MASK 0b11111110
/* I2C address (bit mask) */
#define I2CADDR_MASK 0b11111110
/* I2C data write register */
#define MISCIO_I2CWDATA 0xD6D3
/* I2C data write register */
#define I2CWDATA 0xD6D3
/* I2C data read register */
#define MISCIO_I2CRDATA 0xD6D4
/* I2C data read register */
#define I2CRDATA 0xD6D4
/* DEBUG SD card last error code LSB */
#define MISC_SDDEBUGERRLSB 0xD6DA
/* DEBUG SD card last error code LSB */
#define SDDEBUGERRLSB 0xD6DA
/* DEBUG SD card last error code MSB */
#define MISC_SDDEBUGERRMSB 0xD6DB
/* DEBUG SD card last error code MSB */
#define SDDEBUGERRMSB 0xD6DB
/* FPGA die temperature sensor (lower nybl) */
#define FPGA_FPGATEMPLSB 0xD6DE
/* FPGA die temperature sensor (lower nybl) */
#define FPGATEMPLSB 0xD6DE
/* FPGA die temperature sensor (upper byte) */
#define FPGA_FPGATEMPMSB 0xD6DF
/* FPGA die temperature sensor (upper byte) */
#define FPGATEMPMSB 0xD6DF
/* Write 0 to hold ethernet controller under reset (address) */
#define ETH_RST_ADDR 0xD6E0
/* Write 0 to hold ethernet controller under reset (bit mask) */
#define ETH_RST_MASK 0b00000001
/* Write 0 to hold ethernet controller transmit sub-system under reset (address) */
#define ETH_TXRST_ADDR 0xD6E0
/* Write 0 to hold ethernet controller transmit sub-system under reset (address) */
#define TXRST_ADDR 0xD6E0
/* Write 0 to hold ethernet controller transmit sub-system under reset (bit mask) */
#define ETH_TXRST_MASK 0b00000010
/* Write 0 to hold ethernet controller transmit sub-system under reset (bit mask) */
#define TXRST_MASK 0b00000010
/* Read ethernet RX bits currently on the wire (address) */
#define ETH_DRXD_ADDR 0xD6E0
/* Read ethernet RX bits currently on the wire (address) */
#define DRXD_ADDR 0xD6E0
/* Read ethernet RX bits currently on the wire (bit mask) */
#define ETH_DRXD_MASK 0b00000100
/* Read ethernet RX bits currently on the wire (bit mask) */
#define DRXD_MASK 0b00000100
/* Read ethernet RX data valid (debug) (address) */
#define ETH_DRXDV_ADDR 0xD6E0
/* Read ethernet RX data valid (debug) (address) */
#define DRXDV_ADDR 0xD6E0
/* Read ethernet RX data valid (debug) (bit mask) */
#define ETH_DRXDV_MASK 0b00001000
/* Read ethernet RX data valid (debug) (bit mask) */
#define DRXDV_MASK 0b00001000
/* Allow remote keyboard input via magic ethernet frames (address) */
#define ETH_KEYEN_ADDR 0xD6E0
/* Allow remote keyboard input via magic ethernet frames (address) */
#define KEYEN_ADDR 0xD6E0
/* Allow remote keyboard input via magic ethernet frames (bit mask) */
#define ETH_KEYEN_MASK 0b00010000
/* Allow remote keyboard input via magic ethernet frames (bit mask) */
#define KEYEN_MASK 0b00010000
/* Indicate if ethernet RX is blocked until RX buffers freed (address) */
#define ETH_RXBLKD_ADDR 0xD6E0
/* Indicate if ethernet RX is blocked until RX buffers freed (address) */
#define RXBLKD_ADDR 0xD6E0
/* Indicate if ethernet RX is blocked until RX buffers freed (bit mask) */
#define ETH_RXBLKD_MASK 0b01000000
/* Indicate if ethernet RX is blocked until RX buffers freed (bit mask) */
#define RXBLKD_MASK 0b01000000
/* Ethernet transmit side is idle, i.e., a packet can be sent. (address) */
#define ETH_TXIDLE_ADDR 0xD6E0
/* Ethernet transmit side is idle, i.e., a packet can be sent. (address) */
#define TXIDLE_ADDR 0xD6E0
/* Ethernet transmit side is idle, i.e., a packet can be sent. (bit mask) */
#define ETH_TXIDLE_MASK 0b10000000
/* Ethernet transmit side is idle, i.e., a packet can be sent. (bit mask) */
#define TXIDLE_MASK 0b10000000
/* Number of free receive buffers (address) */
#define ETH_RXBF_ADDR 0xD6E1
/* Number of free receive buffers (address) */
#define RXBF_ADDR 0xD6E1
/* Number of free receive buffers (bit mask) */
#define ETH_RXBF_MASK 0b00000110
/* Number of free receive buffers (bit mask) */
#define RXBF_MASK 0b00000110
/* Enable streaming of CPU instruction stream or VIC-IV display on ethernet (address) */
#define ETH_STRM_ADDR 0xD6E1
/* Enable streaming of CPU instruction stream or VIC-IV display on ethernet (address) */
#define STRM_ADDR 0xD6E1
/* Enable streaming of CPU instruction stream or VIC-IV display on ethernet (bit mask) */
#define ETH_STRM_MASK 0b00001000
/* Enable streaming of CPU instruction stream or VIC-IV display on ethernet (bit mask) */
#define STRM_MASK 0b00001000
/* Ethernet TX IRQ status (address) */
#define ETH_TXQ_ADDR 0xD6E1
/* Ethernet TX IRQ status (address) */
#define TXQ_ADDR 0xD6E1
/* Ethernet TX IRQ status (bit mask) */
#define ETH_TXQ_MASK 0b00010000
/* Ethernet TX IRQ status (bit mask) */
#define TXQ_MASK 0b00010000
/* Ethernet RX IRQ status (address) */
#define ETH_RXQ_ADDR 0xD6E1
/* Ethernet RX IRQ status (address) */
#define RXQ_ADDR 0xD6E1
/* Ethernet RX IRQ status (bit mask) */
#define ETH_RXQ_MASK 0b00100000
/* Ethernet RX IRQ status (bit mask) */
#define RXQ_MASK 0b00100000
/* Enable ethernet TX IRQ (address) */
#define ETH_TXQEN_ADDR 0xD6E1
/* Enable ethernet TX IRQ (address) */
#define TXQEN_ADDR 0xD6E1
/* Enable ethernet TX IRQ (bit mask) */
#define ETH_TXQEN_MASK 0b01000000
/* Enable ethernet TX IRQ (bit mask) */
#define TXQEN_MASK 0b01000000
/* Enable ethernet RX IRQ (address) */
#define ETH_RXQEN_ADDR 0xD6E1
/* Enable ethernet RX IRQ (address) */
#define RXQEN_ADDR 0xD6E1
/* Enable ethernet RX IRQ (bit mask) */
#define ETH_RXQEN_MASK 0b10000000
/* Enable ethernet RX IRQ (bit mask) */
#define RXQEN_MASK 0b10000000
/* TX Packet size (low byte) */
#define ETH_TXSZLSB 0xD6E2
/* TX Packet size (low byte) */
#define TXSZLSB 0xD6E2
/* TX Packet size (high byte) */
#define ETH_TXSZMSB 0xD6E3
/* TX Packet size (high byte) */
#define TXSZMSB 0xD6E3
/* Ethernet command register (write only) */
#define ETH_COMMAND 0xD6E4
/* Ethernet disable promiscuous mode (address) */
#define ETH_NOPROM_ADDR 0xD6E5
/* Ethernet disable promiscuous mode (address) */
#define NOPROM_ADDR 0xD6E5
/* Ethernet disable promiscuous mode (bit mask) */
#define ETH_NOPROM_MASK 0b00000001
/* Ethernet disable promiscuous mode (bit mask) */
#define NOPROM_MASK 0b00000001
/* Disable CRC check for received packets (address) */
#define ETH_NOCRC_ADDR 0xD6E5
/* Disable CRC check for received packets (address) */
#define NOCRC_ADDR 0xD6E5
/* Disable CRC check for received packets (bit mask) */
#define ETH_NOCRC_MASK 0b00000010
/* Disable CRC check for received packets (bit mask) */
#define NOCRC_MASK 0b00000010
/* Ethernet TX clock phase adjust (address) */
#define ETH_TXPH_ADDR 0xD6E5
/* Ethernet TX clock phase adjust (address) */
#define TXPH_ADDR 0xD6E5
/* Ethernet TX clock phase adjust (bit mask) */
#define ETH_TXPH_MASK 0b00001100
/* Ethernet TX clock phase adjust (bit mask) */
#define TXPH_MASK 0b00001100
/* Accept broadcast frames (address) */
#define ETH_BCST_ADDR 0xD6E5
/* Accept broadcast frames (address) */
#define BCST_ADDR 0xD6E5
/* Accept broadcast frames (bit mask) */
#define ETH_BCST_MASK 0b00010000
/* Accept broadcast frames (bit mask) */
#define BCST_MASK 0b00010000
/* Accept multicast frames (address) */
#define ETH_MCST_ADDR 0xD6E5
/* Accept multicast frames (address) */
#define MCST_ADDR 0xD6E5
/* Accept multicast frames (bit mask) */
#define ETH_MCST_MASK 0b00100000
/* Accept multicast frames (bit mask) */
#define MCST_MASK 0b00100000
/* Ethernet RX clock phase adjust (address) */
#define ETH_RXPH_ADDR 0xD6E5
/* Ethernet RX clock phase adjust (address) */
#define RXPH_ADDR 0xD6E5
/* Ethernet RX clock phase adjust (bit mask) */
#define ETH_RXPH_MASK 0b11000000
/* Ethernet RX clock phase adjust (bit mask) */
#define RXPH_MASK 0b11000000
/* Ethernet MIIM register number (address) */
#define ETH_MIIMREG_ADDR 0xD6E6
/* Ethernet MIIM register number (address) */
#define MIIMREG_ADDR 0xD6E6
/* Ethernet MIIM register number (bit mask) */
#define ETH_MIIMREG_MASK 0b00011111
/* Ethernet MIIM register number (bit mask) */
#define MIIMREG_MASK 0b00011111
/* Ethernet MIIM PHY number (use 0 for Nexys4, 1 for MEGA65 r1 PCBs) (address) */
#define ETH_MIIMPHY_ADDR 0xD6E6
/* Ethernet MIIM PHY number (use 0 for Nexys4, 1 for MEGA65 r1 PCBs) (address) */
#define MIIMPHY_ADDR 0xD6E6
/* Ethernet MIIM PHY number (use 0 for Nexys4, 1 for MEGA65 r1 PCBs) (bit mask) */
#define ETH_MIIMPHY_MASK 0b11100000
/* Ethernet MIIM PHY number (use 0 for Nexys4, 1 for MEGA65 r1 PCBs) (bit mask) */
#define MIIMPHY_MASK 0b11100000
/* Ethernet MIIM register value (LSB) */
#define ETH_MIIMVLSB 0xD6E7
/* Ethernet MIIM register value (LSB) */
#define MIIMVLSB 0xD6E7
/* Ethernet MIIM register value (MSB) */
#define ETH_MIIMVMSB 0xD6E8
/* Ethernet MIIM register value (MSB) */
#define MIIMVMSB 0xD6E8
/* Ethernet MAC address */
#define ETH_MACADDR1 0xD6E9
/* Ethernet MAC address */
#define MACADDR1 0xD6E9
/* @MACADDRX */
#define ETH_MACADDR2 0xD6EA
/* @MACADDRX */
#define MACADDR2 0xD6EA
/* @MACADDRX */
#define ETH_MACADDR3 0xD6EB
/* @MACADDRX */
#define MACADDR3 0xD6EB
/* @MACADDRX */
#define ETH_MACADDR4 0xD6EC
/* @MACADDRX */
#define MACADDR4 0xD6EC
/* @MACADDRX */
#define ETH_MACADDR5 0xD6ED
/* @MACADDRX */
#define MACADDR5 0xD6ED
/* @MACADDRX */
#define ETH_MACADDR6 0xD6EE
/* @MACADDRX */
#define MACADDR6 0xD6EE
/* DEBUG show number of writes to eth RX buffer */
#define ETH_DBGRXWCOUNT 0xD6EF
/* DEBUG show number of writes to eth RX buffer */
#define DBGRXWCOUNT 0xD6EF
/* DEBUG show current ethernet TX state */
#define ETH_DBGTXSTAT 0xD6EF
/* DEBUG show current ethernet TX state */
#define DBGTXSTAT 0xD6EF
/* LCD panel brightness control */
#define MISC_LCDBRIGHTNESS 0xD6F0
/* LCD panel brightness control */
#define LCDBRIGHTNESS 0xD6F0
/* LCD panel brightness control */
#define MISCIO_LCDBRIGHT 0xD6F0
/* LCD panel brightness control */
#define LCDBRIGHT 0xD6F0
/* Read FPGA five-way buttons */
#define MISC_FPGABUTTONS 0xD6F2
/* Read FPGA five-way buttons */
#define FPGABUTTONS 0xD6F2
/* Accelerometer bit-bash interface */
#define MISC_ACCELBITBASH 0xD6F3
/* Accelerometer bit-bash interface */
#define ACCELBITBASH 0xD6F3
/* Accelerometer bit-bashing port (debug only) */
#define MISCIO_ACCELBASH 0xD6F3
/* Accelerometer bit-bashing port (debug only) */
#define ACCELBASH 0xD6F3
/* Audio Mixer register select */
#define AUDIO_MIXREGSEL 0xD6F4
/* Audio Mixer register select */
#define MIXREGSEL 0xD6F4
/* Audio Mixer register select */
#define AUDIOMIX_REGSEL 0xD6F4
/* Audio Mixer register select */
#define REGSEL 0xD6F4
/* Audio Mixer register read port */
#define AUDIO_MIXREGDATA 0xD6F5
/* Audio Mixer register read port */
#define MIXREGDATA 0xD6F5
/* Audio Mixer register write port */
#define AUDIOMIX_REGWDATA 0xD6F5
/* Audio Mixer register write port */
#define REGWDATA 0xD6F5
/* Keyboard scan code reader (lower byte) */
#define MISC_PS2KEYSCANLSB 0xD6F6
/* Keyboard scan code reader (lower byte) */
#define PS2KEYSCANLSB 0xD6F6
/* Keyboard scan code reader (upper nybl) */
#define MISC_PS2KEYSCANMSB 0xD6F7
/* Keyboard scan code reader (upper nybl) */
#define PS2KEYSCANMSB 0xD6F7
/* Digital audio, left channel, LSB */
#define AUDIO_DIGILEFTLSB 0xD6F8
/* Digital audio, left channel, LSB */
#define DIGILEFTLSB 0xD6F8
/* 16-bit digital audio out (left LSB) */
#define AUDIO_DIGILLSB 0xD6F8
/* 16-bit digital audio out (left LSB) */
#define DIGILLSB 0xD6F8
/* Digital audio, left channel, MSB */
#define AUDIO_DIGILEFTMSB 0xD6F9
/* Digital audio, left channel, MSB */
#define DIGILEFTMSB 0xD6F9
/* 16-bit digital audio out (left MSB) */
#define AUDIO_DIGILMSB 0xD6F9
/* 16-bit digital audio out (left MSB) */
#define DIGILMSB 0xD6F9
/* Digital audio, left channel, LSB */
#define AUDIO_DIGIRIGHTLSB 0xD6FA
/* Digital audio, left channel, LSB */
#define DIGIRIGHTLSB 0xD6FA
/* 16-bit digital audio out (right LSB) */
#define AUDIO_DIGIRLSB 0xD6FA
/* 16-bit digital audio out (right LSB) */
#define DIGIRLSB 0xD6FA
/* Digital audio, left channel, MSB */
#define AUDIO_DIGIRIGHTMSB 0xD6FB
/* Digital audio, left channel, MSB */
#define DIGIRIGHTMSB 0xD6FB
/* 16-bit digital audio out (right MSB) */
#define AUDIO_DIGIRMSB 0xD6FB
/* 16-bit digital audio out (right MSB) */
#define DIGIRMSB 0xD6FB
/* audio read-back LSB (source selected by $D6F4) */
#define AUDIO_READBACKLSB 0xD6FC
/* audio read-back LSB (source selected by $D6F4) */
#define READBACKLSB 0xD6FC
/* audio read-back MSB (source selected by $D6F4) */
#define AUDIO_READBACKMSB 0xD6FD
/* audio read-back MSB (source selected by $D6F4) */
#define READBACKMSB 0xD6FD
/* DMAgic DMA list address LSB, and trigger DMA (when written) */
#define DMA_ADDRLSBTRIG 0xD700
/* DMAgic DMA list address LSB, and trigger DMA (when written) */
#define ADDRLSBTRIG 0xD700
/* DMA list address high byte (address bits 8 -- 15). */
#define DMA_ADDRMSB 0xD701
/* DMA list address high byte (address bits 8 -- 15). */
#define ADDRMSB 0xD701
/* DMA list address bank (address bits 16 -- 22). Writing clears \$D704. */
#define DMA_ADDRBANK 0xD702
/* DMA list address bank (address bits 16 -- 22). Writing clears \$D704. */
#define ADDRBANK 0xD702
/* DMA enable F018B mode (adds sub-command byte) (address) */
#define DMA_EN018B_ADDR 0xD703
/* DMA enable F018B mode (adds sub-command byte) (address) */
#define EN018B_ADDR 0xD703
/* DMA enable F018B mode (adds sub-command byte) (bit mask) */
#define DMA_EN018B_MASK 0b00000001
/* DMA enable F018B mode (adds sub-command byte) (bit mask) */
#define EN018B_MASK 0b00000001
/* DMA list address mega-byte */
#define DMA_ADDRMB 0xD704
/* DMA list address mega-byte */
#define ADDRMB 0xD704
/* Set low-order byte of DMA list address, and trigger Enhanced DMA job, with list address specified as 28-bit flat address (uses DMA option list) */
#define DMA_ETRIG 0xD705
/* Set low-order byte of DMA list address, and trigger Enhanced DMA job, with list address specified as 28-bit flat address (uses DMA option list) */
#define ETRIG 0xD705
/* Set low-order byte of DMA list address, and trigger Enhanced DMA job, with list in current CPU memory map (uses DMA option list) */
#define DMA_ETRIGMAPD 0xD706
/* Set low-order byte of DMA list address, and trigger Enhanced DMA job, with list in current CPU memory map (uses DMA option list) */
#define ETRIGMAPD 0xD706
/* DMA list address low byte (address bits 0 -- 7) WITHOUT STARTING A DMA JOB (used by Hypervisor for unfreezing DMA-using tasks) */
#define DMA_ADDRLSB 0xD70E
/* DMA list address low byte (address bits 0 -- 7) WITHOUT STARTING A DMA JOB (used by Hypervisor for unfreezing DMA-using tasks) */
#define ADDRLSB 0xD70E
/* Set if hardware multiplier is busy (address) */
#define MATH_MULBUSY_ADDR 0xD70F
/* Set if hardware multiplier is busy (address) */
#define MULBUSY_ADDR 0xD70F
/* Set if hardware multiplier is busy (bit mask) */
#define MATH_MULBUSY_MASK 0b01000000
/* Set if hardware multiplier is busy (bit mask) */
#define MULBUSY_MASK 0b01000000
/* Set if hardware divider is busy (address) */
#define MATH_DIVBUSY_ADDR 0xD70F
/* Set if hardware divider is busy (address) */
#define DIVBUSY_ADDR 0xD70F
/* Set if hardware divider is busy (bit mask) */
#define MATH_DIVBUSY_MASK 0b10000000
/* Set if hardware divider is busy (bit mask) */
#define DIVBUSY_MASK 0b10000000
/* Enable badline emulation (address) */
#define CPU_BADLEN_ADDR 0xD710
/* Enable badline emulation (address) */
#define BADLEN_ADDR 0xD710
/* Enable badline emulation (bit mask) */
#define CPU_BADLEN_MASK 0b00000001
/* Enable badline emulation (bit mask) */
#define BADLEN_MASK 0b00000001
/* Enable 6502-style slow (7 cycle) interrupts (address) */
#define CPU_SLIEN_ADDR 0xD710
/* Enable 6502-style slow (7 cycle) interrupts (address) */
#define SLIEN_ADDR 0xD710
/* Enable 6502-style slow (7 cycle) interrupts (bit mask) */
#define CPU_SLIEN_MASK 0b00000010
/* Enable 6502-style slow (7 cycle) interrupts (bit mask) */
#define SLIEN_MASK 0b00000010
/* Enable VDC inteface simulation (address) */
#define MISC_VDCSEN_ADDR 0xD710
/* Enable VDC inteface simulation (address) */
#define VDCSEN_ADDR 0xD710
/* Enable VDC inteface simulation (bit mask) */
#define MISC_VDCSEN_MASK 0b00000100
/* Enable VDC inteface simulation (bit mask) */
#define VDCSEN_MASK 0b00000100
/* 1=charge extra cycle(s) for branches taken (address) */
#define CPU_BRCOST_ADDR 0xD710
/* 1=charge extra cycle(s) for branches taken (address) */
#define BRCOST_ADDR 0xD710
/* 1=charge extra cycle(s) for branches taken (bit mask) */
#define CPU_BRCOST_MASK 0b00001000
/* 1=charge extra cycle(s) for branches taken (bit mask) */
#define BRCOST_MASK 0b00001000
/* Cost of badlines minus 40. ie. 00=40 cycles, 11 = 43 cycles. (address) */
#define CPU_BADEXTRA_ADDR 0xD710
/* Cost of badlines minus 40. ie. 00=40 cycles, 11 = 43 cycles. (address) */
#define BADEXTRA_ADDR 0xD710
/* Cost of badlines minus 40. ie. 00=40 cycles, 11 = 43 cycles. (bit mask) */
#define CPU_BADEXTRA_MASK 0b00110000
/* Cost of badlines minus 40. ie. 00=40 cycles, 11 = 43 cycles. (bit mask) */
#define BADEXTRA_MASK 0b00110000
/* Audio DMA block timeout (read only) DEBUG (address) */
#define DMA_AUD_BLKTO_ADDR 0xD711
/* Audio DMA block timeout (read only) DEBUG (address) */
#define AUD_BLKTO_ADDR 0xD711
/* Audio DMA block timeout (read only) DEBUG (bit mask) */
#define DMA_AUD_BLKTO_MASK 0b00000111
/* Audio DMA block timeout (read only) DEBUG (bit mask) */
#define AUD_BLKTO_MASK 0b00000111
/* PWM/PDM audio encoding select (address) */
#define AUDIO_PWMPDM_ADDR 0xD711
/* PWM/PDM audio encoding select (address) */
#define PWMPDM_ADDR 0xD711
/* PWM/PDM audio encoding select (bit mask) */
#define AUDIO_PWMPDM_MASK 0b00001000
/* PWM/PDM audio encoding select (bit mask) */
#define PWMPDM_MASK 0b00001000
/* Audio DMA bypasses audio mixer (address) */
#define DMA_NOMIX_ADDR 0xD711
/* Audio DMA bypasses audio mixer (address) */
#define NOMIX_ADDR 0xD711
/* Audio DMA bypasses audio mixer (bit mask) */
#define DMA_NOMIX_MASK 0b00010000
/* Audio DMA bypasses audio mixer (bit mask) */
#define NOMIX_MASK 0b00010000
/* Audio DMA block writes (samples still get read) (address) */
#define DMA_AUD_WRBLK_ADDR 0xD711
/* Audio DMA block writes (samples still get read) (address) */
#define AUD_WRBLK_ADDR 0xD711
/* Audio DMA block writes (samples still get read) (bit mask) */
#define DMA_AUD_WRBLK_MASK 0b00100000
/* Audio DMA block writes (samples still get read) (bit mask) */
#define AUD_WRBLK_MASK 0b00100000
/* Audio DMA blocked (read only) DEBUG (address) */
#define DMA_BLKD_ADDR 0xD711
/* Audio DMA blocked (read only) DEBUG (address) */
#define BLKD_ADDR 0xD711
/* Audio DMA blocked (read only) DEBUG (bit mask) */
#define DMA_BLKD_MASK 0b01000000
/* Audio DMA blocked (read only) DEBUG (bit mask) */
#define BLKD_MASK 0b01000000
/* Enable Audio DMA (address) */
#define DMA_AUDEN_ADDR 0xD711
/* Enable Audio DMA (address) */
#define AUDEN_ADDR 0xD711
/* Enable Audio DMA (bit mask) */
#define DMA_AUDEN_MASK 0b10000000
/* Enable Audio DMA (bit mask) */
#define AUDEN_MASK 0b10000000
/* Audio DMA channel 0 right channel volume */
#define DMA_CH0RVOL 0xD71C
/* Audio DMA channel 0 right channel volume */
#define CH0RVOL 0xD71C
/* Audio DMA channel 1 right channel volume */
#define DMA_CH1RVOL 0xD71D
/* Audio DMA channel 1 right channel volume */
#define CH1RVOL 0xD71D
/* Audio DMA channel 2 left channel volume */
#define DMA_CH2LVOL 0xD71E
/* Audio DMA channel 2 left channel volume */
#define CH2LVOL 0xD71E
/* Audio DMA channel 3 left channel volume */
#define DMA_CH3LVOL 0xD71F
/* Audio DMA channel 3 left channel volume */
#define CH3LVOL 0xD71F
/* Audio DMA channel X sample bits (11=16, 10=8, 01=upper nybl, 00=lower nybl) (address) */
#define DMA_CH0_SBITS_ADDR 0xD720
/* Audio DMA channel X sample bits (11=16, 10=8, 01=upper nybl, 00=lower nybl) (address) */
#define CH0_SBITS_ADDR 0xD720
/* Audio DMA channel X sample bits (11=16, 10=8, 01=upper nybl, 00=lower nybl) (bit mask) */
#define DMA_CH0_SBITS_MASK 0b00000011
/* Audio DMA channel X sample bits (11=16, 10=8, 01=upper nybl, 00=lower nybl) (bit mask) */
#define CH0_SBITS_MASK 0b00000011
/* Audio DMA channel X stop flag (address) */
#define DMA_CH0_STP_ADDR 0xD720
/* Audio DMA channel X stop flag (address) */
#define CH0_STP_ADDR 0xD720
/* Audio DMA channel X stop flag (bit mask) */
#define DMA_CH0_STP_MASK 0b00001000
/* Audio DMA channel X stop flag (bit mask) */
#define CH0_STP_MASK 0b00001000
/* Audio DMA channel X play 32-sample sine wave instead of DMA data (address) */
#define DMA_CH0_SINE_ADDR 0xD720
/* Audio DMA channel X play 32-sample sine wave instead of DMA data (address) */
#define CH0_SINE_ADDR 0xD720
/* Audio DMA channel X play 32-sample sine wave instead of DMA data (bit mask) */
#define DMA_CH0_SINE_MASK 0b00010000
/* Audio DMA channel X play 32-sample sine wave instead of DMA data (bit mask) */
#define CH0_SINE_MASK 0b00010000
/* Enable Audio DMA channel X signed samples (address) */
#define DMA_CH0_SGN_ADDR 0xD720
/* Enable Audio DMA channel X signed samples (address) */
#define CH0_SGN_ADDR 0xD720
/* Enable Audio DMA channel X signed samples (bit mask) */
#define DMA_CH0_SGN_MASK 0b00100000
/* Enable Audio DMA channel X signed samples (bit mask) */
#define CH0_SGN_MASK 0b00100000
/* Enable Audio DMA channel X looping (address) */
#define DMA_CH0_LOOP_ADDR 0xD720
/* Enable Audio DMA channel X looping (address) */
#define CH0_LOOP_ADDR 0xD720
/* Enable Audio DMA channel X looping (bit mask) */
#define DMA_CH0_LOOP_MASK 0b01000000
/* Enable Audio DMA channel X looping (bit mask) */
#define CH0_LOOP_MASK 0b01000000
/* Enable Audio DMA channel X (address) */
#define DMA_CH0_EN_ADDR 0xD720
/* Enable Audio DMA channel X (address) */
#define CH0_EN_ADDR 0xD720
/* Enable Audio DMA channel X (bit mask) */
#define DMA_CH0_EN_MASK 0b10000000
/* Enable Audio DMA channel X (bit mask) */
#define CH0_EN_MASK 0b10000000
/* Audio DMA channel X base address LSB */
#define DMA_CH0BADDRL 0xD721
/* Audio DMA channel X base address LSB */
#define CH0BADDRL 0xD721
/* Audio DMA channel X base address middle byte */
#define DMA_CH0BADDRC 0xD722
/* Audio DMA channel X base address middle byte */
#define CH0BADDRC 0xD722
/* Audio DMA channel X base address MSB */
#define DMA_CH0BADDRM 0xD723
/* Audio DMA channel X base address MSB */
#define CH0BADDRM 0xD723
/* Audio DMA channel X frequency LSB */
#define DMA_CH0FREQL 0xD724
/* Audio DMA channel X frequency LSB */
#define CH0FREQL 0xD724
/* Audio DMA channel X frequency middle byte */
#define DMA_CH0FREQC 0xD725
/* Audio DMA channel X frequency middle byte */
#define CH0FREQC 0xD725
/* Audio DMA channel X frequency MSB */
#define DMA_CH0FREQM 0xD726
/* Audio DMA channel X frequency MSB */
#define CH0FREQM 0xD726
/* Audio DMA channel X top address LSB */
#define DMA_CH0TADDRL 0xD727
/* Audio DMA channel X top address LSB */
#define CH0TADDRL 0xD727
/* Audio DMA channel X top address MSB */
#define DMA_CH0TADDRM 0xD728
/* Audio DMA channel X top address MSB */
#define CH0TADDRM 0xD728
/* Audio DMA channel X playback volume */
#define DMA_CH0VOLUME 0xD729
/* Audio DMA channel X playback volume */
#define CH0VOLUME 0xD729
/* Audio DMA channel X current address LSB */
#define DMA_CH0CURADDRL 0xD72A
/* Audio DMA channel X current address LSB */
#define CH0CURADDRL 0xD72A
/* Audio DMA channel X current address middle byte */
#define DMA_CH0CURADDRC 0xD72B
/* Audio DMA channel X current address middle byte */
#define CH0CURADDRC 0xD72B
/* Audio DMA channel X current address MSB */
#define DMA_CH0CURADDRM 0xD72C
/* Audio DMA channel X current address MSB */
#define CH0CURADDRM 0xD72C
/* Audio DMA channel X timing counter LSB */
#define DMA_CH0TMRADDRL 0xD72D
/* Audio DMA channel X timing counter LSB */
#define CH0TMRADDRL 0xD72D
/* Audio DMA channel X timing counter middle byte */
#define DMA_CH0TMRADDRC 0xD72E
/* Audio DMA channel X timing counter middle byte */
#define CH0TMRADDRC 0xD72E
/* Audio DMA channel X timing counter MSB */
#define DMA_CH0TMRADDRM 0xD72F
/* Audio DMA channel X timing counter MSB */
#define CH0TMRADDRM 0xD72F
/* @CHXSBITS (address) */
#define DMA_CH1_SBITS_ADDR 0xD730
/* @CHXSBITS (address) */
#define CH1_SBITS_ADDR 0xD730
/* @CHXSBITS (bit mask) */
#define DMA_CH1_SBITS_MASK 0b00000011
/* @CHXSBITS (bit mask) */
#define CH1_SBITS_MASK 0b00000011
/* @CHXSTP (address) */
#define DMA_CH1_STP_ADDR 0xD730
/* @CHXSTP (address) */
#define CH1_STP_ADDR 0xD730
/* @CHXSTP (bit mask) */
#define DMA_CH1_STP_MASK 0b00001000
/* @CHXSTP (bit mask) */
#define CH1_STP_MASK 0b00001000
/* @CHXSINE (address) */
#define DMA_CH1_SINE_ADDR 0xD730
/* @CHXSINE (address) */
#define CH1_SINE_ADDR 0xD730
/* @CHXSINE (bit mask) */
#define DMA_CH1_SINE_MASK 0b00010000
/* @CHXSINE (bit mask) */
#define CH1_SINE_MASK 0b00010000
/* @CHXSGN (address) */
#define DMA_CH1_SGN_ADDR 0xD730
/* @CHXSGN (address) */
#define CH1_SGN_ADDR 0xD730
/* @CHXSGN (bit mask) */
#define DMA_CH1_SGN_MASK 0b00100000
/* @CHXSGN (bit mask) */
#define CH1_SGN_MASK 0b00100000
/* @CHXLOOP (address) */
#define DMA_CH1_LOOP_ADDR 0xD730
/* @CHXLOOP (address) */
#define CH1_LOOP_ADDR 0xD730
/* @CHXLOOP (bit mask) */
#define DMA_CH1_LOOP_MASK 0b01000000
/* @CHXLOOP (bit mask) */
#define CH1_LOOP_MASK 0b01000000
/* @CHXEN (address) */
#define DMA_CH1_EN_ADDR 0xD730
/* @CHXEN (address) */
#define CH1_EN_ADDR 0xD730
/* @CHXEN (bit mask) */
#define DMA_CH1_EN_MASK 0b10000000
/* @CHXEN (bit mask) */
#define CH1_EN_MASK 0b10000000
/* @CHXBADDRL */
#define DMA_CH1BADDRL 0xD731
/* @CHXBADDRL */
#define CH1BADDRL 0xD731
/* @CHXBADDRC */
#define DMA_CH1BADDRC 0xD732
/* @CHXBADDRC */
#define CH1BADDRC 0xD732
/* @CHXBADDRM */
#define DMA_CH1BADDRM 0xD733
/* @CHXBADDRM */
#define CH1BADDRM 0xD733
/* @CHXFREQL */
#define DMA_CH1FREQL 0xD734
/* @CHXFREQL */
#define CH1FREQL 0xD734
/* @CHXFREQC */
#define DMA_CH1FREQC 0xD735
/* @CHXFREQC */
#define CH1FREQC 0xD735
/* @CHXFREQM */
#define DMA_CH1FREQM 0xD736
/* @CHXFREQM */
#define CH1FREQM 0xD736
/* @CHXTADDRL */
#define DMA_CH1TADDRL 0xD737
/* @CHXTADDRL */
#define CH1TADDRL 0xD737
/* @CHXTADDRM */
#define DMA_CH1TADDRM 0xD738
/* @CHXTADDRM */
#define CH1TADDRM 0xD738
/* @CHXVOLUME */
#define DMA_CH1VOLUME 0xD739
/* @CHXVOLUME */
#define CH1VOLUME 0xD739
/* @CHXCURADDRL */
#define DMA_CH1CURADDRL 0xD73A
/* @CHXCURADDRL */
#define CH1CURADDRL 0xD73A
/* @CHXCURADDRC */
#define DMA_CH1CURADDRC 0xD73B
/* @CHXCURADDRC */
#define CH1CURADDRC 0xD73B
/* @CHXCURADDRM */
#define DMA_CH1CURADDRM 0xD73C
/* @CHXCURADDRM */
#define CH1CURADDRM 0xD73C
/* @CHXTMRADDRL */
#define DMA_CH1TMRADDRL 0xD73D
/* @CHXTMRADDRL */
#define CH1TMRADDRL 0xD73D
/* @CHXTMRADDRC */
#define DMA_CH1TMRADDRC 0xD73E
/* @CHXTMRADDRC */
#define CH1TMRADDRC 0xD73E
/* @CHXTMRADDRM */
#define DMA_CH1TMRADDRM 0xD73F
/* @CHXTMRADDRM */
#define CH1TMRADDRM 0xD73F
/* @CHXSBITS (address) */
#define DMA_CH2_SBITS_ADDR 0xD740
/* @CHXSBITS (address) */
#define CH2_SBITS_ADDR 0xD740
/* @CHXSBITS (bit mask) */
#define DMA_CH2_SBITS_MASK 0b00000011
/* @CHXSBITS (bit mask) */
#define CH2_SBITS_MASK 0b00000011
/* @CHXSTP (address) */
#define DMA_CH2_STP_ADDR 0xD740
/* @CHXSTP (address) */
#define CH2_STP_ADDR 0xD740
/* @CHXSTP (bit mask) */
#define DMA_CH2_STP_MASK 0b00001000
/* @CHXSTP (bit mask) */
#define CH2_STP_MASK 0b00001000
/* @CHXSINE (address) */
#define DMA_CH2_SINE_ADDR 0xD740
/* @CHXSINE (address) */
#define CH2_SINE_ADDR 0xD740
/* @CHXSINE (bit mask) */
#define DMA_CH2_SINE_MASK 0b00010000
/* @CHXSINE (bit mask) */
#define CH2_SINE_MASK 0b00010000
/* @CHXSGN (address) */
#define DMA_CH2_SGN_ADDR 0xD740
/* @CHXSGN (address) */
#define CH2_SGN_ADDR 0xD740
/* @CHXSGN (bit mask) */
#define DMA_CH2_SGN_MASK 0b00100000
/* @CHXSGN (bit mask) */
#define CH2_SGN_MASK 0b00100000
/* @CHXLOOP (address) */
#define DMA_CH2_LOOP_ADDR 0xD740
/* @CHXLOOP (address) */
#define CH2_LOOP_ADDR 0xD740
/* @CHXLOOP (bit mask) */
#define DMA_CH2_LOOP_MASK 0b01000000
/* @CHXLOOP (bit mask) */
#define CH2_LOOP_MASK 0b01000000
/* @CHXEN (address) */
#define DMA_CH2_EN_ADDR 0xD740
/* @CHXEN (address) */
#define CH2_EN_ADDR 0xD740
/* @CHXEN (bit mask) */
#define DMA_CH2_EN_MASK 0b10000000
/* @CHXEN (bit mask) */
#define CH2_EN_MASK 0b10000000
/* @CHXBADDRL */
#define DMA_CH2BADDRL 0xD741
/* @CHXBADDRL */
#define CH2BADDRL 0xD741
/* @CHXBADDRC */
#define DMA_CH2BADDRC 0xD742
/* @CHXBADDRC */
#define CH2BADDRC 0xD742
/* @CHXBADDRM */
#define DMA_CH2BADDRM 0xD743
/* @CHXBADDRM */
#define CH2BADDRM 0xD743
/* @CHXFREQL */
#define DMA_CH2FREQL 0xD744
/* @CHXFREQL */
#define CH2FREQL 0xD744
/* @CHXFREQC */
#define DMA_CH2FREQC 0xD745
/* @CHXFREQC */
#define CH2FREQC 0xD745
/* @CHXFREQM */
#define DMA_CH2FREQM 0xD746
/* @CHXFREQM */
#define CH2FREQM 0xD746
/* @CHXTADDRL */
#define DMA_CH2TADDRL 0xD747
/* @CHXTADDRL */
#define CH2TADDRL 0xD747
/* @CHXTADDRM */
#define DMA_CH2TADDRM 0xD748
/* @CHXTADDRM */
#define CH2TADDRM 0xD748
/* @CHXVOLUME */
#define DMA_CH2VOLUME 0xD749
/* @CHXVOLUME */
#define CH2VOLUME 0xD749
/* @CHXCURADDRL */
#define DMA_CH2CURADDRL 0xD74A
/* @CHXCURADDRL */
#define CH2CURADDRL 0xD74A
/* @CHXCURADDRC */
#define DMA_CH2CURADDRC 0xD74B
/* @CHXCURADDRC */
#define CH2CURADDRC 0xD74B
/* @CHXCURADDRM */
#define DMA_CH2CURADDRM 0xD74C
/* @CHXCURADDRM */
#define CH2CURADDRM 0xD74C
/* @CHXTMRADDRL */
#define DMA_CH2TMRADDRL 0xD74D
/* @CHXTMRADDRL */
#define CH2TMRADDRL 0xD74D
/* @CHXTMRADDRC */
#define DMA_CH2TMRADDRC 0xD74E
/* @CHXTMRADDRC */
#define CH2TMRADDRC 0xD74E
/* @CHXTMRADDRM */
#define DMA_CH2TMRADDRM 0xD74F
/* @CHXTMRADDRM */
#define CH2TMRADDRM 0xD74F
/* @CHXSBITS (address) */
#define DMA_CH3_SBITS_ADDR 0xD750
/* @CHXSBITS (address) */
#define CH3_SBITS_ADDR 0xD750
/* @CHXSBITS (bit mask) */
#define DMA_CH3_SBITS_MASK 0b00000011
/* @CHXSBITS (bit mask) */
#define CH3_SBITS_MASK 0b00000011
/* @CHXSTP (address) */
#define DMA_CH3_STP_ADDR 0xD750
/* @CHXSTP (address) */
#define CH3_STP_ADDR 0xD750
/* @CHXSTP (bit mask) */
#define DMA_CH3_STP_MASK 0b00001000
/* @CHXSTP (bit mask) */
#define CH3_STP_MASK 0b00001000
/* @CHXSINE (address) */
#define DMA_CH3_SINE_ADDR 0xD750
/* @CHXSINE (address) */
#define CH3_SINE_ADDR 0xD750
/* @CHXSINE (bit mask) */
#define DMA_CH3_SINE_MASK 0b00010000
/* @CHXSINE (bit mask) */
#define CH3_SINE_MASK 0b00010000
/* @CHXSGN (address) */
#define DMA_CH3_SGN_ADDR 0xD750
/* @CHXSGN (address) */
#define CH3_SGN_ADDR 0xD750
/* @CHXSGN (bit mask) */
#define DMA_CH3_SGN_MASK 0b00100000
/* @CHXSGN (bit mask) */
#define CH3_SGN_MASK 0b00100000
/* @CHXLOOP (address) */
#define DMA_CH3_LOOP_ADDR 0xD750
/* @CHXLOOP (address) */
#define CH3_LOOP_ADDR 0xD750
/* @CHXLOOP (bit mask) */
#define DMA_CH3_LOOP_MASK 0b01000000
/* @CHXLOOP (bit mask) */
#define CH3_LOOP_MASK 0b01000000
/* @CHXEN (address) */
#define DMA_CH3_EN_ADDR 0xD750
/* @CHXEN (address) */
#define CH3_EN_ADDR 0xD750
/* @CHXEN (bit mask) */
#define DMA_CH3_EN_MASK 0b10000000
/* @CHXEN (bit mask) */
#define CH3_EN_MASK 0b10000000
/* @CHXBADDRL */
#define DMA_CH3BADDRL 0xD751
/* @CHXBADDRL */
#define CH3BADDRL 0xD751
/* @CHXBADDRC */
#define DMA_CH3BADDRC 0xD752
/* @CHXBADDRC */
#define CH3BADDRC 0xD752
/* @CHXBADDRM */
#define DMA_CH3BADDRM 0xD753
/* @CHXBADDRM */
#define CH3BADDRM 0xD753
/* @CHXFREQL */
#define DMA_CH3FREQL 0xD754
/* @CHXFREQL */
#define CH3FREQL 0xD754
/* @CHXFREQC */
#define DMA_CH3FREQC 0xD755
/* @CHXFREQC */
#define CH3FREQC 0xD755
/* @CHXFREQM */
#define DMA_CH3FREQM 0xD756
/* @CHXFREQM */
#define CH3FREQM 0xD756
/* @CHXTADDRL */
#define DMA_CH3TADDRL 0xD757
/* @CHXTADDRL */
#define CH3TADDRL 0xD757
/* @CHXTADDRM */
#define DMA_CH3TADDRM 0xD758
/* @CHXTADDRM */
#define CH3TADDRM 0xD758
/* @CHXVOLUME */
#define DMA_CH3VOLUME 0xD759
/* @CHXVOLUME */
#define CH3VOLUME 0xD759
/* @CHXCURADDRL */
#define DMA_CH3CURADDRL 0xD75A
/* @CHXCURADDRL */
#define CH3CURADDRL 0xD75A
/* @CHXCURADDRC */
#define DMA_CH3CURADDRC 0xD75B
/* @CHXCURADDRC */
#define CH3CURADDRC 0xD75B
/* @CHXCURADDRM */
#define DMA_CH3CURADDRM 0xD75C
/* @CHXCURADDRM */
#define CH3CURADDRM 0xD75C
/* @CHXTMRADDRL */
#define DMA_CH3TMRADDRL 0xD75D
/* @CHXTMRADDRL */
#define CH3TMRADDRL 0xD75D
/* @CHXTMRADDRC */
#define DMA_CH3TMRADDRC 0xD75E
/* @CHXTMRADDRC */
#define CH3TMRADDRC 0xD75E
/* @CHXTMRADDRM */
#define DMA_CH3TMRADDRM 0xD75F
/* @CHXTMRADDRM */
#define CH3TMRADDRM 0xD75F
/* 64-bit output of MULTINA $\div$ MULTINB */
#define MATH_DIVOUT 0xD768
/* 64-bit output of MULTINA $\div$ MULTINB */
#define GS_MATH_DIVOUT 0xD769
/* 64-bit output of MULTINA $\div$ MULTINB */
#define GS_MATH_DIVOUT_2 0xD76A
/* 64-bit output of MULTINA $\div$ MULTINB */
#define GS_MATH_DIVOUT_3 0xD76B
/* 64-bit output of MULTINA $\div$ MULTINB */
#define GS_MATH_DIVOUT_4 0xD76C
/* 64-bit output of MULTINA $\div$ MULTINB */
#define GS_MATH_DIVOUT_5 0xD76D
/* 64-bit output of MULTINA $\div$ MULTINB */
#define GS_MATH_DIVOUT_6 0xD76E
/* 64-bit output of MULTINA $\div$ MULTINB */
#define GS_MATH_DIVOUT_7 0xD76F
/* Multiplier input A / Divider numerator (32 bit) */
#define MATH_MULTINA 0xD770
/* Multiplier input A / Divider numerator (32 bit) */
#define GS_MATH_MULTINA 0xD771
/* Multiplier input A / Divider numerator (32 bit) */
#define GS_MATH_MULTINA_2 0xD772
/* Multiplier input A / Divider numerator (32 bit) */
#define GS_MATH_MULTINA_3 0xD773
/* Multiplier input B / Divider denominator (32 bit) */
#define MATH_MULTINB 0xD774
/* Multiplier input B / Divider denominator (32 bit) */
#define GS_MATH_MULTINB 0xD775
/* Multiplier input B / Divider denominator (32 bit) */
#define GS_MATH_MULTINB_2 0xD776
/* Multiplier input B / Divider denominator (32 bit) */
#define GS_MATH_MULTINB_3 0xD777
/* 64-bit output of MULTINA $\times$ MULTINB */
#define MATH_MULTOUT 0xD778
/* 64-bit output of MULTINA $\times$ MULTINB */
#define GS_MATH_MULTOUT 0xD779
/* 64-bit output of MULTINA $\times$ MULTINB */
#define GS_MATH_MULTOUT_2 0xD77A
/* 64-bit output of MULTINA $\times$ MULTINB */
#define GS_MATH_MULTOUT_3 0xD77B
/* 64-bit output of MULTINA $\times$ MULTINB */
#define GS_MATH_MULTOUT_4 0xD77C
/* 64-bit output of MULTINA $\times$ MULTINB */
#define GS_MATH_MULTOUT_5 0xD77D
/* 64-bit output of MULTINA $\times$ MULTINB */
#define GS_MATH_MULTOUT_6 0xD77E
/* 64-bit output of MULTINA $\times$ MULTINB */
#define GS_MATH_MULTOUT_7 0xD77F
/* Math unit 32-bit input X */
#define MATH_MATHIN0 0xD780
/* @MATHINX */
#define GS_MATH_MATHIN0 0xD781
/* @MATHINX */
#define GS_MATH_MATHIN0_2 0xD782
/* @MATHINX */
#define GS_MATH_MATHIN0_3 0xD783
/* @MATHINX */
#define MATH_MATHIN1 0xD784
/* @MATHINX */
#define GS_MATH_MATHIN1 0xD785
/* @MATHINX */
#define GS_MATH_MATHIN1_2 0xD786
/* @MATHINX */
#define GS_MATH_MATHIN1_3 0xD787
/* @MATHINX */
#define MATH_MATHIN2 0xD788
/* @MATHINX */
#define GS_MATH_MATHIN2 0xD789
/* @MATHINX */
#define GS_MATH_MATHIN2_2 0xD78A
/* @MATHINX */
#define GS_MATH_MATHIN2_3 0xD78B
/* @MATHINX */
#define MATH_MATHIN3 0xD78C
/* @MATHINX */
#define GS_MATH_MATHIN3 0xD78D
/* @MATHINX */
#define GS_MATH_MATHIN3_2 0xD78E
/* @MATHINX */
#define GS_MATH_MATHIN3_3 0xD78F
/* @MATHINX */
#define MATH_MATHIN4 0xD790
/* @MATHINX */
#define GS_MATH_MATHIN4 0xD791
/* @MATHINX */
#define GS_MATH_MATHIN4_2 0xD792
/* @MATHINX */
#define GS_MATH_MATHIN4_3 0xD793
/* @MATHINX */
#define MATH_MATHIN5 0xD794
/* @MATHINX */
#define GS_MATH_MATHIN5 0xD795
/* @MATHINX */
#define GS_MATH_MATHIN5_2 0xD796
/* @MATHINX */
#define GS_MATH_MATHIN5_3 0xD797
/* @MATHINX */
#define MATH_MATHIN6 0xD798
/* @MATHINX */
#define GS_MATH_MATHIN6 0xD799
/* @MATHINX */
#define GS_MATH_MATHIN6_2 0xD79A
/* @MATHINX */
#define GS_MATH_MATHIN6_3 0xD79B
/* @MATHINX */
#define MATH_MATHIN7 0xD79C
/* @MATHINX */
#define GS_MATH_MATHIN7 0xD79D
/* @MATHINX */
#define GS_MATH_MATHIN7_2 0xD79E
/* @MATHINX */
#define GS_MATH_MATHIN7_3 0xD79F
/* @MATHINX */
#define MATH_MATHIN8 0xD7A0
/* @MATHINX */
#define GS_MATH_MATHIN8 0xD7A1
/* @MATHINX */
#define GS_MATH_MATHIN8_2 0xD7A2
/* @MATHINX */
#define GS_MATH_MATHIN8_3 0xD7A3
/* @MATHINX */
#define MATH_MATHIN9 0xD7A4
/* @MATHINX */
#define GS_MATH_MATHIN9 0xD7A5
/* @MATHINX */
#define GS_MATH_MATHIN9_2 0xD7A6
/* @MATHINX */
#define GS_MATH_MATHIN9_3 0xD7A7
/* @MATHINX */
#define MATH_MATHINA 0xD7A8
/* @MATHINX */
#define GS_MATH_MATHINA 0xD7A9
/* @MATHINX */
#define GS_MATH_MATHINA_2 0xD7AA
/* @MATHINX */
#define GS_MATH_MATHINA_3 0xD7AB
/* @MATHINX */
#define MATH_MATHINB 0xD7AC
/* @MATHINX */
#define GS_MATH_MATHINB 0xD7AD
/* @MATHINX */
#define GS_MATH_MATHINB_2 0xD7AE
/* @MATHINX */
#define GS_MATH_MATHINB_3 0xD7AF
/* @MATHINX */
#define MATH_MATHINC 0xD7B0
/* @MATHINX */
#define GS_MATH_MATHINC 0xD7B1
/* @MATHINX */
#define GS_MATH_MATHINC_2 0xD7B2
/* @MATHINX */
#define GS_MATH_MATHINC_3 0xD7B3
/* @MATHINX */
#define MATH_MATHIND 0xD7B4
/* @MATHINX */
#define GS_MATH_MATHIND 0xD7B5
/* @MATHINX */
#define GS_MATH_MATHIND_2 0xD7B6
/* @MATHINX */
#define GS_MATH_MATHIND_3 0xD7B7
/* @MATHINX */
#define MATH_MATHINE 0xD7B8
/* @MATHINX */
#define GS_MATH_MATHINE 0xD7B9
/* @MATHINX */
#define GS_MATH_MATHINE_2 0xD7BA
/* @MATHINX */
#define GS_MATH_MATHINE_3 0xD7BB
/* @MATHINX */
#define MATH_MATHINF 0xD7BC
/* @MATHINX */
#define GS_MATH_MATHINF 0xD7BD
/* @MATHINX */
#define GS_MATH_MATHINF_2 0xD7BE
/* @MATHINX */
#define GS_MATH_MATHINF_3 0xD7BF
/* Select which of the 16 32-bit math registers is input A for Math Function Unit X. (address) */
#define MATH_UNIT0INA_ADDR 0xD7C0
/* Select which of the 16 32-bit math registers is input A for Math Function Unit X. (address) */
#define UNIT0INA_ADDR 0xD7C0
/* Select which of the 16 32-bit math registers is input A for Math Function Unit X. (bit mask) */
#define MATH_UNIT0INA_MASK 0b00001111
/* Select which of the 16 32-bit math registers is input A for Math Function Unit X. (bit mask) */
#define UNIT0INA_MASK 0b00001111
/* Select which of the 16 32-bit math registers is input B for Math Function Unit X. (address) */
#define MATH_UNIT0INB_ADDR 0xD7C0
/* Select which of the 16 32-bit math registers is input B for Math Function Unit X. (address) */
#define UNIT0INB_ADDR 0xD7C0
/* Select which of the 16 32-bit math registers is input B for Math Function Unit X. (bit mask) */
#define MATH_UNIT0INB_MASK 0b11110000
/* Select which of the 16 32-bit math registers is input B for Math Function Unit X. (bit mask) */
#define UNIT0INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT1INA_ADDR 0xD7C1
/* @UNITXINA (address) */
#define UNIT1INA_ADDR 0xD7C1
/* @UNITXINA (bit mask) */
#define MATH_UNIT1INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT1INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT1INB_ADDR 0xD7C1
/* @UNITXINB (address) */
#define UNIT1INB_ADDR 0xD7C1
/* @UNITXINB (bit mask) */
#define MATH_UNIT1INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT1INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT2INA_ADDR 0xD7C2
/* @UNITXINA (address) */
#define UNIT2INA_ADDR 0xD7C2
/* @UNITXINA (bit mask) */
#define MATH_UNIT2INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT2INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT2INB_ADDR 0xD7C2
/* @UNITXINB (address) */
#define UNIT2INB_ADDR 0xD7C2
/* @UNITXINB (bit mask) */
#define MATH_UNIT2INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT2INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT3INA_ADDR 0xD7C3
/* @UNITXINA (address) */
#define UNIT3INA_ADDR 0xD7C3
/* @UNITXINA (bit mask) */
#define MATH_UNIT3INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT3INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT3INB_ADDR 0xD7C3
/* @UNITXINB (address) */
#define UNIT3INB_ADDR 0xD7C3
/* @UNITXINB (bit mask) */
#define MATH_UNIT3INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT3INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT4INA_ADDR 0xD7C4
/* @UNITXINA (address) */
#define UNIT4INA_ADDR 0xD7C4
/* @UNITXINA (bit mask) */
#define MATH_UNIT4INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT4INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT4INB_ADDR 0xD7C4
/* @UNITXINB (address) */
#define UNIT4INB_ADDR 0xD7C4
/* @UNITXINB (bit mask) */
#define MATH_UNIT4INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT4INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT5INA_ADDR 0xD7C5
/* @UNITXINA (address) */
#define UNIT5INA_ADDR 0xD7C5
/* @UNITXINA (bit mask) */
#define MATH_UNIT5INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT5INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT5INB_ADDR 0xD7C5
/* @UNITXINB (address) */
#define UNIT5INB_ADDR 0xD7C5
/* @UNITXINB (bit mask) */
#define MATH_UNIT5INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT5INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT6INA_ADDR 0xD7C6
/* @UNITXINA (address) */
#define UNIT6INA_ADDR 0xD7C6
/* @UNITXINA (bit mask) */
#define MATH_UNIT6INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT6INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT6INB_ADDR 0xD7C6
/* @UNITXINB (address) */
#define UNIT6INB_ADDR 0xD7C6
/* @UNITXINB (bit mask) */
#define MATH_UNIT6INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT6INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT7INA_ADDR 0xD7C7
/* @UNITXINA (address) */
#define UNIT7INA_ADDR 0xD7C7
/* @UNITXINA (bit mask) */
#define MATH_UNIT7INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT7INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT7INB_ADDR 0xD7C7
/* @UNITXINB (address) */
#define UNIT7INB_ADDR 0xD7C7
/* @UNITXINB (bit mask) */
#define MATH_UNIT7INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT7INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT8INA_ADDR 0xD7C8
/* @UNITXINA (address) */
#define UNIT8INA_ADDR 0xD7C8
/* @UNITXINA (bit mask) */
#define MATH_UNIT8INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT8INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT8INB_ADDR 0xD7C8
/* @UNITXINB (address) */
#define UNIT8INB_ADDR 0xD7C8
/* @UNITXINB (bit mask) */
#define MATH_UNIT8INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT8INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNIT9INA_ADDR 0xD7C9
/* @UNITXINA (address) */
#define UNIT9INA_ADDR 0xD7C9
/* @UNITXINA (bit mask) */
#define MATH_UNIT9INA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNIT9INA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNIT9INB_ADDR 0xD7C9
/* @UNITXINB (address) */
#define UNIT9INB_ADDR 0xD7C9
/* @UNITXINB (bit mask) */
#define MATH_UNIT9INB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNIT9INB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNITAINA_ADDR 0xD7CA
/* @UNITXINA (address) */
#define UNITAINA_ADDR 0xD7CA
/* @UNITXINA (bit mask) */
#define MATH_UNITAINA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNITAINA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNITAINB_ADDR 0xD7CA
/* @UNITXINB (address) */
#define UNITAINB_ADDR 0xD7CA
/* @UNITXINB (bit mask) */
#define MATH_UNITAINB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNITAINB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNITBINA_ADDR 0xD7CB
/* @UNITXINA (address) */
#define UNITBINA_ADDR 0xD7CB
/* @UNITXINA (bit mask) */
#define MATH_UNITBINA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNITBINA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNITBINB_ADDR 0xD7CB
/* @UNITXINB (address) */
#define UNITBINB_ADDR 0xD7CB
/* @UNITXINB (bit mask) */
#define MATH_UNITBINB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNITBINB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNITCINA_ADDR 0xD7CC
/* @UNITXINA (address) */
#define UNITCINA_ADDR 0xD7CC
/* @UNITXINA (bit mask) */
#define MATH_UNITCINA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNITCINA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNITCINB_ADDR 0xD7CC
/* @UNITXINB (address) */
#define UNITCINB_ADDR 0xD7CC
/* @UNITXINB (bit mask) */
#define MATH_UNITCINB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNITCINB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNITDINA_ADDR 0xD7CD
/* @UNITXINA (address) */
#define UNITDINA_ADDR 0xD7CD
/* @UNITXINA (bit mask) */
#define MATH_UNITDINA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNITDINA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNITDINB_ADDR 0xD7CD
/* @UNITXINB (address) */
#define UNITDINB_ADDR 0xD7CD
/* @UNITXINB (bit mask) */
#define MATH_UNITDINB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNITDINB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNITEINA_ADDR 0xD7CE
/* @UNITXINA (address) */
#define UNITEINA_ADDR 0xD7CE
/* @UNITXINA (bit mask) */
#define MATH_UNITEINA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNITEINA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNITEINB_ADDR 0xD7CE
/* @UNITXINB (address) */
#define UNITEINB_ADDR 0xD7CE
/* @UNITXINB (bit mask) */
#define MATH_UNITEINB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNITEINB_MASK 0b11110000
/* @UNITXINA (address) */
#define MATH_UNITFINA_ADDR 0xD7CF
/* @UNITXINA (address) */
#define UNITFINA_ADDR 0xD7CF
/* @UNITXINA (bit mask) */
#define MATH_UNITFINA_MASK 0b00001111
/* @UNITXINA (bit mask) */
#define UNITFINA_MASK 0b00001111
/* @UNITXINB (address) */
#define MATH_UNITFINB_ADDR 0xD7CF
/* @UNITXINB (address) */
#define UNITFINB_ADDR 0xD7CF
/* @UNITXINB (bit mask) */
#define MATH_UNITFINB_MASK 0b11110000
/* @UNITXINB (bit mask) */
#define UNITFINB_MASK 0b11110000
/* Select which of the 16 32-bit math registers receives the output of Math Function Unit X (address) */
#define MATH_UNIT0OUT_ADDR 0xD7D0
/* Select which of the 16 32-bit math registers receives the output of Math Function Unit X (address) */
#define UNIT0OUT_ADDR 0xD7D0
/* Select which of the 16 32-bit math registers receives the output of Math Function Unit X (bit mask) */
#define MATH_UNIT0OUT_MASK 0b00001111
/* Select which of the 16 32-bit math registers receives the output of Math Function Unit X (bit mask) */
#define UNIT0OUT_MASK 0b00001111
/* If set, the low-half of the output of Math Function Unit X is written to math register UNITXOUT. (address) */
#define MATH_U0_LOWOUT_ADDR 0xD7D0
/* If set, the low-half of the output of Math Function Unit X is written to math register UNITXOUT. (address) */
#define U0_LOWOUT_ADDR 0xD7D0
/* If set, the low-half of the output of Math Function Unit X is written to math register UNITXOUT. (bit mask) */
#define MATH_U0_LOWOUT_MASK 0b00010000
/* If set, the low-half of the output of Math Function Unit X is written to math register UNITXOUT. (bit mask) */
#define U0_LOWOUT_MASK 0b00010000
/* If set, the high-half of the output of Math Function Unit X is written to math register UNITXOUT. (address) */
#define MATH_U0_HIOUT_ADDR 0xD7D0
/* If set, the high-half of the output of Math Function Unit X is written to math register UNITXOUT. (address) */
#define U0_HIOUT_ADDR 0xD7D0
/* If set, the high-half of the output of Math Function Unit X is written to math register UNITXOUT. (bit mask) */
#define MATH_U0_HIOUT_MASK 0b00100000
/* If set, the high-half of the output of Math Function Unit X is written to math register UNITXOUT. (bit mask) */
#define U0_HIOUT_MASK 0b00100000
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit multiplier. (address) */
#define MATH_U0_MLADD_ADDR 0xD7D0
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit multiplier. (address) */
#define U0_MLADD_ADDR 0xD7D0
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit multiplier. (bit mask) */
#define MATH_U0_MLADD_MASK 0b01000000
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit multiplier. (bit mask) */
#define U0_MLADD_MASK 0b01000000
/* If set, Math Function Unit X's output is latched. (address) */
#define MATH_U0_LATCH_ADDR 0xD7D0
/* If set, Math Function Unit X's output is latched. (address) */
#define U0_LATCH_ADDR 0xD7D0
/* If set, Math Function Unit X's output is latched. (bit mask) */
#define MATH_U0_LATCH_MASK 0b10000000
/* If set, Math Function Unit X's output is latched. (bit mask) */
#define U0_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT1OUT_ADDR 0xD7D1
/* @UNITXOUT (address) */
#define UNIT1OUT_ADDR 0xD7D1
/* @UNITXOUT (bit mask) */
#define MATH_UNIT1OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT1OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U1_LOWOUT_ADDR 0xD7D1
/* @UXLOWOUT (address) */
#define U1_LOWOUT_ADDR 0xD7D1
/* @UXLOWOUT (bit mask) */
#define MATH_U1_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U1_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U1_HIOUT_ADDR 0xD7D1
/* @UXHIOUT (address) */
#define U1_HIOUT_ADDR 0xD7D1
/* @UXHIOUT (bit mask) */
#define MATH_U1_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U1_HIOUT_MASK 0b00100000
/* @UXMLADD (address) */
#define MATH_U1_MLADD_ADDR 0xD7D1
/* @UXMLADD (address) */
#define U1_MLADD_ADDR 0xD7D1
/* @UXMLADD (bit mask) */
#define MATH_U1_MLADD_MASK 0b01000000
/* @UXMLADD (bit mask) */
#define U1_MLADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U1_LATCH_ADDR 0xD7D1
/* @UXLATCH (address) */
#define U1_LATCH_ADDR 0xD7D1
/* @UXLATCH (bit mask) */
#define MATH_U1_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U1_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT2OUT_ADDR 0xD7D2
/* @UNITXOUT (address) */
#define UNIT2OUT_ADDR 0xD7D2
/* @UNITXOUT (bit mask) */
#define MATH_UNIT2OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT2OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U2_LOWOUT_ADDR 0xD7D2
/* @UXLOWOUT (address) */
#define U2_LOWOUT_ADDR 0xD7D2
/* @UXLOWOUT (bit mask) */
#define MATH_U2_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U2_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U2_HIOUT_ADDR 0xD7D2
/* @UXHIOUT (address) */
#define U2_HIOUT_ADDR 0xD7D2
/* @UXHIOUT (bit mask) */
#define MATH_U2_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U2_HIOUT_MASK 0b00100000
/* @UXMLADD (address) */
#define MATH_U2_MLADD_ADDR 0xD7D2
/* @UXMLADD (address) */
#define U2_MLADD_ADDR 0xD7D2
/* @UXMLADD (bit mask) */
#define MATH_U2_MLADD_MASK 0b01000000
/* @UXMLADD (bit mask) */
#define U2_MLADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U2_LATCH_ADDR 0xD7D2
/* @UXLATCH (address) */
#define U2_LATCH_ADDR 0xD7D2
/* @UXLATCH (bit mask) */
#define MATH_U2_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U2_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT3OUT_ADDR 0xD7D3
/* @UNITXOUT (address) */
#define UNIT3OUT_ADDR 0xD7D3
/* @UNITXOUT (bit mask) */
#define MATH_UNIT3OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT3OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U3_LOWOUT_ADDR 0xD7D3
/* @UXLOWOUT (address) */
#define U3_LOWOUT_ADDR 0xD7D3
/* @UXLOWOUT (bit mask) */
#define MATH_U3_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U3_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U3_HIOUT_ADDR 0xD7D3
/* @UXHIOUT (address) */
#define U3_HIOUT_ADDR 0xD7D3
/* @UXHIOUT (bit mask) */
#define MATH_U3_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U3_HIOUT_MASK 0b00100000
/* @UXMLADD (address) */
#define MATH_U3_MLADD_ADDR 0xD7D3
/* @UXMLADD (address) */
#define U3_MLADD_ADDR 0xD7D3
/* @UXMLADD (bit mask) */
#define MATH_U3_MLADD_MASK 0b01000000
/* @UXMLADD (bit mask) */
#define U3_MLADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U3_LATCH_ADDR 0xD7D3
/* @UXLATCH (address) */
#define U3_LATCH_ADDR 0xD7D3
/* @UXLATCH (bit mask) */
#define MATH_U3_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U3_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT4OUT_ADDR 0xD7D4
/* @UNITXOUT (address) */
#define UNIT4OUT_ADDR 0xD7D4
/* @UNITXOUT (bit mask) */
#define MATH_UNIT4OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT4OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U4_LOWOUT_ADDR 0xD7D4
/* @UXLOWOUT (address) */
#define U4_LOWOUT_ADDR 0xD7D4
/* @UXLOWOUT (bit mask) */
#define MATH_U4_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U4_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U4_HIOUT_ADDR 0xD7D4
/* @UXHIOUT (address) */
#define U4_HIOUT_ADDR 0xD7D4
/* @UXHIOUT (bit mask) */
#define MATH_U4_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U4_HIOUT_MASK 0b00100000
/* @UXMLADD (address) */
#define MATH_U4_MLADD_ADDR 0xD7D4
/* @UXMLADD (address) */
#define U4_MLADD_ADDR 0xD7D4
/* @UXMLADD (bit mask) */
#define MATH_U4_MLADD_MASK 0b01000000
/* @UXMLADD (bit mask) */
#define U4_MLADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U4_LATCH_ADDR 0xD7D4
/* @UXLATCH (address) */
#define U4_LATCH_ADDR 0xD7D4
/* @UXLATCH (bit mask) */
#define MATH_U4_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U4_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT5OUT_ADDR 0xD7D5
/* @UNITXOUT (address) */
#define UNIT5OUT_ADDR 0xD7D5
/* @UNITXOUT (bit mask) */
#define MATH_UNIT5OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT5OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U5_LOWOUT_ADDR 0xD7D5
/* @UXLOWOUT (address) */
#define U5_LOWOUT_ADDR 0xD7D5
/* @UXLOWOUT (bit mask) */
#define MATH_U5_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U5_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U5_HIOUT_ADDR 0xD7D5
/* @UXHIOUT (address) */
#define U5_HIOUT_ADDR 0xD7D5
/* @UXHIOUT (bit mask) */
#define MATH_U5_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U5_HIOUT_MASK 0b00100000
/* @UXMLADD (address) */
#define MATH_U5_MLADD_ADDR 0xD7D5
/* @UXMLADD (address) */
#define U5_MLADD_ADDR 0xD7D5
/* @UXMLADD (bit mask) */
#define MATH_U5_MLADD_MASK 0b01000000
/* @UXMLADD (bit mask) */
#define U5_MLADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U5_LATCH_ADDR 0xD7D5
/* @UXLATCH (address) */
#define U5_LATCH_ADDR 0xD7D5
/* @UXLATCH (bit mask) */
#define MATH_U5_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U5_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT6OUT_ADDR 0xD7D6
/* @UNITXOUT (address) */
#define UNIT6OUT_ADDR 0xD7D6
/* @UNITXOUT (bit mask) */
#define MATH_UNIT6OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT6OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U6_LOWOUT_ADDR 0xD7D6
/* @UXLOWOUT (address) */
#define U6_LOWOUT_ADDR 0xD7D6
/* @UXLOWOUT (bit mask) */
#define MATH_U6_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U6_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U6_HIOUT_ADDR 0xD7D6
/* @UXHIOUT (address) */
#define U6_HIOUT_ADDR 0xD7D6
/* @UXHIOUT (bit mask) */
#define MATH_U6_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U6_HIOUT_MASK 0b00100000
/* @UXMLADD (address) */
#define MATH_U6_MLADD_ADDR 0xD7D6
/* @UXMLADD (address) */
#define U6_MLADD_ADDR 0xD7D6
/* @UXMLADD (bit mask) */
#define MATH_U6_MLADD_MASK 0b01000000
/* @UXMLADD (bit mask) */
#define U6_MLADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U6_LATCH_ADDR 0xD7D6
/* @UXLATCH (address) */
#define U6_LATCH_ADDR 0xD7D6
/* @UXLATCH (bit mask) */
#define MATH_U6_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U6_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT7OUT_ADDR 0xD7D7
/* @UNITXOUT (address) */
#define UNIT7OUT_ADDR 0xD7D7
/* @UNITXOUT (bit mask) */
#define MATH_UNIT7OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT7OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U7_LOWOUT_ADDR 0xD7D7
/* @UXLOWOUT (address) */
#define U7_LOWOUT_ADDR 0xD7D7
/* @UXLOWOUT (bit mask) */
#define MATH_U7_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U7_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U7_HIOUT_ADDR 0xD7D7
/* @UXHIOUT (address) */
#define U7_HIOUT_ADDR 0xD7D7
/* @UXHIOUT (bit mask) */
#define MATH_U7_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U7_HIOUT_MASK 0b00100000
/* @UXMLADD (address) */
#define MATH_U7_MLADD_ADDR 0xD7D7
/* @UXMLADD (address) */
#define U7_MLADD_ADDR 0xD7D7
/* @UXMLADD (bit mask) */
#define MATH_U7_MLADD_MASK 0b01000000
/* @UXMLADD (bit mask) */
#define U7_MLADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U7_LATCH_ADDR 0xD7D7
/* @UXLATCH (address) */
#define U7_LATCH_ADDR 0xD7D7
/* @UXLATCH (bit mask) */
#define MATH_U7_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U7_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT8OUT_ADDR 0xD7D8
/* @UNITXOUT (address) */
#define UNIT8OUT_ADDR 0xD7D8
/* @UNITXOUT (bit mask) */
#define MATH_UNIT8OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT8OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U8_LOWOUT_ADDR 0xD7D8
/* @UXLOWOUT (address) */
#define U8_LOWOUT_ADDR 0xD7D8
/* @UXLOWOUT (bit mask) */
#define MATH_U8_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U8_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U8_HIOUT_ADDR 0xD7D8
/* @UXHIOUT (address) */
#define U8_HIOUT_ADDR 0xD7D8
/* @UXHIOUT (bit mask) */
#define MATH_U8_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U8_HIOUT_MASK 0b00100000
/* If set, Math Function Unit Y acts as a 32-bit adder instead of 32-bit barrel-shifter. (address) */
#define MATH_U8_BSADD_ADDR 0xD7D8
/* If set, Math Function Unit Y acts as a 32-bit adder instead of 32-bit barrel-shifter. (address) */
#define U8_BSADD_ADDR 0xD7D8
/* If set, Math Function Unit Y acts as a 32-bit adder instead of 32-bit barrel-shifter. (bit mask) */
#define MATH_U8_BSADD_MASK 0b01000000
/* If set, Math Function Unit Y acts as a 32-bit adder instead of 32-bit barrel-shifter. (bit mask) */
#define U8_BSADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U8_LATCH_ADDR 0xD7D8
/* @UXLATCH (address) */
#define U8_LATCH_ADDR 0xD7D8
/* @UXLATCH (bit mask) */
#define MATH_U8_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U8_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNIT9OUT_ADDR 0xD7D9
/* @UNITXOUT (address) */
#define UNIT9OUT_ADDR 0xD7D9
/* @UNITXOUT (bit mask) */
#define MATH_UNIT9OUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNIT9OUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_U9_LOWOUT_ADDR 0xD7D9
/* @UXLOWOUT (address) */
#define U9_LOWOUT_ADDR 0xD7D9
/* @UXLOWOUT (bit mask) */
#define MATH_U9_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define U9_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_U9_HIOUT_ADDR 0xD7D9
/* @UXHIOUT (address) */
#define U9_HIOUT_ADDR 0xD7D9
/* @UXHIOUT (bit mask) */
#define MATH_U9_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define U9_HIOUT_MASK 0b00100000
/* @UXBSADD (address) */
#define MATH_U9_BSADD_ADDR 0xD7D9
/* @UXBSADD (address) */
#define U9_BSADD_ADDR 0xD7D9
/* @UXBSADD (bit mask) */
#define MATH_U9_BSADD_MASK 0b01000000
/* @UXBSADD (bit mask) */
#define U9_BSADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_U9_LATCH_ADDR 0xD7D9
/* @UXLATCH (address) */
#define U9_LATCH_ADDR 0xD7D9
/* @UXLATCH (bit mask) */
#define MATH_U9_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define U9_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNITAOUT_ADDR 0xD7DA
/* @UNITXOUT (address) */
#define UNITAOUT_ADDR 0xD7DA
/* @UNITXOUT (bit mask) */
#define MATH_UNITAOUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNITAOUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_UA_LOWOUT_ADDR 0xD7DA
/* @UXLOWOUT (address) */
#define UA_LOWOUT_ADDR 0xD7DA
/* @UXLOWOUT (bit mask) */
#define MATH_UA_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define UA_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_UA_HIOUT_ADDR 0xD7DA
/* @UXHIOUT (address) */
#define UA_HIOUT_ADDR 0xD7DA
/* @UXHIOUT (bit mask) */
#define MATH_UA_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define UA_HIOUT_MASK 0b00100000
/* @UXBSADD (address) */
#define MATH_UA_BSADD_ADDR 0xD7DA
/* @UXBSADD (address) */
#define UA_BSADD_ADDR 0xD7DA
/* @UXBSADD (bit mask) */
#define MATH_UA_BSADD_MASK 0b01000000
/* @UXBSADD (bit mask) */
#define UA_BSADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_UA_LATCH_ADDR 0xD7DA
/* @UXLATCH (address) */
#define UA_LATCH_ADDR 0xD7DA
/* @UXLATCH (bit mask) */
#define MATH_UA_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define UA_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNITBOUT_ADDR 0xD7DB
/* @UNITXOUT (address) */
#define UNITBOUT_ADDR 0xD7DB
/* @UNITXOUT (bit mask) */
#define MATH_UNITBOUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNITBOUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_UB_LOWOUT_ADDR 0xD7DB
/* @UXLOWOUT (address) */
#define UB_LOWOUT_ADDR 0xD7DB
/* @UXLOWOUT (bit mask) */
#define MATH_UB_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define UB_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_UB_HIOUT_ADDR 0xD7DB
/* @UXHIOUT (address) */
#define UB_HIOUT_ADDR 0xD7DB
/* @UXHIOUT (bit mask) */
#define MATH_UB_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define UB_HIOUT_MASK 0b00100000
/* @UXBSADD (address) */
#define MATH_UB_BSADD_ADDR 0xD7DB
/* @UXBSADD (address) */
#define UB_BSADD_ADDR 0xD7DB
/* @UXBSADD (bit mask) */
#define MATH_UB_BSADD_MASK 0b01000000
/* @UXBSADD (bit mask) */
#define UB_BSADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_UB_LATCH_ADDR 0xD7DB
/* @UXLATCH (address) */
#define UB_LATCH_ADDR 0xD7DB
/* @UXLATCH (bit mask) */
#define MATH_UB_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define UB_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNITCOUT_ADDR 0xD7DC
/* @UNITXOUT (address) */
#define UNITCOUT_ADDR 0xD7DC
/* @UNITXOUT (bit mask) */
#define MATH_UNITCOUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNITCOUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_UC_LOWOUT_ADDR 0xD7DC
/* @UXLOWOUT (address) */
#define UC_LOWOUT_ADDR 0xD7DC
/* @UXLOWOUT (bit mask) */
#define MATH_UC_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define UC_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_UC_HIOUT_ADDR 0xD7DC
/* @UXHIOUT (address) */
#define UC_HIOUT_ADDR 0xD7DC
/* @UXHIOUT (bit mask) */
#define MATH_UC_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define UC_HIOUT_MASK 0b00100000
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit divider. (address) */
#define MATH_UC_DVADD_ADDR 0xD7DC
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit divider. (address) */
#define UC_DVADD_ADDR 0xD7DC
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit divider. (bit mask) */
#define MATH_UC_DVADD_MASK 0b01000000
/* If set, Math Function Unit X acts as a 32-bit adder instead of 32-bit divider. (bit mask) */
#define UC_DVADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_UC_LATCH_ADDR 0xD7DC
/* @UXLATCH (address) */
#define UC_LATCH_ADDR 0xD7DC
/* @UXLATCH (bit mask) */
#define MATH_UC_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define UC_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNITDOUT_ADDR 0xD7DD
/* @UNITXOUT (address) */
#define UNITDOUT_ADDR 0xD7DD
/* @UNITXOUT (bit mask) */
#define MATH_UNITDOUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNITDOUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_UD_LOWOUT_ADDR 0xD7DD
/* @UXLOWOUT (address) */
#define UD_LOWOUT_ADDR 0xD7DD
/* @UXLOWOUT (bit mask) */
#define MATH_UD_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define UD_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_UD_HIOUT_ADDR 0xD7DD
/* @UXHIOUT (address) */
#define UD_HIOUT_ADDR 0xD7DD
/* @UXHIOUT (bit mask) */
#define MATH_UD_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define UD_HIOUT_MASK 0b00100000
/*  (address) */
#define MATH_UD_DVADD_ADDR 0xD7DD
/*  (address) */
#define UD_DVADD_ADDR 0xD7DD
/*  (bit mask) */
#define MATH_UD_DVADD_MASK 0b01000000
/*  (bit mask) */
#define UD_DVADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_UD_LATCH_ADDR 0xD7DD
/* @UXLATCH (address) */
#define UD_LATCH_ADDR 0xD7DD
/* @UXLATCH (bit mask) */
#define MATH_UD_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define UD_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNITEOUT_ADDR 0xD7DE
/* @UNITXOUT (address) */
#define UNITEOUT_ADDR 0xD7DE
/* @UNITXOUT (bit mask) */
#define MATH_UNITEOUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNITEOUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_UE_LOWOUT_ADDR 0xD7DE
/* @UXLOWOUT (address) */
#define UE_LOWOUT_ADDR 0xD7DE
/* @UXLOWOUT (bit mask) */
#define MATH_UE_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define UE_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_UE_HIOUT_ADDR 0xD7DE
/* @UXHIOUT (address) */
#define UE_HIOUT_ADDR 0xD7DE
/* @UXHIOUT (bit mask) */
#define MATH_UE_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define UE_HIOUT_MASK 0b00100000
/*  (address) */
#define MATH_UE_DVADD_ADDR 0xD7DE
/*  (address) */
#define UE_DVADD_ADDR 0xD7DE
/*  (bit mask) */
#define MATH_UE_DVADD_MASK 0b01000000
/*  (bit mask) */
#define UE_DVADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_UE_LATCH_ADDR 0xD7DE
/* @UXLATCH (address) */
#define UE_LATCH_ADDR 0xD7DE
/* @UXLATCH (bit mask) */
#define MATH_UE_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define UE_LATCH_MASK 0b10000000
/* @UNITXOUT (address) */
#define MATH_UNITFOUT_ADDR 0xD7DF
/* @UNITXOUT (address) */
#define UNITFOUT_ADDR 0xD7DF
/* @UNITXOUT (bit mask) */
#define MATH_UNITFOUT_MASK 0b00001111
/* @UNITXOUT (bit mask) */
#define UNITFOUT_MASK 0b00001111
/* @UXLOWOUT (address) */
#define MATH_UF_LOWOUT_ADDR 0xD7DF
/* @UXLOWOUT (address) */
#define UF_LOWOUT_ADDR 0xD7DF
/* @UXLOWOUT (bit mask) */
#define MATH_UF_LOWOUT_MASK 0b00010000
/* @UXLOWOUT (bit mask) */
#define UF_LOWOUT_MASK 0b00010000
/* @UXHIOUT (address) */
#define MATH_UF_HIOUT_ADDR 0xD7DF
/* @UXHIOUT (address) */
#define UF_HIOUT_ADDR 0xD7DF
/* @UXHIOUT (bit mask) */
#define MATH_UF_HIOUT_MASK 0b00100000
/* @UXHIOUT (bit mask) */
#define UF_HIOUT_MASK 0b00100000
/*  (address) */
#define MATH_UF_DVADD_ADDR 0xD7DF
/*  (address) */
#define UF_DVADD_ADDR 0xD7DF
/*  (bit mask) */
#define MATH_UF_DVADD_MASK 0b01000000
/*  (bit mask) */
#define UF_DVADD_MASK 0b01000000
/* @UXLATCH (address) */
#define MATH_UF_LATCH_ADDR 0xD7DF
/* @UXLATCH (address) */
#define UF_LATCH_ADDR 0xD7DF
/* @UXLATCH (bit mask) */
#define MATH_UF_LATCH_MASK 0b10000000
/* @UXLATCH (bit mask) */
#define UF_LATCH_MASK 0b10000000
/* Latch interval for latched outputs (in CPU cycles) */
#define MATH_LATCHINT 0xD7E0
/* Latch interval for latched outputs (in CPU cycles) */
#define LATCHINT 0xD7E0
/* Enable setting of math registers (must normally be set) (address) */
#define MATH_WREN_ADDR 0xD7E1
/* Enable setting of math registers (must normally be set) (address) */
#define WREN_ADDR 0xD7E1
/* Enable setting of math registers (must normally be set) (bit mask) */
#define MATH_WREN_MASK 0b00000001
/* Enable setting of math registers (must normally be set) (bit mask) */
#define WREN_MASK 0b00000001
/* Enable committing of output values from math units back to math registers (clearing effectively pauses iterative formulae) (address) */
#define MATH_CALCEN_ADDR 0xD7E1
/* Enable committing of output values from math units back to math registers (clearing effectively pauses iterative formulae) (address) */
#define CALCEN_ADDR 0xD7E1
/* Enable committing of output values from math units back to math registers (clearing effectively pauses iterative formulae) (bit mask) */
#define MATH_CALCEN_MASK 0b00000010
/* Enable committing of output values from math units back to math registers (clearing effectively pauses iterative formulae) (bit mask) */
#define CALCEN_MASK 0b00000010
/* Reserved */
#define MATH_RESERVED 0xD7E2
/* Reserved */
#define GS_MATH_RESERVED 0xD7E3
/* Iteration Counter (32 bit) */
#define MATH_ITERCNT 0xD7E4
/* Iteration Counter (32 bit) */
#define GS_MATH_ITERCNT 0xD7E5
/* Iteration Counter (32 bit) */
#define GS_MATH_ITERCNT_2 0xD7E6
/* Iteration Counter (32 bit) */
#define GS_MATH_ITERCNT_3 0xD7E7
/* Math iteration counter comparator (32 bit) */
#define MATH_ITERCMP 0xD7E8
/* Math iteration counter comparator (32 bit) */
#define GS_MATH_ITERCMP 0xD7E9
/* Math iteration counter comparator (32 bit) */
#define GS_MATH_ITERCMP_2 0xD7EA
/* Math iteration counter comparator (32 bit) */
#define GS_MATH_ITERCMP_3 0xD7EB
/* IEC bus is active (address) */
#define CPU_IECBUSACT_ADDR 0xD7F1
/* IEC bus is active (address) */
#define IECBUSACT_ADDR 0xD7F1
/* IEC bus is active (bit mask) */
#define CPU_IECBUSACT_MASK 0b00000001
/* IEC bus is active (bit mask) */
#define IECBUSACT_MASK 0b00000001
/* Count the number of PHI cycles per video frame (LSB) */
#define CPU_PHIPERFRAME 0xD7F2
/* Count the number of PHI cycles per video frame (MSB) */
#define GS_CPU_PHIPERFRAME 0xD7F5
/* Count the number of usable (proceed=1) CPU cycles per video frame (LSB) */
#define CPU_CYCPERFRAME 0xD7F6
/* Count the number of usable (proceed=1) CPU cycles per video frame (MSB) */
#define GS_CPU_CYCPERFRAME 0xD7F9
/* Count number of elapsed video frames */
#define CPU_FRAMECOUNT 0xD7FA
/* Count number of elapsed video frames */
#define FRAMECOUNT 0xD7FA
/* 1= enable cartridges (address) */
#define CPU_CARTEN_ADDR 0xD7FB
/* 1= enable cartridges (address) */
#define CARTEN_ADDR 0xD7FB
/* 1= enable cartridges (bit mask) */
#define CPU_CARTEN_MASK 0b00000010
/* 1= enable cartridges (bit mask) */
#define CARTEN_MASK 0b00000010
/* Set to zero to power off computer on supported systems. WRITE ONLY. (address) */
#define CPU_POWEREN_ADDR 0xD7FD
/* Set to zero to power off computer on supported systems. WRITE ONLY. (address) */
#define POWEREN_ADDR 0xD7FD
/* Set to zero to power off computer on supported systems. WRITE ONLY. (bit mask) */
#define CPU_POWEREN_MASK 0b00000001
/* Set to zero to power off computer on supported systems. WRITE ONLY. (bit mask) */
#define POWEREN_MASK 0b00000001
/* Override for /GAME : Must be 0 to enable /GAME signal (address) */
#define CPU_NOGAME_ADDR 0xD7FD
/* Override for /GAME : Must be 0 to enable /GAME signal (address) */
#define NOGAME_ADDR 0xD7FD
/* Override for /GAME : Must be 0 to enable /GAME signal (bit mask) */
#define CPU_NOGAME_MASK 0b01000000
/* Override for /GAME : Must be 0 to enable /GAME signal (bit mask) */
#define NOGAME_MASK 0b01000000
/* Override for /EXROM : Must be 0 to enable /EXROM signal (address) */
#define CPU_NOEXROM_ADDR 0xD7FD
/* Override for /EXROM : Must be 0 to enable /EXROM signal (address) */
#define NOEXROM_ADDR 0xD7FD
/* Override for /EXROM : Must be 0 to enable /EXROM signal (bit mask) */
#define CPU_NOEXROM_MASK 0b10000000
/* Override for /EXROM : Must be 0 to enable /EXROM signal (bit mask) */
#define NOEXROM_MASK 0b10000000
/* Enable expansion RAM pre-fetch logic (address) */
#define CPU_PREFETCH_ADDR 0xD7FE
/* Enable expansion RAM pre-fetch logic (address) */
#define PREFETCH_ADDR 0xD7FE
/* Enable expansion RAM pre-fetch logic (bit mask) */
#define CPU_PREFETCH_MASK 0b00000001
/* Enable expansion RAM pre-fetch logic (bit mask) */
#define PREFETCH_MASK 0b00000001
/* Enable Ocean Type A cartridge emulation (address) */
#define CPU_OCEANA_ADDR 0xD7FE
/* Enable Ocean Type A cartridge emulation (address) */
#define OCEANA_ADDR 0xD7FE
/* Enable Ocean Type A cartridge emulation (bit mask) */
#define CPU_OCEANA_MASK 0b00000010
/* Enable Ocean Type A cartridge emulation (bit mask) */
#define OCEANA_MASK 0b00000010
/* Select CPU debug stream via ethernet when \$D6E1.3 is set */
#define ETHCOMMAND_DEBUGCPU 0xDC
/* Select CPU debug stream via ethernet when \$D6E1.3 is set */
#define DEBUGCPU 0xDC
/* Port A */
#define CIA1_PORTA 0xDC00
/* Port B */
#define CIA1_PORTB 0xDC01
/* Port A DDR */
#define CIA1_DDRA 0xDC02
/* Port B DDR */
#define CIA1_DDRB 0xDC03
/* Timer A counter (16 bit) */
#define CIA1_TIMERA 0xDC04
/* Timer A counter (16 bit) */
#define C64_CIA1_TIMERA 0xDC05
/* Timer B counter (16 bit) */
#define CIA1_TIMERB 0xDC06
/* Timer B counter (16 bit) */
#define C64_CIA1_TIMERB 0xDC07
/* TOD tenths of seconds (address) */
#define CIA1_TODJIF_ADDR 0xDC08
/* TOD tenths of seconds (bit mask) */
#define CIA1_TODJIF_MASK 0b00001111
/* TOD seconds (address) */
#define CIA1_TODSEC_ADDR 0xDC09
/* TOD seconds (bit mask) */
#define CIA1_TODSEC_MASK 0b00111111
/* TOD minutes (address) */
#define CIA1_TODMIN_ADDR 0xDC0A
/* TOD minutes (address) */
#define TODMIN_ADDR 0xDC0A
/* TOD minutes (bit mask) */
#define CIA1_TODMIN_MASK 0b00111111
/* TOD minutes (bit mask) */
#define TODMIN_MASK 0b00111111
/* TOD hours (address) */
#define CIA1_TODHOUR_ADDR 0xDC0B
/* TOD hours (bit mask) */
#define CIA1_TODHOUR_MASK 0b00011111
/* TOD PM flag (address) */
#define CIA1_TODAMPM_ADDR 0xDC0B
/* TOD PM flag (bit mask) */
#define CIA1_TODAMPM_MASK 0b10000000
/* shift register data register(writing starts sending) */
#define CIA1_SDR 0xDC0C
/* Timer A underflow (address) */
#define CIA1_TA_ADDR 0xDC0D
/* Timer A underflow (bit mask) */
#define CIA1_TA_MASK 0b00000001
/* Timer B underflow (address) */
#define CIA1_TB_ADDR 0xDC0D
/* Timer B underflow (bit mask) */
#define CIA1_TB_MASK 0b00000010
/* TOD alarm (address) */
#define CIA1_ALRM_ADDR 0xDC0D
/* TOD alarm (bit mask) */
#define CIA1_ALRM_MASK 0b00000100
/* shift register full/empty (address) */
#define CIA1_SP_ADDR 0xDC0D
/* shift register full/empty (bit mask) */
#define CIA1_SP_MASK 0b00001000
/* FLAG edge detected (address) */
#define CIA1_FLG_ADDR 0xDC0D
/* FLAG edge detected (bit mask) */
#define CIA1_FLG_MASK 0b00010000
/* Interrupt flag (address) */
#define CIA1_IR_ADDR 0xDC0D
/* Interrupt flag (address) */
#define IR_ADDR 0xDC0D
/* Interrupt flag (bit mask) */
#define CIA1_IR_MASK 0b10000000
/* Interrupt flag (bit mask) */
#define IR_MASK 0b10000000
/* Timer A start (address) */
#define CIA1_STRTA_ADDR 0xDC0E
/* Timer A start (bit mask) */
#define CIA1_STRTA_MASK 0b00000001
/* Timer A PB6 out (address) */
#define CIA1_PBONA_ADDR 0xDC0E
/* Timer A PB6 out (bit mask) */
#define CIA1_PBONA_MASK 0b00000010
/* Timer A toggle or pulse (address) */
#define CIA1_OMODA_ADDR 0xDC0E
/* Timer A toggle or pulse (bit mask) */
#define CIA1_OMODA_MASK 0b00000100
/* Timer A one-shot mode (address) */
#define CIA1_RMODA_ADDR 0xDC0E
/* Timer A one-shot mode (bit mask) */
#define CIA1_RMODA_MASK 0b00001000
/* Timer A Timer A tick source (address) */
#define CIA1_IMODA_ADDR 0xDC0E
/* Timer A Timer A tick source (bit mask) */
#define CIA1_IMODA_MASK 0b00100000
/* Serial port direction (address) */
#define CIA1_SPMOD_ADDR 0xDC0E
/* Serial port direction (bit mask) */
#define CIA1_SPMOD_MASK 0b01000000
/* 50/60Hz select for TOD clock (address) */
#define CIA1_TOD50_ADDR 0xDC0E
/* 50/60Hz select for TOD clock (bit mask) */
#define CIA1_TOD50_MASK 0b10000000
/* Timer B start (address) */
#define CIA1_STRTB_ADDR 0xDC0F
/* Timer B start (bit mask) */
#define CIA1_STRTB_MASK 0b00000001
/* Timer B PB7 out (address) */
#define CIA1_PBONB_ADDR 0xDC0F
/* Timer B PB7 out (bit mask) */
#define CIA1_PBONB_MASK 0b00000010
/* Timer B toggle or pulse (address) */
#define CIA1_OMODB_ADDR 0xDC0F
/* Timer B toggle or pulse (bit mask) */
#define CIA1_OMODB_MASK 0b00000100
/* Timer B one-shot mode (address) */
#define CIA1_RMODB_ADDR 0xDC0F
/* Timer B one-shot mode (bit mask) */
#define CIA1_RMODB_MASK 0b00001000
/* Strobe input to force-load timers (address) */
#define CIA1_LOAD_ADDR 0xDC0F
/* Strobe input to force-load timers (bit mask) */
#define CIA1_LOAD_MASK 0b00010000
/* Timer B Timer A tick source (address) */
#define CIA1_IMODB_ADDR 0xDC0F
/* Timer B Timer A tick source (bit mask) */
#define CIA1_IMODB_MASK 0b01100000
/* TOD alarm edit (address) */
#define CIA2_TODEDIT_ADDR 0xDC0F
/* TOD alarm edit (bit mask) */
#define CIA2_TODEDIT_MASK 0b10000000
/* Timer A latch value (16 bit) */
#define CIA1_TALATCH 0xDC10
/* Timer A latch value (16 bit) */
#define GS_CIA1_TALATCH 0xDC11
/* Timer B latch value (16 bit) */
#define GS_CIA1_TALATCH_2 0xDC12
/* Timer B latch value (16 bit) */
#define GS_CIA1_TALATCH_3 0xDC13
/* Timer A current value (16 bit) */
#define GS_CIA1_TALATCH_4 0xDC14
/* Timer A current value (16 bit) */
#define GS_CIA1_TALATCH_5 0xDC15
/* Timer B current value (16 bit) */
#define GS_CIA1_TALATCH_6 0xDC16
/* Timer B current value (16 bit) */
#define GS_CIA1_TALATCH_7 0xDC17
/* TOD 10ths of seconds value (address) */
#define GS_CIA1_TODJIF_ADDR 0xDC18
/* TOD 10ths of seconds value (bit mask) */
#define GS_CIA1_TODJIF_MASK 0b00001111
/* Interrupt mask for Timer B (address) */
#define CIA1_IMTB_ADDR 0xDC18
/* Interrupt mask for Timer B (bit mask) */
#define CIA1_IMTB_MASK 0b00010000
/* Interrupt mask for TOD alarm (address) */
#define CIA1_IMALRM_ADDR 0xDC18
/* Interrupt mask for TOD alarm (bit mask) */
#define CIA1_IMALRM_MASK 0b00100000
/* Interrupt mask for shift register (serial port) (address) */
#define CIA1_IMSP_ADDR 0xDC18
/* Interrupt mask for shift register (serial port) (bit mask) */
#define CIA1_IMSP_MASK 0b01000000
/* Interrupt mask for FLAG line (address) */
#define CIA1_IMFLG_ADDR 0xDC18
/* Interrupt mask for FLAG line (bit mask) */
#define CIA1_IMFLG_MASK 0b10000000
/* TOD Alarm seconds value */
#define CIA1_TODSEC 0xDC19
/* TOD Alarm minutes value */
#define CIA1_TODMIN 0xDC1A
/* TOD hours value (address) */
#define GS_CIA1_TODHOUR_ADDR 0xDC1B
/* TOD hours value (bit mask) */
#define GS_CIA1_TODHOUR_MASK 0b01111111
/* TOD AM/PM flag (address) */
#define GS_CIA1_TODAMPM_ADDR 0xDC1B
/* TOD AM/PM flag (bit mask) */
#define GS_CIA1_TODAMPM_MASK 0b10000000
/* TOD Alarm 10ths of seconds value */
#define CIA1_ALRMJIF 0xDC1C
/* TOD Alarm seconds value */
#define CIA1_ALRMSEC 0xDC1D
/* TOD Alarm minutes value */
#define CIA1_ALRMMIN 0xDC1E
/* TOD Alarm hours value (address) */
#define CIA1_ALRMHOUR_ADDR 0xDC1F
/* TOD Alarm hours value (bit mask) */
#define CIA1_ALRMHOUR_MASK 0b01111111
/* TOD Alarm AM/PM flag (address) */
#define CIA1_ALRMAMPM_ADDR 0xDC1F
/* TOD Alarm AM/PM flag (bit mask) */
#define CIA1_ALRMAMPM_MASK 0b10000000
/* Port A */
#define CIA2_PORTA 0xDD00
/* Port B */
#define CIA2_PORTB 0xDD01
/* Port A DDR */
#define CIA2_DDRA 0xDD02
/* Port B DDR */
#define CIA2_DDRB 0xDD03
/* Timer A counter (16 bit) */
#define CIA2_TIMERA 0xDD04
/* Timer A counter (16 bit) */
#define C64_CIA2_TIMERA 0xDD05
/* Timer B counter (16 bit) */
#define CIA2_TIMERB 0xDD06
/* Timer B counter (16 bit) */
#define C64_CIA2_TIMERB 0xDD07
/* TOD tenths of seconds (address) */
#define CIA2_TODJIF_ADDR 0xDD08
/* TOD tenths of seconds (bit mask) */
#define CIA2_TODJIF_MASK 0b00001111
/* TOD seconds (address) */
#define CIA2_TODSEC_ADDR 0xDD09
/* TOD seconds (bit mask) */
#define CIA2_TODSEC_MASK 0b00111111
/* TOD hours (address) */
#define CIA2_TODHOUR_ADDR 0xDD0B
/* TOD hours (bit mask) */
#define CIA2_TODHOUR_MASK 0b00011111
/* TOD PM flag (address) */
#define CIA2_TODAMPM_ADDR 0xDD0B
/* TOD PM flag (bit mask) */
#define CIA2_TODAMPM_MASK 0b10000000
/* shift register data register(writing starts sending) */
#define CIA2_SDR 0xDD0C
/* Timer A underflow (address) */
#define CIA2_TA_ADDR 0xDD0D
/* Timer A underflow (bit mask) */
#define CIA2_TA_MASK 0b00000001
/* Timer B underflow (address) */
#define CIA2_TB_ADDR 0xDD0D
/* Timer B underflow (bit mask) */
#define CIA2_TB_MASK 0b00000010
/* TOD alarm (address) */
#define CIA2_ALRM_ADDR 0xDD0D
/* TOD alarm (bit mask) */
#define CIA2_ALRM_MASK 0b00000100
/* shift register full/empty (address) */
#define CIA2_SP_ADDR 0xDD0D
/* shift register full/empty (bit mask) */
#define CIA2_SP_MASK 0b00001000
/* FLAG edge detected (address) */
#define CIA2_FLG_ADDR 0xDD0D
/* FLAG edge detected (bit mask) */
#define CIA2_FLG_MASK 0b00010000
/* Timer A start (address) */
#define CIA2_STRTA_ADDR 0xDD0E
/* Timer A start (bit mask) */
#define CIA2_STRTA_MASK 0b00000001
/* Timer A PB6 out (address) */
#define CIA2_PBONA_ADDR 0xDD0E
/* Timer A PB6 out (bit mask) */
#define CIA2_PBONA_MASK 0b00000010
/* Timer A toggle or pulse (address) */
#define CIA2_OMODA_ADDR 0xDD0E
/* Timer A toggle or pulse (bit mask) */
#define CIA2_OMODA_MASK 0b00000100
/* Timer A one-shot mode (address) */
#define CIA2_RMODA_ADDR 0xDD0E
/* Timer A one-shot mode (bit mask) */
#define CIA2_RMODA_MASK 0b00001000
/* Timer A Timer A tick source (address) */
#define CIA2_IMODA_ADDR 0xDD0E
/* Timer A Timer A tick source (bit mask) */
#define CIA2_IMODA_MASK 0b00100000
/* Serial port direction (address) */
#define CIA2_SPMOD_ADDR 0xDD0E
/* Serial port direction (bit mask) */
#define CIA2_SPMOD_MASK 0b01000000
/* 50/60Hz select for TOD clock (address) */
#define CIA2_TOD50_ADDR 0xDD0E
/* 50/60Hz select for TOD clock (bit mask) */
#define CIA2_TOD50_MASK 0b10000000
/* Timer B start (address) */
#define CIA2_STRTB_ADDR 0xDD0F
/* Timer B start (bit mask) */
#define CIA2_STRTB_MASK 0b00000001
/* Timer B PB7 out (address) */
#define CIA2_PBONB_ADDR 0xDD0F
/* Timer B PB7 out (bit mask) */
#define CIA2_PBONB_MASK 0b00000010
/* Timer B toggle or pulse (address) */
#define CIA2_OMODB_ADDR 0xDD0F
/* Timer B toggle or pulse (bit mask) */
#define CIA2_OMODB_MASK 0b00000100
/* Timer B one-shot mode (address) */
#define CIA2_RMODB_ADDR 0xDD0F
/* Timer B one-shot mode (bit mask) */
#define CIA2_RMODB_MASK 0b00001000
/* Strobe input to force-load timers (address) */
#define CIA2_LOAD_ADDR 0xDD0F
/* Strobe input to force-load timers (bit mask) */
#define CIA2_LOAD_MASK 0b00010000
/* Timer B Timer A tick source (address) */
#define CIA2_IMODB_ADDR 0xDD0F
/* Timer B Timer A tick source (bit mask) */
#define CIA2_IMODB_MASK 0b01100000
/* TOD alarm edit (address) */
#define C64_CIA2_TODEDIT_ADDR 0xDD0F
/* TOD alarm edit (bit mask) */
#define C64_CIA2_TODEDIT_MASK 0b10000000
/* Timer A latch value (16 bit) */
#define CIA2_TALATCH 0xDD10
/* Timer A latch value (16 bit) */
#define GS_CIA2_TALATCH 0xDD11
/* Timer B latch value (16 bit) */
#define GS_CIA2_TALATCH_2 0xDD12
/* Timer B latch value (16 bit) */
#define GS_CIA2_TALATCH_3 0xDD13
/* Timer A current value (16 bit) */
#define GS_CIA2_TALATCH_4 0xDD14
/* Timer A current value (16 bit) */
#define GS_CIA2_TALATCH_5 0xDD15
/* Timer B current value (16 bit) */
#define GS_CIA2_TALATCH_6 0xDD16
/* Timer B current value (16 bit) */
#define GS_CIA2_TALATCH_7 0xDD17
/* TOD 10ths of seconds value (address) */
#define GS_CIA2_TODJIF_ADDR 0xDD18
/* TOD 10ths of seconds value (bit mask) */
#define GS_CIA2_TODJIF_MASK 0b00001111
/* Interrupt mask for Timer B (address) */
#define CIA2_IMTB_ADDR 0xDD18
/* Interrupt mask for Timer B (bit mask) */
#define CIA2_IMTB_MASK 0b00010000
/* Interrupt mask for TOD alarm (address) */
#define CIA2_IMALRM_ADDR 0xDD18
/* Interrupt mask for TOD alarm (bit mask) */
#define CIA2_IMALRM_MASK 0b00100000
/* Interrupt mask for shift register (serial port) (address) */
#define CIA2_IMSP_ADDR 0xDD18
/* Interrupt mask for shift register (serial port) (bit mask) */
#define CIA2_IMSP_MASK 0b01000000
/* Interrupt mask for FLAG line (address) */
#define CIA2_IMFLG_ADDR 0xDD18
/* Interrupt mask for FLAG line (bit mask) */
#define CIA2_IMFLG_MASK 0b10000000
/* TOD Alarm seconds value */
#define CIA2_TODSEC 0xDD19
/* TOD Alarm minutes value */
#define CIA2_TODMIN 0xDD1A
/* TOD hours value (address) */
#define GS_CIA2_TODHOUR_ADDR 0xDD1B
/* TOD hours value (bit mask) */
#define GS_CIA2_TODHOUR_MASK 0b01111111
/* TOD AM/PM flag (address) */
#define GS_CIA2_TODAMPM_ADDR 0xDD1B
/* TOD AM/PM flag (bit mask) */
#define GS_CIA2_TODAMPM_MASK 0b10000000
/* TOD Alarm 10ths of seconds value */
#define CIA2_ALRMJIF 0xDD1C
/* Enable delaying writes to $DD00 by 3 cycles to match real 6502 timing (address) */
#define CIA2_DD00DELAY_ADDR 0xDD1C
/* Enable delaying writes to $DD00 by 3 cycles to match real 6502 timing (address) */
#define DD00DELAY_ADDR 0xDD1C
/* Enable delaying writes to $DD00 by 3 cycles to match real 6502 timing (bit mask) */
#define CIA2_DD00DELAY_MASK 0b10000000
/* Enable delaying writes to $DD00 by 3 cycles to match real 6502 timing (bit mask) */
#define DD00DELAY_MASK 0b10000000
/* TOD Alarm seconds value */
#define CIA2_ALRMSEC 0xDD1D
/* TOD Alarm minutes value */
#define CIA2_ALRMMIN 0xDD1E
/* TOD Alarm hours value (address) */
#define CIA2_ALRMHOUR_ADDR 0xDD1F
/* TOD Alarm hours value (bit mask) */
#define CIA2_ALRMHOUR_MASK 0b01111111
/* TOD Alarm AM/PM flag (address) */
#define CIA2_ALRMAMPM_ADDR 0xDD1F
/* TOD Alarm AM/PM flag (bit mask) */
#define CIA2_ALRMAMPM_MASK 0b10000000
/* Receive exactly one ethernet frame only, and keep all signals states (for debugging ethernet sub-system) */
#define ETHCOMMAND_RXONLYONE 0xDE
/* Receive exactly one ethernet frame only, and keep all signals states (for debugging ethernet sub-system) */
#define RXONLYONE 0xDE
/* Select ~1KiB frames for video/cpu debug stream frames (for receivers that do not support MTUs of greater than 2KiB) */
#define ETHCOMMAND_FRAME1K 0xF1
/* Select ~1KiB frames for video/cpu debug stream frames (for receivers that do not support MTUs of greater than 2KiB) */
#define FRAME1K 0xF1
/* Select ~2KiB frames for video/cpu debug stream frames, for optimal performance. */
#define ETHCOMMAND_FRAME2K 0xF2
/* Select ~2KiB frames for video/cpu debug stream frames, for optimal performance. */
#define FRAME2K 0xF2
/* VIC-IV CHARROM write area */
#define SUMMARY_CHARWRITE 0xFF7E000
/* VIC-IV CHARROM write area */
#define CHARWRITE 0xFF7E000
/* Colour RAM (32KB or 64KB) */
#define SUMMARY_COLOURRAM 0xFF80000
/* Colour RAM (32KB or 64KB) */
#define COLOURRAM 0xFF80000
/* Real-time Clock seconds value (binary coded decimal) */
#define RTC_RTCSEC 0xFFD7110
/* Real-time Clock seconds value (binary coded decimal) */
#define RTCSEC 0xFFD7110
/* Real-time Clock */
#define RTC_RTC 0xFFD7110
/* Real-time Clock */
#define RTC 0xFFD7110
/* Real-time Clock minutes value (binary coded decimal) */
#define RTC_RTCMIN 0xFFD7111
/* Real-time Clock minutes value (binary coded decimal) */
#define RTCMIN 0xFFD7111
/* Real-time Clock hours value (binary coded decimal) */
#define RTC_RTCHOUR 0xFFD7112
/* Real-time Clock hours value (binary coded decimal) */
#define RTCHOUR 0xFFD7112
/* Real-time Clock day of month value (binary coded decimal) */
#define RTC_RTCDAY 0xFFD7113
/* Real-time Clock day of month value (binary coded decimal) */
#define RTCDAY 0xFFD7113
/* Real-time Clock month value (binary coded decimal) */
#define RTC_RTCMONTH 0xFFD7114
/* Real-time Clock month value (binary coded decimal) */
#define RTCMONTH 0xFFD7114
/* Real-time Clock year value (binary coded decimal) */
#define RTC_RTCYEAR 0xFFD7115
/* Real-time Clock year value (binary coded decimal) */
#define RTCYEAR 0xFFD7115
/* 64-bytes of non-volatile RAM. Can be used for storing machine configuration. */
#define RTC_NVRAM 0xFFD7140
/* 64-bytes of non-volatile RAM. Can be used for storing machine configuration. */
#define NVRAM 0xFFD7140
/* 16KB Hyppo/Hypervisor ROM */
#define SUMMARY_HYPERVISOR 0xFFF8000
/* 16KB Hyppo/Hypervisor ROM */
#define HYPERVISOR 0xFFF8000
