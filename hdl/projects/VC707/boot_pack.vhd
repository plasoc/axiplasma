library ieee;
use ieee.std_logic_1164.all;

package boot_pack is

	constant cpu_width : integer := 32;
	constant ram_size : integer := 398;
	subtype word_type is std_logic_vector(cpu_width-1 downto 0);
	type ram_type is array(0 to ram_size-1) of word_type;
	function load_hex return ram_type;

end package;

package body boot_pack is

	function load_hex return ram_type is
		variable ram_buffer : ram_type := (others=>(others=>'0'));
	begin
		ram_buffer(0) := X"3C1C0001";
		ram_buffer(1) := X"279C8630";
		ram_buffer(2) := X"3C050000";
		ram_buffer(3) := X"24A50638";
		ram_buffer(4) := X"3C040000";
		ram_buffer(5) := X"24840A94";
		ram_buffer(6) := X"3C1D0000";
		ram_buffer(7) := X"27BD0838";
		ram_buffer(8) := X"ACA00000";
		ram_buffer(9) := X"00A4182A";
		ram_buffer(10) := X"1460FFFD";
		ram_buffer(11) := X"24A50004";
		ram_buffer(12) := X"0C00007C";
		ram_buffer(13) := X"00000000";
		ram_buffer(14) := X"0800000E";
		ram_buffer(15) := X"23BDFF98";
		ram_buffer(16) := X"AFA10010";
		ram_buffer(17) := X"AFA20014";
		ram_buffer(18) := X"AFA30018";
		ram_buffer(19) := X"AFA4001C";
		ram_buffer(20) := X"AFA50020";
		ram_buffer(21) := X"AFA60024";
		ram_buffer(22) := X"AFA70028";
		ram_buffer(23) := X"AFA8002C";
		ram_buffer(24) := X"AFA90030";
		ram_buffer(25) := X"AFAA0034";
		ram_buffer(26) := X"AFAB0038";
		ram_buffer(27) := X"AFAC003C";
		ram_buffer(28) := X"AFAD0040";
		ram_buffer(29) := X"AFAE0044";
		ram_buffer(30) := X"AFAF0048";
		ram_buffer(31) := X"AFB8004C";
		ram_buffer(32) := X"AFB90050";
		ram_buffer(33) := X"AFBF0054";
		ram_buffer(34) := X"401A7000";
		ram_buffer(35) := X"235AFFFC";
		ram_buffer(36) := X"AFBA0058";
		ram_buffer(37) := X"0000D810";
		ram_buffer(38) := X"AFBB005C";
		ram_buffer(39) := X"0000D812";
		ram_buffer(40) := X"AFBB0060";
		ram_buffer(41) := X"0C0000D9";
		ram_buffer(42) := X"23A50000";
		ram_buffer(43) := X"8FA10010";
		ram_buffer(44) := X"8FA20014";
		ram_buffer(45) := X"8FA30018";
		ram_buffer(46) := X"8FA4001C";
		ram_buffer(47) := X"8FA50020";
		ram_buffer(48) := X"8FA60024";
		ram_buffer(49) := X"8FA70028";
		ram_buffer(50) := X"8FA8002C";
		ram_buffer(51) := X"8FA90030";
		ram_buffer(52) := X"8FAA0034";
		ram_buffer(53) := X"8FAB0038";
		ram_buffer(54) := X"8FAC003C";
		ram_buffer(55) := X"8FAD0040";
		ram_buffer(56) := X"8FAE0044";
		ram_buffer(57) := X"8FAF0048";
		ram_buffer(58) := X"8FB8004C";
		ram_buffer(59) := X"8FB90050";
		ram_buffer(60) := X"8FBF0054";
		ram_buffer(61) := X"8FBA0058";
		ram_buffer(62) := X"8FBB005C";
		ram_buffer(63) := X"03600011";
		ram_buffer(64) := X"8FBB0060";
		ram_buffer(65) := X"03600013";
		ram_buffer(66) := X"23BD0068";
		ram_buffer(67) := X"341B0001";
		ram_buffer(68) := X"03400008";
		ram_buffer(69) := X"409B6000";
		ram_buffer(70) := X"40026000";
		ram_buffer(71) := X"03E00008";
		ram_buffer(72) := X"40846000";
		ram_buffer(73) := X"3C050000";
		ram_buffer(74) := X"24A50150";
		ram_buffer(75) := X"8CA60000";
		ram_buffer(76) := X"AC06003C";
		ram_buffer(77) := X"8CA60004";
		ram_buffer(78) := X"AC060040";
		ram_buffer(79) := X"8CA60008";
		ram_buffer(80) := X"AC060044";
		ram_buffer(81) := X"8CA6000C";
		ram_buffer(82) := X"03E00008";
		ram_buffer(83) := X"AC060048";
		ram_buffer(84) := X"3C1A0000";
		ram_buffer(85) := X"375A003C";
		ram_buffer(86) := X"03400008";
		ram_buffer(87) := X"00000000";
		ram_buffer(88) := X"AC900000";
		ram_buffer(89) := X"AC910004";
		ram_buffer(90) := X"AC920008";
		ram_buffer(91) := X"AC93000C";
		ram_buffer(92) := X"AC940010";
		ram_buffer(93) := X"AC950014";
		ram_buffer(94) := X"AC960018";
		ram_buffer(95) := X"AC97001C";
		ram_buffer(96) := X"AC9E0020";
		ram_buffer(97) := X"AC9C0024";
		ram_buffer(98) := X"AC9D0028";
		ram_buffer(99) := X"AC9F002C";
		ram_buffer(100) := X"03E00008";
		ram_buffer(101) := X"34020000";
		ram_buffer(102) := X"8C900000";
		ram_buffer(103) := X"8C910004";
		ram_buffer(104) := X"8C920008";
		ram_buffer(105) := X"8C93000C";
		ram_buffer(106) := X"8C940010";
		ram_buffer(107) := X"8C950014";
		ram_buffer(108) := X"8C960018";
		ram_buffer(109) := X"8C97001C";
		ram_buffer(110) := X"8C9E0020";
		ram_buffer(111) := X"8C9C0024";
		ram_buffer(112) := X"8C9D0028";
		ram_buffer(113) := X"8C9F002C";
		ram_buffer(114) := X"03E00008";
		ram_buffer(115) := X"34A20000";
		ram_buffer(116) := X"00850019";
		ram_buffer(117) := X"00001012";
		ram_buffer(118) := X"00002010";
		ram_buffer(119) := X"03E00008";
		ram_buffer(120) := X"ACC40000";
		ram_buffer(121) := X"0000000C";
		ram_buffer(122) := X"03E00008";
		ram_buffer(123) := X"00000000";
		ram_buffer(124) := X"3C040000";
		ram_buffer(125) := X"27BDFFE8";
		ram_buffer(126) := X"AFBF0014";
		ram_buffer(127) := X"0C0000F6";
		ram_buffer(128) := X"24840214";
		ram_buffer(129) := X"8FBF0014";
		ram_buffer(130) := X"00001025";
		ram_buffer(131) := X"03E00008";
		ram_buffer(132) := X"27BD0018";
		ram_buffer(133) := X"27BDFFC0";
		ram_buffer(134) := X"AFB30024";
		ram_buffer(135) := X"3C13F0F0";
		ram_buffer(136) := X"AFB70034";
		ram_buffer(137) := X"AFB60030";
		ram_buffer(138) := X"AFB5002C";
		ram_buffer(139) := X"AFBF003C";
		ram_buffer(140) := X"AFBE0038";
		ram_buffer(141) := X"AFB40028";
		ram_buffer(142) := X"AFB20020";
		ram_buffer(143) := X"AFB1001C";
		ram_buffer(144) := X"AFB00018";
		ram_buffer(145) := X"3673F0F0";
		ram_buffer(146) := X"3C160100";
		ram_buffer(147) := X"241500E6";
		ram_buffer(148) := X"24170003";
		ram_buffer(149) := X"0C00015F";
		ram_buffer(150) := X"00000000";
		ram_buffer(151) := X"1453FFFD";
		ram_buffer(152) := X"00000000";
		ram_buffer(153) := X"0C000129";
		ram_buffer(154) := X"24040001";
		ram_buffer(155) := X"3C110100";
		ram_buffer(156) := X"00008025";
		ram_buffer(157) := X"3C120100";
		ram_buffer(158) := X"0C00015F";
		ram_buffer(159) := X"00000000";
		ram_buffer(160) := X"0C000133";
		ram_buffer(161) := X"0040A025";
		ram_buffer(162) := X"0C000133";
		ram_buffer(163) := X"AFA20010";
		ram_buffer(164) := X"16A00002";
		ram_buffer(165) := X"0295001B";
		ram_buffer(166) := X"0007000D";
		ram_buffer(167) := X"8FA30010";
		ram_buffer(168) := X"305E00FF";
		ram_buffer(169) := X"306300FF";
		ram_buffer(170) := X"00001010";
		ram_buffer(171) := X"1462000B";
		ram_buffer(172) := X"24040002";
		ram_buffer(173) := X"AE340000";
		ram_buffer(174) := X"16170016";
		ram_buffer(175) := X"26310004";
		ram_buffer(176) := X"02402825";
		ram_buffer(177) := X"24060010";
		ram_buffer(178) := X"0C000174";
		ram_buffer(179) := X"24040004";
		ram_buffer(180) := X"02209025";
		ram_buffer(181) := X"00008025";
		ram_buffer(182) := X"24040001";
		ram_buffer(183) := X"0C000129";
		ram_buffer(184) := X"00000000";
		ram_buffer(185) := X"24020002";
		ram_buffer(186) := X"17C2FFE3";
		ram_buffer(187) := X"24060010";
		ram_buffer(188) := X"02402825";
		ram_buffer(189) := X"0C000174";
		ram_buffer(190) := X"24040004";
		ram_buffer(191) := X"0C00011C";
		ram_buffer(192) := X"00000000";
		ram_buffer(193) := X"02C00008";
		ram_buffer(194) := X"00000000";
		ram_buffer(195) := X"1000FFD1";
		ram_buffer(196) := X"00000000";
		ram_buffer(197) := X"1000FFF0";
		ram_buffer(198) := X"26100001";
		ram_buffer(199) := X"8F828010";
		ram_buffer(200) := X"00000000";
		ram_buffer(201) := X"8C440004";
		ram_buffer(202) := X"8F82800C";
		ram_buffer(203) := X"8F838008";
		ram_buffer(204) := X"24420001";
		ram_buffer(205) := X"304201FF";
		ram_buffer(206) := X"10430008";
		ram_buffer(207) := X"00000000";
		ram_buffer(208) := X"8F83800C";
		ram_buffer(209) := X"3C050000";
		ram_buffer(210) := X"24A50850";
		ram_buffer(211) := X"308400FF";
		ram_buffer(212) := X"00651821";
		ram_buffer(213) := X"A0640000";
		ram_buffer(214) := X"AF82800C";
		ram_buffer(215) := X"03E00008";
		ram_buffer(216) := X"00000000";
		ram_buffer(217) := X"3C030000";
		ram_buffer(218) := X"8C620A50";
		ram_buffer(219) := X"27BDFFE0";
		ram_buffer(220) := X"8C420004";
		ram_buffer(221) := X"AFB10018";
		ram_buffer(222) := X"3C110000";
		ram_buffer(223) := X"AFB00014";
		ram_buffer(224) := X"AFBF001C";
		ram_buffer(225) := X"00608025";
		ram_buffer(226) := X"26310A54";
		ram_buffer(227) := X"2C430008";
		ram_buffer(228) := X"14600006";
		ram_buffer(229) := X"00000000";
		ram_buffer(230) := X"8FBF001C";
		ram_buffer(231) := X"8FB10018";
		ram_buffer(232) := X"8FB00014";
		ram_buffer(233) := X"03E00008";
		ram_buffer(234) := X"27BD0020";
		ram_buffer(235) := X"000210C0";
		ram_buffer(236) := X"02221021";
		ram_buffer(237) := X"8C430000";
		ram_buffer(238) := X"8C440004";
		ram_buffer(239) := X"0060F809";
		ram_buffer(240) := X"00000000";
		ram_buffer(241) := X"8E020A50";
		ram_buffer(242) := X"00000000";
		ram_buffer(243) := X"8C420004";
		ram_buffer(244) := X"1000FFEF";
		ram_buffer(245) := X"2C430008";
		ram_buffer(246) := X"27BDFFE8";
		ram_buffer(247) := X"3C0244A0";
		ram_buffer(248) := X"3C030000";
		ram_buffer(249) := X"AC620A50";
		ram_buffer(250) := X"AFB00010";
		ram_buffer(251) := X"3C020000";
		ram_buffer(252) := X"00808025";
		ram_buffer(253) := X"3C040000";
		ram_buffer(254) := X"AFBF0014";
		ram_buffer(255) := X"24420A54";
		ram_buffer(256) := X"24840A94";
		ram_buffer(257) := X"24420008";
		ram_buffer(258) := X"1444FFFE";
		ram_buffer(259) := X"AC40FFF8";
		ram_buffer(260) := X"3C0244A4";
		ram_buffer(261) := X"AF828010";
		ram_buffer(262) := X"3C020000";
		ram_buffer(263) := X"24640A50";
		ram_buffer(264) := X"2442031C";
		ram_buffer(265) := X"AC82001C";
		ram_buffer(266) := X"AC800020";
		ram_buffer(267) := X"8C630A50";
		ram_buffer(268) := X"24040001";
		ram_buffer(269) := X"8C620000";
		ram_buffer(270) := X"00000000";
		ram_buffer(271) := X"34420008";
		ram_buffer(272) := X"0C000046";
		ram_buffer(273) := X"AC620000";
		ram_buffer(274) := X"12000005";
		ram_buffer(275) := X"0200C825";
		ram_buffer(276) := X"8FBF0014";
		ram_buffer(277) := X"8FB00010";
		ram_buffer(278) := X"03200008";
		ram_buffer(279) := X"27BD0018";
		ram_buffer(280) := X"8FBF0014";
		ram_buffer(281) := X"8FB00010";
		ram_buffer(282) := X"03E00008";
		ram_buffer(283) := X"27BD0018";
		ram_buffer(284) := X"27BDFFE8";
		ram_buffer(285) := X"AFBF0014";
		ram_buffer(286) := X"0C000046";
		ram_buffer(287) := X"00002025";
		ram_buffer(288) := X"3C020000";
		ram_buffer(289) := X"8C430A50";
		ram_buffer(290) := X"8FBF0014";
		ram_buffer(291) := X"8C620000";
		ram_buffer(292) := X"2404FFF7";
		ram_buffer(293) := X"00441024";
		ram_buffer(294) := X"AC620000";
		ram_buffer(295) := X"03E00008";
		ram_buffer(296) := X"27BD0018";
		ram_buffer(297) := X"8F838010";
		ram_buffer(298) := X"00000000";
		ram_buffer(299) := X"8C620000";
		ram_buffer(300) := X"00000000";
		ram_buffer(301) := X"30420002";
		ram_buffer(302) := X"1040FFFC";
		ram_buffer(303) := X"00000000";
		ram_buffer(304) := X"AC640008";
		ram_buffer(305) := X"03E00008";
		ram_buffer(306) := X"00000000";
		ram_buffer(307) := X"27BDFFE8";
		ram_buffer(308) := X"AFBF0014";
		ram_buffer(309) := X"AFB00010";
		ram_buffer(310) := X"0C000046";
		ram_buffer(311) := X"00002025";
		ram_buffer(312) := X"8F83800C";
		ram_buffer(313) := X"8F828008";
		ram_buffer(314) := X"00000000";
		ram_buffer(315) := X"14620005";
		ram_buffer(316) := X"00000000";
		ram_buffer(317) := X"0C000046";
		ram_buffer(318) := X"24040001";
		ram_buffer(319) := X"1000FFF6";
		ram_buffer(320) := X"00000000";
		ram_buffer(321) := X"8F828008";
		ram_buffer(322) := X"3C030000";
		ram_buffer(323) := X"24630850";
		ram_buffer(324) := X"00431021";
		ram_buffer(325) := X"90500000";
		ram_buffer(326) := X"8F828008";
		ram_buffer(327) := X"24040001";
		ram_buffer(328) := X"24420001";
		ram_buffer(329) := X"304201FF";
		ram_buffer(330) := X"AF828008";
		ram_buffer(331) := X"0C000046";
		ram_buffer(332) := X"321000FF";
		ram_buffer(333) := X"8FBF0014";
		ram_buffer(334) := X"02001025";
		ram_buffer(335) := X"8FB00010";
		ram_buffer(336) := X"03E00008";
		ram_buffer(337) := X"27BD0018";
		ram_buffer(338) := X"27BDFFE8";
		ram_buffer(339) := X"00803025";
		ram_buffer(340) := X"24050004";
		ram_buffer(341) := X"AFBF0014";
		ram_buffer(342) := X"0C000129";
		ram_buffer(343) := X"30C400FF";
		ram_buffer(344) := X"24A5FFFF";
		ram_buffer(345) := X"14A0FFFC";
		ram_buffer(346) := X"00063202";
		ram_buffer(347) := X"8FBF0014";
		ram_buffer(348) := X"00000000";
		ram_buffer(349) := X"03E00008";
		ram_buffer(350) := X"27BD0018";
		ram_buffer(351) := X"27BDFFE0";
		ram_buffer(352) := X"AFB20018";
		ram_buffer(353) := X"AFB10014";
		ram_buffer(354) := X"AFB00010";
		ram_buffer(355) := X"AFBF001C";
		ram_buffer(356) := X"00008025";
		ram_buffer(357) := X"00008825";
		ram_buffer(358) := X"24120020";
		ram_buffer(359) := X"0C000133";
		ram_buffer(360) := X"00000000";
		ram_buffer(361) := X"02021004";
		ram_buffer(362) := X"26100008";
		ram_buffer(363) := X"1612FFFB";
		ram_buffer(364) := X"02228825";
		ram_buffer(365) := X"8FBF001C";
		ram_buffer(366) := X"02201025";
		ram_buffer(367) := X"8FB20018";
		ram_buffer(368) := X"8FB10014";
		ram_buffer(369) := X"8FB00010";
		ram_buffer(370) := X"03E00008";
		ram_buffer(371) := X"27BD0020";
		ram_buffer(372) := X"10C0000D";
		ram_buffer(373) := X"00C53021";
		ram_buffer(374) := X"2402FFF0";
		ram_buffer(375) := X"00C21824";
		ram_buffer(376) := X"0066302B";
		ram_buffer(377) := X"00A22824";
		ram_buffer(378) := X"00063100";
		ram_buffer(379) := X"24620010";
		ram_buffer(380) := X"00463021";
		ram_buffer(381) := X"3C022000";
		ram_buffer(382) := X"00822021";
		ram_buffer(383) := X"2402FFF0";
		ram_buffer(384) := X"14C50003";
		ram_buffer(385) := X"00A21824";
		ram_buffer(386) := X"03E00008";
		ram_buffer(387) := X"00000000";
		ram_buffer(388) := X"AC830000";
		ram_buffer(389) := X"AC600000";
		ram_buffer(390) := X"1000FFF9";
		ram_buffer(391) := X"24A50010";
		ram_buffer(392) := X"00000100";
		ram_buffer(393) := X"01010001";
		ram_buffer(394) := X"00000000";
		ram_buffer(395) := X"00000000";
		ram_buffer(396) := X"00000000";
		ram_buffer(397) := X"00000000";
		return ram_buffer;
	end;
end;