" Vim semantic highlighting file
"
" Non syntax symbols are assigned colors according to
" a color table. 
"
" This could be a language agnostic script if the
" synIDattr() function could identify syntax IDs reliably.
"
" Original Details
" ================
" Language: C
" Maintainer: John Leimon <jleimon@gmail.com>
" Version: 1.0
" Last Change: 2014 Apr 21
" License: BSD (See below)
"
" Copyright (c) 2014, John Leimon
" All rights reserved.
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are met:
"
" 1. Redistributions of source code must retain the above copyright notice, this
"    list of conditions and the following disclaimer.
" 2. Redistributions in binary form must reproduce the above copyright notice,
"    this list of conditions and the following disclaimer in the documentation
"    and/or other materials provided with the distribution.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
" ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
" WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
" DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
" ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
" (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
" LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
" ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
" SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
" ================

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
 finish
endif

let s:change_index = 0
let s:match_pattern = '[a-zA-Z_][a-zA-Z0-9_]*'
let s:color_map = { }
let s:ignordict = { }
let s:num_of_colors = 0

function! SemHL_Init()
 let s:change_index = b:changedtick

 " Workaround for synIDattr() false negatives:
 " ignore_dict is populated with keywords to ignore.
 let s:ignore_dict = { 'goto': 0, 'break': 0, 'return': 0, 'continue': 0, 'asm': 0, 'case': 0, 'default': 0, 'if': 0, 'else': 0, 'switch': 0, 'while': 0, 'for': 0, 'do': 0, 'sizeof': 0, '__asm__': 0, 'typeof': 0, '__real__': 0, '__imag__': 0, 'int': 0, 'long': 0, 'short': 0, 'char': 0, 'void': 0, 'signed': 0, 'unsigned': 0, 'float': 0, 'double': 0, 'size_t': 0, 'ssize_t': 0, 'FILE': 0, 'DIR': 0, '_Bool': 0, 'bool': 0, '_Complex': 0, 'complex': 0, '_Imaginary': 0, 'imaginary': 0, 'int8_t': 0, 'int16_t': 0, 'int32_t': 0, 'int64_t': 0, 'uint8_t': 0, 'uint16_t': 0, 'uint32_t': 0, 'uint64_t': 0, 'struct': 0, 'union': 0, 'enum': 0, 'typedef': 0, 'static': 0, 'register': 0, 'volatile': 0, 'extern': 0, 'const': 0, 'inline': 0, '__attribute__': 0, '__LINE__': 0, '__FILE__': 0, '__DATE__': 0, '__TIME__': 0, '__STDC__': 0, '__PRETTY_FUNCTION__': 0 }

 call SemHL_SetColorMap_256()

 if s:num_of_colors == 0
   echom "SemanticHL: FATAL: Color map not defined."
   finish
 endif

 call SemHL_DefineSyntax()
 call SemHL_HighlightBuffer()
endfunction

function! SemHL_SetColorMap_768()
 " Define a color map composed of three walks over hue.
 "
 " Color: Hue        [0.0, 1.0] in steps of 0.003906
 "        Saturation { 0.50, 0.75, 1.00 }
 "        Lightness  0.5
 "
 " Total colors = 768
 let s:color_map = { 0x00: 'df1f1f', 0x01: 'df241f', 0x02: 'df281f', 0x03: 'df2d1f', 0x04: 'df311f', 0x05: 'df361f', 0x06: 'df3a1f', 0x07: 'df3f1f', 0x08: 'df431f', 0x09: 'df481f', 0x0a: 'df4c1f', 0x0b: 'df511f', 0x0c: 'df551f', 0x0d: 'df5a1f', 0x0e: 'df5e1f', 0x0f: 'df631f', 0x10: 'df671f', 0x11: 'df6c1f', 0x12: 'df701f', 0x13: 'df751f', 0x14: 'df791f', 0x15: 'df7e1f', 0x16: 'df821f', 0x17: 'df871f', 0x18: 'df8b1f', 0x19: 'df901f', 0x1a: 'df941f', 0x1b: 'df991f', 0x1c: 'df9d1f', 0x1d: 'dfa21f', 0x1e: 'dfa61f', 0x1f: 'dfab1f', 0x20: 'dfaf1f', 0x21: 'dfb41f', 0x22: 'dfb81f', 0x23: 'dfbd1f', 0x24: 'dfc11f', 0x25: 'dfc61f', 0x26: 'dfca1f', 0x27: 'dfcf1f', 0x28: 'dfd31f', 0x29: 'dfd81f', 0x2a: 'dfdc1f', 0x2b: 'dcdf1f', 0x2c: 'd8df1f', 0x2d: 'd3df1f', 0x2e: 'cfdf1f', 0x2f: 'cadf1f', 0x30: 'c6df1f', 0x31: 'c1df1f', 0x32: 'bddf1f', 0x33: 'b8df1f', 0x34: 'b4df1f', 0x35: 'afdf1f', 0x36: 'abdf1f', 0x37: 'a6df1f', 0x38: 'a2df1f', 0x39: '9ddf1f', 0x3a: '99df1f', 0x3b: '94df1f', 0x3c: '90df1f', 0x3d: '8bdf1f', 0x3e: '87df1f', 0x3f: '82df1f', 0x40: '7edf1f', 0x41: '79df1f', 0x42: '75df1f', 0x43: '70df1f', 0x44: '6cdf1f', 0x45: '67df1f', 0x46: '63df1f', 0x47: '5edf1f', 0x48: '5adf1f', 0x49: '55df1f', 0x4a: '51df1f', 0x4b: '4cdf1f', 0x4c: '48df1f', 0x4d: '43df1f', 0x4e: '3fdf1f', 0x4f: '3adf1f', 0x50: '36df1f', 0x51: '31df1f', 0x52: '2ddf1f', 0x53: '28df1f', 0x54: '24df1f', 0x55: '1fdf1f', 0x56: '1fdf24', 0x57: '1fdf28', 0x58: '1fdf2d', 0x59: '1fdf31', 0x5a: '1fdf36', 0x5b: '1fdf3a', 0x5c: '1fdf3f', 0x5d: '1fdf43', 0x5e: '1fdf48', 0x5f: '1fdf4c', 0x60: '1fdf51', 0x61: '1fdf55', 0x62: '1fdf5a', 0x63: '1fdf5e', 0x64: '1fdf63', 0x65: '1fdf67', 0x66: '1fdf6c', 0x67: '1fdf70', 0x68: '1fdf75', 0x69: '1fdf79', 0x6a: '1fdf7e', 0x6b: '1fdf82', 0x6c: '1fdf87', 0x6d: '1fdf8b', 0x6e: '1fdf90', 0x6f: '1fdf94', 0x70: '1fdf99', 0x71: '1fdf9d', 0x72: '1fdfa2', 0x73: '1fdfa6', 0x74: '1fdfab', 0x75: '1fdfaf', 0x76: '1fdfb4', 0x77: '1fdfb8', 0x78: '1fdfbd', 0x79: '1fdfc1', 0x7a: '1fdfc6', 0x7b: '1fdfca', 0x7c: '1fdfcf', 0x7d: '1fdfd3', 0x7e: '1fdfd8', 0x7f: '1fdfdc', 0x80: '1fdcdf', 0x81: '1fd8df', 0x82: '1fd3df', 0x83: '1fcfdf', 0x84: '1fcadf', 0x85: '1fc6df', 0x86: '1fc1df', 0x87: '1fbddf', 0x88: '1fb8df', 0x89: '1fb4df', 0x8a: '1fafdf', 0x8b: '1fabdf', 0x8c: '1fa6df', 0x8d: '1fa2df', 0x8e: '1f9ddf', 0x8f: '1f99df', 0x90: '1f94df', 0x91: '1f90df', 0x92: '1f8bdf', 0x93: '1f87df', 0x94: '1f82df', 0x95: '1f7edf', 0x96: '1f79df', 0x97: '1f75df', 0x98: '1f70df', 0x99: '1f6cdf', 0x9a: '1f67df', 0x9b: '1f63df', 0x9c: '1f5edf', 0x9d: '1f5adf', 0x9e: '1f55df', 0x9f: '1f51df', 0xa0: '1f4cdf', 0xa1: '1f48df', 0xa2: '1f43df', 0xa3: '1f3fdf', 0xa4: '1f3adf', 0xa5: '1f36df', 0xa6: '1f31df', 0xa7: '1f2ddf', 0xa8: '1f28df', 0xa9: '1f24df', 0xaa: '1f1fdf', 0xab: '241fdf', 0xac: '281fdf', 0xad: '2d1fdf', 0xae: '311fdf', 0xaf: '361fdf', 0xb0: '3a1fdf', 0xb1: '3f1fdf', 0xb2: '431fdf', 0xb3: '481fdf', 0xb4: '4c1fdf', 0xb5: '511fdf', 0xb6: '551fdf', 0xb7: '5a1fdf', 0xb8: '5e1fdf', 0xb9: '631fdf', 0xba: '671fdf', 0xbb: '6c1fdf', 0xbc: '701fdf', 0xbd: '751fdf', 0xbe: '791fdf', 0xbf: '7e1fdf', 0xc0: '821fdf', 0xc1: '871fdf', 0xc2: '8b1fdf', 0xc3: '901fdf', 0xc4: '941fdf', 0xc5: '991fdf', 0xc6: '9d1fdf', 0xc7: 'a21fdf', 0xc8: 'a61fdf', 0xc9: 'ab1fdf', 0xca: 'af1fdf', 0xcb: 'b41fdf', 0xcc: 'b81fdf', 0xcd: 'bd1fdf', 0xce: 'c11fdf', 0xcf: 'c61fdf', 0xd0: 'ca1fdf', 0xd1: 'cf1fdf', 0xd2: 'd31fdf', 0xd3: 'd81fdf', 0xd4: 'dc1fdf', 0xd5: 'df1fdc', 0xd6: 'df1fd8', 0xd7: 'df1fd3', 0xd8: 'df1fcf', 0xd9: 'df1fca', 0xda: 'df1fc6', 0xdb: 'df1fc1', 0xdc: 'df1fbd', 0xdd: 'df1fb8', 0xde: 'df1fb4', 0xdf: 'df1faf', 0xe0: 'df1fab', 0xe1: 'df1fa6', 0xe2: 'df1fa2', 0xe3: 'df1f9d', 0xe4: 'df1f99', 0xe5: 'df1f94', 0xe6: 'df1f90', 0xe7: 'df1f8b', 0xe8: 'df1f87', 0xe9: 'df1f82', 0xea: 'df1f7e', 0xeb: 'df1f79', 0xec: 'df1f75', 0xed: 'df1f70', 0xee: 'df1f6c', 0xef: 'df1f67', 0xf0: 'df1f63', 0xf1: 'df1f5e', 0xf2: 'df1f5a', 0xf3: 'df1f55', 0xf4: 'df1f51', 0xf5: 'df1f4c', 0xf6: 'df1f48', 0xf7: 'df1f43', 0xf8: 'df1f3f', 0xf9: 'df1f3a', 0xfa: 'df1f36', 0xfb: 'df1f31', 0xfc: 'df1f2d', 0xfd: 'df1f28', 0xfe: 'df1f24', 0xff: 'ef0f0f', 0x100: 'ef150f', 0x101: 'ef1a0f', 0x102: 'ef1f0f', 0x103: 'ef240f', 0x104: 'ef2a0f', 0x105: 'ef2f0f', 0x106: 'ef340f', 0x107: 'ef390f', 0x108: 'ef3f0f', 0x109: 'ef440f', 0x10a: 'ef490f', 0x10b: 'ef4e0f', 0x10c: 'ef540f', 0x10d: 'ef590f', 0x10e: 'ef5e0f', 0x10f: 'ef630f', 0x110: 'ef690f', 0x111: 'ef6e0f', 0x112: 'ef730f', 0x113: 'ef780f', 0x114: 'ef7e0f', 0x115: 'ef830f', 0x116: 'ef880f', 0x117: 'ef8d0f', 0x118: 'ef930f', 0x119: 'ef980f', 0x11a: 'ef9d0f', 0x11b: 'efa20f', 0x11c: 'efa80f', 0x11d: 'efad0f', 0x11e: 'efb20f', 0x11f: 'efb70f', 0x120: 'efbd0f', 0x121: 'efc20f', 0x122: 'efc70f', 0x123: 'efcc0f', 0x124: 'efd20f', 0x125: 'efd70f', 0x126: 'efdc0f', 0x127: 'efe10f', 0x128: 'efe70f', 0x129: 'efec0f', 0x12a: 'ecef0f', 0x12b: 'e7ef0f', 0x12c: 'e1ef0f', 0x12d: 'dcef0f', 0x12e: 'd7ef0f', 0x12f: 'd2ef0f', 0x130: 'ccef0f', 0x131: 'c7ef0f', 0x132: 'c2ef0f', 0x133: 'bdef0f', 0x134: 'b7ef0f', 0x135: 'b2ef0f', 0x136: 'adef0f', 0x137: 'a8ef0f', 0x138: 'a2ef0f', 0x139: '9def0f', 0x13a: '98ef0f', 0x13b: '93ef0f', 0x13c: '8def0f', 0x13d: '88ef0f', 0x13e: '83ef0f', 0x13f: '7eef0f', 0x140: '78ef0f', 0x141: '73ef0f', 0x142: '6eef0f', 0x143: '69ef0f', 0x144: '63ef0f', 0x145: '5eef0f', 0x146: '59ef0f', 0x147: '54ef0f', 0x148: '4eef0f', 0x149: '49ef0f', 0x14a: '44ef0f', 0x14b: '3fef0f', 0x14c: '39ef0f', 0x14d: '34ef0f', 0x14e: '2fef0f', 0x14f: '2aef0f', 0x150: '24ef0f', 0x151: '1fef0f', 0x152: '1aef0f', 0x153: '15ef0f', 0x154: '0fef0f', 0x155: '0fef15', 0x156: '0fef1a', 0x157: '0fef1f', 0x158: '0fef24', 0x159: '0fef2a', 0x15a: '0fef2f', 0x15b: '0fef34', 0x15c: '0fef39', 0x15d: '0fef3f', 0x15e: '0fef44', 0x15f: '0fef49', 0x160: '0fef4e', 0x161: '0fef54', 0x162: '0fef59', 0x163: '0fef5e', 0x164: '0fef63', 0x165: '0fef69', 0x166: '0fef6e', 0x167: '0fef73', 0x168: '0fef78', 0x169: '0fef7e', 0x16a: '0fef83', 0x16b: '0fef88', 0x16c: '0fef8d', 0x16d: '0fef93', 0x16e: '0fef98', 0x16f: '0fef9d', 0x170: '0fefa2', 0x171: '0fefa8', 0x172: '0fefad', 0x173: '0fefb2', 0x174: '0fefb7', 0x175: '0fefbd', 0x176: '0fefc2', 0x177: '0fefc7', 0x178: '0fefcc', 0x179: '0fefd2', 0x17a: '0fefd7', 0x17b: '0fefdc', 0x17c: '0fefe1', 0x17d: '0fefe7', 0x17e: '0fefec', 0x17f: '0fecef', 0x180: '0fe7ef', 0x181: '0fe1ef', 0x182: '0fdcef', 0x183: '0fd7ef', 0x184: '0fd2ef', 0x185: '0fccef', 0x186: '0fc7ef', 0x187: '0fc2ef', 0x188: '0fbdef', 0x189: '0fb7ef', 0x18a: '0fb2ef', 0x18b: '0fadef', 0x18c: '0fa8ef', 0x18d: '0fa2ef', 0x18e: '0f9def', 0x18f: '0f98ef', 0x190: '0f93ef', 0x191: '0f8def', 0x192: '0f88ef', 0x193: '0f83ef', 0x194: '0f7eef', 0x195: '0f78ef', 0x196: '0f73ef', 0x197: '0f6eef', 0x198: '0f69ef', 0x199: '0f63ef', 0x19a: '0f5eef', 0x19b: '0f59ef', 0x19c: '0f54ef', 0x19d: '0f4eef', 0x19e: '0f49ef', 0x19f: '0f44ef', 0x1a0: '0f3fef', 0x1a1: '0f39ef', 0x1a2: '0f34ef', 0x1a3: '0f2fef', 0x1a4: '0f2aef', 0x1a5: '0f24ef', 0x1a6: '0f1fef', 0x1a7: '0f1aef', 0x1a8: '0f15ef', 0x1a9: '0f0fef', 0x1aa: '150fef', 0x1ab: '1a0fef', 0x1ac: '1f0fef', 0x1ad: '240fef', 0x1ae: '2a0fef', 0x1af: '2f0fef', 0x1b0: '340fef', 0x1b1: '390fef', 0x1b2: '3f0fef', 0x1b3: '440fef', 0x1b4: '490fef', 0x1b5: '4e0fef', 0x1b6: '540fef', 0x1b7: '590fef', 0x1b8: '5e0fef', 0x1b9: '630fef', 0x1ba: '690fef', 0x1bb: '6e0fef', 0x1bc: '730fef', 0x1bd: '780fef', 0x1be: '7e0fef', 0x1bf: '830fef', 0x1c0: '880fef', 0x1c1: '8d0fef', 0x1c2: '930fef', 0x1c3: '980fef', 0x1c4: '9d0fef', 0x1c5: 'a20fef', 0x1c6: 'a80fef', 0x1c7: 'ad0fef', 0x1c8: 'b20fef', 0x1c9: 'b70fef', 0x1ca: 'bd0fef', 0x1cb: 'c20fef', 0x1cc: 'c70fef', 0x1cd: 'cc0fef', 0x1ce: 'd20fef', 0x1cf: 'd70fef', 0x1d0: 'dc0fef', 0x1d1: 'e10fef', 0x1d2: 'e70fef', 0x1d3: 'ec0fef', 0x1d4: 'ef0fec', 0x1d5: 'ef0fe7', 0x1d6: 'ef0fe1', 0x1d7: 'ef0fdc', 0x1d8: 'ef0fd7', 0x1d9: 'ef0fd2', 0x1da: 'ef0fcc', 0x1db: 'ef0fc7', 0x1dc: 'ef0fc2', 0x1dd: 'ef0fbd', 0x1de: 'ef0fb7', 0x1df: 'ef0fb2', 0x1e0: 'ef0fad', 0x1e1: 'ef0fa8', 0x1e2: 'ef0fa2', 0x1e3: 'ef0f9d', 0x1e4: 'ef0f98', 0x1e5: 'ef0f93', 0x1e6: 'ef0f8d', 0x1e7: 'ef0f88', 0x1e8: 'ef0f83', 0x1e9: 'ef0f7e', 0x1ea: 'ef0f78', 0x1eb: 'ef0f73', 0x1ec: 'ef0f6e', 0x1ed: 'ef0f69', 0x1ee: 'ef0f63', 0x1ef: 'ef0f5e', 0x1f0: 'ef0f59', 0x1f1: 'ef0f54', 0x1f2: 'ef0f4e', 0x1f3: 'ef0f49', 0x1f4: 'ef0f44', 0x1f5: 'ef0f3f', 0x1f6: 'ef0f39', 0x1f7: 'ef0f34', 0x1f8: 'ef0f2f', 0x1f9: 'ef0f2a', 0x1fa: 'ef0f24', 0x1fb: 'ef0f1f', 0x1fc: 'ef0f1a', 0x1fd: 'ef0f15', 0x1fe: 'ff0000', 0x1ff: 'ff0500', 0x200: 'ff0b00', 0x201: 'ff1200', 0x202: 'ff1800', 0x203: 'ff1e00', 0x204: 'ff2400', 0x205: 'ff2a00', 0x206: 'ff3000', 0x207: 'ff3600', 0x208: 'ff3c00', 0x209: 'ff4200', 0x20a: 'ff4800', 0x20b: 'ff4e00', 0x20c: 'ff5400', 0x20d: 'ff5a00', 0x20e: 'ff6000', 0x20f: 'ff6600', 0x210: 'ff6c00', 0x211: 'ff7200', 0x212: 'ff7800', 0x213: 'ff7e00', 0x214: 'ff8400', 0x215: 'ff8a00', 0x216: 'ff9000', 0x217: 'ff9600', 0x218: 'ff9c00', 0x219: 'ffa200', 0x21a: 'ffa800', 0x21b: 'ffae00', 0x21c: 'ffb400', 0x21d: 'ffba00', 0x21e: 'ffc000', 0x21f: 'ffc600', 0x220: 'ffcc00', 0x221: 'ffd200', 0x222: 'ffd800', 0x223: 'ffde00', 0x224: 'ffe400', 0x225: 'ffea00', 0x226: 'fff000', 0x227: 'fff600', 0x228: 'fffc00', 0x229: 'fbff00', 0x22a: 'f5ff00', 0x22b: 'efff00', 0x22c: 'e9ff00', 0x22d: 'e3ff00', 0x22e: 'ddff00', 0x22f: 'd7ff00', 0x230: 'd1ff00', 0x231: 'cbff00', 0x232: 'c5ff00', 0x233: 'bfff00', 0x234: 'b9ff00', 0x235: 'b3ff00', 0x236: 'adff00', 0x237: 'a7ff00', 0x238: 'a1ff00', 0x239: '9bff00', 0x23a: '95ff00', 0x23b: '8fff00', 0x23c: '89ff00', 0x23d: '83ff00', 0x23e: '7dff00', 0x23f: '77ff00', 0x240: '71ff00', 0x241: '6bff00', 0x242: '65ff00', 0x243: '5fff00', 0x244: '59ff00', 0x245: '53ff00', 0x246: '4dff00', 0x247: '47ff00', 0x248: '41ff00', 0x249: '3bff00', 0x24a: '35ff00', 0x24b: '2fff00', 0x24c: '29ff00', 0x24d: '23ff00', 0x24e: '1dff00', 0x24f: '17ff00', 0x250: '11ff00', 0x251: '0bff00', 0x252: '05ff00', 0x253: '00ff00', 0x254: '00ff05', 0x255: '00ff0b', 0x256: '00ff11', 0x257: '00ff17', 0x258: '00ff1d', 0x259: '00ff23', 0x25a: '00ff29', 0x25b: '00ff2f', 0x25c: '00ff35', 0x25d: '00ff3b', 0x25e: '00ff42', 0x25f: '00ff48', 0x260: '00ff4e', 0x261: '00ff54', 0x262: '00ff5a', 0x263: '00ff60', 0x264: '00ff66', 0x265: '00ff6c', 0x266: '00ff72', 0x267: '00ff78', 0x268: '00ff7e', 0x269: '00ff84', 0x26a: '00ff8a', 0x26b: '00ff90', 0x26c: '00ff96', 0x26d: '00ff9c', 0x26e: '00ffa2', 0x26f: '00ffa8', 0x270: '00ffae', 0x271: '00ffb4', 0x272: '00ffba', 0x273: '00ffc0', 0x274: '00ffc6', 0x275: '00ffcc', 0x276: '00ffd2', 0x277: '00ffd8', 0x278: '00ffde', 0x279: '00ffe4', 0x27a: '00ffea', 0x27b: '00fff0', 0x27c: '00fff6', 0x27d: '00fffc', 0x27e: '00fbff', 0x27f: '00f5ff', 0x280: '00efff', 0x281: '00e9ff', 0x282: '00e3ff', 0x283: '00ddff', 0x284: '00d7ff', 0x285: '00d1ff', 0x286: '00cbff', 0x287: '00c5ff', 0x288: '00bfff', 0x289: '00b9ff', 0x28a: '00b3ff', 0x28b: '00adff', 0x28c: '00a7ff', 0x28d: '00a1ff', 0x28e: '009bff', 0x28f: '0095ff', 0x290: '008fff', 0x291: '0089ff', 0x292: '0083ff', 0x293: '007dff', 0x294: '0077ff', 0x295: '0071ff', 0x296: '006bff', 0x297: '0065ff', 0x298: '005fff', 0x299: '0059ff', 0x29a: '0053ff', 0x29b: '004dff', 0x29c: '0047ff', 0x29d: '0041ff', 0x29e: '003bff', 0x29f: '0035ff', 0x2a0: '002fff', 0x2a1: '0029ff', 0x2a2: '0023ff', 0x2a3: '001dff', 0x2a4: '0017ff', 0x2a5: '0011ff', 0x2a6: '000bff', 0x2a7: '0005ff', 0x2a8: '0000ff', 0x2a9: '0600ff', 0x2aa: '0b00ff', 0x2ab: '1200ff', 0x2ac: '1700ff', 0x2ad: '1e00ff', 0x2ae: '2300ff', 0x2af: '2a00ff', 0x2b0: '2f00ff', 0x2b1: '3600ff', 0x2b2: '3b00ff', 0x2b3: '4200ff', 0x2b4: '4700ff', 0x2b5: '4e00ff', 0x2b6: '5300ff', 0x2b7: '5a00ff', 0x2b8: '5f00ff', 0x2b9: '6600ff', 0x2ba: '6b00ff', 0x2bb: '7200ff', 0x2bc: '7700ff', 0x2bd: '7e00ff', 0x2be: '8400ff', 0x2bf: '8a00ff', 0x2c0: '9000ff', 0x2c1: '9600ff', 0x2c2: '9c00ff', 0x2c3: 'a200ff', 0x2c4: 'a800ff', 0x2c5: 'ae00ff', 0x2c6: 'b400ff', 0x2c7: 'ba00ff', 0x2c8: 'c000ff', 0x2c9: 'c600ff', 0x2ca: 'cc00ff', 0x2cb: 'd200ff', 0x2cc: 'd800ff', 0x2cd: 'de00ff', 0x2ce: 'e400ff', 0x2cf: 'ea00ff', 0x2d0: 'f000ff', 0x2d1: 'f600ff', 0x2d2: 'fc00ff', 0x2d3: 'ff00fb', 0x2d4: 'ff00f5', 0x2d5: 'ff00ef', 0x2d6: 'ff00e9', 0x2d7: 'ff00e3', 0x2d8: 'ff00dd', 0x2d9: 'ff00d7', 0x2da: 'ff00d1', 0x2db: 'ff00cb', 0x2dc: 'ff00c5', 0x2dd: 'ff00bf', 0x2de: 'ff00b9', 0x2df: 'ff00b3', 0x2e0: 'ff00ad', 0x2e1: 'ff00a7', 0x2e2: 'ff00a1', 0x2e3: 'ff009b', 0x2e4: 'ff0095', 0x2e5: 'ff008f', 0x2e6: 'ff0089', 0x2e7: 'ff0083', 0x2e8: 'ff007d', 0x2e9: 'ff0077', 0x2ea: 'ff0071', 0x2eb: 'ff006b', 0x2ec: 'ff0065', 0x2ed: 'ff005f', 0x2ee: 'ff0059', 0x2ef: 'ff0053', 0x2f0: 'ff004d', 0x2f1: 'ff0047', 0x2f2: 'ff0041', 0x2f3: 'ff003b', 0x2f4: 'ff0035', 0x2f5: 'ff002f', 0x2f6: 'ff0029', 0x2f7: 'ff0023', 0x2f8: 'ff001d', 0x2f9: 'ff0017', 0x2fa: 'ff0011', 0x2fb: 'ff000b', 0x2fc: 'ff0005' } 
 let s:num_of_colors = len(s:color_map)
endfunction

function! SemHL_SetColorMap_256()
 " Define a color map composed of one walk over hue.
 "
 " Color: Hue        [0.0, 1.0] in steps of 0.003906
 "        Saturation 0.75
 "        Lightness  0.5
 "
 " Total colors = 256
 let s:color_map = { 0x00: 'ef0f0f', 0x01: 'ef150f', 0x02: 'ef1a0f', 0x03: 'ef1f0f', 0x04: 'ef240f', 0x05: 'ef2a0f', 0x06: 'ef2f0f', 0x07: 'ef340f', 0x08: 'ef390f', 0x09: 'ef3f0f', 0x0a: 'ef440f', 0x0b: 'ef490f', 0x0c: 'ef4e0f', 0x0d: 'ef540f', 0x0e: 'ef590f', 0x0f: 'ef5e0f', 0x10: 'ef630f', 0x11: 'ef690f', 0x12: 'ef6e0f', 0x13: 'ef730f', 0x14: 'ef780f', 0x15: 'ef7e0f', 0x16: 'ef830f', 0x17: 'ef880f', 0x18: 'ef8d0f', 0x19: 'ef930f', 0x1a: 'ef980f', 0x1b: 'ef9d0f', 0x1c: 'efa20f', 0x1d: 'efa80f', 0x1e: 'efad0f', 0x1f: 'efb20f', 0x20: 'efb70f', 0x21: 'efbd0f', 0x22: 'efc20f', 0x23: 'efc70f', 0x24: 'efcc0f', 0x25: 'efd20f', 0x26: 'efd70f', 0x27: 'efdc0f', 0x28: 'efe10f', 0x29: 'efe70f', 0x2a: 'efec0f', 0x2b: 'ecef0f', 0x2c: 'e7ef0f', 0x2d: 'e1ef0f', 0x2e: 'dcef0f', 0x2f: 'd7ef0f', 0x30: 'd2ef0f', 0x31: 'ccef0f', 0x32: 'c7ef0f', 0x33: 'c2ef0f', 0x34: 'bdef0f', 0x35: 'b7ef0f', 0x36: 'b2ef0f', 0x37: 'adef0f', 0x38: 'a8ef0f', 0x39: 'a2ef0f', 0x3a: '9def0f', 0x3b: '98ef0f', 0x3c: '93ef0f', 0x3d: '8def0f', 0x3e: '88ef0f', 0x3f: '83ef0f', 0x40: '7eef0f', 0x41: '78ef0f', 0x42: '73ef0f', 0x43: '6eef0f', 0x44: '69ef0f', 0x45: '63ef0f', 0x46: '5eef0f', 0x47: '59ef0f', 0x48: '54ef0f', 0x49: '4eef0f', 0x4a: '49ef0f', 0x4b: '44ef0f', 0x4c: '3fef0f', 0x4d: '39ef0f', 0x4e: '34ef0f', 0x4f: '2fef0f', 0x50: '2aef0f', 0x51: '24ef0f', 0x52: '1fef0f', 0x53: '1aef0f', 0x54: '15ef0f', 0x55: '0fef0f', 0x56: '0fef15', 0x57: '0fef1a', 0x58: '0fef1f', 0x59: '0fef24', 0x5a: '0fef2a', 0x5b: '0fef2f', 0x5c: '0fef34', 0x5d: '0fef39', 0x5e: '0fef3f', 0x5f: '0fef44', 0x60: '0fef49', 0x61: '0fef4e', 0x62: '0fef54', 0x63: '0fef59', 0x64: '0fef5e', 0x65: '0fef63', 0x66: '0fef69', 0x67: '0fef6e', 0x68: '0fef73', 0x69: '0fef78', 0x6a: '0fef7e', 0x6b: '0fef83', 0x6c: '0fef88', 0x6d: '0fef8d', 0x6e: '0fef93', 0x6f: '0fef98', 0x70: '0fef9d', 0x71: '0fefa2', 0x72: '0fefa8', 0x73: '0fefad', 0x74: '0fefb2', 0x75: '0fefb7', 0x76: '0fefbd', 0x77: '0fefc2', 0x78: '0fefc7', 0x79: '0fefcc', 0x7a: '0fefd2', 0x7b: '0fefd7', 0x7c: '0fefdc', 0x7d: '0fefe1', 0x7e: '0fefe7', 0x7f: '0fefec', 0x80: '0fecef', 0x81: '0fe7ef', 0x82: '0fe1ef', 0x83: '0fdcef', 0x84: '0fd7ef', 0x85: '0fd2ef', 0x86: '0fccef', 0x87: '0fc7ef', 0x88: '0fc2ef', 0x89: '0fbdef', 0x8a: '0fb7ef', 0x8b: '0fb2ef', 0x8c: '0fadef', 0x8d: '0fa8ef', 0x8e: '0fa2ef', 0x8f: '0f9def', 0x90: '0f98ef', 0x91: '0f93ef', 0x92: '0f8def', 0x93: '0f88ef', 0x94: '0f83ef', 0x95: '0f7eef', 0x96: '0f78ef', 0x97: '0f73ef', 0x98: '0f6eef', 0x99: '0f69ef', 0x9a: '0f63ef', 0x9b: '0f5eef', 0x9c: '0f59ef', 0x9d: '0f54ef', 0x9e: '0f4eef', 0x9f: '0f49ef', 0xa0: '0f44ef', 0xa1: '0f3fef', 0xa2: '0f39ef', 0xa3: '0f34ef', 0xa4: '0f2fef', 0xa5: '0f2aef', 0xa6: '0f24ef', 0xa7: '0f1fef', 0xa8: '0f1aef', 0xa9: '0f15ef', 0xaa: '0f0fef', 0xab: '150fef', 0xac: '1a0fef', 0xad: '1f0fef', 0xae: '240fef', 0xaf: '2a0fef', 0xb0: '2f0fef', 0xb1: '340fef', 0xb2: '390fef', 0xb3: '3f0fef', 0xb4: '440fef', 0xb5: '490fef', 0xb6: '4e0fef', 0xb7: '540fef', 0xb8: '590fef', 0xb9: '5e0fef', 0xba: '630fef', 0xbb: '690fef', 0xbc: '6e0fef', 0xbd: '730fef', 0xbe: '780fef', 0xbf: '7e0fef', 0xc0: '830fef', 0xc1: '880fef', 0xc2: '8d0fef', 0xc3: '930fef', 0xc4: '980fef', 0xc5: '9d0fef', 0xc6: 'a20fef', 0xc7: 'a80fef', 0xc8: 'ad0fef', 0xc9: 'b20fef', 0xca: 'b70fef', 0xcb: 'bd0fef', 0xcc: 'c20fef', 0xcd: 'c70fef', 0xce: 'cc0fef', 0xcf: 'd20fef', 0xd0: 'd70fef', 0xd1: 'dc0fef', 0xd2: 'e10fef', 0xd3: 'e70fef', 0xd4: 'ec0fef', 0xd5: 'ef0fec', 0xd6: 'ef0fe7', 0xd7: 'ef0fe1', 0xd8: 'ef0fdc', 0xd9: 'ef0fd7', 0xda: 'ef0fd2', 0xdb: 'ef0fcc', 0xdc: 'ef0fc7', 0xdd: 'ef0fc2', 0xde: 'ef0fbd', 0xdf: 'ef0fb7', 0xe0: 'ef0fb2', 0xe1: 'ef0fad', 0xe2: 'ef0fa8', 0xe3: 'ef0fa2', 0xe4: 'ef0f9d', 0xe5: 'ef0f98', 0xe6: 'ef0f93', 0xe7: 'ef0f8d', 0xe8: 'ef0f88', 0xe9: 'ef0f83', 0xea: 'ef0f7e', 0xeb: 'ef0f78', 0xec: 'ef0f73', 0xed: 'ef0f6e', 0xee: 'ef0f69', 0xef: 'ef0f63', 0xf0: 'ef0f5e', 0xf1: 'ef0f59', 0xf2: 'ef0f54', 0xf3: 'ef0f4e', 0xf4: 'ef0f49', 0xf5: 'ef0f44', 0xf6: 'ef0f3f', 0xf7: 'ef0f39', 0xf8: 'ef0f34', 0xf9: 'ef0f2f', 0xfa: 'ef0f2a', 0xfb: 'ef0f24', 0xfc: 'ef0f1f', 0xfd: 'ef0f1a', 0xfe: 'ef0f15', 0xff: 'ef0f00' }
 let s:num_of_colors = len(s:color_map)
endfunction

function! SemHL_OnTimeout()
 " Has buffer changed?
 if(s:change_index != b:changedtick)
  " Buffer Changed : Remove unused syntax patterns created by SemHL_HighlightView()
  call SemHL_HighlightBuffer()
  let s:change_index = b:changedtick
 endif
endfunction

function! SemHL_DefineSyntax()
 " Adjust this to set background and non-syntax non-semantic color
 hi Normal          guifg=#ffffff guibg=#777777

 hi def link PreProc	 Error
 hi Comment         guifg=#b0b0e0 term=italic
 hi String          guifg=#ffffff
 hi Error           guifg=#ff0000 guibg=#ffffff
 hi Number          guifg=#bbffff
 hi Todo            guifg=#000000 guibg=#ffff00
 hi Operator        guifg=#ffffff
 hi Conditional     guifg=#ffffff
 hi Statement       guifg=#ffffff
 hi StorageClass    guifg=#ffffff
 hi PreCondit       guifg=#cccccc
 hi Include         guifg=#cccccc
 hi Macro           guifg=#cccccc
 hi SpecialChar     guifg=#bbbbff
 hi Type            guifg=#ffffff
 hi Boolean         guifg=#ffffff
 hi LineNr          guifg=#cccccc
 hi CursorLineNr    guifg=#ffffff

 " Define base syntax rules
 
 if(exists("b:current_syntax"))
   unlet b:current_syntax
 endif
 runtime! syntax/c.vim
endfunction
 
" Convert a string (input) to an index in the color map (output)  
function! SemHL_HashStringToColor(string)
 let value = 0 
 let index = 0
 " Character to binary hex map
 let lookuptable = { '_': 0x50, 'a': 0x01, 'b': 0x02, 'c': 0x03, 'd': 0x04, 'e': 0x05, 'f': 0x06, 'g': 0x07, 'h': 0x08, 'i': 0x09, 'j': 0x0a, 'k': 0x0b, 'l': 0x0c, 'm': 0x0d, 'n': 0x0e, 'o': 0x0f, 'p': 0x10, 'q': 0x11, 'r': 0x12, 's': 0x13, 't': 0x14, 'u': 0x15, 'v': 0x16, 'w': 0x17, 'x': 0x18, 'y': 0x19, 'z': 0x1a, 'A': 0x1b, 'B': 0x1c, 'C': 0x1d, 'D': 0x1e, 'E': 0x1f, 'F': 0x20, 'G': 0x21, 'H': 0x22, 'I': 0x23, 'J': 0x24, 'K': 0x25, 'L': 0x26, 'M': 0x27, 'N': 0x28, 'O': 0x29, 'P': 0x2a, 'Q': 0x2b, 'R': 0x2c, 'S': 0x2d, 'T': 0x2e, 'U': 0x2f, 'V': 0x30, 'W': 0x31, 'X': 0x32, 'Y': 0x33, 'Z': 0x34, '0': 0x35, '1': 0x36, '2': 0x37, '3': 0x38, '4': 0x39, '5': 0x3a, '6': 0x3b, '7': 0x3c, '8': 0x3d, '9': 0x3e }

 " Hash function
 while index != len(a:string)
  let char = a:string[index]
  let value += lookuptable[char] * 7 * (index + 1)
  let index += 1
 endwhile
 return value % s:num_of_colors
endfunction

function! SemHL_HighlightView()
 " Execute semantic highlighting for lines visible in buffer and do it quickly.
 " This function leaves residual syntax rules as it's called and does not clean
 " them up. To clean up syntax rules call SemHL_HighlightView().
 " This function should execute fast enough such that it can be called on
 " CursorMoved events.
 let lines_left = line("w$") - line("w0") + 1
 let line_index = line("w0")
 while lines_left
  let search_index = 0
  let line = getline(line_index)
  while 1
   " Search line using a regular expression for a C/C++ symbol
   let match = matchstr(line, s:match_pattern, search_index) " regex match
   let match_index = match(line, s:match_pattern, search_index) " regex match
   " Was a match found?
   if(!empty(match))
    " Match found
    let syntax = synIDattr(synIDtrans(synID(line_index, match_index + 1, 1)), "name")
    " If the symbol is not already assigned to a syntax group, or it's 
    " not in the ignored symbols dictionary then assign it a semantic color
    if(empty(syntax) && !has_key(s:ignore_dict, match))
      execute 'syn keyword _s'.SemHL_HashStringToColor(match) match
    endif
    let search_index += len(match) + 1
   else
     " No match found in line - skip line
     break
   endif
  endwhile
  let line_index += 1
  let lines_left -= 1
 endwhile
endfunction

function! SemHL_HighlightBuffer()
 " Execute semantic highlighting for all lines in buffer. Removes
 " all unused syntax rules. This function can be slow to complete, 
 " depending on the size of the buffer.
 execute 'syntax clear'
 execute 'hi clear'

 " Define semantic highlight color groups
 for key in keys(s:color_map)
   execute 'hi def _s'.key.' guifg=#'.s:color_map[key]
 endfor
 
 " Establish syntax rules
 call SemHL_DefineSyntax()

 let lines_left = line("$")
 let line_index = 1
 while lines_left
  let search_index = 0
  let line = getline(line_index)
  while 1
   " Search line using a regular expression for a C/C++ symbol
   let match = matchstr(line, s:match_pattern, search_index)
   let match_index = match(line, s:match_pattern, search_index)
   " Was a match found?
   if(!empty(match))
    " Match found - make sure the symbol is not already defined
    let syntax = synIDattr(synIDtrans(synID(line_index, match_index + 1, 1)), "name")
    " If the symbol is not already assigned to a syntax group, or it's 
    " not in the ignored symbols dictionary then assign it a semantic color
    if(empty(syntax) && !has_key(s:ignore_dict, match))
      execute 'syn keyword _s'.SemHL_HashStringToColor(match) match
    endif
    let search_index += len(match) + 1
   else
     " No match found in line - skip line
     break
   endif
  endwhile
  let line_index += 1
  let lines_left -= 1
 endwhile
endfunction 

autocmd BufEnter * call SemHL_Init()
autocmd BufWritePost * call SemHL_Init()
autocmd InsertChange * call SemHL_HighlightView()
autocmd InsertEnter * call SemHL_HighlightView()
autocmd InsertLeave * call SemHL_HighlightView()
autocmd CursorHold * call SemHL_OnTimeout()
autocmd CursorHoldI * call SemHL_OnTimeout()

let b:current_syntax = "c"
