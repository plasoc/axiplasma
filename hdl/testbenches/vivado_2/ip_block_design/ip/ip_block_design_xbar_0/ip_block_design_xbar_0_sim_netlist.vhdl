-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
-- Date        : Thu Jan 26 16:07:14 2017
-- Host        : andrewandrepowell2-desktop running 64-bit Ubuntu 16.04 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /opt/Xilinx/Projects/koc/axiplasma/hdl/testbenches/vivado_2/ip_block_design/ip/ip_block_design_xbar_0/ip_block_design_xbar_0_sim_netlist.vhdl
-- Design      : ip_block_design_xbar_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter is
  port (
    S_AXI_ARREADY : out STD_LOGIC_VECTOR ( 0 to 0 );
    aa_mi_arvalid : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_master_slots[2].r_issuing_cnt_reg[17]\ : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_master_slots[2].r_issuing_cnt_reg[16]\ : out STD_LOGIC;
    \gen_master_slots[1].r_issuing_cnt_reg[9]\ : out STD_LOGIC;
    \gen_master_slots[1].r_issuing_cnt_reg[8]\ : out STD_LOGIC;
    \gen_master_slots[0].r_issuing_cnt_reg[1]\ : out STD_LOGIC;
    \gen_master_slots[0].r_issuing_cnt_reg[0]\ : out STD_LOGIC;
    \gen_master_slots[3].r_issuing_cnt_reg[24]\ : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \gen_no_arbiter.m_valid_i_reg_0\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]_0\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[0]_0\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[0]_1\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[0]_2\ : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_no_arbiter.m_target_hot_i_reg[1]_0\ : out STD_LOGIC;
    \gen_axi.s_axi_rlast_i_reg\ : out STD_LOGIC;
    \m_axi_arqos[3]\ : out STD_LOGIC_VECTOR ( 56 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    \m_payload_i_reg[34]\ : in STD_LOGIC;
    r_issuing_cnt : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \m_payload_i_reg[34]_0\ : in STD_LOGIC;
    \m_payload_i_reg[34]_1\ : in STD_LOGIC;
    mi_arready_3 : in STD_LOGIC;
    aresetn_d : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_arqos[3]\ : in STD_LOGIC_VECTOR ( 56 downto 0 );
    m_valid_i_reg : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[3]\ : in STD_LOGIC;
    \gen_single_thread.accept_cnt_reg[1]\ : in STD_LOGIC;
    \s_axi_araddr[18]\ : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter : entity is "axi_crossbar_v2_1_10_addr_arbiter";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter is
  signal \^d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_arready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal aa_mi_artarget_hot : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^aa_mi_arvalid\ : STD_LOGIC;
  signal \gen_axi.s_axi_rlast_i_i_4_n_0\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_target_hot_i_reg[0]_0\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_target_hot_i_reg[0]_1\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_target_hot_i_reg[0]_2\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_target_hot_i_reg[1]_0\ : STD_LOGIC;
  signal \gen_no_arbiter.m_valid_i_i_1__0_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.m_valid_i_i_2__0_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.m_valid_i_i_3__0_n_0\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_valid_i_reg_0\ : STD_LOGIC;
  signal \^m_axi_arqos[3]\ : STD_LOGIC_VECTOR ( 56 downto 0 );
  signal s_ready_i2 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_axi.s_axi_arready_i_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_target_hot_i[0]_i_1__0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_valid_i_i_3__0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \gen_no_arbiter.s_ready_i[0]_i_10__0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gen_no_arbiter.s_ready_i[0]_i_4__0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \m_axi_arvalid[0]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \m_axi_arvalid[1]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \m_axi_arvalid[2]_INST_0\ : label is "soft_lutpair3";
begin
  D(1 downto 0) <= \^d\(1 downto 0);
  Q(0) <= \^q\(0);
  SR(0) <= \^sr\(0);
  S_AXI_ARREADY(0) <= \^s_axi_arready\(0);
  aa_mi_arvalid <= \^aa_mi_arvalid\;
  \gen_no_arbiter.m_target_hot_i_reg[0]_0\ <= \^gen_no_arbiter.m_target_hot_i_reg[0]_0\;
  \gen_no_arbiter.m_target_hot_i_reg[0]_1\ <= \^gen_no_arbiter.m_target_hot_i_reg[0]_1\;
  \gen_no_arbiter.m_target_hot_i_reg[0]_2\ <= \^gen_no_arbiter.m_target_hot_i_reg[0]_2\;
  \gen_no_arbiter.m_target_hot_i_reg[1]_0\ <= \^gen_no_arbiter.m_target_hot_i_reg[1]_0\;
  \gen_no_arbiter.m_valid_i_reg_0\ <= \^gen_no_arbiter.m_valid_i_reg_0\;
  \m_axi_arqos[3]\(56 downto 0) <= \^m_axi_arqos[3]\(56 downto 0);
\gen_axi.s_axi_arready_i_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^aa_mi_arvalid\,
      I1 => \^q\(0),
      I2 => mi_arready_3,
      O => \gen_master_slots[3].r_issuing_cnt_reg[24]\
    );
\gen_axi.s_axi_rlast_i_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \^m_axi_arqos[3]\(34),
      I1 => \^m_axi_arqos[3]\(35),
      I2 => \^m_axi_arqos[3]\(32),
      I3 => \^m_axi_arqos[3]\(33),
      I4 => \gen_axi.s_axi_rlast_i_i_4_n_0\,
      O => \gen_axi.s_axi_rlast_i_reg\
    );
\gen_axi.s_axi_rlast_i_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^m_axi_arqos[3]\(39),
      I1 => \^m_axi_arqos[3]\(38),
      I2 => \^m_axi_arqos[3]\(37),
      I3 => \^m_axi_arqos[3]\(36),
      O => \gen_axi.s_axi_rlast_i_i_4_n_0\
    );
\gen_master_slots[0].r_issuing_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F808080807F00"
    )
        port map (
      I0 => m_axi_arready(0),
      I1 => aa_mi_artarget_hot(0),
      I2 => \^aa_mi_arvalid\,
      I3 => r_issuing_cnt(1),
      I4 => \m_payload_i_reg[34]_1\,
      I5 => r_issuing_cnt(0),
      O => \gen_master_slots[0].r_issuing_cnt_reg[0]\
    );
\gen_master_slots[0].r_issuing_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6CC8C8C8C8C8C8C8"
    )
        port map (
      I0 => \m_payload_i_reg[34]_1\,
      I1 => r_issuing_cnt(1),
      I2 => r_issuing_cnt(0),
      I3 => \^aa_mi_arvalid\,
      I4 => aa_mi_artarget_hot(0),
      I5 => m_axi_arready(0),
      O => \gen_master_slots[0].r_issuing_cnt_reg[1]\
    );
\gen_master_slots[1].r_issuing_cnt[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F808080807F00"
    )
        port map (
      I0 => m_axi_arready(1),
      I1 => aa_mi_artarget_hot(1),
      I2 => \^aa_mi_arvalid\,
      I3 => r_issuing_cnt(3),
      I4 => \m_payload_i_reg[34]_0\,
      I5 => r_issuing_cnt(2),
      O => \gen_master_slots[1].r_issuing_cnt_reg[8]\
    );
\gen_master_slots[1].r_issuing_cnt[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6CC8C8C8C8C8C8C8"
    )
        port map (
      I0 => \m_payload_i_reg[34]_0\,
      I1 => r_issuing_cnt(3),
      I2 => r_issuing_cnt(2),
      I3 => \^aa_mi_arvalid\,
      I4 => aa_mi_artarget_hot(1),
      I5 => m_axi_arready(1),
      O => \gen_master_slots[1].r_issuing_cnt_reg[9]\
    );
\gen_master_slots[2].r_issuing_cnt[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F808080807F00"
    )
        port map (
      I0 => aa_mi_artarget_hot(2),
      I1 => m_axi_arready(2),
      I2 => \^aa_mi_arvalid\,
      I3 => r_issuing_cnt(5),
      I4 => \m_payload_i_reg[34]\,
      I5 => r_issuing_cnt(4),
      O => \gen_master_slots[2].r_issuing_cnt_reg[16]\
    );
\gen_master_slots[2].r_issuing_cnt[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6CC8C8C8C8C8C8C8"
    )
        port map (
      I0 => \m_payload_i_reg[34]\,
      I1 => r_issuing_cnt(5),
      I2 => r_issuing_cnt(4),
      I3 => \^aa_mi_arvalid\,
      I4 => m_axi_arready(2),
      I5 => aa_mi_artarget_hot(2),
      O => \gen_master_slots[2].r_issuing_cnt_reg[17]\
    );
\gen_no_arbiter.m_mesg_i[32]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn_d,
      O => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i[32]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^aa_mi_arvalid\,
      O => s_ready_i2
    );
\gen_no_arbiter.m_mesg_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(9),
      Q => \^m_axi_arqos[3]\(9),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(10),
      Q => \^m_axi_arqos[3]\(10),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(11),
      Q => \^m_axi_arqos[3]\(11),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(12),
      Q => \^m_axi_arqos[3]\(12),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(13),
      Q => \^m_axi_arqos[3]\(13),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(14),
      Q => \^m_axi_arqos[3]\(14),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(15),
      Q => \^m_axi_arqos[3]\(15),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(16),
      Q => \^m_axi_arqos[3]\(16),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(17),
      Q => \^m_axi_arqos[3]\(17),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(18),
      Q => \^m_axi_arqos[3]\(18),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(0),
      Q => \^m_axi_arqos[3]\(0),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(19),
      Q => \^m_axi_arqos[3]\(19),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(20),
      Q => \^m_axi_arqos[3]\(20),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(21),
      Q => \^m_axi_arqos[3]\(21),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(22),
      Q => \^m_axi_arqos[3]\(22),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(23),
      Q => \^m_axi_arqos[3]\(23),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(24),
      Q => \^m_axi_arqos[3]\(24),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(25),
      Q => \^m_axi_arqos[3]\(25),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(26),
      Q => \^m_axi_arqos[3]\(26),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(27),
      Q => \^m_axi_arqos[3]\(27),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(28),
      Q => \^m_axi_arqos[3]\(28),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(1),
      Q => \^m_axi_arqos[3]\(1),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(29),
      Q => \^m_axi_arqos[3]\(29),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(30),
      Q => \^m_axi_arqos[3]\(30),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(31),
      Q => \^m_axi_arqos[3]\(31),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(32),
      Q => \^m_axi_arqos[3]\(32),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(33),
      Q => \^m_axi_arqos[3]\(33),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(34),
      Q => \^m_axi_arqos[3]\(34),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(35),
      Q => \^m_axi_arqos[3]\(35),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(36),
      Q => \^m_axi_arqos[3]\(36),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(37),
      Q => \^m_axi_arqos[3]\(37),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(38),
      Q => \^m_axi_arqos[3]\(38),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(2),
      Q => \^m_axi_arqos[3]\(2),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(39),
      Q => \^m_axi_arqos[3]\(39),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(40),
      Q => \^m_axi_arqos[3]\(40),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(41),
      Q => \^m_axi_arqos[3]\(41),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(42),
      Q => \^m_axi_arqos[3]\(42),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(43),
      Q => \^m_axi_arqos[3]\(43),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(44),
      Q => \^m_axi_arqos[3]\(44),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(45),
      Q => \^m_axi_arqos[3]\(45),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(46),
      Q => \^m_axi_arqos[3]\(46),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(3),
      Q => \^m_axi_arqos[3]\(3),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(47),
      Q => \^m_axi_arqos[3]\(47),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(48),
      Q => \^m_axi_arqos[3]\(48),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(49),
      Q => \^m_axi_arqos[3]\(49),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(50),
      Q => \^m_axi_arqos[3]\(50),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(51),
      Q => \^m_axi_arqos[3]\(51),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(52),
      Q => \^m_axi_arqos[3]\(52),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(53),
      Q => \^m_axi_arqos[3]\(53),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(4),
      Q => \^m_axi_arqos[3]\(4),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(54),
      Q => \^m_axi_arqos[3]\(54),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(55),
      Q => \^m_axi_arqos[3]\(55),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(56),
      Q => \^m_axi_arqos[3]\(56),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(5),
      Q => \^m_axi_arqos[3]\(5),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(6),
      Q => \^m_axi_arqos[3]\(6),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(7),
      Q => \^m_axi_arqos[3]\(7),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_mesg_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_arqos[3]\(8),
      Q => \^m_axi_arqos[3]\(8),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_target_hot_i[0]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
        port map (
      I0 => \s_axi_arqos[3]\(16),
      I1 => \^gen_no_arbiter.m_target_hot_i_reg[0]_0\,
      I2 => \^gen_no_arbiter.m_target_hot_i_reg[0]_1\,
      I3 => \s_axi_arqos[3]\(31),
      I4 => \^gen_no_arbiter.m_target_hot_i_reg[0]_2\,
      O => \^d\(0)
    );
\gen_no_arbiter.m_target_hot_i[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => \^gen_no_arbiter.m_target_hot_i_reg[1]_0\,
      I1 => \s_axi_arqos[3]\(18),
      I2 => \s_axi_arqos[3]\(19),
      I3 => \s_axi_arqos[3]\(17),
      I4 => \s_axi_arqos[3]\(16),
      I5 => \^gen_no_arbiter.m_target_hot_i_reg[0]_1\,
      O => \^d\(1)
    );
\gen_no_arbiter.m_target_hot_i[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFEF"
    )
        port map (
      I0 => \s_axi_arqos[3]\(31),
      I1 => \s_axi_arqos[3]\(26),
      I2 => \s_axi_arqos[3]\(30),
      I3 => \s_axi_arqos[3]\(27),
      I4 => \s_axi_arqos[3]\(28),
      I5 => \s_axi_arqos[3]\(29),
      O => \^gen_no_arbiter.m_target_hot_i_reg[1]_0\
    );
\gen_no_arbiter.m_target_hot_i[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFEFF"
    )
        port map (
      I0 => \s_axi_arqos[3]\(29),
      I1 => \s_axi_arqos[3]\(28),
      I2 => \s_axi_arqos[3]\(27),
      I3 => \s_axi_arqos[3]\(30),
      I4 => \s_axi_arqos[3]\(26),
      O => \^gen_no_arbiter.m_target_hot_i_reg[0]_2\
    );
\gen_no_arbiter.m_target_hot_i[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \s_axi_arqos[3]\(24),
      I1 => \s_axi_arqos[3]\(23),
      I2 => \s_axi_arqos[3]\(21),
      I3 => \s_axi_arqos[3]\(25),
      I4 => \s_axi_arqos[3]\(20),
      I5 => \s_axi_arqos[3]\(22),
      O => \^gen_no_arbiter.m_target_hot_i_reg[0]_1\
    );
\gen_no_arbiter.m_target_hot_i[3]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \s_axi_arqos[3]\(17),
      I1 => \s_axi_arqos[3]\(19),
      I2 => \s_axi_arqos[3]\(18),
      O => \^gen_no_arbiter.m_target_hot_i_reg[0]_0\
    );
\gen_no_arbiter.m_target_hot_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \^d\(0),
      Q => aa_mi_artarget_hot(0),
      R => '0'
    );
\gen_no_arbiter.m_target_hot_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \^d\(1),
      Q => aa_mi_artarget_hot(1),
      R => '0'
    );
\gen_no_arbiter.m_target_hot_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \s_axi_araddr[18]\(0),
      Q => aa_mi_artarget_hot(2),
      R => '0'
    );
\gen_no_arbiter.m_target_hot_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \s_axi_araddr[18]\(1),
      Q => \^q\(0),
      R => '0'
    );
\gen_no_arbiter.m_valid_i_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0B00FFFF0B000B00"
    )
        port map (
      I0 => m_valid_i_reg,
      I1 => \gen_single_thread.active_target_hot_reg[3]\,
      I2 => \^gen_no_arbiter.m_valid_i_reg_0\,
      I3 => \gen_single_thread.accept_cnt_reg[1]\,
      I4 => \gen_no_arbiter.m_valid_i_i_2__0_n_0\,
      I5 => \^aa_mi_arvalid\,
      O => \gen_no_arbiter.m_valid_i_i_1__0_n_0\
    );
\gen_no_arbiter.m_valid_i_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF8880000"
    )
        port map (
      I0 => \^q\(0),
      I1 => mi_arready_3,
      I2 => aa_mi_artarget_hot(2),
      I3 => m_axi_arready(2),
      I4 => \^aa_mi_arvalid\,
      I5 => \gen_no_arbiter.m_valid_i_i_3__0_n_0\,
      O => \gen_no_arbiter.m_valid_i_i_2__0_n_0\
    );
\gen_no_arbiter.m_valid_i_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0808080"
    )
        port map (
      I0 => aa_mi_artarget_hot(0),
      I1 => m_axi_arready(0),
      I2 => \^aa_mi_arvalid\,
      I3 => aa_mi_artarget_hot(1),
      I4 => m_axi_arready(1),
      O => \gen_no_arbiter.m_valid_i_i_3__0_n_0\
    );
\gen_no_arbiter.m_valid_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_no_arbiter.m_valid_i_i_1__0_n_0\,
      Q => \^aa_mi_arvalid\,
      R => \^sr\(0)
    );
\gen_no_arbiter.s_ready_i[0]_i_10__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010002"
    )
        port map (
      I0 => \s_axi_arqos[3]\(16),
      I1 => \^gen_no_arbiter.m_target_hot_i_reg[0]_0\,
      I2 => \^gen_no_arbiter.m_target_hot_i_reg[0]_1\,
      I3 => \^gen_no_arbiter.m_target_hot_i_reg[0]_2\,
      I4 => \s_axi_arqos[3]\(31),
      O => \gen_no_arbiter.m_target_hot_i_reg[3]_0\
    );
\gen_no_arbiter.s_ready_i[0]_i_4__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
        port map (
      I0 => s_axi_arvalid(0),
      I1 => \^s_axi_arready\(0),
      I2 => \^aa_mi_arvalid\,
      O => \^gen_no_arbiter.m_valid_i_reg_0\
    );
\gen_no_arbiter.s_ready_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => E(0),
      Q => \^s_axi_arready\(0),
      R => '0'
    );
\m_axi_arvalid[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^aa_mi_arvalid\,
      I1 => aa_mi_artarget_hot(0),
      O => m_axi_arvalid(0)
    );
\m_axi_arvalid[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^aa_mi_arvalid\,
      I1 => aa_mi_artarget_hot(1),
      O => m_axi_arvalid(1)
    );
\m_axi_arvalid[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^aa_mi_arvalid\,
      I1 => aa_mi_artarget_hot(2),
      O => m_axi_arvalid(2)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter_0 is
  port (
    ss_aa_awready : out STD_LOGIC;
    aa_sa_awvalid : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_no_arbiter.m_target_hot_i_reg[1]_0\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[1]_1\ : out STD_LOGIC;
    \gen_master_slots[2].w_issuing_cnt_reg[17]\ : out STD_LOGIC;
    \gen_master_slots[2].w_issuing_cnt_reg[17]_0\ : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_master_slots[2].w_issuing_cnt_reg[16]\ : out STD_LOGIC;
    \gen_master_slots[1].w_issuing_cnt_reg[9]\ : out STD_LOGIC;
    \gen_master_slots[1].w_issuing_cnt_reg[8]\ : out STD_LOGIC;
    \gen_master_slots[0].w_issuing_cnt_reg[1]\ : out STD_LOGIC;
    \gen_master_slots[0].w_issuing_cnt_reg[0]\ : out STD_LOGIC;
    \m_ready_d_reg[1]\ : out STD_LOGIC;
    \gen_master_slots[3].w_issuing_cnt_reg[24]\ : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \gen_no_arbiter.m_valid_i_reg_0\ : out STD_LOGIC;
    st_aa_awtarget_enc : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_no_arbiter.m_target_hot_i_reg[3]_0\ : out STD_LOGIC;
    \m_ready_d_reg[1]_0\ : out STD_LOGIC;
    \gen_master_slots[3].w_issuing_cnt_reg[24]_0\ : out STD_LOGIC;
    \m_axi_awqos[3]\ : out STD_LOGIC_VECTOR ( 56 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_awqos[3]\ : in STD_LOGIC_VECTOR ( 56 downto 0 );
    \s_axi_awaddr[18]\ : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    w_issuing_cnt : in STD_LOGIC_VECTOR ( 6 downto 0 );
    \gen_single_thread.active_target_hot_reg[2]\ : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[1]\ : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[0]\ : in STD_LOGIC;
    m_ready_d : in STD_LOGIC_VECTOR ( 1 downto 0 );
    mi_awready_3 : in STD_LOGIC;
    m_ready_d_0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_master_slots[3].w_issuing_cnt_reg[24]_1\ : in STD_LOGIC;
    \gen_single_thread.accept_cnt_reg[0]\ : in STD_LOGIC;
    \gen_single_thread.accept_cnt_reg[1]\ : in STD_LOGIC;
    p_42_out : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[3]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_awaddr[22]\ : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter_0 : entity is "axi_crossbar_v2_1_10_addr_arbiter";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter_0;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter_0 is
  signal \^d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal aa_mi_awtarget_hot : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^aa_sa_awvalid\ : STD_LOGIC;
  signal \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\ : STD_LOGIC;
  signal \^gen_master_slots[3].w_issuing_cnt_reg[24]\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_target_hot_i_reg[1]_0\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_target_hot_i_reg[1]_1\ : STD_LOGIC;
  signal \gen_no_arbiter.m_valid_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.m_valid_i_i_2_n_0\ : STD_LOGIC;
  signal \^gen_no_arbiter.m_valid_i_reg_0\ : STD_LOGIC;
  signal \m_ready_d[1]_i_4_n_0\ : STD_LOGIC;
  signal \^m_ready_d_reg[1]\ : STD_LOGIC;
  signal s_ready_i2 : STD_LOGIC;
  signal \^ss_aa_awready\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_axi.write_cs[0]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_master_slots[2].w_issuing_cnt[17]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_target_hot_i[1]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_target_hot_i[2]_i_1__0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_axi_awvalid[0]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axi_awvalid[1]_INST_0\ : label is "soft_lutpair6";
begin
  D(1 downto 0) <= \^d\(1 downto 0);
  Q(0) <= \^q\(0);
  aa_sa_awvalid <= \^aa_sa_awvalid\;
  \gen_master_slots[2].w_issuing_cnt_reg[17]_0\ <= \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\;
  \gen_master_slots[3].w_issuing_cnt_reg[24]\ <= \^gen_master_slots[3].w_issuing_cnt_reg[24]\;
  \gen_no_arbiter.m_target_hot_i_reg[1]_0\ <= \^gen_no_arbiter.m_target_hot_i_reg[1]_0\;
  \gen_no_arbiter.m_target_hot_i_reg[1]_1\ <= \^gen_no_arbiter.m_target_hot_i_reg[1]_1\;
  \gen_no_arbiter.m_valid_i_reg_0\ <= \^gen_no_arbiter.m_valid_i_reg_0\;
  \m_ready_d_reg[1]\ <= \^m_ready_d_reg[1]\;
  ss_aa_awready <= \^ss_aa_awready\;
\gen_axi.write_cs[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => m_ready_d(1),
      I1 => \^aa_sa_awvalid\,
      I2 => \^q\(0),
      I3 => mi_awready_3,
      O => \^gen_master_slots[3].w_issuing_cnt_reg[24]\
    );
\gen_master_slots[0].w_issuing_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5AAAAAAAA4444444"
    )
        port map (
      I0 => \gen_single_thread.active_target_hot_reg[0]\,
      I1 => w_issuing_cnt(1),
      I2 => m_axi_awready(0),
      I3 => aa_mi_awtarget_hot(0),
      I4 => \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\,
      I5 => w_issuing_cnt(0),
      O => \gen_master_slots[0].w_issuing_cnt_reg[0]\
    );
\gen_master_slots[0].w_issuing_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F80FF00FF008000"
    )
        port map (
      I0 => \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\,
      I1 => aa_mi_awtarget_hot(0),
      I2 => m_axi_awready(0),
      I3 => w_issuing_cnt(1),
      I4 => w_issuing_cnt(0),
      I5 => \gen_single_thread.active_target_hot_reg[0]\,
      O => \gen_master_slots[0].w_issuing_cnt_reg[1]\
    );
\gen_master_slots[1].w_issuing_cnt[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5AAAAAAAA4444444"
    )
        port map (
      I0 => \gen_single_thread.active_target_hot_reg[1]\,
      I1 => w_issuing_cnt(3),
      I2 => m_axi_awready(1),
      I3 => aa_mi_awtarget_hot(1),
      I4 => \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\,
      I5 => w_issuing_cnt(2),
      O => \gen_master_slots[1].w_issuing_cnt_reg[8]\
    );
\gen_master_slots[1].w_issuing_cnt[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F80FF00FF008000"
    )
        port map (
      I0 => \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\,
      I1 => aa_mi_awtarget_hot(1),
      I2 => m_axi_awready(1),
      I3 => w_issuing_cnt(3),
      I4 => w_issuing_cnt(2),
      I5 => \gen_single_thread.active_target_hot_reg[1]\,
      O => \gen_master_slots[1].w_issuing_cnt_reg[9]\
    );
\gen_master_slots[2].w_issuing_cnt[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5AAAAAAAA4444444"
    )
        port map (
      I0 => \gen_single_thread.active_target_hot_reg[2]\,
      I1 => w_issuing_cnt(5),
      I2 => m_axi_awready(2),
      I3 => aa_mi_awtarget_hot(2),
      I4 => \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\,
      I5 => w_issuing_cnt(4),
      O => \gen_master_slots[2].w_issuing_cnt_reg[16]\
    );
\gen_master_slots[2].w_issuing_cnt[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F80FF00FF008000"
    )
        port map (
      I0 => \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\,
      I1 => aa_mi_awtarget_hot(2),
      I2 => m_axi_awready(2),
      I3 => w_issuing_cnt(5),
      I4 => w_issuing_cnt(4),
      I5 => \gen_single_thread.active_target_hot_reg[2]\,
      O => \gen_master_slots[2].w_issuing_cnt_reg[17]\
    );
\gen_master_slots[2].w_issuing_cnt[17]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^aa_sa_awvalid\,
      I1 => m_ready_d(1),
      O => \^gen_master_slots[2].w_issuing_cnt_reg[17]_0\
    );
\gen_master_slots[3].w_issuing_cnt[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"95552AAA"
    )
        port map (
      I0 => \^gen_master_slots[3].w_issuing_cnt_reg[24]\,
      I1 => p_42_out,
      I2 => \gen_single_thread.active_target_hot_reg[3]\(0),
      I3 => s_axi_bready(0),
      I4 => w_issuing_cnt(6),
      O => \gen_master_slots[3].w_issuing_cnt_reg[24]_0\
    );
\gen_no_arbiter.m_mesg_i[32]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^aa_sa_awvalid\,
      O => s_ready_i2
    );
\gen_no_arbiter.m_mesg_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(9),
      Q => \m_axi_awqos[3]\(9),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(10),
      Q => \m_axi_awqos[3]\(10),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(11),
      Q => \m_axi_awqos[3]\(11),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(12),
      Q => \m_axi_awqos[3]\(12),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(13),
      Q => \m_axi_awqos[3]\(13),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(14),
      Q => \m_axi_awqos[3]\(14),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(15),
      Q => \m_axi_awqos[3]\(15),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(16),
      Q => \m_axi_awqos[3]\(16),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(17),
      Q => \m_axi_awqos[3]\(17),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(18),
      Q => \m_axi_awqos[3]\(18),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(0),
      Q => \m_axi_awqos[3]\(0),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(19),
      Q => \m_axi_awqos[3]\(19),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(20),
      Q => \m_axi_awqos[3]\(20),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(21),
      Q => \m_axi_awqos[3]\(21),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(22),
      Q => \m_axi_awqos[3]\(22),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(23),
      Q => \m_axi_awqos[3]\(23),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(24),
      Q => \m_axi_awqos[3]\(24),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(25),
      Q => \m_axi_awqos[3]\(25),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(26),
      Q => \m_axi_awqos[3]\(26),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(27),
      Q => \m_axi_awqos[3]\(27),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(28),
      Q => \m_axi_awqos[3]\(28),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(1),
      Q => \m_axi_awqos[3]\(1),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(29),
      Q => \m_axi_awqos[3]\(29),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(30),
      Q => \m_axi_awqos[3]\(30),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(31),
      Q => \m_axi_awqos[3]\(31),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(32),
      Q => \m_axi_awqos[3]\(32),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(33),
      Q => \m_axi_awqos[3]\(33),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(34),
      Q => \m_axi_awqos[3]\(34),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(35),
      Q => \m_axi_awqos[3]\(35),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(36),
      Q => \m_axi_awqos[3]\(36),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(37),
      Q => \m_axi_awqos[3]\(37),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(38),
      Q => \m_axi_awqos[3]\(38),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(2),
      Q => \m_axi_awqos[3]\(2),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(39),
      Q => \m_axi_awqos[3]\(39),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(40),
      Q => \m_axi_awqos[3]\(40),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(41),
      Q => \m_axi_awqos[3]\(41),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(42),
      Q => \m_axi_awqos[3]\(42),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(43),
      Q => \m_axi_awqos[3]\(43),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(44),
      Q => \m_axi_awqos[3]\(44),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(45),
      Q => \m_axi_awqos[3]\(45),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(46),
      Q => \m_axi_awqos[3]\(46),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(3),
      Q => \m_axi_awqos[3]\(3),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(47),
      Q => \m_axi_awqos[3]\(47),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(48),
      Q => \m_axi_awqos[3]\(48),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(49),
      Q => \m_axi_awqos[3]\(49),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(50),
      Q => \m_axi_awqos[3]\(50),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(51),
      Q => \m_axi_awqos[3]\(51),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(52),
      Q => \m_axi_awqos[3]\(52),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(53),
      Q => \m_axi_awqos[3]\(53),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(4),
      Q => \m_axi_awqos[3]\(4),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(54),
      Q => \m_axi_awqos[3]\(54),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(55),
      Q => \m_axi_awqos[3]\(55),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(56),
      Q => \m_axi_awqos[3]\(56),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(5),
      Q => \m_axi_awqos[3]\(5),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(6),
      Q => \m_axi_awqos[3]\(6),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(7),
      Q => \m_axi_awqos[3]\(7),
      R => SR(0)
    );
\gen_no_arbiter.m_mesg_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_ready_i2,
      D => \s_axi_awqos[3]\(8),
      Q => \m_axi_awqos[3]\(8),
      R => SR(0)
    );
\gen_no_arbiter.m_target_hot_i[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
        port map (
      I0 => \^gen_no_arbiter.m_target_hot_i_reg[1]_0\,
      I1 => \s_axi_awaddr[18]\,
      I2 => \s_axi_awqos[3]\(16),
      I3 => \s_axi_awqos[3]\(31),
      I4 => \^gen_no_arbiter.m_target_hot_i_reg[1]_1\,
      O => \^d\(0)
    );
\gen_no_arbiter.m_target_hot_i[2]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \s_axi_awqos[3]\(31),
      I1 => \^gen_no_arbiter.m_target_hot_i_reg[1]_0\,
      I2 => \s_axi_awaddr[18]\,
      I3 => \s_axi_awqos[3]\(16),
      I4 => \^gen_no_arbiter.m_target_hot_i_reg[1]_1\,
      O => \^d\(1)
    );
\gen_no_arbiter.m_target_hot_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \s_axi_awaddr[22]\(0),
      Q => aa_mi_awtarget_hot(0),
      R => '0'
    );
\gen_no_arbiter.m_target_hot_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \^d\(0),
      Q => aa_mi_awtarget_hot(1),
      R => '0'
    );
\gen_no_arbiter.m_target_hot_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \^d\(1),
      Q => aa_mi_awtarget_hot(2),
      R => '0'
    );
\gen_no_arbiter.m_target_hot_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \s_axi_awaddr[22]\(1),
      Q => \^q\(0),
      R => '0'
    );
\gen_no_arbiter.m_valid_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"222F2222222F222F"
    )
        port map (
      I0 => \^aa_sa_awvalid\,
      I1 => \gen_no_arbiter.m_valid_i_i_2_n_0\,
      I2 => \gen_master_slots[3].w_issuing_cnt_reg[24]_1\,
      I3 => \^gen_no_arbiter.m_valid_i_reg_0\,
      I4 => \gen_single_thread.accept_cnt_reg[0]\,
      I5 => \gen_single_thread.accept_cnt_reg[1]\,
      O => \gen_no_arbiter.m_valid_i_i_1_n_0\
    );
\gen_no_arbiter.m_valid_i_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555554"
    )
        port map (
      I0 => \^m_ready_d_reg[1]\,
      I1 => \^q\(0),
      I2 => aa_mi_awtarget_hot(2),
      I3 => aa_mi_awtarget_hot(1),
      I4 => aa_mi_awtarget_hot(0),
      I5 => m_ready_d(0),
      O => \gen_no_arbiter.m_valid_i_i_2_n_0\
    );
\gen_no_arbiter.m_valid_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_no_arbiter.m_valid_i_i_1_n_0\,
      Q => \^aa_sa_awvalid\,
      R => SR(0)
    );
\gen_no_arbiter.s_ready_i[0]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \s_axi_awqos[3]\(16),
      I1 => \s_axi_awqos[3]\(18),
      I2 => \s_axi_awqos[3]\(19),
      I3 => \s_axi_awqos[3]\(17),
      O => \gen_no_arbiter.m_target_hot_i_reg[3]_0\
    );
\gen_no_arbiter.s_ready_i[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => m_ready_d_0(0),
      I1 => \^ss_aa_awready\,
      I2 => s_axi_awvalid(0),
      I3 => \^aa_sa_awvalid\,
      O => \^gen_no_arbiter.m_valid_i_reg_0\
    );
\gen_no_arbiter.s_ready_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => E(0),
      Q => \^ss_aa_awready\,
      R => '0'
    );
\gen_primitive_shifter.gen_srls[0].srl_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \^gen_no_arbiter.m_target_hot_i_reg[1]_1\,
      I1 => \s_axi_awqos[3]\(16),
      I2 => \s_axi_awqos[3]\(18),
      I3 => \s_axi_awqos[3]\(19),
      I4 => \s_axi_awqos[3]\(17),
      I5 => \^gen_no_arbiter.m_target_hot_i_reg[1]_0\,
      O => st_aa_awtarget_enc(0)
    );
\gen_primitive_shifter.gen_srls[0].srl_inst_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFEFF"
    )
        port map (
      I0 => \s_axi_awqos[3]\(29),
      I1 => \s_axi_awqos[3]\(28),
      I2 => \s_axi_awqos[3]\(27),
      I3 => \s_axi_awqos[3]\(30),
      I4 => \s_axi_awqos[3]\(26),
      O => \^gen_no_arbiter.m_target_hot_i_reg[1]_1\
    );
\gen_primitive_shifter.gen_srls[0].srl_inst_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \s_axi_awqos[3]\(24),
      I1 => \s_axi_awqos[3]\(23),
      I2 => \s_axi_awqos[3]\(21),
      I3 => \s_axi_awqos[3]\(25),
      I4 => \s_axi_awqos[3]\(20),
      I5 => \s_axi_awqos[3]\(22),
      O => \^gen_no_arbiter.m_target_hot_i_reg[1]_0\
    );
\m_axi_awvalid[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => aa_mi_awtarget_hot(0),
      I1 => m_ready_d(1),
      I2 => \^aa_sa_awvalid\,
      O => m_axi_awvalid(0)
    );
\m_axi_awvalid[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => aa_mi_awtarget_hot(1),
      I1 => m_ready_d(1),
      I2 => \^aa_sa_awvalid\,
      O => m_axi_awvalid(1)
    );
\m_axi_awvalid[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => aa_mi_awtarget_hot(2),
      I1 => m_ready_d(1),
      I2 => \^aa_sa_awvalid\,
      O => m_axi_awvalid(2)
    );
\m_ready_d[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000011101110111"
    )
        port map (
      I0 => m_ready_d(1),
      I1 => \m_ready_d[1]_i_4_n_0\,
      I2 => aa_mi_awtarget_hot(1),
      I3 => m_axi_awready(1),
      I4 => aa_mi_awtarget_hot(0),
      I5 => m_axi_awready(0),
      O => \^m_ready_d_reg[1]\
    );
\m_ready_d[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => m_ready_d(0),
      I1 => aa_mi_awtarget_hot(0),
      I2 => aa_mi_awtarget_hot(1),
      I3 => aa_mi_awtarget_hot(2),
      I4 => \^q\(0),
      O => \m_ready_d_reg[1]_0\
    );
\m_ready_d[1]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \^q\(0),
      I1 => mi_awready_3,
      I2 => aa_mi_awtarget_hot(2),
      I3 => m_axi_awready(2),
      O => \m_ready_d[1]_i_4_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_decerr_slave is
  port (
    mi_awready_3 : out STD_LOGIC;
    wr_tmp_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_19_in : out STD_LOGIC;
    s_axi_rlast_i : out STD_LOGIC;
    s_ready_i_reg : out STD_LOGIC;
    mi_arready_3 : out STD_LOGIC;
    m_valid_i_reg : out STD_LOGIC;
    \gen_axi.s_axi_awready_i_reg_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    p_42_out : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    \gen_no_arbiter.m_valid_i_reg\ : in STD_LOGIC;
    mi_rready_3 : in STD_LOGIC;
    \gen_no_arbiter.m_mesg_i_reg[40]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    aa_mi_arvalid : in STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    mi_bready_3 : in STD_LOGIC;
    \gen_no_arbiter.m_valid_i_reg_0\ : in STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \m_ready_d_reg[1]\ : in STD_LOGIC;
    \gen_axi.write_cs_reg[1]_0\ : in STD_LOGIC;
    \gen_no_arbiter.m_mesg_i_reg[35]\ : in STD_LOGIC;
    aresetn_d : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_decerr_slave : entity is "axi_crossbar_v2_1_10_decerr_slave";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_decerr_slave;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_decerr_slave is
  signal \gen_axi.read_cnt[6]_i_2_n_0\ : STD_LOGIC;
  signal \gen_axi.read_cnt[7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_axi.read_cnt[7]_i_3_n_0\ : STD_LOGIC;
  signal \gen_axi.read_cnt_reg__0\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \gen_axi.read_cnt_reg__1\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \gen_axi.read_cs[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_axi.s_axi_arready_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_axi.s_axi_arready_i_i_2_n_0\ : STD_LOGIC;
  signal \gen_axi.s_axi_awready_i_i_1_n_0\ : STD_LOGIC;
  signal \^gen_axi.s_axi_awready_i_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \gen_axi.s_axi_bvalid_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_axi.s_axi_rlast_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_axi.s_axi_rlast_i_i_3_n_0\ : STD_LOGIC;
  signal \gen_axi.s_axi_rlast_i_i_5_n_0\ : STD_LOGIC;
  signal \gen_axi.s_axi_wready_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_axi.write_cs[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_axi.write_cs[1]_i_1_n_0\ : STD_LOGIC;
  signal \^mi_arready_3\ : STD_LOGIC;
  signal \^mi_awready_3\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^p_19_in\ : STD_LOGIC;
  signal p_25_in : STD_LOGIC;
  signal \^s_axi_rlast_i\ : STD_LOGIC;
  signal \^wr_tmp_wready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal write_cs : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_axi.read_cnt[0]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_axi.read_cnt[1]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_axi.s_axi_bvalid_i_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_axi.s_axi_wready_i_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_axi.write_cs[0]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_axi.write_cs[1]_i_1\ : label is "soft_lutpair7";
begin
  \gen_axi.s_axi_awready_i_reg_0\(0) <= \^gen_axi.s_axi_awready_i_reg_0\(0);
  mi_arready_3 <= \^mi_arready_3\;
  mi_awready_3 <= \^mi_awready_3\;
  p_19_in <= \^p_19_in\;
  s_axi_rlast_i <= \^s_axi_rlast_i\;
  wr_tmp_wready(0) <= \^wr_tmp_wready\(0);
\gen_axi.read_cnt[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__1\(0),
      I1 => \^p_19_in\,
      I2 => \gen_no_arbiter.m_mesg_i_reg[40]\(0),
      O => p_0_in(0)
    );
\gen_axi.read_cnt[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9F90"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__1\(0),
      I1 => \gen_axi.read_cnt_reg__0\(1),
      I2 => \^p_19_in\,
      I3 => \gen_no_arbiter.m_mesg_i_reg[40]\(1),
      O => p_0_in(1)
    );
\gen_axi.read_cnt[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E1FFE100"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__1\(0),
      I1 => \gen_axi.read_cnt_reg__0\(1),
      I2 => \gen_axi.read_cnt_reg__0\(2),
      I3 => \^p_19_in\,
      I4 => \gen_no_arbiter.m_mesg_i_reg[40]\(2),
      O => p_0_in(2)
    );
\gen_axi.read_cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE01FFFFFE010000"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(2),
      I1 => \gen_axi.read_cnt_reg__0\(1),
      I2 => \gen_axi.read_cnt_reg__1\(0),
      I3 => \gen_axi.read_cnt_reg__0\(3),
      I4 => \^p_19_in\,
      I5 => \gen_no_arbiter.m_mesg_i_reg[40]\(3),
      O => p_0_in(3)
    );
\gen_axi.read_cnt[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9F90"
    )
        port map (
      I0 => \gen_axi.read_cnt[6]_i_2_n_0\,
      I1 => \gen_axi.read_cnt_reg__0\(4),
      I2 => \^p_19_in\,
      I3 => \gen_no_arbiter.m_mesg_i_reg[40]\(4),
      O => p_0_in(4)
    );
\gen_axi.read_cnt[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A9FFA900"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(5),
      I1 => \gen_axi.read_cnt[6]_i_2_n_0\,
      I2 => \gen_axi.read_cnt_reg__0\(4),
      I3 => \^p_19_in\,
      I4 => \gen_no_arbiter.m_mesg_i_reg[40]\(5),
      O => p_0_in(5)
    );
\gen_axi.read_cnt[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA9FFFFAAA90000"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(6),
      I1 => \gen_axi.read_cnt_reg__0\(4),
      I2 => \gen_axi.read_cnt_reg__0\(5),
      I3 => \gen_axi.read_cnt[6]_i_2_n_0\,
      I4 => \^p_19_in\,
      I5 => \gen_no_arbiter.m_mesg_i_reg[40]\(6),
      O => p_0_in(6)
    );
\gen_axi.read_cnt[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(1),
      I1 => \gen_axi.read_cnt_reg__1\(0),
      I2 => \gen_axi.read_cnt_reg__0\(3),
      I3 => \gen_axi.read_cnt_reg__0\(2),
      O => \gen_axi.read_cnt[6]_i_2_n_0\
    );
\gen_axi.read_cnt[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8F80808080808080"
    )
        port map (
      I0 => mi_rready_3,
      I1 => \gen_axi.s_axi_arready_i_i_2_n_0\,
      I2 => \^p_19_in\,
      I3 => aa_mi_arvalid,
      I4 => \gen_no_arbiter.m_target_hot_i_reg[3]\(0),
      I5 => \^mi_arready_3\,
      O => \gen_axi.read_cnt[7]_i_1_n_0\
    );
\gen_axi.read_cnt[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"9AFF9A00"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(7),
      I1 => \gen_axi.read_cnt_reg__0\(6),
      I2 => \gen_axi.read_cnt[7]_i_3_n_0\,
      I3 => \^p_19_in\,
      I4 => \gen_no_arbiter.m_mesg_i_reg[40]\(7),
      O => p_0_in(7)
    );
\gen_axi.read_cnt[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(2),
      I1 => \gen_axi.read_cnt_reg__0\(3),
      I2 => \gen_axi.read_cnt_reg__1\(0),
      I3 => \gen_axi.read_cnt_reg__0\(1),
      I4 => \gen_axi.read_cnt_reg__0\(5),
      I5 => \gen_axi.read_cnt_reg__0\(4),
      O => \gen_axi.read_cnt[7]_i_3_n_0\
    );
\gen_axi.read_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(0),
      Q => \gen_axi.read_cnt_reg__1\(0),
      R => SR(0)
    );
\gen_axi.read_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(1),
      Q => \gen_axi.read_cnt_reg__0\(1),
      R => SR(0)
    );
\gen_axi.read_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(2),
      Q => \gen_axi.read_cnt_reg__0\(2),
      R => SR(0)
    );
\gen_axi.read_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(3),
      Q => \gen_axi.read_cnt_reg__0\(3),
      R => SR(0)
    );
\gen_axi.read_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(4),
      Q => \gen_axi.read_cnt_reg__0\(4),
      R => SR(0)
    );
\gen_axi.read_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(5),
      Q => \gen_axi.read_cnt_reg__0\(5),
      R => SR(0)
    );
\gen_axi.read_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(6),
      Q => \gen_axi.read_cnt_reg__0\(6),
      R => SR(0)
    );
\gen_axi.read_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_axi.read_cnt[7]_i_1_n_0\,
      D => p_0_in(7),
      Q => \gen_axi.read_cnt_reg__0\(7),
      R => SR(0)
    );
\gen_axi.read_cs[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFD0D0D0D0D0D0D0"
    )
        port map (
      I0 => mi_rready_3,
      I1 => \gen_axi.s_axi_arready_i_i_2_n_0\,
      I2 => \^p_19_in\,
      I3 => aa_mi_arvalid,
      I4 => \gen_no_arbiter.m_target_hot_i_reg[3]\(0),
      I5 => \^mi_arready_3\,
      O => \gen_axi.read_cs[0]_i_1_n_0\
    );
\gen_axi.read_cs_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.read_cs[0]_i_1_n_0\,
      Q => \^p_19_in\,
      R => SR(0)
    );
\gen_axi.s_axi_arready_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BA00BA000000FF00"
    )
        port map (
      I0 => \^mi_arready_3\,
      I1 => \gen_axi.s_axi_arready_i_i_2_n_0\,
      I2 => mi_rready_3,
      I3 => aresetn_d,
      I4 => \gen_no_arbiter.m_valid_i_reg\,
      I5 => \^p_19_in\,
      O => \gen_axi.s_axi_arready_i_i_1_n_0\
    );
\gen_axi.s_axi_arready_i_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(7),
      I1 => \gen_axi.read_cnt_reg__0\(6),
      I2 => \gen_axi.read_cnt_reg__0\(4),
      I3 => \gen_axi.read_cnt_reg__0\(5),
      I4 => \gen_axi.read_cnt[6]_i_2_n_0\,
      O => \gen_axi.s_axi_arready_i_i_2_n_0\
    );
\gen_axi.s_axi_arready_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.s_axi_arready_i_i_1_n_0\,
      Q => \^mi_arready_3\,
      R => '0'
    );
\gen_axi.s_axi_awready_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF7F70F000F0F"
    )
        port map (
      I0 => \gen_no_arbiter.m_valid_i_reg_0\,
      I1 => \gen_no_arbiter.m_target_hot_i_reg[3]_0\(0),
      I2 => write_cs(0),
      I3 => mi_bready_3,
      I4 => \^gen_axi.s_axi_awready_i_reg_0\(0),
      I5 => \^mi_awready_3\,
      O => \gen_axi.s_axi_awready_i_i_1_n_0\
    );
\gen_axi.s_axi_awready_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.s_axi_awready_i_i_1_n_0\,
      Q => \^mi_awready_3\,
      R => SR(0)
    );
\gen_axi.s_axi_bvalid_i_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFFA888"
    )
        port map (
      I0 => \gen_axi.write_cs_reg[1]_0\,
      I1 => write_cs(0),
      I2 => \^gen_axi.s_axi_awready_i_reg_0\(0),
      I3 => mi_bready_3,
      I4 => p_25_in,
      O => \gen_axi.s_axi_bvalid_i_i_1_n_0\
    );
\gen_axi.s_axi_bvalid_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.s_axi_bvalid_i_i_1_n_0\,
      Q => p_25_in,
      R => SR(0)
    );
\gen_axi.s_axi_rlast_i_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \gen_axi.s_axi_arready_i_i_2_n_0\,
      I1 => \^p_19_in\,
      I2 => \gen_no_arbiter.m_mesg_i_reg[35]\,
      I3 => \gen_axi.s_axi_rlast_i_i_3_n_0\,
      I4 => \^s_axi_rlast_i\,
      O => \gen_axi.s_axi_rlast_i_i_1_n_0\
    );
\gen_axi.s_axi_rlast_i_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0A0A3A0A"
    )
        port map (
      I0 => \gen_no_arbiter.m_valid_i_reg\,
      I1 => \gen_axi.s_axi_rlast_i_i_5_n_0\,
      I2 => \^p_19_in\,
      I3 => mi_rready_3,
      I4 => \gen_axi.read_cnt_reg__0\(1),
      O => \gen_axi.s_axi_rlast_i_i_3_n_0\
    );
\gen_axi.s_axi_rlast_i_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \gen_axi.read_cnt_reg__0\(7),
      I1 => \gen_axi.read_cnt_reg__0\(6),
      I2 => \gen_axi.read_cnt_reg__0\(4),
      I3 => \gen_axi.read_cnt_reg__0\(5),
      I4 => \gen_axi.read_cnt_reg__0\(2),
      I5 => \gen_axi.read_cnt_reg__0\(3),
      O => \gen_axi.s_axi_rlast_i_i_5_n_0\
    );
\gen_axi.s_axi_rlast_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.s_axi_rlast_i_i_1_n_0\,
      Q => \^s_axi_rlast_i\,
      R => SR(0)
    );
\gen_axi.s_axi_wready_i_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FFF0202"
    )
        port map (
      I0 => \m_ready_d_reg[1]\,
      I1 => \^gen_axi.s_axi_awready_i_reg_0\(0),
      I2 => write_cs(0),
      I3 => \gen_axi.write_cs_reg[1]_0\,
      I4 => \^wr_tmp_wready\(0),
      O => \gen_axi.s_axi_wready_i_i_1_n_0\
    );
\gen_axi.s_axi_wready_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.s_axi_wready_i_i_1_n_0\,
      Q => \^wr_tmp_wready\(0),
      R => SR(0)
    );
\gen_axi.write_cs[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"02F2"
    )
        port map (
      I0 => \m_ready_d_reg[1]\,
      I1 => \^gen_axi.s_axi_awready_i_reg_0\(0),
      I2 => write_cs(0),
      I3 => \gen_axi.write_cs_reg[1]_0\,
      O => \gen_axi.write_cs[0]_i_1_n_0\
    );
\gen_axi.write_cs[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F4C4"
    )
        port map (
      I0 => mi_bready_3,
      I1 => \^gen_axi.s_axi_awready_i_reg_0\(0),
      I2 => write_cs(0),
      I3 => \gen_axi.write_cs_reg[1]_0\,
      O => \gen_axi.write_cs[1]_i_1_n_0\
    );
\gen_axi.write_cs_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.write_cs[0]_i_1_n_0\,
      Q => write_cs(0),
      R => SR(0)
    );
\gen_axi.write_cs_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.write_cs[1]_i_1_n_0\,
      Q => \^gen_axi.s_axi_awready_i_reg_0\(0),
      R => SR(0)
    );
\m_valid_i_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8BBB"
    )
        port map (
      I0 => p_25_in,
      I1 => mi_bready_3,
      I2 => Q(0),
      I3 => s_axi_bready(0),
      O => m_valid_i_reg
    );
\s_ready_i_i_1__7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D111FFFF"
    )
        port map (
      I0 => p_25_in,
      I1 => p_42_out,
      I2 => s_axi_bready(0),
      I3 => Q(0),
      I4 => \aresetn_d_reg[1]\,
      O => s_ready_i_reg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor is
  port (
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    s_axi_rlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_single_thread.active_target_hot_reg[3]_0\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \m_payload_i_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \m_payload_i_reg[0]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \m_payload_i_reg[0]_1\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_36_out : in STD_LOGIC;
    p_58_out : in STD_LOGIC;
    \s_axi_araddr[26]\ : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_valid_i_reg : in STD_LOGIC;
    p_98_out : in STD_LOGIC;
    p_78_out : in STD_LOGIC;
    \s_axi_araddr[31]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \s_axi_araddr[26]_0\ : in STD_LOGIC;
    \s_axi_araddr[22]\ : in STD_LOGIC;
    \s_axi_araddr[18]\ : in STD_LOGIC;
    \s_axi_araddr[29]\ : in STD_LOGIC;
    st_mr_rmesg : in STD_LOGIC_VECTOR ( 103 downto 0 );
    \m_payload_i_reg[34]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \m_payload_i_reg[34]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_38_out : in STD_LOGIC;
    \m_payload_i_reg[34]_1\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor : entity is "axi_crossbar_v2_1_10_si_transactor";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor is
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal accept_cnt : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal active_target_enc : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \gen_no_arbiter.s_ready_i[0]_i_9__0_n_0\ : STD_LOGIC;
  signal \gen_single_thread.accept_cnt[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \gen_single_thread.accept_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_single_thread.accept_cnt[1]_i_2__0_n_0\ : STD_LOGIC;
  signal \gen_single_thread.active_target_enc[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_single_thread.active_target_enc[0]_i_2_n_0\ : STD_LOGIC;
  signal \gen_single_thread.active_target_enc[1]_i_1_n_0\ : STD_LOGIC;
  signal \^gen_single_thread.active_target_hot_reg[3]_0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^s_axi_rlast\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \s_axi_rvalid[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_single_thread.accept_cnt[0]_i_1__0\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \gen_single_thread.accept_cnt[1]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_1__0\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_1__1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \s_axi_rvalid[0]_INST_0_i_1\ : label is "soft_lutpair69";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
  \gen_single_thread.active_target_hot_reg[3]_0\(1 downto 0) <= \^gen_single_thread.active_target_hot_reg[3]_0\(1 downto 0);
  s_axi_rlast(0) <= \^s_axi_rlast\(0);
\gen_no_arbiter.m_target_hot_i[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \s_axi_araddr[31]\(0),
      I1 => \s_axi_araddr[31]\(2),
      I2 => \s_axi_araddr[31]\(3),
      I3 => \s_axi_araddr[31]\(1),
      I4 => \s_axi_araddr[22]\,
      I5 => \s_axi_araddr[29]\,
      O => \^gen_single_thread.active_target_hot_reg[3]_0\(0)
    );
\gen_no_arbiter.m_target_hot_i[3]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEFFFC"
    )
        port map (
      I0 => \s_axi_araddr[31]\(9),
      I1 => \s_axi_araddr[26]_0\,
      I2 => \s_axi_araddr[22]\,
      I3 => \s_axi_araddr[18]\,
      I4 => \s_axi_araddr[31]\(0),
      O => \^gen_single_thread.active_target_hot_reg[3]_0\(1)
    );
\gen_no_arbiter.s_ready_i[0]_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"050505FD05FD0505"
    )
        port map (
      I0 => accept_cnt(1),
      I1 => \gen_single_thread.accept_cnt[1]_i_2__0_n_0\,
      I2 => accept_cnt(0),
      I3 => \gen_no_arbiter.s_ready_i[0]_i_9__0_n_0\,
      I4 => active_target_enc(1),
      I5 => \s_axi_araddr[26]\,
      O => \gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\gen_no_arbiter.s_ready_i[0]_i_9__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55555556"
    )
        port map (
      I0 => active_target_enc(0),
      I1 => \s_axi_araddr[31]\(0),
      I2 => \s_axi_araddr[18]\,
      I3 => \s_axi_araddr[22]\,
      I4 => \s_axi_araddr[26]_0\,
      O => \gen_no_arbiter.s_ready_i[0]_i_9__0_n_0\
    );
\gen_single_thread.accept_cnt[0]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A54A"
    )
        port map (
      I0 => accept_cnt(0),
      I1 => accept_cnt(1),
      I2 => \gen_single_thread.accept_cnt[1]_i_2__0_n_0\,
      I3 => E(0),
      O => \gen_single_thread.accept_cnt[0]_i_1__0_n_0\
    );
\gen_single_thread.accept_cnt[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C68C"
    )
        port map (
      I0 => accept_cnt(0),
      I1 => accept_cnt(1),
      I2 => \gen_single_thread.accept_cnt[1]_i_2__0_n_0\,
      I3 => E(0),
      O => \gen_single_thread.accept_cnt[1]_i_1_n_0\
    );
\gen_single_thread.accept_cnt[1]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888888808080"
    )
        port map (
      I0 => \^s_axi_rlast\(0),
      I1 => s_axi_rready(0),
      I2 => m_valid_i_reg,
      I3 => p_36_out,
      I4 => \^q\(3),
      I5 => \s_axi_rvalid[0]_INST_0_i_1_n_0\,
      O => \gen_single_thread.accept_cnt[1]_i_2__0_n_0\
    );
\gen_single_thread.accept_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_single_thread.accept_cnt[0]_i_1__0_n_0\,
      Q => accept_cnt(0),
      R => SR(0)
    );
\gen_single_thread.accept_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_single_thread.accept_cnt[1]_i_1_n_0\,
      Q => accept_cnt(1),
      R => SR(0)
    );
\gen_single_thread.active_target_enc[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFFFFFFFFFF"
    )
        port map (
      I0 => \s_axi_araddr[31]\(7),
      I1 => \s_axi_araddr[31]\(6),
      I2 => \s_axi_araddr[31]\(5),
      I3 => \s_axi_araddr[31]\(8),
      I4 => \s_axi_araddr[31]\(4),
      I5 => \gen_single_thread.active_target_enc[0]_i_2_n_0\,
      O => \gen_single_thread.active_target_enc[0]_i_1_n_0\
    );
\gen_single_thread.active_target_enc[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \s_axi_araddr[22]\,
      I1 => \s_axi_araddr[31]\(1),
      I2 => \s_axi_araddr[31]\(3),
      I3 => \s_axi_araddr[31]\(2),
      I4 => \s_axi_araddr[31]\(0),
      O => \gen_single_thread.active_target_enc[0]_i_2_n_0\
    );
\gen_single_thread.active_target_enc[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^gen_single_thread.active_target_hot_reg[3]_0\(1),
      I1 => \^gen_single_thread.active_target_hot_reg[3]_0\(0),
      O => \gen_single_thread.active_target_enc[1]_i_1_n_0\
    );
\gen_single_thread.active_target_enc_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \gen_single_thread.active_target_enc[0]_i_1_n_0\,
      Q => active_target_enc(0),
      R => SR(0)
    );
\gen_single_thread.active_target_enc_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \gen_single_thread.active_target_enc[1]_i_1_n_0\,
      Q => active_target_enc(1),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => D(0),
      Q => \^q\(0),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => D(1),
      Q => \^q\(1),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \^gen_single_thread.active_target_hot_reg[3]_0\(0),
      Q => \^q\(2),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \^gen_single_thread.active_target_hot_reg[3]_0\(1),
      Q => \^q\(3),
      R => SR(0)
    );
\m_payload_i[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8F"
    )
        port map (
      I0 => \^q\(0),
      I1 => s_axi_rready(0),
      I2 => p_98_out,
      O => \m_payload_i_reg[0]\(0)
    );
\m_payload_i[34]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8F"
    )
        port map (
      I0 => \^q\(1),
      I1 => s_axi_rready(0),
      I2 => p_78_out,
      O => \m_payload_i_reg[0]_0\(0)
    );
\m_payload_i[34]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8F"
    )
        port map (
      I0 => \^q\(2),
      I1 => s_axi_rready(0),
      I2 => p_58_out,
      O => \m_payload_i_reg[0]_1\(0)
    );
\s_axi_rdata[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(70),
      I1 => st_mr_rmesg(36),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(2),
      O => s_axi_rdata(0)
    );
\s_axi_rdata[10]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(80),
      I1 => st_mr_rmesg(46),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(12),
      O => s_axi_rdata(10)
    );
\s_axi_rdata[11]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FAC00AC"
    )
        port map (
      I0 => st_mr_rmesg(47),
      I1 => st_mr_rmesg(13),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(81),
      O => s_axi_rdata(11)
    );
\s_axi_rdata[12]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(48),
      I1 => st_mr_rmesg(82),
      I2 => active_target_enc(1),
      I3 => active_target_enc(0),
      I4 => st_mr_rmesg(14),
      O => s_axi_rdata(12)
    );
\s_axi_rdata[13]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(83),
      I1 => st_mr_rmesg(49),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(15),
      O => s_axi_rdata(13)
    );
\s_axi_rdata[14]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(84),
      I1 => st_mr_rmesg(50),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(16),
      O => s_axi_rdata(14)
    );
\s_axi_rdata[15]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(85),
      I1 => st_mr_rmesg(51),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(17),
      O => s_axi_rdata(15)
    );
\s_axi_rdata[16]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(86),
      I1 => st_mr_rmesg(52),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(18),
      O => s_axi_rdata(16)
    );
\s_axi_rdata[17]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(87),
      I1 => st_mr_rmesg(53),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(19),
      O => s_axi_rdata(17)
    );
\s_axi_rdata[18]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(88),
      I1 => st_mr_rmesg(54),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(20),
      O => s_axi_rdata(18)
    );
\s_axi_rdata[19]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FAC00AC"
    )
        port map (
      I0 => st_mr_rmesg(55),
      I1 => st_mr_rmesg(21),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(89),
      O => s_axi_rdata(19)
    );
\s_axi_rdata[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(71),
      I1 => st_mr_rmesg(37),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(3),
      O => s_axi_rdata(1)
    );
\s_axi_rdata[20]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(56),
      I1 => st_mr_rmesg(90),
      I2 => active_target_enc(1),
      I3 => active_target_enc(0),
      I4 => st_mr_rmesg(22),
      O => s_axi_rdata(20)
    );
\s_axi_rdata[21]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(91),
      I1 => st_mr_rmesg(57),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(23),
      O => s_axi_rdata(21)
    );
\s_axi_rdata[22]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(92),
      I1 => st_mr_rmesg(58),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(24),
      O => s_axi_rdata(22)
    );
\s_axi_rdata[23]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(93),
      I1 => st_mr_rmesg(59),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(25),
      O => s_axi_rdata(23)
    );
\s_axi_rdata[24]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(94),
      I1 => st_mr_rmesg(60),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(26),
      O => s_axi_rdata(24)
    );
\s_axi_rdata[25]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(95),
      I1 => st_mr_rmesg(61),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(27),
      O => s_axi_rdata(25)
    );
\s_axi_rdata[26]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(96),
      I1 => st_mr_rmesg(62),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(28),
      O => s_axi_rdata(26)
    );
\s_axi_rdata[27]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FAC00AC"
    )
        port map (
      I0 => st_mr_rmesg(63),
      I1 => st_mr_rmesg(29),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(97),
      O => s_axi_rdata(27)
    );
\s_axi_rdata[28]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(64),
      I1 => st_mr_rmesg(98),
      I2 => active_target_enc(1),
      I3 => active_target_enc(0),
      I4 => st_mr_rmesg(30),
      O => s_axi_rdata(28)
    );
\s_axi_rdata[29]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(99),
      I1 => st_mr_rmesg(65),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(31),
      O => s_axi_rdata(29)
    );
\s_axi_rdata[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(72),
      I1 => st_mr_rmesg(38),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(4),
      O => s_axi_rdata(2)
    );
\s_axi_rdata[30]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(100),
      I1 => st_mr_rmesg(66),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(32),
      O => s_axi_rdata(30)
    );
\s_axi_rdata[31]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(101),
      I1 => st_mr_rmesg(67),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(33),
      O => s_axi_rdata(31)
    );
\s_axi_rdata[3]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FAC00AC"
    )
        port map (
      I0 => st_mr_rmesg(39),
      I1 => st_mr_rmesg(5),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(73),
      O => s_axi_rdata(3)
    );
\s_axi_rdata[4]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(40),
      I1 => st_mr_rmesg(74),
      I2 => active_target_enc(1),
      I3 => active_target_enc(0),
      I4 => st_mr_rmesg(6),
      O => s_axi_rdata(4)
    );
\s_axi_rdata[5]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(75),
      I1 => st_mr_rmesg(41),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(7),
      O => s_axi_rdata(5)
    );
\s_axi_rdata[6]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(76),
      I1 => st_mr_rmesg(42),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(8),
      O => s_axi_rdata(6)
    );
\s_axi_rdata[7]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(77),
      I1 => st_mr_rmesg(43),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(9),
      O => s_axi_rdata(7)
    );
\s_axi_rdata[8]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(78),
      I1 => st_mr_rmesg(44),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(10),
      O => s_axi_rdata(8)
    );
\s_axi_rdata[9]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ACF0AC0"
    )
        port map (
      I0 => st_mr_rmesg(79),
      I1 => st_mr_rmesg(45),
      I2 => active_target_enc(0),
      I3 => active_target_enc(1),
      I4 => st_mr_rmesg(11),
      O => s_axi_rdata(9)
    );
\s_axi_rlast[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0CCAAFFF0CCAA00"
    )
        port map (
      I0 => \m_payload_i_reg[34]\(0),
      I1 => \m_payload_i_reg[34]_0\(0),
      I2 => p_38_out,
      I3 => active_target_enc(1),
      I4 => active_target_enc(0),
      I5 => \m_payload_i_reg[34]_1\(0),
      O => \^s_axi_rlast\(0)
    );
\s_axi_rresp[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0CCAAFFF0CCAA00"
    )
        port map (
      I0 => st_mr_rmesg(68),
      I1 => st_mr_rmesg(34),
      I2 => st_mr_rmesg(102),
      I3 => active_target_enc(1),
      I4 => active_target_enc(0),
      I5 => st_mr_rmesg(0),
      O => s_axi_rresp(0)
    );
\s_axi_rresp[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0CCAAFFF0CCAA00"
    )
        port map (
      I0 => st_mr_rmesg(69),
      I1 => st_mr_rmesg(35),
      I2 => st_mr_rmesg(103),
      I3 => active_target_enc(1),
      I4 => active_target_enc(0),
      I5 => st_mr_rmesg(1),
      O => s_axi_rresp(1)
    );
\s_axi_rvalid[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \s_axi_rvalid[0]_INST_0_i_1_n_0\,
      I1 => \^q\(3),
      I2 => p_36_out,
      I3 => \^q\(2),
      I4 => p_58_out,
      O => s_axi_rvalid(0)
    );
\s_axi_rvalid[0]_INST_0_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \^q\(0),
      I1 => p_98_out,
      I2 => \^q\(1),
      I3 => p_78_out,
      O => \s_axi_rvalid[0]_INST_0_i_1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor__parameterized0\ is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_master_slots[2].w_issuing_cnt_reg[17]\ : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \gen_master_slots[0].w_issuing_cnt_reg[1]\ : out STD_LOGIC;
    \gen_master_slots[1].w_issuing_cnt_reg[9]\ : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_single_thread.active_target_hot_reg[3]_0\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]_0\ : out STD_LOGIC;
    \gen_no_arbiter.m_valid_i_reg\ : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_master_slots[3].w_issuing_cnt_reg[24]\ : in STD_LOGIC;
    \m_ready_d_reg[0]\ : in STD_LOGIC;
    aresetn_d : in STD_LOGIC;
    p_64_out : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_104_out : in STD_LOGIC;
    p_84_out : in STD_LOGIC;
    \m_ready_d_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_42_out : in STD_LOGIC;
    st_aa_awtarget_enc : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \s_axi_awaddr[26]\ : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    \s_axi_awaddr[22]\ : in STD_LOGIC;
    st_mr_bmesg : in STD_LOGIC_VECTOR ( 5 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    \s_axi_awaddr[26]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor__parameterized0\ : entity is "axi_crossbar_v2_1_10_si_transactor";
end \ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor__parameterized0\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor__parameterized0\ is
  signal \^d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal accept_cnt : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal active_target_enc : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^gen_no_arbiter.m_target_hot_i_reg[3]\ : STD_LOGIC;
  signal \gen_single_thread.accept_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_single_thread.accept_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_single_thread.accept_cnt[1]_i_2_n_0\ : STD_LOGIC;
  signal \^gen_single_thread.active_target_hot_reg[3]_0\ : STD_LOGIC;
  signal \s_axi_bvalid[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_master_slots[0].w_issuing_cnt[1]_i_2\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \gen_master_slots[2].w_issuing_cnt[17]_i_3\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_target_hot_i[0]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_target_hot_i[3]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \gen_no_arbiter.s_ready_i[0]_i_6\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \gen_single_thread.accept_cnt[0]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \gen_single_thread.accept_cnt[1]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \s_axi_bvalid[0]_INST_0_i_1\ : label is "soft_lutpair73";
begin
  D(1 downto 0) <= \^d\(1 downto 0);
  Q(3 downto 0) <= \^q\(3 downto 0);
  \gen_no_arbiter.m_target_hot_i_reg[3]\ <= \^gen_no_arbiter.m_target_hot_i_reg[3]\;
  \gen_single_thread.active_target_hot_reg[3]_0\ <= \^gen_single_thread.active_target_hot_reg[3]_0\;
\gen_master_slots[0].w_issuing_cnt[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \^q\(0),
      I1 => p_104_out,
      I2 => s_axi_bready(0),
      O => \gen_master_slots[0].w_issuing_cnt_reg[1]\
    );
\gen_master_slots[1].w_issuing_cnt[9]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \^q\(1),
      I1 => p_84_out,
      I2 => s_axi_bready(0),
      O => \gen_master_slots[1].w_issuing_cnt_reg[9]\
    );
\gen_master_slots[2].w_issuing_cnt[17]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \^q\(2),
      I1 => p_64_out,
      I2 => s_axi_bready(0),
      O => \gen_master_slots[2].w_issuing_cnt_reg[17]\
    );
\gen_no_arbiter.m_target_hot_i[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => \s_axi_awaddr[22]\,
      I2 => \^gen_single_thread.active_target_hot_reg[3]_0\,
      I3 => s_axi_awaddr(0),
      I4 => \s_axi_awaddr[26]\,
      O => \^d\(0)
    );
\gen_no_arbiter.m_target_hot_i[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFEA"
    )
        port map (
      I0 => \s_axi_awaddr[26]\,
      I1 => s_axi_awaddr(4),
      I2 => s_axi_awaddr(0),
      I3 => \^gen_single_thread.active_target_hot_reg[3]_0\,
      I4 => \s_axi_awaddr[22]\,
      O => \^d\(1)
    );
\gen_no_arbiter.m_valid_i_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => accept_cnt(1),
      I1 => accept_cnt(0),
      O => \gen_no_arbiter.m_valid_i_reg\
    );
\gen_no_arbiter.s_ready_i[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1010101100000000"
    )
        port map (
      I0 => \gen_master_slots[3].w_issuing_cnt_reg[24]\,
      I1 => \m_ready_d_reg[0]\,
      I2 => \^gen_no_arbiter.m_target_hot_i_reg[3]\,
      I3 => accept_cnt(0),
      I4 => accept_cnt(1),
      I5 => aresetn_d,
      O => E(0)
    );
\gen_no_arbiter.s_ready_i[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E00E00000000E00E"
    )
        port map (
      I0 => \gen_single_thread.accept_cnt[1]_i_2_n_0\,
      I1 => accept_cnt(0),
      I2 => active_target_enc(0),
      I3 => st_aa_awtarget_enc(0),
      I4 => st_aa_awtarget_enc(1),
      I5 => active_target_enc(1),
      O => \^gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\gen_no_arbiter.s_ready_i[0]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => s_axi_bready(0),
      I1 => \^q\(3),
      I2 => p_42_out,
      O => \gen_no_arbiter.m_target_hot_i_reg[3]_0\
    );
\gen_primitive_shifter.gen_srls[0].srl_inst_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => s_axi_awaddr(1),
      I1 => s_axi_awaddr(3),
      I2 => s_axi_awaddr(2),
      O => \^gen_single_thread.active_target_hot_reg[3]_0\
    );
\gen_single_thread.accept_cnt[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A54A"
    )
        port map (
      I0 => accept_cnt(0),
      I1 => accept_cnt(1),
      I2 => \gen_single_thread.accept_cnt[1]_i_2_n_0\,
      I3 => \m_ready_d_reg[0]_0\(0),
      O => \gen_single_thread.accept_cnt[0]_i_1_n_0\
    );
\gen_single_thread.accept_cnt[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C68C"
    )
        port map (
      I0 => accept_cnt(0),
      I1 => accept_cnt(1),
      I2 => \gen_single_thread.accept_cnt[1]_i_2_n_0\,
      I3 => \m_ready_d_reg[0]_0\(0),
      O => \gen_single_thread.accept_cnt[1]_i_1_n_0\
    );
\gen_single_thread.accept_cnt[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA888A888A888"
    )
        port map (
      I0 => s_axi_bready(0),
      I1 => \s_axi_bvalid[0]_INST_0_i_1_n_0\,
      I2 => \^q\(3),
      I3 => p_42_out,
      I4 => \^q\(2),
      I5 => p_64_out,
      O => \gen_single_thread.accept_cnt[1]_i_2_n_0\
    );
\gen_single_thread.accept_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_single_thread.accept_cnt[0]_i_1_n_0\,
      Q => accept_cnt(0),
      R => SR(0)
    );
\gen_single_thread.accept_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_single_thread.accept_cnt[1]_i_1_n_0\,
      Q => accept_cnt(1),
      R => SR(0)
    );
\gen_single_thread.active_target_enc_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \m_ready_d_reg[0]_0\(0),
      D => st_aa_awtarget_enc(0),
      Q => active_target_enc(0),
      R => SR(0)
    );
\gen_single_thread.active_target_enc_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \m_ready_d_reg[0]_0\(0),
      D => st_aa_awtarget_enc(1),
      Q => active_target_enc(1),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \m_ready_d_reg[0]_0\(0),
      D => \^d\(0),
      Q => \^q\(0),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \m_ready_d_reg[0]_0\(0),
      D => \s_axi_awaddr[26]_0\(0),
      Q => \^q\(1),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \m_ready_d_reg[0]_0\(0),
      D => \s_axi_awaddr[26]_0\(1),
      Q => \^q\(2),
      R => SR(0)
    );
\gen_single_thread.active_target_hot_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \m_ready_d_reg[0]_0\(0),
      D => \^d\(1),
      Q => \^q\(3),
      R => SR(0)
    );
\s_axi_bresp[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCEEFC22"
    )
        port map (
      I0 => st_mr_bmesg(0),
      I1 => active_target_enc(1),
      I2 => st_mr_bmesg(2),
      I3 => active_target_enc(0),
      I4 => st_mr_bmesg(4),
      O => s_axi_bresp(0)
    );
\s_axi_bresp[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCEEFC22"
    )
        port map (
      I0 => st_mr_bmesg(1),
      I1 => active_target_enc(1),
      I2 => st_mr_bmesg(3),
      I3 => active_target_enc(0),
      I4 => st_mr_bmesg(5),
      O => s_axi_bresp(1)
    );
\s_axi_bvalid[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \s_axi_bvalid[0]_INST_0_i_1_n_0\,
      I1 => \^q\(3),
      I2 => p_42_out,
      I3 => \^q\(2),
      I4 => p_64_out,
      O => s_axi_bvalid(0)
    );
\s_axi_bvalid[0]_INST_0_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \^q\(0),
      I1 => p_104_out,
      I2 => \^q\(1),
      I3 => p_84_out,
      O => \s_axi_bvalid[0]_INST_0_i_1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_ready_d : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ss_wr_awvalid : out STD_LOGIC;
    ss_aa_awready : in STD_LOGIC;
    ss_wr_awready : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    aresetn_d : in STD_LOGIC;
    aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter : entity is "axi_crossbar_v2_1_10_splitter";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter is
  signal \^m_ready_d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \m_ready_d[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_ready_d[1]_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_primitive_shifter.gen_srls[0].srl_inst_i_3\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \s_axi_awready[0]_INST_0\ : label is "soft_lutpair75";
begin
  m_ready_d(1 downto 0) <= \^m_ready_d\(1 downto 0);
\gen_primitive_shifter.gen_srls[0].srl_inst_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_awvalid(0),
      I1 => \^m_ready_d\(1),
      O => ss_wr_awvalid
    );
\m_ready_d[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000000C8C0"
    )
        port map (
      I0 => s_axi_awvalid(0),
      I1 => aresetn_d,
      I2 => \^m_ready_d\(0),
      I3 => ss_aa_awready,
      I4 => ss_wr_awready,
      I5 => \^m_ready_d\(1),
      O => \m_ready_d[0]_i_1_n_0\
    );
\m_ready_d[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000C000C00080000"
    )
        port map (
      I0 => s_axi_awvalid(0),
      I1 => aresetn_d,
      I2 => \^m_ready_d\(0),
      I3 => ss_aa_awready,
      I4 => ss_wr_awready,
      I5 => \^m_ready_d\(1),
      O => \m_ready_d[1]_i_1_n_0\
    );
\m_ready_d_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[0]_i_1_n_0\,
      Q => \^m_ready_d\(0),
      R => '0'
    );
\m_ready_d_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[1]_i_1_n_0\,
      Q => \^m_ready_d\(1),
      R => '0'
    );
\s_axi_awready[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EEE0"
    )
        port map (
      I0 => \^m_ready_d\(0),
      I1 => ss_aa_awready,
      I2 => ss_wr_awready,
      I3 => \^m_ready_d\(1),
      O => E(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter_4 is
  port (
    m_ready_d : out STD_LOGIC_VECTOR ( 1 downto 0 );
    aa_sa_awvalid : in STD_LOGIC;
    aresetn_d : in STD_LOGIC;
    \m_ready_d_reg[1]_0\ : in STD_LOGIC;
    \m_ready_d_reg[0]_0\ : in STD_LOGIC;
    aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter_4 : entity is "axi_crossbar_v2_1_10_splitter";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter_4;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter_4 is
  signal \^m_ready_d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \m_ready_d[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_ready_d[1]_i_1_n_0\ : STD_LOGIC;
begin
  m_ready_d(1 downto 0) <= \^m_ready_d\(1 downto 0);
\m_ready_d[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000E000"
    )
        port map (
      I0 => aa_sa_awvalid,
      I1 => \^m_ready_d\(0),
      I2 => aresetn_d,
      I3 => \m_ready_d_reg[1]_0\,
      I4 => \m_ready_d_reg[0]_0\,
      O => \m_ready_d[0]_i_1_n_0\
    );
\m_ready_d[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00E00000"
    )
        port map (
      I0 => aa_sa_awvalid,
      I1 => \^m_ready_d\(1),
      I2 => aresetn_d,
      I3 => \m_ready_d_reg[1]_0\,
      I4 => \m_ready_d_reg[0]_0\,
      O => \m_ready_d[1]_i_1_n_0\
    );
\m_ready_d_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[0]_i_1_n_0\,
      Q => \^m_ready_d\(0),
      R => '0'
    );
\m_ready_d_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[1]_i_1_n_0\,
      Q => \^m_ready_d\(1),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl is
  port (
    \storage_data1_reg[0]\ : out STD_LOGIC;
    push : in STD_LOGIC;
    st_aa_awtarget_enc : in STD_LOGIC_VECTOR ( 0 to 0 );
    fifoaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl : entity is "axi_data_fifo_v2_1_8_ndeep_srl";
end ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl;

architecture STRUCTURE of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl is
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "SRLC32E";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "inst/\gen_samd.crossbar_samd/gen_slave_slots[0].gen_si_write.wdata_router_w/wrouter_aw_fifo/gen_srls[0].gen_rep[0].srl_nx1/gen_primitive_shifter.gen_srls ";
  attribute srl_name : string;
  attribute srl_name of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "inst/\gen_samd.crossbar_samd/gen_slave_slots[0].gen_si_write.wdata_router_w/wrouter_aw_fifo/gen_srls[0].gen_rep[0].srl_nx1/gen_primitive_shifter.gen_srls[0].srl_inst ";
begin
\gen_primitive_shifter.gen_srls[0].srl_inst\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => fifoaddr(0),
      A1 => fifoaddr(1),
      A2 => '0',
      A3 => '0',
      CE => push,
      CLK => aclk,
      D => st_aa_awtarget_enc(0),
      Q => \storage_data1_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_5 is
  port (
    p_2_out : out STD_LOGIC;
    \gen_single_thread.active_target_enc_reg[1]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    push : in STD_LOGIC;
    fifoaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aclk : in STD_LOGIC;
    \s_axi_awaddr[26]\ : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \s_axi_awaddr[18]\ : in STD_LOGIC;
    \s_axi_awaddr[22]\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_5 : entity is "axi_data_fifo_v2_1_8_ndeep_srl";
end ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_5;

architecture STRUCTURE of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_5 is
  signal \^gen_single_thread.active_target_enc_reg[1]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "SRLC32E";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "inst/\gen_samd.crossbar_samd/gen_slave_slots[0].gen_si_write.wdata_router_w/wrouter_aw_fifo/gen_srls[0].gen_rep[1].srl_nx1/gen_primitive_shifter.gen_srls ";
  attribute srl_name : string;
  attribute srl_name of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "inst/\gen_samd.crossbar_samd/gen_slave_slots[0].gen_si_write.wdata_router_w/wrouter_aw_fifo/gen_srls[0].gen_rep[1].srl_nx1/gen_primitive_shifter.gen_srls[0].srl_inst ";
begin
  \gen_single_thread.active_target_enc_reg[1]\(0) <= \^gen_single_thread.active_target_enc_reg[1]\(0);
\gen_primitive_shifter.gen_srls[0].srl_inst\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => fifoaddr(0),
      A1 => fifoaddr(1),
      A2 => '0',
      A3 => '0',
      CE => push,
      CLK => aclk,
      D => \^gen_single_thread.active_target_enc_reg[1]\(0),
      Q => p_2_out
    );
\gen_primitive_shifter.gen_srls[0].srl_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEFFFB"
    )
        port map (
      I0 => \s_axi_awaddr[26]\,
      I1 => s_axi_awaddr(0),
      I2 => \s_axi_awaddr[18]\,
      I3 => \s_axi_awaddr[22]\,
      I4 => s_axi_awaddr(1),
      O => \^gen_single_thread.active_target_enc_reg[1]\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_6 is
  port (
    p_3_out : out STD_LOGIC;
    push : out STD_LOGIC;
    s_ready_i_reg : out STD_LOGIC;
    fifoaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aclk : in STD_LOGIC;
    s_ready_i_reg_0 : in STD_LOGIC;
    out0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    ss_wr_awvalid : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_select_enc : in STD_LOGIC_VECTOR ( 2 downto 0 );
    wr_tmp_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_avalid : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_6 : entity is "axi_data_fifo_v2_1_8_ndeep_srl";
end ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_6;

architecture STRUCTURE of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_6 is
  signal \gen_primitive_shifter.gen_srls[0].srl_inst_i_4_n_0\ : STD_LOGIC;
  signal \^push\ : STD_LOGIC;
  signal \s_axi_wready[0]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \^s_ready_i_reg\ : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "SRLC32E";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "inst/\gen_samd.crossbar_samd/gen_slave_slots[0].gen_si_write.wdata_router_w/wrouter_aw_fifo/gen_srls[0].gen_rep[2].srl_nx1/gen_primitive_shifter.gen_srls ";
  attribute srl_name : string;
  attribute srl_name of \gen_primitive_shifter.gen_srls[0].srl_inst\ : label is "inst/\gen_samd.crossbar_samd/gen_slave_slots[0].gen_si_write.wdata_router_w/wrouter_aw_fifo/gen_srls[0].gen_rep[2].srl_nx1/gen_primitive_shifter.gen_srls[0].srl_inst ";
begin
  push <= \^push\;
  s_ready_i_reg <= \^s_ready_i_reg\;
\gen_primitive_shifter.gen_srls[0].srl_inst\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => fifoaddr(0),
      A1 => fifoaddr(1),
      A2 => '0',
      A3 => '0',
      CE => \^push\,
      CLK => aclk,
      D => '0',
      Q => p_3_out
    );
\gen_primitive_shifter.gen_srls[0].srl_inst_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F0F08080808080"
    )
        port map (
      I0 => s_ready_i_reg_0,
      I1 => out0(0),
      I2 => ss_wr_awvalid,
      I3 => \^s_ready_i_reg\,
      I4 => \gen_primitive_shifter.gen_srls[0].srl_inst_i_4_n_0\,
      I5 => out0(1),
      O => \^push\
    );
\gen_primitive_shifter.gen_srls[0].srl_inst_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => s_axi_wvalid(0),
      I1 => m_avalid,
      I2 => s_axi_wlast(0),
      O => \gen_primitive_shifter.gen_srls[0].srl_inst_i_4_n_0\
    );
\s_axi_wready[0]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FCFDFFFD"
    )
        port map (
      I0 => m_axi_wready(0),
      I1 => m_select_enc(2),
      I2 => m_select_enc(1),
      I3 => m_select_enc(0),
      I4 => m_axi_wready(1),
      I5 => \s_axi_wready[0]_INST_0_i_2_n_0\,
      O => \^s_ready_i_reg\
    );
\s_axi_wready[0]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0C080008"
    )
        port map (
      I0 => m_axi_wready(2),
      I1 => m_select_enc(1),
      I2 => m_select_enc(2),
      I3 => m_select_enc(0),
      I4 => wr_tmp_wready(0),
      O => \s_axi_wready[0]_INST_0_i_2_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1\ is
  port (
    p_42_out : out STD_LOGIC;
    mi_bready_3 : out STD_LOGIC;
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    \gen_axi.s_axi_bvalid_i_reg\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    \gen_axi.s_axi_bvalid_i_reg_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1\ is
begin
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.s_axi_bvalid_i_reg\,
      Q => p_42_out,
      R => \aresetn_d_reg[1]\
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_axi.s_axi_bvalid_i_reg_0\,
      Q => mi_bready_3,
      R => \aresetn_d_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_11\ is
  port (
    s_ready_i_reg_0 : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    st_mr_bmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    \aresetn_d_reg[1]_0\ : in STD_LOGIC;
    m_valid_i_reg_0 : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_awaddr[22]\ : in STD_LOGIC;
    \s_axi_awaddr[17]\ : in STD_LOGIC;
    \s_axi_awaddr[26]\ : in STD_LOGIC;
    w_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_11\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_11\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_11\ is
  signal \gen_no_arbiter.s_ready_i[0]_i_8_n_0\ : STD_LOGIC;
  signal \^m_axi_bready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \m_payload_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_payload_i[1]_i_1_n_0\ : STD_LOGIC;
  signal m_valid_i_i_2_n_0 : STD_LOGIC;
  signal \s_ready_i_i_1__5_n_0\ : STD_LOGIC;
  signal \^s_ready_i_reg_0\ : STD_LOGIC;
  signal \^st_mr_bmesg\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_payload_i[0]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_payload_i[1]_i_1\ : label is "soft_lutpair10";
begin
  m_axi_bready(0) <= \^m_axi_bready\(0);
  s_ready_i_reg_0 <= \^s_ready_i_reg_0\;
  st_mr_bmesg(1 downto 0) <= \^st_mr_bmesg\(1 downto 0);
\gen_no_arbiter.s_ready_i[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000053"
    )
        port map (
      I0 => \gen_no_arbiter.s_ready_i[0]_i_8_n_0\,
      I1 => m_valid_i_reg_0,
      I2 => s_axi_awaddr(0),
      I3 => \s_axi_awaddr[22]\,
      I4 => \s_axi_awaddr[17]\,
      I5 => \s_axi_awaddr[26]\,
      O => \gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\gen_no_arbiter.s_ready_i[0]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00007F00"
    )
        port map (
      I0 => s_axi_bready(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => Q(0),
      I3 => w_issuing_cnt(1),
      I4 => w_issuing_cnt(0),
      O => \gen_no_arbiter.s_ready_i[0]_i_8_n_0\
    );
\m_payload_i[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => m_axi_bresp(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => \^st_mr_bmesg\(0),
      O => \m_payload_i[0]_i_1_n_0\
    );
\m_payload_i[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => m_axi_bresp(1),
      I1 => \^s_ready_i_reg_0\,
      I2 => \^st_mr_bmesg\(1),
      O => \m_payload_i[1]_i_1_n_0\
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[0]_i_1_n_0\,
      Q => \^st_mr_bmesg\(0),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[1]_i_1_n_0\,
      Q => \^st_mr_bmesg\(1),
      R => '0'
    );
m_valid_i_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8BBB"
    )
        port map (
      I0 => m_axi_bvalid(0),
      I1 => \^m_axi_bready\(0),
      I2 => Q(0),
      I3 => s_axi_bready(0),
      O => m_valid_i_i_2_n_0
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => m_valid_i_i_2_n_0,
      Q => \^s_ready_i_reg_0\,
      R => \aresetn_d_reg[1]\
    );
\s_ready_i_i_1__5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D111FFFF"
    )
        port map (
      I0 => m_axi_bvalid(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => Q(0),
      I3 => s_axi_bready(0),
      I4 => \aresetn_d_reg[1]_0\,
      O => \s_ready_i_i_1__5_n_0\
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \s_ready_i_i_1__5_n_0\,
      Q => \^m_axi_bready\(0),
      R => \aresetn_d_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_7\ is
  port (
    s_ready_i_reg_0 : out STD_LOGIC;
    m_valid_i_reg_0 : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_ready_i_reg_1 : out STD_LOGIC;
    s_ready_i_reg_2 : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    st_mr_bmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    w_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_7\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_7\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_7\ is
  signal \aresetn_d[1]_i_1_n_0\ : STD_LOGIC;
  signal \aresetn_d_reg_n_0_[0]\ : STD_LOGIC;
  signal \^m_axi_bready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \m_payload_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_payload_i[1]_i_1_n_0\ : STD_LOGIC;
  signal \m_valid_i_i_1__1_n_0\ : STD_LOGIC;
  signal \^m_valid_i_reg_0\ : STD_LOGIC;
  signal s_ready_i_i_2_n_0 : STD_LOGIC;
  signal \^s_ready_i_reg_0\ : STD_LOGIC;
  signal \^s_ready_i_reg_1\ : STD_LOGIC;
  signal \^s_ready_i_reg_2\ : STD_LOGIC;
  signal \^st_mr_bmesg\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_payload_i[0]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \m_payload_i[1]_i_1\ : label is "soft_lutpair46";
begin
  m_axi_bready(0) <= \^m_axi_bready\(0);
  m_valid_i_reg_0 <= \^m_valid_i_reg_0\;
  s_ready_i_reg_0 <= \^s_ready_i_reg_0\;
  s_ready_i_reg_1 <= \^s_ready_i_reg_1\;
  s_ready_i_reg_2 <= \^s_ready_i_reg_2\;
  st_mr_bmesg(1 downto 0) <= \^st_mr_bmesg\(1 downto 0);
\aresetn_d[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \aresetn_d_reg_n_0_[0]\,
      I1 => aresetn,
      O => \aresetn_d[1]_i_1_n_0\
    );
\aresetn_d_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => aresetn,
      Q => \aresetn_d_reg_n_0_[0]\,
      R => '0'
    );
\aresetn_d_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \aresetn_d[1]_i_1_n_0\,
      Q => \^s_ready_i_reg_2\,
      R => '0'
    );
\gen_no_arbiter.s_ready_i[0]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00007F00"
    )
        port map (
      I0 => s_axi_bready(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => Q(0),
      I3 => w_issuing_cnt(1),
      I4 => w_issuing_cnt(0),
      O => \gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\m_payload_i[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => m_axi_bresp(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => \^st_mr_bmesg\(0),
      O => \m_payload_i[0]_i_1_n_0\
    );
\m_payload_i[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => m_axi_bresp(1),
      I1 => \^s_ready_i_reg_0\,
      I2 => \^st_mr_bmesg\(1),
      O => \m_payload_i[1]_i_1_n_0\
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[0]_i_1_n_0\,
      Q => \^st_mr_bmesg\(0),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[1]_i_1_n_0\,
      Q => \^st_mr_bmesg\(1),
      R => '0'
    );
\m_valid_i_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8BBB"
    )
        port map (
      I0 => m_axi_bvalid(0),
      I1 => \^m_axi_bready\(0),
      I2 => Q(0),
      I3 => s_axi_bready(0),
      O => \m_valid_i_i_1__1_n_0\
    );
\m_valid_i_i_1__7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^s_ready_i_reg_2\,
      O => \^m_valid_i_reg_0\
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_valid_i_i_1__1_n_0\,
      Q => \^s_ready_i_reg_0\,
      R => \^m_valid_i_reg_0\
    );
\s_ready_i_i_1__3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \aresetn_d_reg_n_0_[0]\,
      O => \^s_ready_i_reg_1\
    );
s_ready_i_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D111FFFF"
    )
        port map (
      I0 => m_axi_bvalid(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => Q(0),
      I3 => s_axi_bready(0),
      I4 => \^s_ready_i_reg_2\,
      O => s_ready_i_i_2_n_0
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => s_ready_i_i_2_n_0,
      Q => \^m_axi_bready\(0),
      R => \^s_ready_i_reg_1\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_9\ is
  port (
    s_ready_i_reg_0 : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    st_mr_bmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    \aresetn_d_reg[1]_0\ : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 0 to 0 );
    st_aa_awtarget_enc : in STD_LOGIC_VECTOR ( 0 to 0 );
    w_issuing_cnt : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \gen_single_thread.active_target_hot_reg[3]\ : in STD_LOGIC;
    m_valid_i_reg_0 : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_9\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_9\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_9\ is
  signal \gen_no_arbiter.s_ready_i[0]_i_5_n_0\ : STD_LOGIC;
  signal \^m_axi_bready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \m_payload_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_payload_i[1]_i_1_n_0\ : STD_LOGIC;
  signal \m_valid_i_i_1__0_n_0\ : STD_LOGIC;
  signal \s_ready_i_i_1__6_n_0\ : STD_LOGIC;
  signal \^s_ready_i_reg_0\ : STD_LOGIC;
  signal \^st_mr_bmesg\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_payload_i[0]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \m_payload_i[1]_i_1\ : label is "soft_lutpair28";
begin
  m_axi_bready(0) <= \^m_axi_bready\(0);
  s_ready_i_reg_0 <= \^s_ready_i_reg_0\;
  st_mr_bmesg(1 downto 0) <= \^st_mr_bmesg\(1 downto 0);
\gen_no_arbiter.s_ready_i[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000008D8DDD8D"
    )
        port map (
      I0 => D(0),
      I1 => \gen_no_arbiter.s_ready_i[0]_i_5_n_0\,
      I2 => st_aa_awtarget_enc(0),
      I3 => w_issuing_cnt(2),
      I4 => \gen_single_thread.active_target_hot_reg[3]\,
      I5 => m_valid_i_reg_0,
      O => \gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\gen_no_arbiter.s_ready_i[0]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00007F00"
    )
        port map (
      I0 => s_axi_bready(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => Q(0),
      I3 => w_issuing_cnt(1),
      I4 => w_issuing_cnt(0),
      O => \gen_no_arbiter.s_ready_i[0]_i_5_n_0\
    );
\m_payload_i[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => m_axi_bresp(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => \^st_mr_bmesg\(0),
      O => \m_payload_i[0]_i_1_n_0\
    );
\m_payload_i[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => m_axi_bresp(1),
      I1 => \^s_ready_i_reg_0\,
      I2 => \^st_mr_bmesg\(1),
      O => \m_payload_i[1]_i_1_n_0\
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[0]_i_1_n_0\,
      Q => \^st_mr_bmesg\(0),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[1]_i_1_n_0\,
      Q => \^st_mr_bmesg\(1),
      R => '0'
    );
\m_valid_i_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8BBB"
    )
        port map (
      I0 => m_axi_bvalid(0),
      I1 => \^m_axi_bready\(0),
      I2 => Q(0),
      I3 => s_axi_bready(0),
      O => \m_valid_i_i_1__0_n_0\
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_valid_i_i_1__0_n_0\,
      Q => \^s_ready_i_reg_0\,
      R => \aresetn_d_reg[1]\
    );
\s_ready_i_i_1__6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D111FFFF"
    )
        port map (
      I0 => m_axi_bvalid(0),
      I1 => \^s_ready_i_reg_0\,
      I2 => Q(0),
      I3 => s_axi_bready(0),
      I4 => \aresetn_d_reg[1]_0\,
      O => \s_ready_i_i_1__6_n_0\
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \s_ready_i_i_1__6_n_0\,
      Q => \^m_axi_bready\(0),
      R => \aresetn_d_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2\ is
  port (
    m_valid_i_reg_0 : out STD_LOGIC;
    \skid_buffer_reg[32]_0\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_master_slots[3].r_issuing_cnt_reg[24]\ : out STD_LOGIC;
    \gen_master_slots[3].r_issuing_cnt_reg[24]_0\ : out STD_LOGIC;
    st_mr_rmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_15_in : in STD_LOGIC;
    \s_axi_araddr[18]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_19_in : in STD_LOGIC;
    s_axi_rlast_i : in STD_LOGIC;
    \gen_no_arbiter.m_valid_i_reg\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2\ is
  signal \^gen_master_slots[3].r_issuing_cnt_reg[24]\ : STD_LOGIC;
  signal \m_payload_i[32]_i_1_n_0\ : STD_LOGIC;
  signal \m_payload_i[33]_i_1_n_0\ : STD_LOGIC;
  signal \m_payload_i[34]_i_1_n_0\ : STD_LOGIC;
  signal \m_payload_i[34]_i_2_n_0\ : STD_LOGIC;
  signal m_valid_i0 : STD_LOGIC;
  signal \^m_valid_i_reg_0\ : STD_LOGIC;
  signal s_ready_i0 : STD_LOGIC;
  signal \skid_buffer[32]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[33]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[34]_i_1_n_0\ : STD_LOGIC;
  signal \^skid_buffer_reg[32]_0\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[32]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[33]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[34]\ : STD_LOGIC;
  signal \^st_mr_rmesg\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_2\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \m_valid_i_i_1__6\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \skid_buffer[32]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \skid_buffer[33]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \skid_buffer[34]_i_1\ : label is "soft_lutpair65";
begin
  \gen_master_slots[3].r_issuing_cnt_reg[24]\ <= \^gen_master_slots[3].r_issuing_cnt_reg[24]\;
  m_valid_i_reg_0 <= \^m_valid_i_reg_0\;
  \skid_buffer_reg[32]_0\ <= \^skid_buffer_reg[32]_0\;
  st_mr_rmesg(1 downto 0) <= \^st_mr_rmesg\(1 downto 0);
\gen_master_slots[3].r_issuing_cnt[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"955555552AAAAAAA"
    )
        port map (
      I0 => \gen_no_arbiter.m_valid_i_reg\,
      I1 => s_axi_rready(0),
      I2 => \^gen_master_slots[3].r_issuing_cnt_reg[24]\,
      I3 => \^m_valid_i_reg_0\,
      I4 => Q(0),
      I5 => p_15_in,
      O => \gen_master_slots[3].r_issuing_cnt_reg[24]_0\
    );
\gen_no_arbiter.s_ready_i[0]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF0000FFFFFFFF"
    )
        port map (
      I0 => Q(0),
      I1 => \^m_valid_i_reg_0\,
      I2 => \^gen_master_slots[3].r_issuing_cnt_reg[24]\,
      I3 => s_axi_rready(0),
      I4 => p_15_in,
      I5 => \s_axi_araddr[18]\(0),
      O => \gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\m_payload_i[32]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFEEEEE000EEEE"
    )
        port map (
      I0 => \^skid_buffer_reg[32]_0\,
      I1 => \skid_buffer_reg_n_0_[32]\,
      I2 => Q(0),
      I3 => s_axi_rready(0),
      I4 => \^m_valid_i_reg_0\,
      I5 => \^st_mr_rmesg\(0),
      O => \m_payload_i[32]_i_1_n_0\
    );
\m_payload_i[33]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFEEEEE000EEEE"
    )
        port map (
      I0 => \^skid_buffer_reg[32]_0\,
      I1 => \skid_buffer_reg_n_0_[33]\,
      I2 => Q(0),
      I3 => s_axi_rready(0),
      I4 => \^m_valid_i_reg_0\,
      I5 => \^st_mr_rmesg\(1),
      O => \m_payload_i[33]_i_1_n_0\
    );
\m_payload_i[34]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFB800B8"
    )
        port map (
      I0 => s_axi_rlast_i,
      I1 => \^skid_buffer_reg[32]_0\,
      I2 => \skid_buffer_reg_n_0_[34]\,
      I3 => \m_payload_i[34]_i_2_n_0\,
      I4 => \^gen_master_slots[3].r_issuing_cnt_reg[24]\,
      O => \m_payload_i[34]_i_1_n_0\
    );
\m_payload_i[34]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2A"
    )
        port map (
      I0 => \^m_valid_i_reg_0\,
      I1 => s_axi_rready(0),
      I2 => Q(0),
      O => \m_payload_i[34]_i_2_n_0\
    );
\m_payload_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[32]_i_1_n_0\,
      Q => \^st_mr_rmesg\(0),
      R => '0'
    );
\m_payload_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[33]_i_1_n_0\,
      Q => \^st_mr_rmesg\(1),
      R => '0'
    );
\m_payload_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_payload_i[34]_i_1_n_0\,
      Q => \^gen_master_slots[3].r_issuing_cnt_reg[24]\,
      R => '0'
    );
\m_valid_i_i_1__6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF70FFFF"
    )
        port map (
      I0 => Q(0),
      I1 => s_axi_rready(0),
      I2 => \^m_valid_i_reg_0\,
      I3 => p_19_in,
      I4 => \^skid_buffer_reg[32]_0\,
      O => m_valid_i0
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => m_valid_i0,
      Q => \^m_valid_i_reg_0\,
      R => \aresetn_d_reg[1]\
    );
\s_ready_i_i_1__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F444FFFF"
    )
        port map (
      I0 => p_19_in,
      I1 => \^skid_buffer_reg[32]_0\,
      I2 => Q(0),
      I3 => s_axi_rready(0),
      I4 => \^m_valid_i_reg_0\,
      O => s_ready_i0
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => s_ready_i0,
      Q => \^skid_buffer_reg[32]_0\,
      R => \aresetn_d_reg[0]\
    );
\skid_buffer[32]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^skid_buffer_reg[32]_0\,
      I1 => \skid_buffer_reg_n_0_[32]\,
      O => \skid_buffer[32]_i_1_n_0\
    );
\skid_buffer[33]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^skid_buffer_reg[32]_0\,
      I1 => \skid_buffer_reg_n_0_[33]\,
      O => \skid_buffer[33]_i_1_n_0\
    );
\skid_buffer[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_rlast_i,
      I1 => \^skid_buffer_reg[32]_0\,
      I2 => \skid_buffer_reg_n_0_[34]\,
      O => \skid_buffer[34]_i_1_n_0\
    );
\skid_buffer_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \skid_buffer[32]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[32]\,
      R => '0'
    );
\skid_buffer_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \skid_buffer[33]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[33]\,
      R => '0'
    );
\skid_buffer_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \skid_buffer[34]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[34]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_10\ is
  port (
    m_valid_i_reg_0 : out STD_LOGIC;
    \m_axi_rready[1]\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_master_slots[1].r_issuing_cnt_reg[9]\ : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \gen_master_slots[1].r_issuing_cnt_reg[9]_0\ : out STD_LOGIC;
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    r_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_10\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_10\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_10\ is
  signal \^gen_master_slots[1].r_issuing_cnt_reg[9]\ : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal \^m_axi_rready[1]\ : STD_LOGIC;
  signal \m_payload_i[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[10]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[11]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[12]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[13]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[14]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[15]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[16]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[17]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[18]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[19]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[1]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[20]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[21]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[22]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[23]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[24]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[25]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[26]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[27]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[28]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[29]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[2]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[30]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[31]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[33]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[34]_i_2__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[3]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[4]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[5]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[6]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[7]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[8]_i_1__0_n_0\ : STD_LOGIC;
  signal \m_payload_i[9]_i_1__0_n_0\ : STD_LOGIC;
  signal m_valid_i0 : STD_LOGIC;
  signal \^m_valid_i_reg_0\ : STD_LOGIC;
  signal s_ready_i0 : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[0]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[10]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[11]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[12]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[13]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[14]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[15]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[16]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[17]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[18]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[19]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[1]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[20]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[21]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[22]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[23]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[24]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[25]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[26]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[27]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[28]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[29]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[2]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[30]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[31]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[32]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[33]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[34]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[3]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[4]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[5]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[6]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[7]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[8]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[9]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_payload_i[10]_i_1__0\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \m_payload_i[11]_i_1__0\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \m_payload_i[12]_i_1__0\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \m_payload_i[13]_i_1__0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \m_payload_i[14]_i_1__0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \m_payload_i[15]_i_1__0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \m_payload_i[16]_i_1__0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \m_payload_i[17]_i_1__0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \m_payload_i[18]_i_1__0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \m_payload_i[19]_i_1__0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \m_payload_i[1]_i_1__0\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \m_payload_i[20]_i_1__0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \m_payload_i[21]_i_1__0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \m_payload_i[22]_i_1__0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \m_payload_i[23]_i_1__0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \m_payload_i[24]_i_1__0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \m_payload_i[25]_i_1__0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \m_payload_i[26]_i_1__0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \m_payload_i[27]_i_1__0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_payload_i[28]_i_1__0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_payload_i[29]_i_1__0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_payload_i[2]_i_1__0\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \m_payload_i[30]_i_1__0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_payload_i[31]_i_1__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_1__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_payload_i[33]_i_1__0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_2__1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_payload_i[3]_i_1__0\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \m_payload_i[4]_i_1__0\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \m_payload_i[5]_i_1__0\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \m_payload_i[6]_i_1__0\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \m_payload_i[7]_i_1__0\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \m_payload_i[8]_i_1__0\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \m_payload_i[9]_i_1__0\ : label is "soft_lutpair41";
begin
  \gen_master_slots[1].r_issuing_cnt_reg[9]\(34 downto 0) <= \^gen_master_slots[1].r_issuing_cnt_reg[9]\(34 downto 0);
  \m_axi_rready[1]\ <= \^m_axi_rready[1]\;
  m_valid_i_reg_0 <= \^m_valid_i_reg_0\;
\gen_master_slots[1].r_issuing_cnt[9]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(34),
      I1 => s_axi_rready(0),
      I2 => \gen_single_thread.active_target_hot_reg[1]\(0),
      I3 => \^m_valid_i_reg_0\,
      O => \gen_master_slots[1].r_issuing_cnt_reg[9]_0\
    );
\gen_no_arbiter.s_ready_i[0]_i_7__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000007FFF0000"
    )
        port map (
      I0 => \^m_valid_i_reg_0\,
      I1 => \gen_single_thread.active_target_hot_reg[1]\(0),
      I2 => s_axi_rready(0),
      I3 => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(34),
      I4 => r_issuing_cnt(1),
      I5 => r_issuing_cnt(0),
      O => \gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\m_payload_i[0]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(0),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[0]\,
      O => \m_payload_i[0]_i_1__0_n_0\
    );
\m_payload_i[10]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(10),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[10]\,
      O => \m_payload_i[10]_i_1__0_n_0\
    );
\m_payload_i[11]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(11),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[11]\,
      O => \m_payload_i[11]_i_1__0_n_0\
    );
\m_payload_i[12]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(12),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[12]\,
      O => \m_payload_i[12]_i_1__0_n_0\
    );
\m_payload_i[13]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(13),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[13]\,
      O => \m_payload_i[13]_i_1__0_n_0\
    );
\m_payload_i[14]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(14),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[14]\,
      O => \m_payload_i[14]_i_1__0_n_0\
    );
\m_payload_i[15]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(15),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[15]\,
      O => \m_payload_i[15]_i_1__0_n_0\
    );
\m_payload_i[16]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(16),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[16]\,
      O => \m_payload_i[16]_i_1__0_n_0\
    );
\m_payload_i[17]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(17),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[17]\,
      O => \m_payload_i[17]_i_1__0_n_0\
    );
\m_payload_i[18]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(18),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[18]\,
      O => \m_payload_i[18]_i_1__0_n_0\
    );
\m_payload_i[19]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(19),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[19]\,
      O => \m_payload_i[19]_i_1__0_n_0\
    );
\m_payload_i[1]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(1),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[1]\,
      O => \m_payload_i[1]_i_1__0_n_0\
    );
\m_payload_i[20]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(20),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[20]\,
      O => \m_payload_i[20]_i_1__0_n_0\
    );
\m_payload_i[21]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(21),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[21]\,
      O => \m_payload_i[21]_i_1__0_n_0\
    );
\m_payload_i[22]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(22),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[22]\,
      O => \m_payload_i[22]_i_1__0_n_0\
    );
\m_payload_i[23]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(23),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[23]\,
      O => \m_payload_i[23]_i_1__0_n_0\
    );
\m_payload_i[24]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(24),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[24]\,
      O => \m_payload_i[24]_i_1__0_n_0\
    );
\m_payload_i[25]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(25),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[25]\,
      O => \m_payload_i[25]_i_1__0_n_0\
    );
\m_payload_i[26]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(26),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[26]\,
      O => \m_payload_i[26]_i_1__0_n_0\
    );
\m_payload_i[27]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(27),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[27]\,
      O => \m_payload_i[27]_i_1__0_n_0\
    );
\m_payload_i[28]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(28),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[28]\,
      O => \m_payload_i[28]_i_1__0_n_0\
    );
\m_payload_i[29]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(29),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[29]\,
      O => \m_payload_i[29]_i_1__0_n_0\
    );
\m_payload_i[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(2),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[2]\,
      O => \m_payload_i[2]_i_1__0_n_0\
    );
\m_payload_i[30]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(30),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[30]\,
      O => \m_payload_i[30]_i_1__0_n_0\
    );
\m_payload_i[31]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(31),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[31]\,
      O => \m_payload_i[31]_i_1__0_n_0\
    );
\m_payload_i[32]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rresp(0),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[32]\,
      O => \m_payload_i[32]_i_1__0_n_0\
    );
\m_payload_i[33]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[33]\,
      O => \m_payload_i[33]_i_1__0_n_0\
    );
\m_payload_i[34]_i_2__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rlast(0),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[34]\,
      O => \m_payload_i[34]_i_2__1_n_0\
    );
\m_payload_i[3]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(3),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[3]\,
      O => \m_payload_i[3]_i_1__0_n_0\
    );
\m_payload_i[4]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(4),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[4]\,
      O => \m_payload_i[4]_i_1__0_n_0\
    );
\m_payload_i[5]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(5),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[5]\,
      O => \m_payload_i[5]_i_1__0_n_0\
    );
\m_payload_i[6]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(6),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[6]\,
      O => \m_payload_i[6]_i_1__0_n_0\
    );
\m_payload_i[7]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(7),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[7]\,
      O => \m_payload_i[7]_i_1__0_n_0\
    );
\m_payload_i[8]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(8),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[8]\,
      O => \m_payload_i[8]_i_1__0_n_0\
    );
\m_payload_i[9]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(9),
      I1 => \^m_axi_rready[1]\,
      I2 => \skid_buffer_reg_n_0_[9]\,
      O => \m_payload_i[9]_i_1__0_n_0\
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[0]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(0),
      R => '0'
    );
\m_payload_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[10]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(10),
      R => '0'
    );
\m_payload_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[11]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(11),
      R => '0'
    );
\m_payload_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[12]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(12),
      R => '0'
    );
\m_payload_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[13]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(13),
      R => '0'
    );
\m_payload_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[14]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(14),
      R => '0'
    );
\m_payload_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[15]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(15),
      R => '0'
    );
\m_payload_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[16]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(16),
      R => '0'
    );
\m_payload_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[17]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(17),
      R => '0'
    );
\m_payload_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[18]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(18),
      R => '0'
    );
\m_payload_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[19]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(19),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[1]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(1),
      R => '0'
    );
\m_payload_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[20]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(20),
      R => '0'
    );
\m_payload_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[21]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(21),
      R => '0'
    );
\m_payload_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[22]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(22),
      R => '0'
    );
\m_payload_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[23]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(23),
      R => '0'
    );
\m_payload_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[24]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(24),
      R => '0'
    );
\m_payload_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[25]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(25),
      R => '0'
    );
\m_payload_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[26]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(26),
      R => '0'
    );
\m_payload_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[27]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(27),
      R => '0'
    );
\m_payload_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[28]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(28),
      R => '0'
    );
\m_payload_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[29]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(29),
      R => '0'
    );
\m_payload_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[2]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(2),
      R => '0'
    );
\m_payload_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[30]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(30),
      R => '0'
    );
\m_payload_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[31]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(31),
      R => '0'
    );
\m_payload_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[32]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(32),
      R => '0'
    );
\m_payload_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[33]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(33),
      R => '0'
    );
\m_payload_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[34]_i_2__1_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(34),
      R => '0'
    );
\m_payload_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[3]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(3),
      R => '0'
    );
\m_payload_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[4]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(4),
      R => '0'
    );
\m_payload_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[5]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(5),
      R => '0'
    );
\m_payload_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[6]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(6),
      R => '0'
    );
\m_payload_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[7]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(7),
      R => '0'
    );
\m_payload_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[8]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(8),
      R => '0'
    );
\m_payload_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[9]_i_1__0_n_0\,
      Q => \^gen_master_slots[1].r_issuing_cnt_reg[9]\(9),
      R => '0'
    );
\m_valid_i_i_1__4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF70FFFF"
    )
        port map (
      I0 => \gen_single_thread.active_target_hot_reg[1]\(0),
      I1 => s_axi_rready(0),
      I2 => \^m_valid_i_reg_0\,
      I3 => m_axi_rvalid(0),
      I4 => \^m_axi_rready[1]\,
      O => m_valid_i0
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => m_valid_i0,
      Q => \^m_valid_i_reg_0\,
      R => \aresetn_d_reg[1]\
    );
\s_ready_i_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F444FFFF"
    )
        port map (
      I0 => m_axi_rvalid(0),
      I1 => \^m_axi_rready[1]\,
      I2 => \gen_single_thread.active_target_hot_reg[1]\(0),
      I3 => s_axi_rready(0),
      I4 => \^m_valid_i_reg_0\,
      O => s_ready_i0
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => s_ready_i0,
      Q => \^m_axi_rready[1]\,
      R => \aresetn_d_reg[0]\
    );
\skid_buffer_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(0),
      Q => \skid_buffer_reg_n_0_[0]\,
      R => '0'
    );
\skid_buffer_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(10),
      Q => \skid_buffer_reg_n_0_[10]\,
      R => '0'
    );
\skid_buffer_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(11),
      Q => \skid_buffer_reg_n_0_[11]\,
      R => '0'
    );
\skid_buffer_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(12),
      Q => \skid_buffer_reg_n_0_[12]\,
      R => '0'
    );
\skid_buffer_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(13),
      Q => \skid_buffer_reg_n_0_[13]\,
      R => '0'
    );
\skid_buffer_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(14),
      Q => \skid_buffer_reg_n_0_[14]\,
      R => '0'
    );
\skid_buffer_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(15),
      Q => \skid_buffer_reg_n_0_[15]\,
      R => '0'
    );
\skid_buffer_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(16),
      Q => \skid_buffer_reg_n_0_[16]\,
      R => '0'
    );
\skid_buffer_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(17),
      Q => \skid_buffer_reg_n_0_[17]\,
      R => '0'
    );
\skid_buffer_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(18),
      Q => \skid_buffer_reg_n_0_[18]\,
      R => '0'
    );
\skid_buffer_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(19),
      Q => \skid_buffer_reg_n_0_[19]\,
      R => '0'
    );
\skid_buffer_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(1),
      Q => \skid_buffer_reg_n_0_[1]\,
      R => '0'
    );
\skid_buffer_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(20),
      Q => \skid_buffer_reg_n_0_[20]\,
      R => '0'
    );
\skid_buffer_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(21),
      Q => \skid_buffer_reg_n_0_[21]\,
      R => '0'
    );
\skid_buffer_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(22),
      Q => \skid_buffer_reg_n_0_[22]\,
      R => '0'
    );
\skid_buffer_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(23),
      Q => \skid_buffer_reg_n_0_[23]\,
      R => '0'
    );
\skid_buffer_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(24),
      Q => \skid_buffer_reg_n_0_[24]\,
      R => '0'
    );
\skid_buffer_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(25),
      Q => \skid_buffer_reg_n_0_[25]\,
      R => '0'
    );
\skid_buffer_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(26),
      Q => \skid_buffer_reg_n_0_[26]\,
      R => '0'
    );
\skid_buffer_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(27),
      Q => \skid_buffer_reg_n_0_[27]\,
      R => '0'
    );
\skid_buffer_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(28),
      Q => \skid_buffer_reg_n_0_[28]\,
      R => '0'
    );
\skid_buffer_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(29),
      Q => \skid_buffer_reg_n_0_[29]\,
      R => '0'
    );
\skid_buffer_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(2),
      Q => \skid_buffer_reg_n_0_[2]\,
      R => '0'
    );
\skid_buffer_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(30),
      Q => \skid_buffer_reg_n_0_[30]\,
      R => '0'
    );
\skid_buffer_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(31),
      Q => \skid_buffer_reg_n_0_[31]\,
      R => '0'
    );
\skid_buffer_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rresp(0),
      Q => \skid_buffer_reg_n_0_[32]\,
      R => '0'
    );
\skid_buffer_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rresp(1),
      Q => \skid_buffer_reg_n_0_[33]\,
      R => '0'
    );
\skid_buffer_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rlast(0),
      Q => \skid_buffer_reg_n_0_[34]\,
      R => '0'
    );
\skid_buffer_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(3),
      Q => \skid_buffer_reg_n_0_[3]\,
      R => '0'
    );
\skid_buffer_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(4),
      Q => \skid_buffer_reg_n_0_[4]\,
      R => '0'
    );
\skid_buffer_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(5),
      Q => \skid_buffer_reg_n_0_[5]\,
      R => '0'
    );
\skid_buffer_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(6),
      Q => \skid_buffer_reg_n_0_[6]\,
      R => '0'
    );
\skid_buffer_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(7),
      Q => \skid_buffer_reg_n_0_[7]\,
      R => '0'
    );
\skid_buffer_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(8),
      Q => \skid_buffer_reg_n_0_[8]\,
      R => '0'
    );
\skid_buffer_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[1]\,
      D => m_axi_rdata(9),
      Q => \skid_buffer_reg_n_0_[9]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_12\ is
  port (
    m_valid_i_reg_0 : out STD_LOGIC;
    \m_axi_rready[0]\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_master_slots[0].r_issuing_cnt_reg[1]\ : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \gen_master_slots[0].r_issuing_cnt_reg[1]_0\ : out STD_LOGIC;
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[3]\ : in STD_LOGIC;
    \gen_no_arbiter.s_ready_i_reg[0]\ : in STD_LOGIC;
    \gen_single_thread.accept_cnt_reg[1]\ : in STD_LOGIC;
    aresetn_d : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_valid_i_reg_1 : in STD_LOGIC;
    m_valid_i_reg_2 : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[0]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    r_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \gen_single_thread.active_target_hot_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_12\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_12\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_12\ is
  signal \^gen_master_slots[0].r_issuing_cnt_reg[1]\ : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal \^gen_no_arbiter.m_target_hot_i_reg[3]\ : STD_LOGIC;
  signal \gen_no_arbiter.s_ready_i[0]_i_6__0_n_0\ : STD_LOGIC;
  signal \^m_axi_rready[0]\ : STD_LOGIC;
  signal m_valid_i0 : STD_LOGIC;
  signal \^m_valid_i_reg_0\ : STD_LOGIC;
  signal s_ready_i0 : STD_LOGIC;
  signal skid_buffer : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal \skid_buffer_reg_n_0_[0]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[10]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[11]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[12]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[13]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[14]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[15]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[16]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[17]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[18]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[19]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[1]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[20]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[21]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[22]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[23]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[24]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[25]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[26]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[27]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[28]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[29]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[2]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[30]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[31]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[32]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[33]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[34]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[3]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[4]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[5]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[6]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[7]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[8]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[9]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_payload_i[10]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \m_payload_i[11]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_payload_i[12]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_payload_i[13]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_payload_i[14]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_payload_i[15]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_payload_i[16]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_payload_i[17]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_payload_i[18]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_payload_i[19]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_payload_i[1]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_payload_i[20]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_payload_i[21]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_payload_i[22]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_payload_i[23]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_payload_i[24]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_payload_i[25]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_payload_i[26]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_payload_i[27]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_payload_i[28]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_payload_i[29]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_payload_i[2]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_payload_i[30]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_payload_i[31]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_payload_i[33]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_2__0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_payload_i[3]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_payload_i[4]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_payload_i[5]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_payload_i[6]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_payload_i[7]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \m_payload_i[8]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \m_payload_i[9]_i_1\ : label is "soft_lutpair23";
begin
  \gen_master_slots[0].r_issuing_cnt_reg[1]\(34 downto 0) <= \^gen_master_slots[0].r_issuing_cnt_reg[1]\(34 downto 0);
  \gen_no_arbiter.m_target_hot_i_reg[3]\ <= \^gen_no_arbiter.m_target_hot_i_reg[3]\;
  \m_axi_rready[0]\ <= \^m_axi_rready[0]\;
  m_valid_i_reg_0 <= \^m_valid_i_reg_0\;
\gen_master_slots[0].r_issuing_cnt[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(34),
      I1 => s_axi_rready(0),
      I2 => \gen_single_thread.active_target_hot_reg[0]\(0),
      I3 => \^m_valid_i_reg_0\,
      O => \gen_master_slots[0].r_issuing_cnt_reg[1]_0\
    );
\gen_no_arbiter.s_ready_i[0]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0B000000"
    )
        port map (
      I0 => \^gen_no_arbiter.m_target_hot_i_reg[3]\,
      I1 => \gen_single_thread.active_target_hot_reg[3]\,
      I2 => \gen_no_arbiter.s_ready_i_reg[0]\,
      I3 => \gen_single_thread.accept_cnt_reg[1]\,
      I4 => aresetn_d,
      O => E(0)
    );
\gen_no_arbiter.s_ready_i[0]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \gen_no_arbiter.s_ready_i[0]_i_6__0_n_0\,
      I1 => D(0),
      I2 => D(1),
      I3 => m_valid_i_reg_1,
      I4 => D(2),
      I5 => m_valid_i_reg_2,
      O => \^gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\gen_no_arbiter.s_ready_i[0]_i_6__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000007FFF0000"
    )
        port map (
      I0 => \^m_valid_i_reg_0\,
      I1 => \gen_single_thread.active_target_hot_reg[0]\(0),
      I2 => s_axi_rready(0),
      I3 => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(34),
      I4 => r_issuing_cnt(1),
      I5 => r_issuing_cnt(0),
      O => \gen_no_arbiter.s_ready_i[0]_i_6__0_n_0\
    );
\m_payload_i[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(0),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[0]\,
      O => skid_buffer(0)
    );
\m_payload_i[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(10),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[10]\,
      O => skid_buffer(10)
    );
\m_payload_i[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(11),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[11]\,
      O => skid_buffer(11)
    );
\m_payload_i[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(12),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[12]\,
      O => skid_buffer(12)
    );
\m_payload_i[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(13),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[13]\,
      O => skid_buffer(13)
    );
\m_payload_i[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(14),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[14]\,
      O => skid_buffer(14)
    );
\m_payload_i[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(15),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[15]\,
      O => skid_buffer(15)
    );
\m_payload_i[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(16),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[16]\,
      O => skid_buffer(16)
    );
\m_payload_i[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(17),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[17]\,
      O => skid_buffer(17)
    );
\m_payload_i[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(18),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[18]\,
      O => skid_buffer(18)
    );
\m_payload_i[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(19),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[19]\,
      O => skid_buffer(19)
    );
\m_payload_i[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(1),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[1]\,
      O => skid_buffer(1)
    );
\m_payload_i[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(20),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[20]\,
      O => skid_buffer(20)
    );
\m_payload_i[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(21),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[21]\,
      O => skid_buffer(21)
    );
\m_payload_i[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(22),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[22]\,
      O => skid_buffer(22)
    );
\m_payload_i[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(23),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[23]\,
      O => skid_buffer(23)
    );
\m_payload_i[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(24),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[24]\,
      O => skid_buffer(24)
    );
\m_payload_i[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(25),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[25]\,
      O => skid_buffer(25)
    );
\m_payload_i[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(26),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[26]\,
      O => skid_buffer(26)
    );
\m_payload_i[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(27),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[27]\,
      O => skid_buffer(27)
    );
\m_payload_i[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(28),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[28]\,
      O => skid_buffer(28)
    );
\m_payload_i[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(29),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[29]\,
      O => skid_buffer(29)
    );
\m_payload_i[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(2),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[2]\,
      O => skid_buffer(2)
    );
\m_payload_i[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(30),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[30]\,
      O => skid_buffer(30)
    );
\m_payload_i[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(31),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[31]\,
      O => skid_buffer(31)
    );
\m_payload_i[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rresp(0),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[32]\,
      O => skid_buffer(32)
    );
\m_payload_i[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[33]\,
      O => skid_buffer(33)
    );
\m_payload_i[34]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rlast(0),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[34]\,
      O => skid_buffer(34)
    );
\m_payload_i[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(3),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[3]\,
      O => skid_buffer(3)
    );
\m_payload_i[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(4),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[4]\,
      O => skid_buffer(4)
    );
\m_payload_i[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(5),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[5]\,
      O => skid_buffer(5)
    );
\m_payload_i[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(6),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[6]\,
      O => skid_buffer(6)
    );
\m_payload_i[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(7),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[7]\,
      O => skid_buffer(7)
    );
\m_payload_i[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(8),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[8]\,
      O => skid_buffer(8)
    );
\m_payload_i[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(9),
      I1 => \^m_axi_rready[0]\,
      I2 => \skid_buffer_reg_n_0_[9]\,
      O => skid_buffer(9)
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(0),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(0),
      R => '0'
    );
\m_payload_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(10),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(10),
      R => '0'
    );
\m_payload_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(11),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(11),
      R => '0'
    );
\m_payload_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(12),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(12),
      R => '0'
    );
\m_payload_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(13),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(13),
      R => '0'
    );
\m_payload_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(14),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(14),
      R => '0'
    );
\m_payload_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(15),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(15),
      R => '0'
    );
\m_payload_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(16),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(16),
      R => '0'
    );
\m_payload_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(17),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(17),
      R => '0'
    );
\m_payload_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(18),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(18),
      R => '0'
    );
\m_payload_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(19),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(19),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(1),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(1),
      R => '0'
    );
\m_payload_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(20),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(20),
      R => '0'
    );
\m_payload_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(21),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(21),
      R => '0'
    );
\m_payload_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(22),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(22),
      R => '0'
    );
\m_payload_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(23),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(23),
      R => '0'
    );
\m_payload_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(24),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(24),
      R => '0'
    );
\m_payload_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(25),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(25),
      R => '0'
    );
\m_payload_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(26),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(26),
      R => '0'
    );
\m_payload_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(27),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(27),
      R => '0'
    );
\m_payload_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(28),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(28),
      R => '0'
    );
\m_payload_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(29),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(29),
      R => '0'
    );
\m_payload_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(2),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(2),
      R => '0'
    );
\m_payload_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(30),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(30),
      R => '0'
    );
\m_payload_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(31),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(31),
      R => '0'
    );
\m_payload_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(32),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(32),
      R => '0'
    );
\m_payload_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(33),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(33),
      R => '0'
    );
\m_payload_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(34),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(34),
      R => '0'
    );
\m_payload_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(3),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(3),
      R => '0'
    );
\m_payload_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(4),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(4),
      R => '0'
    );
\m_payload_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(5),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(5),
      R => '0'
    );
\m_payload_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(6),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(6),
      R => '0'
    );
\m_payload_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(7),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(7),
      R => '0'
    );
\m_payload_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(8),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(8),
      R => '0'
    );
\m_payload_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      D => skid_buffer(9),
      Q => \^gen_master_slots[0].r_issuing_cnt_reg[1]\(9),
      R => '0'
    );
\m_valid_i_i_1__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF70FFFF"
    )
        port map (
      I0 => \gen_single_thread.active_target_hot_reg[0]\(0),
      I1 => s_axi_rready(0),
      I2 => \^m_valid_i_reg_0\,
      I3 => m_axi_rvalid(0),
      I4 => \^m_axi_rready[0]\,
      O => m_valid_i0
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => m_valid_i0,
      Q => \^m_valid_i_reg_0\,
      R => \aresetn_d_reg[1]\
    );
s_ready_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F444FFFF"
    )
        port map (
      I0 => m_axi_rvalid(0),
      I1 => \^m_axi_rready[0]\,
      I2 => \gen_single_thread.active_target_hot_reg[0]\(0),
      I3 => s_axi_rready(0),
      I4 => \^m_valid_i_reg_0\,
      O => s_ready_i0
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => s_ready_i0,
      Q => \^m_axi_rready[0]\,
      R => \aresetn_d_reg[0]\
    );
\skid_buffer_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(0),
      Q => \skid_buffer_reg_n_0_[0]\,
      R => '0'
    );
\skid_buffer_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(10),
      Q => \skid_buffer_reg_n_0_[10]\,
      R => '0'
    );
\skid_buffer_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(11),
      Q => \skid_buffer_reg_n_0_[11]\,
      R => '0'
    );
\skid_buffer_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(12),
      Q => \skid_buffer_reg_n_0_[12]\,
      R => '0'
    );
\skid_buffer_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(13),
      Q => \skid_buffer_reg_n_0_[13]\,
      R => '0'
    );
\skid_buffer_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(14),
      Q => \skid_buffer_reg_n_0_[14]\,
      R => '0'
    );
\skid_buffer_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(15),
      Q => \skid_buffer_reg_n_0_[15]\,
      R => '0'
    );
\skid_buffer_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(16),
      Q => \skid_buffer_reg_n_0_[16]\,
      R => '0'
    );
\skid_buffer_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(17),
      Q => \skid_buffer_reg_n_0_[17]\,
      R => '0'
    );
\skid_buffer_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(18),
      Q => \skid_buffer_reg_n_0_[18]\,
      R => '0'
    );
\skid_buffer_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(19),
      Q => \skid_buffer_reg_n_0_[19]\,
      R => '0'
    );
\skid_buffer_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(1),
      Q => \skid_buffer_reg_n_0_[1]\,
      R => '0'
    );
\skid_buffer_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(20),
      Q => \skid_buffer_reg_n_0_[20]\,
      R => '0'
    );
\skid_buffer_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(21),
      Q => \skid_buffer_reg_n_0_[21]\,
      R => '0'
    );
\skid_buffer_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(22),
      Q => \skid_buffer_reg_n_0_[22]\,
      R => '0'
    );
\skid_buffer_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(23),
      Q => \skid_buffer_reg_n_0_[23]\,
      R => '0'
    );
\skid_buffer_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(24),
      Q => \skid_buffer_reg_n_0_[24]\,
      R => '0'
    );
\skid_buffer_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(25),
      Q => \skid_buffer_reg_n_0_[25]\,
      R => '0'
    );
\skid_buffer_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(26),
      Q => \skid_buffer_reg_n_0_[26]\,
      R => '0'
    );
\skid_buffer_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(27),
      Q => \skid_buffer_reg_n_0_[27]\,
      R => '0'
    );
\skid_buffer_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(28),
      Q => \skid_buffer_reg_n_0_[28]\,
      R => '0'
    );
\skid_buffer_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(29),
      Q => \skid_buffer_reg_n_0_[29]\,
      R => '0'
    );
\skid_buffer_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(2),
      Q => \skid_buffer_reg_n_0_[2]\,
      R => '0'
    );
\skid_buffer_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(30),
      Q => \skid_buffer_reg_n_0_[30]\,
      R => '0'
    );
\skid_buffer_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(31),
      Q => \skid_buffer_reg_n_0_[31]\,
      R => '0'
    );
\skid_buffer_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rresp(0),
      Q => \skid_buffer_reg_n_0_[32]\,
      R => '0'
    );
\skid_buffer_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rresp(1),
      Q => \skid_buffer_reg_n_0_[33]\,
      R => '0'
    );
\skid_buffer_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rlast(0),
      Q => \skid_buffer_reg_n_0_[34]\,
      R => '0'
    );
\skid_buffer_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(3),
      Q => \skid_buffer_reg_n_0_[3]\,
      R => '0'
    );
\skid_buffer_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(4),
      Q => \skid_buffer_reg_n_0_[4]\,
      R => '0'
    );
\skid_buffer_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(5),
      Q => \skid_buffer_reg_n_0_[5]\,
      R => '0'
    );
\skid_buffer_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(6),
      Q => \skid_buffer_reg_n_0_[6]\,
      R => '0'
    );
\skid_buffer_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(7),
      Q => \skid_buffer_reg_n_0_[7]\,
      R => '0'
    );
\skid_buffer_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(8),
      Q => \skid_buffer_reg_n_0_[8]\,
      R => '0'
    );
\skid_buffer_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[0]\,
      D => m_axi_rdata(9),
      Q => \skid_buffer_reg_n_0_[9]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_8\ is
  port (
    m_valid_i_reg_0 : out STD_LOGIC;
    \m_axi_rready[2]\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_master_slots[2].r_issuing_cnt_reg[17]\ : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \gen_master_slots[2].r_issuing_cnt_reg[17]_0\ : out STD_LOGIC;
    \gen_single_thread.accept_cnt_reg[1]\ : out STD_LOGIC;
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[2]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    r_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_8\ : entity is "axi_register_slice_v2_1_9_axic_register_slice";
end \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_8\;

architecture STRUCTURE of \ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_8\ is
  signal \^gen_master_slots[2].r_issuing_cnt_reg[17]\ : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal \^m_axi_rready[2]\ : STD_LOGIC;
  signal \m_payload_i[0]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[10]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[11]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[12]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[13]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[14]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[15]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[16]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[17]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[18]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[19]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[1]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[20]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[21]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[22]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[23]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[24]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[25]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[26]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[27]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[28]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[29]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[2]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[30]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[31]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[33]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[34]_i_2__2_n_0\ : STD_LOGIC;
  signal \m_payload_i[3]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[4]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[5]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[6]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[7]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[8]_i_1__1_n_0\ : STD_LOGIC;
  signal \m_payload_i[9]_i_1__1_n_0\ : STD_LOGIC;
  signal m_valid_i0 : STD_LOGIC;
  signal \^m_valid_i_reg_0\ : STD_LOGIC;
  signal s_ready_i0 : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[0]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[10]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[11]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[12]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[13]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[14]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[15]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[16]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[17]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[18]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[19]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[1]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[20]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[21]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[22]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[23]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[24]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[25]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[26]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[27]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[28]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[29]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[2]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[30]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[31]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[32]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[33]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[34]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[3]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[4]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[5]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[6]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[7]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[8]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[9]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_single_thread.accept_cnt[1]_i_3\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \m_payload_i[10]_i_1__1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \m_payload_i[11]_i_1__1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \m_payload_i[12]_i_1__1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \m_payload_i[13]_i_1__1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \m_payload_i[14]_i_1__1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \m_payload_i[15]_i_1__1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \m_payload_i[16]_i_1__1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \m_payload_i[17]_i_1__1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \m_payload_i[18]_i_1__1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \m_payload_i[19]_i_1__1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \m_payload_i[1]_i_1__1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \m_payload_i[20]_i_1__1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \m_payload_i[21]_i_1__1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \m_payload_i[22]_i_1__1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \m_payload_i[23]_i_1__1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \m_payload_i[24]_i_1__1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \m_payload_i[25]_i_1__1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \m_payload_i[26]_i_1__1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \m_payload_i[27]_i_1__1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \m_payload_i[28]_i_1__1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \m_payload_i[29]_i_1__1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \m_payload_i[2]_i_1__1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \m_payload_i[30]_i_1__1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \m_payload_i[31]_i_1__1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_1__1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \m_payload_i[33]_i_1__1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_2__2\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \m_payload_i[3]_i_1__1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \m_payload_i[4]_i_1__1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \m_payload_i[5]_i_1__1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \m_payload_i[6]_i_1__1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \m_payload_i[7]_i_1__1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \m_payload_i[8]_i_1__1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \m_payload_i[9]_i_1__1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \m_valid_i_i_1__5\ : label is "soft_lutpair47";
begin
  \gen_master_slots[2].r_issuing_cnt_reg[17]\(34 downto 0) <= \^gen_master_slots[2].r_issuing_cnt_reg[17]\(34 downto 0);
  \m_axi_rready[2]\ <= \^m_axi_rready[2]\;
  m_valid_i_reg_0 <= \^m_valid_i_reg_0\;
\gen_master_slots[2].r_issuing_cnt[17]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(34),
      I1 => s_axi_rready(0),
      I2 => \gen_single_thread.active_target_hot_reg[2]\(0),
      I3 => \^m_valid_i_reg_0\,
      O => \gen_master_slots[2].r_issuing_cnt_reg[17]_0\
    );
\gen_no_arbiter.s_ready_i[0]_i_8__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000007FFF0000"
    )
        port map (
      I0 => \^m_valid_i_reg_0\,
      I1 => \gen_single_thread.active_target_hot_reg[2]\(0),
      I2 => s_axi_rready(0),
      I3 => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(34),
      I4 => r_issuing_cnt(1),
      I5 => r_issuing_cnt(0),
      O => \gen_no_arbiter.m_target_hot_i_reg[3]\
    );
\gen_single_thread.accept_cnt[1]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^m_valid_i_reg_0\,
      I1 => \gen_single_thread.active_target_hot_reg[2]\(0),
      O => \gen_single_thread.accept_cnt_reg[1]\
    );
\m_payload_i[0]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(0),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[0]\,
      O => \m_payload_i[0]_i_1__1_n_0\
    );
\m_payload_i[10]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(10),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[10]\,
      O => \m_payload_i[10]_i_1__1_n_0\
    );
\m_payload_i[11]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(11),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[11]\,
      O => \m_payload_i[11]_i_1__1_n_0\
    );
\m_payload_i[12]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(12),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[12]\,
      O => \m_payload_i[12]_i_1__1_n_0\
    );
\m_payload_i[13]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(13),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[13]\,
      O => \m_payload_i[13]_i_1__1_n_0\
    );
\m_payload_i[14]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(14),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[14]\,
      O => \m_payload_i[14]_i_1__1_n_0\
    );
\m_payload_i[15]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(15),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[15]\,
      O => \m_payload_i[15]_i_1__1_n_0\
    );
\m_payload_i[16]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(16),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[16]\,
      O => \m_payload_i[16]_i_1__1_n_0\
    );
\m_payload_i[17]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(17),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[17]\,
      O => \m_payload_i[17]_i_1__1_n_0\
    );
\m_payload_i[18]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(18),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[18]\,
      O => \m_payload_i[18]_i_1__1_n_0\
    );
\m_payload_i[19]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(19),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[19]\,
      O => \m_payload_i[19]_i_1__1_n_0\
    );
\m_payload_i[1]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(1),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[1]\,
      O => \m_payload_i[1]_i_1__1_n_0\
    );
\m_payload_i[20]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(20),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[20]\,
      O => \m_payload_i[20]_i_1__1_n_0\
    );
\m_payload_i[21]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(21),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[21]\,
      O => \m_payload_i[21]_i_1__1_n_0\
    );
\m_payload_i[22]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(22),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[22]\,
      O => \m_payload_i[22]_i_1__1_n_0\
    );
\m_payload_i[23]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(23),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[23]\,
      O => \m_payload_i[23]_i_1__1_n_0\
    );
\m_payload_i[24]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(24),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[24]\,
      O => \m_payload_i[24]_i_1__1_n_0\
    );
\m_payload_i[25]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(25),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[25]\,
      O => \m_payload_i[25]_i_1__1_n_0\
    );
\m_payload_i[26]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(26),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[26]\,
      O => \m_payload_i[26]_i_1__1_n_0\
    );
\m_payload_i[27]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(27),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[27]\,
      O => \m_payload_i[27]_i_1__1_n_0\
    );
\m_payload_i[28]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(28),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[28]\,
      O => \m_payload_i[28]_i_1__1_n_0\
    );
\m_payload_i[29]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(29),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[29]\,
      O => \m_payload_i[29]_i_1__1_n_0\
    );
\m_payload_i[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(2),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[2]\,
      O => \m_payload_i[2]_i_1__1_n_0\
    );
\m_payload_i[30]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(30),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[30]\,
      O => \m_payload_i[30]_i_1__1_n_0\
    );
\m_payload_i[31]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(31),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[31]\,
      O => \m_payload_i[31]_i_1__1_n_0\
    );
\m_payload_i[32]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rresp(0),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[32]\,
      O => \m_payload_i[32]_i_1__1_n_0\
    );
\m_payload_i[33]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[33]\,
      O => \m_payload_i[33]_i_1__1_n_0\
    );
\m_payload_i[34]_i_2__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rlast(0),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[34]\,
      O => \m_payload_i[34]_i_2__2_n_0\
    );
\m_payload_i[3]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(3),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[3]\,
      O => \m_payload_i[3]_i_1__1_n_0\
    );
\m_payload_i[4]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(4),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[4]\,
      O => \m_payload_i[4]_i_1__1_n_0\
    );
\m_payload_i[5]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(5),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[5]\,
      O => \m_payload_i[5]_i_1__1_n_0\
    );
\m_payload_i[6]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(6),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[6]\,
      O => \m_payload_i[6]_i_1__1_n_0\
    );
\m_payload_i[7]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(7),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[7]\,
      O => \m_payload_i[7]_i_1__1_n_0\
    );
\m_payload_i[8]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(8),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[8]\,
      O => \m_payload_i[8]_i_1__1_n_0\
    );
\m_payload_i[9]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m_axi_rdata(9),
      I1 => \^m_axi_rready[2]\,
      I2 => \skid_buffer_reg_n_0_[9]\,
      O => \m_payload_i[9]_i_1__1_n_0\
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[0]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(0),
      R => '0'
    );
\m_payload_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[10]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(10),
      R => '0'
    );
\m_payload_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[11]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(11),
      R => '0'
    );
\m_payload_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[12]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(12),
      R => '0'
    );
\m_payload_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[13]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(13),
      R => '0'
    );
\m_payload_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[14]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(14),
      R => '0'
    );
\m_payload_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[15]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(15),
      R => '0'
    );
\m_payload_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[16]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(16),
      R => '0'
    );
\m_payload_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[17]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(17),
      R => '0'
    );
\m_payload_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[18]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(18),
      R => '0'
    );
\m_payload_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[19]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(19),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[1]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(1),
      R => '0'
    );
\m_payload_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[20]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(20),
      R => '0'
    );
\m_payload_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[21]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(21),
      R => '0'
    );
\m_payload_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[22]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(22),
      R => '0'
    );
\m_payload_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[23]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(23),
      R => '0'
    );
\m_payload_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[24]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(24),
      R => '0'
    );
\m_payload_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[25]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(25),
      R => '0'
    );
\m_payload_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[26]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(26),
      R => '0'
    );
\m_payload_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[27]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(27),
      R => '0'
    );
\m_payload_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[28]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(28),
      R => '0'
    );
\m_payload_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[29]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(29),
      R => '0'
    );
\m_payload_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[2]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(2),
      R => '0'
    );
\m_payload_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[30]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(30),
      R => '0'
    );
\m_payload_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[31]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(31),
      R => '0'
    );
\m_payload_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[32]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(32),
      R => '0'
    );
\m_payload_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[33]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(33),
      R => '0'
    );
\m_payload_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[34]_i_2__2_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(34),
      R => '0'
    );
\m_payload_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[3]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(3),
      R => '0'
    );
\m_payload_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[4]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(4),
      R => '0'
    );
\m_payload_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[5]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(5),
      R => '0'
    );
\m_payload_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[6]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(6),
      R => '0'
    );
\m_payload_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[7]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(7),
      R => '0'
    );
\m_payload_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[8]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(8),
      R => '0'
    );
\m_payload_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => \m_payload_i[9]_i_1__1_n_0\,
      Q => \^gen_master_slots[2].r_issuing_cnt_reg[17]\(9),
      R => '0'
    );
\m_valid_i_i_1__5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF70FFFF"
    )
        port map (
      I0 => \gen_single_thread.active_target_hot_reg[2]\(0),
      I1 => s_axi_rready(0),
      I2 => \^m_valid_i_reg_0\,
      I3 => m_axi_rvalid(0),
      I4 => \^m_axi_rready[2]\,
      O => m_valid_i0
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => m_valid_i0,
      Q => \^m_valid_i_reg_0\,
      R => \aresetn_d_reg[1]\
    );
\s_ready_i_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F444FFFF"
    )
        port map (
      I0 => m_axi_rvalid(0),
      I1 => \^m_axi_rready[2]\,
      I2 => \gen_single_thread.active_target_hot_reg[2]\(0),
      I3 => s_axi_rready(0),
      I4 => \^m_valid_i_reg_0\,
      O => s_ready_i0
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => s_ready_i0,
      Q => \^m_axi_rready[2]\,
      R => \aresetn_d_reg[0]\
    );
\skid_buffer_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(0),
      Q => \skid_buffer_reg_n_0_[0]\,
      R => '0'
    );
\skid_buffer_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(10),
      Q => \skid_buffer_reg_n_0_[10]\,
      R => '0'
    );
\skid_buffer_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(11),
      Q => \skid_buffer_reg_n_0_[11]\,
      R => '0'
    );
\skid_buffer_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(12),
      Q => \skid_buffer_reg_n_0_[12]\,
      R => '0'
    );
\skid_buffer_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(13),
      Q => \skid_buffer_reg_n_0_[13]\,
      R => '0'
    );
\skid_buffer_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(14),
      Q => \skid_buffer_reg_n_0_[14]\,
      R => '0'
    );
\skid_buffer_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(15),
      Q => \skid_buffer_reg_n_0_[15]\,
      R => '0'
    );
\skid_buffer_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(16),
      Q => \skid_buffer_reg_n_0_[16]\,
      R => '0'
    );
\skid_buffer_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(17),
      Q => \skid_buffer_reg_n_0_[17]\,
      R => '0'
    );
\skid_buffer_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(18),
      Q => \skid_buffer_reg_n_0_[18]\,
      R => '0'
    );
\skid_buffer_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(19),
      Q => \skid_buffer_reg_n_0_[19]\,
      R => '0'
    );
\skid_buffer_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(1),
      Q => \skid_buffer_reg_n_0_[1]\,
      R => '0'
    );
\skid_buffer_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(20),
      Q => \skid_buffer_reg_n_0_[20]\,
      R => '0'
    );
\skid_buffer_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(21),
      Q => \skid_buffer_reg_n_0_[21]\,
      R => '0'
    );
\skid_buffer_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(22),
      Q => \skid_buffer_reg_n_0_[22]\,
      R => '0'
    );
\skid_buffer_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(23),
      Q => \skid_buffer_reg_n_0_[23]\,
      R => '0'
    );
\skid_buffer_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(24),
      Q => \skid_buffer_reg_n_0_[24]\,
      R => '0'
    );
\skid_buffer_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(25),
      Q => \skid_buffer_reg_n_0_[25]\,
      R => '0'
    );
\skid_buffer_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(26),
      Q => \skid_buffer_reg_n_0_[26]\,
      R => '0'
    );
\skid_buffer_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(27),
      Q => \skid_buffer_reg_n_0_[27]\,
      R => '0'
    );
\skid_buffer_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(28),
      Q => \skid_buffer_reg_n_0_[28]\,
      R => '0'
    );
\skid_buffer_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(29),
      Q => \skid_buffer_reg_n_0_[29]\,
      R => '0'
    );
\skid_buffer_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(2),
      Q => \skid_buffer_reg_n_0_[2]\,
      R => '0'
    );
\skid_buffer_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(30),
      Q => \skid_buffer_reg_n_0_[30]\,
      R => '0'
    );
\skid_buffer_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(31),
      Q => \skid_buffer_reg_n_0_[31]\,
      R => '0'
    );
\skid_buffer_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rresp(0),
      Q => \skid_buffer_reg_n_0_[32]\,
      R => '0'
    );
\skid_buffer_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rresp(1),
      Q => \skid_buffer_reg_n_0_[33]\,
      R => '0'
    );
\skid_buffer_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rlast(0),
      Q => \skid_buffer_reg_n_0_[34]\,
      R => '0'
    );
\skid_buffer_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(3),
      Q => \skid_buffer_reg_n_0_[3]\,
      R => '0'
    );
\skid_buffer_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(4),
      Q => \skid_buffer_reg_n_0_[4]\,
      R => '0'
    );
\skid_buffer_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(5),
      Q => \skid_buffer_reg_n_0_[5]\,
      R => '0'
    );
\skid_buffer_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(6),
      Q => \skid_buffer_reg_n_0_[6]\,
      R => '0'
    );
\skid_buffer_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(7),
      Q => \skid_buffer_reg_n_0_[7]\,
      R => '0'
    );
\skid_buffer_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(8),
      Q => \skid_buffer_reg_n_0_[8]\,
      R => '0'
    );
\skid_buffer_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_axi_rready[2]\,
      D => m_axi_rdata(9),
      Q => \skid_buffer_reg_n_0_[9]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_data_fifo_v2_1_8_axic_reg_srl_fifo is
  port (
    \gen_single_thread.active_target_enc_reg[1]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_ready_i_reg_0 : out STD_LOGIC;
    \gen_axi.s_axi_wready_i_reg\ : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    st_aa_awtarget_enc : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    ss_wr_awvalid : in STD_LOGIC;
    \gen_axi.write_cs_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_awaddr[26]\ : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \s_axi_awaddr[18]\ : in STD_LOGIC;
    \s_axi_awaddr[22]\ : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    wr_tmp_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_ready_d : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_axic_reg_srl_fifo : entity is "axi_data_fifo_v2_1_8_axic_reg_srl_fifo";
end ip_block_design_xbar_0_axi_data_fifo_v2_1_8_axic_reg_srl_fifo;

architecture STRUCTURE of ip_block_design_xbar_0_axi_data_fifo_v2_1_8_axic_reg_srl_fifo is
  signal \FSM_onehot_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_6_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[2]\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[2]\ : signal is "yes";
  signal \FSM_onehot_state_reg_n_0_[3]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[3]\ : signal is "yes";
  signal areset_d1 : STD_LOGIC;
  signal fifoaddr : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \gen_axi.write_cs[1]_i_3_n_0\ : STD_LOGIC;
  signal \gen_rep[0].fifoaddr[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_rep[0].fifoaddr[1]_i_1_n_0\ : STD_LOGIC;
  signal \^gen_single_thread.active_target_enc_reg[1]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \gen_srls[0].gen_rep[0].srl_nx1_n_0\ : STD_LOGIC;
  signal \gen_srls[0].gen_rep[2].srl_nx1_n_2\ : STD_LOGIC;
  signal m_avalid : STD_LOGIC;
  signal m_select_enc : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m_valid_i : STD_LOGIC;
  signal m_valid_i_i_1_n_0 : STD_LOGIC;
  signal \m_valid_i_i_2__0_n_0\ : STD_LOGIC;
  signal p_0_in8_in : STD_LOGIC;
  attribute RTL_KEEP of p_0_in8_in : signal is "yes";
  signal p_2_out : STD_LOGIC;
  signal p_3_out : STD_LOGIC;
  signal p_9_in : STD_LOGIC;
  attribute RTL_KEEP of p_9_in : signal is "yes";
  signal push : STD_LOGIC;
  signal \s_ready_i_i_1__4_n_0\ : STD_LOGIC;
  signal \^s_ready_i_reg_0\ : STD_LOGIC;
  signal \storage_data1[0]_i_1_n_0\ : STD_LOGIC;
  signal \storage_data1[1]_i_1_n_0\ : STD_LOGIC;
  signal \storage_data1[1]_i_2_n_0\ : STD_LOGIC;
  signal \storage_data1[2]_i_1_n_0\ : STD_LOGIC;
  signal \storage_data1[2]_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state[3]_i_6\ : label is "soft_lutpair78";
  attribute KEEP : string;
  attribute KEEP of \FSM_onehot_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[3]\ : label is "yes";
  attribute SOFT_HLUTNM of \gen_axi.write_cs[1]_i_3\ : label is "soft_lutpair77";
  attribute syn_keep : string;
  attribute syn_keep of \gen_rep[0].fifoaddr_reg[0]\ : label is "1";
  attribute syn_keep of \gen_rep[0].fifoaddr_reg[1]\ : label is "1";
  attribute SOFT_HLUTNM of \m_axi_wvalid[0]_INST_0\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \m_axi_wvalid[1]_INST_0\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \m_axi_wvalid[2]_INST_0\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \s_axi_wready[0]_INST_0\ : label is "soft_lutpair78";
begin
  \gen_single_thread.active_target_enc_reg[1]\(0) <= \^gen_single_thread.active_target_enc_reg[1]\(0);
  s_ready_i_reg_0 <= \^s_ready_i_reg_0\;
\FSM_onehot_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00450000"
    )
        port map (
      I0 => p_9_in,
      I1 => m_ready_d(0),
      I2 => s_axi_awvalid(0),
      I3 => \FSM_onehot_state[3]_i_6_n_0\,
      I4 => p_0_in8_in,
      O => \FSM_onehot_state[0]_i_1_n_0\
    );
\FSM_onehot_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888888888B88"
    )
        port map (
      I0 => ss_wr_awvalid,
      I1 => p_9_in,
      I2 => \FSM_onehot_state[3]_i_5_n_0\,
      I3 => \FSM_onehot_state[2]_i_2_n_0\,
      I4 => push,
      I5 => p_0_in8_in,
      O => \FSM_onehot_state[1]_i_1_n_0\
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444444477777477"
    )
        port map (
      I0 => ss_wr_awvalid,
      I1 => p_9_in,
      I2 => \FSM_onehot_state[3]_i_5_n_0\,
      I3 => \FSM_onehot_state[2]_i_2_n_0\,
      I4 => push,
      I5 => p_0_in8_in,
      O => \FSM_onehot_state[2]_i_1_n_0\
    );
\FSM_onehot_state[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[3]\,
      I1 => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      I2 => s_axi_wvalid(0),
      I3 => m_avalid,
      I4 => s_axi_wlast(0),
      O => \FSM_onehot_state[2]_i_2_n_0\
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEEEEEEEEFEEEE"
    )
        port map (
      I0 => \FSM_onehot_state[3]_i_3_n_0\,
      I1 => \FSM_onehot_state[3]_i_4_n_0\,
      I2 => \FSM_onehot_state[3]_i_5_n_0\,
      I3 => \FSM_onehot_state[3]_i_6_n_0\,
      I4 => \FSM_onehot_state_reg_n_0_[3]\,
      I5 => push,
      O => m_valid_i
    );
\FSM_onehot_state[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AA20"
    )
        port map (
      I0 => p_0_in8_in,
      I1 => m_ready_d(0),
      I2 => s_axi_awvalid(0),
      I3 => \FSM_onehot_state[3]_i_6_n_0\,
      I4 => p_9_in,
      O => \FSM_onehot_state[3]_i_2_n_0\
    );
\FSM_onehot_state[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAA2AAA00008000"
    )
        port map (
      I0 => p_0_in8_in,
      I1 => s_axi_wlast(0),
      I2 => m_avalid,
      I3 => s_axi_wvalid(0),
      I4 => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      I5 => ss_wr_awvalid,
      O => \FSM_onehot_state[3]_i_3_n_0\
    );
\FSM_onehot_state[3]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => p_9_in,
      I1 => m_ready_d(0),
      I2 => s_axi_awvalid(0),
      O => \FSM_onehot_state[3]_i_4_n_0\
    );
\FSM_onehot_state[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => fifoaddr(0),
      I1 => fifoaddr(1),
      O => \FSM_onehot_state[3]_i_5_n_0\
    );
\FSM_onehot_state[3]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => s_axi_wlast(0),
      I1 => m_avalid,
      I2 => s_axi_wvalid(0),
      I3 => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      O => \FSM_onehot_state[3]_i_6_n_0\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => aclk,
      CE => m_valid_i,
      D => \FSM_onehot_state[0]_i_1_n_0\,
      Q => p_9_in,
      S => areset_d1
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => m_valid_i,
      D => \FSM_onehot_state[1]_i_1_n_0\,
      Q => p_0_in8_in,
      R => areset_d1
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => m_valid_i,
      D => \FSM_onehot_state[2]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[2]\,
      R => areset_d1
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => m_valid_i,
      D => \FSM_onehot_state[3]_i_2_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[3]\,
      R => areset_d1
    );
areset_d1_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => SR(0),
      Q => areset_d1,
      R => '0'
    );
\gen_axi.write_cs[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000040000000000"
    )
        port map (
      I0 => \gen_axi.write_cs_reg[1]\(0),
      I1 => m_select_enc(1),
      I2 => m_select_enc(2),
      I3 => m_select_enc(0),
      I4 => \gen_axi.write_cs[1]_i_3_n_0\,
      I5 => s_axi_wlast(0),
      O => \gen_axi.s_axi_wready_i_reg\
    );
\gen_axi.write_cs[1]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => m_avalid,
      I1 => s_axi_wvalid(0),
      O => \gen_axi.write_cs[1]_i_3_n_0\
    );
\gen_rep[0].fifoaddr[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0FB37FB3F04C804C"
    )
        port map (
      I0 => \^s_ready_i_reg_0\,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      I2 => ss_wr_awvalid,
      I3 => \FSM_onehot_state[3]_i_6_n_0\,
      I4 => p_0_in8_in,
      I5 => fifoaddr(0),
      O => \gen_rep[0].fifoaddr[0]_i_1_n_0\
    );
\gen_rep[0].fifoaddr[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"75EF8A10"
    )
        port map (
      I0 => fifoaddr(0),
      I1 => \FSM_onehot_state[3]_i_6_n_0\,
      I2 => \FSM_onehot_state_reg_n_0_[3]\,
      I3 => push,
      I4 => fifoaddr(1),
      O => \gen_rep[0].fifoaddr[1]_i_1_n_0\
    );
\gen_rep[0].fifoaddr_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_rep[0].fifoaddr[0]_i_1_n_0\,
      Q => fifoaddr(0),
      S => SR(0)
    );
\gen_rep[0].fifoaddr_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_rep[0].fifoaddr[1]_i_1_n_0\,
      Q => fifoaddr(1),
      S => SR(0)
    );
\gen_srls[0].gen_rep[0].srl_nx1\: entity work.ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl
     port map (
      aclk => aclk,
      fifoaddr(1 downto 0) => fifoaddr(1 downto 0),
      push => push,
      st_aa_awtarget_enc(0) => st_aa_awtarget_enc(0),
      \storage_data1_reg[0]\ => \gen_srls[0].gen_rep[0].srl_nx1_n_0\
    );
\gen_srls[0].gen_rep[1].srl_nx1\: entity work.ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_5
     port map (
      aclk => aclk,
      fifoaddr(1 downto 0) => fifoaddr(1 downto 0),
      \gen_single_thread.active_target_enc_reg[1]\(0) => \^gen_single_thread.active_target_enc_reg[1]\(0),
      p_2_out => p_2_out,
      push => push,
      s_axi_awaddr(1 downto 0) => s_axi_awaddr(1 downto 0),
      \s_axi_awaddr[18]\ => \s_axi_awaddr[18]\,
      \s_axi_awaddr[22]\ => \s_axi_awaddr[22]\,
      \s_axi_awaddr[26]\ => \s_axi_awaddr[26]\
    );
\gen_srls[0].gen_rep[2].srl_nx1\: entity work.ip_block_design_xbar_0_axi_data_fifo_v2_1_8_ndeep_srl_6
     port map (
      aclk => aclk,
      fifoaddr(1 downto 0) => fifoaddr(1 downto 0),
      m_avalid => m_avalid,
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_select_enc(2 downto 0) => m_select_enc(2 downto 0),
      out0(1) => p_0_in8_in,
      out0(0) => \FSM_onehot_state_reg_n_0_[3]\,
      p_3_out => p_3_out,
      push => push,
      s_axi_wlast(0) => s_axi_wlast(0),
      s_axi_wvalid(0) => s_axi_wvalid(0),
      s_ready_i_reg => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      s_ready_i_reg_0 => \^s_ready_i_reg_0\,
      ss_wr_awvalid => ss_wr_awvalid,
      wr_tmp_wready(0) => wr_tmp_wready(0)
    );
\m_axi_wvalid[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
        port map (
      I0 => s_axi_wvalid(0),
      I1 => m_avalid,
      I2 => m_select_enc(2),
      I3 => m_select_enc(1),
      I4 => m_select_enc(0),
      O => m_axi_wvalid(0)
    );
\m_axi_wvalid[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000080"
    )
        port map (
      I0 => s_axi_wvalid(0),
      I1 => m_avalid,
      I2 => m_select_enc(0),
      I3 => m_select_enc(2),
      I4 => m_select_enc(1),
      O => m_axi_wvalid(1)
    );
\m_axi_wvalid[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => s_axi_wvalid(0),
      I1 => m_avalid,
      I2 => m_select_enc(2),
      I3 => m_select_enc(1),
      I4 => m_select_enc(0),
      O => m_axi_wvalid(2)
    );
m_valid_i_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEEEEEEEEFEEEE"
    )
        port map (
      I0 => \m_valid_i_i_2__0_n_0\,
      I1 => \FSM_onehot_state[3]_i_4_n_0\,
      I2 => \FSM_onehot_state[3]_i_5_n_0\,
      I3 => \FSM_onehot_state[3]_i_6_n_0\,
      I4 => \FSM_onehot_state_reg_n_0_[3]\,
      I5 => push,
      O => m_valid_i_i_1_n_0
    );
\m_valid_i_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAA2AAA00000000"
    )
        port map (
      I0 => p_0_in8_in,
      I1 => s_axi_wlast(0),
      I2 => m_avalid,
      I3 => s_axi_wvalid(0),
      I4 => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      I5 => ss_wr_awvalid,
      O => \m_valid_i_i_2__0_n_0\
    );
m_valid_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => m_valid_i,
      D => m_valid_i_i_1_n_0,
      Q => m_avalid,
      R => areset_d1
    );
\s_axi_wready[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => m_avalid,
      I1 => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      O => s_axi_wready(0)
    );
\s_ready_i_i_1__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFFEEEEEEEE"
    )
        port map (
      I0 => \FSM_onehot_state[2]_i_2_n_0\,
      I1 => areset_d1,
      I2 => fifoaddr(0),
      I3 => fifoaddr(1),
      I4 => push,
      I5 => \^s_ready_i_reg_0\,
      O => \s_ready_i_i_1__4_n_0\
    );
s_ready_i_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \s_ready_i_i_1__4_n_0\,
      Q => \^s_ready_i_reg_0\,
      R => SR(0)
    );
\storage_data1[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AACCFAFFAACC0A00"
    )
        port map (
      I0 => \gen_srls[0].gen_rep[0].srl_nx1_n_0\,
      I1 => st_aa_awtarget_enc(0),
      I2 => \FSM_onehot_state[3]_i_6_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      I4 => \storage_data1[1]_i_2_n_0\,
      I5 => m_select_enc(0),
      O => \storage_data1[0]_i_1_n_0\
    );
\storage_data1[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AACCFAFFAACC0A00"
    )
        port map (
      I0 => p_2_out,
      I1 => \^gen_single_thread.active_target_enc_reg[1]\(0),
      I2 => \FSM_onehot_state[3]_i_6_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      I4 => \storage_data1[1]_i_2_n_0\,
      I5 => m_select_enc(1),
      O => \storage_data1[1]_i_1_n_0\
    );
\storage_data1[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888A888888888888"
    )
        port map (
      I0 => ss_wr_awvalid,
      I1 => p_9_in,
      I2 => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      I3 => \gen_axi.write_cs[1]_i_3_n_0\,
      I4 => s_axi_wlast(0),
      I5 => p_0_in8_in,
      O => \storage_data1[1]_i_2_n_0\
    );
\storage_data1[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFA0EFEF20A02020"
    )
        port map (
      I0 => p_3_out,
      I1 => \FSM_onehot_state[3]_i_6_n_0\,
      I2 => \FSM_onehot_state_reg_n_0_[3]\,
      I3 => \storage_data1[2]_i_2_n_0\,
      I4 => ss_wr_awvalid,
      I5 => m_select_enc(2),
      O => \storage_data1[2]_i_1_n_0\
    );
\storage_data1[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFFF7FFF"
    )
        port map (
      I0 => p_0_in8_in,
      I1 => s_axi_wlast(0),
      I2 => m_avalid,
      I3 => s_axi_wvalid(0),
      I4 => \gen_srls[0].gen_rep[2].srl_nx1_n_2\,
      I5 => p_9_in,
      O => \storage_data1[2]_i_2_n_0\
    );
\storage_data1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \storage_data1[0]_i_1_n_0\,
      Q => m_select_enc(0),
      R => '0'
    );
\storage_data1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \storage_data1[1]_i_1_n_0\,
      Q => m_select_enc(1),
      R => '0'
    );
\storage_data1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \storage_data1[2]_i_1_n_0\,
      Q => m_select_enc(2),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice is
  port (
    p_104_out : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_98_out : out STD_LOGIC;
    \m_axi_rready[0]\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]_0\ : out STD_LOGIC;
    \gen_master_slots[0].r_issuing_cnt_reg[1]\ : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \gen_master_slots[0].r_issuing_cnt_reg[1]_0\ : out STD_LOGIC;
    st_mr_bmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    \aresetn_d_reg[1]_0\ : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[3]\ : in STD_LOGIC;
    \gen_no_arbiter.s_ready_i_reg[0]\ : in STD_LOGIC;
    \gen_single_thread.accept_cnt_reg[1]\ : in STD_LOGIC;
    aresetn_d : in STD_LOGIC;
    m_valid_i_reg : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_awaddr[22]\ : in STD_LOGIC;
    \s_axi_awaddr[17]\ : in STD_LOGIC;
    \s_axi_awaddr[26]\ : in STD_LOGIC;
    w_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    D : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_valid_i_reg_0 : in STD_LOGIC;
    m_valid_i_reg_1 : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[0]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    r_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_single_thread.active_target_hot_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice : entity is "axi_register_slice_v2_1_9_axi_register_slice";
end ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice;

architecture STRUCTURE of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice is
begin
b_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_11\
     port map (
      Q(0) => Q(0),
      aclk => aclk,
      \aresetn_d_reg[0]\ => \aresetn_d_reg[0]\,
      \aresetn_d_reg[1]\ => \aresetn_d_reg[1]\,
      \aresetn_d_reg[1]_0\ => \aresetn_d_reg[1]_0\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_no_arbiter.m_target_hot_i_reg[3]_0\,
      m_axi_bready(0) => m_axi_bready(0),
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_bvalid(0) => m_axi_bvalid(0),
      m_valid_i_reg_0 => m_valid_i_reg,
      s_axi_awaddr(0) => s_axi_awaddr(0),
      \s_axi_awaddr[17]\ => \s_axi_awaddr[17]\,
      \s_axi_awaddr[22]\ => \s_axi_awaddr[22]\,
      \s_axi_awaddr[26]\ => \s_axi_awaddr[26]\,
      s_axi_bready(0) => s_axi_bready(0),
      s_ready_i_reg_0 => p_104_out,
      st_mr_bmesg(1 downto 0) => st_mr_bmesg(1 downto 0),
      w_issuing_cnt(1 downto 0) => w_issuing_cnt(1 downto 0)
    );
r_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_12\
     port map (
      D(2 downto 0) => D(2 downto 0),
      E(0) => E(0),
      aclk => aclk,
      aresetn_d => aresetn_d,
      \aresetn_d_reg[0]\ => \aresetn_d_reg[0]\,
      \aresetn_d_reg[1]\ => \aresetn_d_reg[1]\,
      \gen_master_slots[0].r_issuing_cnt_reg[1]\(34 downto 0) => \gen_master_slots[0].r_issuing_cnt_reg[1]\(34 downto 0),
      \gen_master_slots[0].r_issuing_cnt_reg[1]_0\ => \gen_master_slots[0].r_issuing_cnt_reg[1]_0\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_no_arbiter.m_target_hot_i_reg[3]\,
      \gen_no_arbiter.s_ready_i_reg[0]\ => \gen_no_arbiter.s_ready_i_reg[0]\,
      \gen_single_thread.accept_cnt_reg[1]\ => \gen_single_thread.accept_cnt_reg[1]\,
      \gen_single_thread.active_target_hot_reg[0]\(0) => \gen_single_thread.active_target_hot_reg[0]\(0),
      \gen_single_thread.active_target_hot_reg[0]_0\(0) => \gen_single_thread.active_target_hot_reg[0]_0\(0),
      \gen_single_thread.active_target_hot_reg[3]\ => \gen_single_thread.active_target_hot_reg[3]\,
      m_axi_rdata(31 downto 0) => m_axi_rdata(31 downto 0),
      m_axi_rlast(0) => m_axi_rlast(0),
      \m_axi_rready[0]\ => \m_axi_rready[0]\,
      m_axi_rresp(1 downto 0) => m_axi_rresp(1 downto 0),
      m_axi_rvalid(0) => m_axi_rvalid(0),
      m_valid_i_reg_0 => p_98_out,
      m_valid_i_reg_1 => m_valid_i_reg_0,
      m_valid_i_reg_2 => m_valid_i_reg_1,
      r_issuing_cnt(1 downto 0) => r_issuing_cnt(1 downto 0),
      s_axi_rready(0) => s_axi_rready(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_1 is
  port (
    p_84_out : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_78_out : out STD_LOGIC;
    \m_axi_rready[1]\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]_0\ : out STD_LOGIC;
    \gen_master_slots[1].r_issuing_cnt_reg[9]\ : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \gen_master_slots[1].r_issuing_cnt_reg[9]_0\ : out STD_LOGIC;
    st_mr_bmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    \aresetn_d_reg[1]_0\ : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 0 to 0 );
    st_aa_awtarget_enc : in STD_LOGIC_VECTOR ( 0 to 0 );
    w_issuing_cnt : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \gen_single_thread.active_target_hot_reg[3]\ : in STD_LOGIC;
    m_valid_i_reg : in STD_LOGIC;
    \gen_single_thread.active_target_hot_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    r_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_1 : entity is "axi_register_slice_v2_1_9_axi_register_slice";
end ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_1;

architecture STRUCTURE of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_1 is
begin
b_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_9\
     port map (
      D(0) => D(0),
      Q(0) => Q(0),
      aclk => aclk,
      \aresetn_d_reg[0]\ => \aresetn_d_reg[0]\,
      \aresetn_d_reg[1]\ => \aresetn_d_reg[1]\,
      \aresetn_d_reg[1]_0\ => \aresetn_d_reg[1]_0\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_no_arbiter.m_target_hot_i_reg[3]\,
      \gen_single_thread.active_target_hot_reg[3]\ => \gen_single_thread.active_target_hot_reg[3]\,
      m_axi_bready(0) => m_axi_bready(0),
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_bvalid(0) => m_axi_bvalid(0),
      m_valid_i_reg_0 => m_valid_i_reg,
      s_axi_bready(0) => s_axi_bready(0),
      s_ready_i_reg_0 => p_84_out,
      st_aa_awtarget_enc(0) => st_aa_awtarget_enc(0),
      st_mr_bmesg(1 downto 0) => st_mr_bmesg(1 downto 0),
      w_issuing_cnt(2 downto 0) => w_issuing_cnt(2 downto 0)
    );
r_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_10\
     port map (
      E(0) => E(0),
      aclk => aclk,
      \aresetn_d_reg[0]\ => \aresetn_d_reg[0]\,
      \aresetn_d_reg[1]\ => \aresetn_d_reg[1]\,
      \gen_master_slots[1].r_issuing_cnt_reg[9]\(34 downto 0) => \gen_master_slots[1].r_issuing_cnt_reg[9]\(34 downto 0),
      \gen_master_slots[1].r_issuing_cnt_reg[9]_0\ => \gen_master_slots[1].r_issuing_cnt_reg[9]_0\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_no_arbiter.m_target_hot_i_reg[3]_0\,
      \gen_single_thread.active_target_hot_reg[1]\(0) => \gen_single_thread.active_target_hot_reg[1]\(0),
      m_axi_rdata(31 downto 0) => m_axi_rdata(31 downto 0),
      m_axi_rlast(0) => m_axi_rlast(0),
      \m_axi_rready[1]\ => \m_axi_rready[1]\,
      m_axi_rresp(1 downto 0) => m_axi_rresp(1 downto 0),
      m_axi_rvalid(0) => m_axi_rvalid(0),
      m_valid_i_reg_0 => p_78_out,
      r_issuing_cnt(1 downto 0) => r_issuing_cnt(1 downto 0),
      s_axi_rready(0) => s_axi_rready(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_2 is
  port (
    p_64_out : out STD_LOGIC;
    m_valid_i_reg : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_ready_i_reg : out STD_LOGIC;
    p_58_out : out STD_LOGIC;
    \m_axi_rready[2]\ : out STD_LOGIC;
    s_ready_i_reg_0 : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]_0\ : out STD_LOGIC;
    \gen_master_slots[2].r_issuing_cnt_reg[17]\ : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \gen_master_slots[2].r_issuing_cnt_reg[17]_0\ : out STD_LOGIC;
    \gen_single_thread.accept_cnt_reg[1]\ : out STD_LOGIC;
    st_mr_bmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    w_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_single_thread.active_target_hot_reg[2]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    r_issuing_cnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_2 : entity is "axi_register_slice_v2_1_9_axi_register_slice";
end ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_2;

architecture STRUCTURE of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_2 is
  signal \^m_valid_i_reg\ : STD_LOGIC;
  signal \^s_ready_i_reg\ : STD_LOGIC;
begin
  m_valid_i_reg <= \^m_valid_i_reg\;
  s_ready_i_reg <= \^s_ready_i_reg\;
b_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1_7\
     port map (
      Q(0) => Q(0),
      aclk => aclk,
      aresetn => aresetn,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_no_arbiter.m_target_hot_i_reg[3]\,
      m_axi_bready(0) => m_axi_bready(0),
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_bvalid(0) => m_axi_bvalid(0),
      m_valid_i_reg_0 => \^m_valid_i_reg\,
      s_axi_bready(0) => s_axi_bready(0),
      s_ready_i_reg_0 => p_64_out,
      s_ready_i_reg_1 => \^s_ready_i_reg\,
      s_ready_i_reg_2 => s_ready_i_reg_0,
      st_mr_bmesg(1 downto 0) => st_mr_bmesg(1 downto 0),
      w_issuing_cnt(1 downto 0) => w_issuing_cnt(1 downto 0)
    );
r_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2_8\
     port map (
      E(0) => E(0),
      aclk => aclk,
      \aresetn_d_reg[0]\ => \^s_ready_i_reg\,
      \aresetn_d_reg[1]\ => \^m_valid_i_reg\,
      \gen_master_slots[2].r_issuing_cnt_reg[17]\(34 downto 0) => \gen_master_slots[2].r_issuing_cnt_reg[17]\(34 downto 0),
      \gen_master_slots[2].r_issuing_cnt_reg[17]_0\ => \gen_master_slots[2].r_issuing_cnt_reg[17]_0\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_no_arbiter.m_target_hot_i_reg[3]_0\,
      \gen_single_thread.accept_cnt_reg[1]\ => \gen_single_thread.accept_cnt_reg[1]\,
      \gen_single_thread.active_target_hot_reg[2]\(0) => \gen_single_thread.active_target_hot_reg[2]\(0),
      m_axi_rdata(31 downto 0) => m_axi_rdata(31 downto 0),
      m_axi_rlast(0) => m_axi_rlast(0),
      \m_axi_rready[2]\ => \m_axi_rready[2]\,
      m_axi_rresp(1 downto 0) => m_axi_rresp(1 downto 0),
      m_axi_rvalid(0) => m_axi_rvalid(0),
      m_valid_i_reg_0 => p_58_out,
      r_issuing_cnt(1 downto 0) => r_issuing_cnt(1 downto 0),
      s_axi_rready(0) => s_axi_rready(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_3 is
  port (
    p_42_out : out STD_LOGIC;
    p_36_out : out STD_LOGIC;
    mi_rready_3 : out STD_LOGIC;
    mi_bready_3 : out STD_LOGIC;
    \gen_no_arbiter.m_target_hot_i_reg[3]\ : out STD_LOGIC;
    p_38_out : out STD_LOGIC;
    \gen_master_slots[3].r_issuing_cnt_reg[24]\ : out STD_LOGIC;
    st_mr_rmesg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \aresetn_d_reg[1]\ : in STD_LOGIC;
    \gen_axi.s_axi_bvalid_i_reg\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \aresetn_d_reg[0]\ : in STD_LOGIC;
    \gen_axi.s_axi_bvalid_i_reg_0\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_15_in : in STD_LOGIC;
    \s_axi_araddr[18]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_19_in : in STD_LOGIC;
    s_axi_rlast_i : in STD_LOGIC;
    \gen_no_arbiter.m_valid_i_reg\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_3 : entity is "axi_register_slice_v2_1_9_axi_register_slice";
end ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_3;

architecture STRUCTURE of ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_3 is
begin
b_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized1\
     port map (
      aclk => aclk,
      \aresetn_d_reg[0]\ => \aresetn_d_reg[0]\,
      \aresetn_d_reg[1]\ => \aresetn_d_reg[1]\,
      \gen_axi.s_axi_bvalid_i_reg\ => \gen_axi.s_axi_bvalid_i_reg\,
      \gen_axi.s_axi_bvalid_i_reg_0\ => \gen_axi.s_axi_bvalid_i_reg_0\,
      mi_bready_3 => mi_bready_3,
      p_42_out => p_42_out
    );
r_pipe: entity work.\ip_block_design_xbar_0_axi_register_slice_v2_1_9_axic_register_slice__parameterized2\
     port map (
      Q(0) => Q(0),
      aclk => aclk,
      \aresetn_d_reg[0]\ => \aresetn_d_reg[0]\,
      \aresetn_d_reg[1]\ => \aresetn_d_reg[1]\,
      \gen_master_slots[3].r_issuing_cnt_reg[24]\ => p_38_out,
      \gen_master_slots[3].r_issuing_cnt_reg[24]_0\ => \gen_master_slots[3].r_issuing_cnt_reg[24]\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_no_arbiter.m_target_hot_i_reg[3]\,
      \gen_no_arbiter.m_valid_i_reg\ => \gen_no_arbiter.m_valid_i_reg\,
      m_valid_i_reg_0 => p_36_out,
      p_15_in => p_15_in,
      p_19_in => p_19_in,
      \s_axi_araddr[18]\(0) => \s_axi_araddr[18]\(0),
      s_axi_rlast_i => s_axi_rlast_i,
      s_axi_rready(0) => s_axi_rready(0),
      \skid_buffer_reg[32]_0\ => mi_rready_3,
      st_mr_rmesg(1 downto 0) => st_mr_rmesg(1 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_wdata_router is
  port (
    \gen_single_thread.active_target_enc_reg[1]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    ss_wr_awready : out STD_LOGIC;
    \gen_axi.s_axi_wready_i_reg\ : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    st_aa_awtarget_enc : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    ss_wr_awvalid : in STD_LOGIC;
    \gen_axi.write_cs_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_awaddr[26]\ : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \s_axi_awaddr[18]\ : in STD_LOGIC;
    \s_axi_awaddr[22]\ : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    wr_tmp_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_ready_d : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_wdata_router : entity is "axi_crossbar_v2_1_10_wdata_router";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_wdata_router;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_wdata_router is
begin
wrouter_aw_fifo: entity work.ip_block_design_xbar_0_axi_data_fifo_v2_1_8_axic_reg_srl_fifo
     port map (
      SR(0) => SR(0),
      aclk => aclk,
      \gen_axi.s_axi_wready_i_reg\ => \gen_axi.s_axi_wready_i_reg\,
      \gen_axi.write_cs_reg[1]\(0) => \gen_axi.write_cs_reg[1]\(0),
      \gen_single_thread.active_target_enc_reg[1]\(0) => \gen_single_thread.active_target_enc_reg[1]\(0),
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_axi_wvalid(2 downto 0) => m_axi_wvalid(2 downto 0),
      m_ready_d(0) => m_ready_d(0),
      s_axi_awaddr(1 downto 0) => s_axi_awaddr(1 downto 0),
      \s_axi_awaddr[18]\ => \s_axi_awaddr[18]\,
      \s_axi_awaddr[22]\ => \s_axi_awaddr[22]\,
      \s_axi_awaddr[26]\ => \s_axi_awaddr[26]\,
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_wlast(0) => s_axi_wlast(0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wvalid(0) => s_axi_wvalid(0),
      s_ready_i_reg_0 => ss_wr_awready,
      ss_wr_awvalid => ss_wr_awvalid,
      st_aa_awtarget_enc(0) => st_aa_awtarget_enc(0),
      wr_tmp_wready(0) => wr_tmp_wready(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_crossbar is
  port (
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_ARREADY : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : out STD_LOGIC_VECTOR ( 56 downto 0 );
    \m_axi_arqos[3]\ : out STD_LOGIC_VECTOR ( 56 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_RREADY : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    aresetn : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 24 downto 0 );
    \s_axi_arqos[3]\ : in STD_LOGIC_VECTOR ( 56 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_crossbar : entity is "axi_crossbar_v2_1_10_crossbar";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_crossbar;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_crossbar is
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_arready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal aa_mi_artarget_hot : STD_LOGIC_VECTOR ( 3 to 3 );
  signal aa_mi_arvalid : STD_LOGIC;
  signal aa_mi_awtarget_hot : STD_LOGIC_VECTOR ( 3 to 3 );
  signal aa_sa_awvalid : STD_LOGIC;
  signal active_target_hot : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal active_target_hot_2 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal addr_arbiter_ar_n_10 : STD_LOGIC;
  signal addr_arbiter_ar_n_14 : STD_LOGIC;
  signal addr_arbiter_ar_n_15 : STD_LOGIC;
  signal addr_arbiter_ar_n_16 : STD_LOGIC;
  signal addr_arbiter_ar_n_17 : STD_LOGIC;
  signal addr_arbiter_ar_n_18 : STD_LOGIC;
  signal addr_arbiter_ar_n_21 : STD_LOGIC;
  signal addr_arbiter_ar_n_22 : STD_LOGIC;
  signal addr_arbiter_ar_n_3 : STD_LOGIC;
  signal addr_arbiter_ar_n_5 : STD_LOGIC;
  signal addr_arbiter_ar_n_6 : STD_LOGIC;
  signal addr_arbiter_ar_n_7 : STD_LOGIC;
  signal addr_arbiter_ar_n_8 : STD_LOGIC;
  signal addr_arbiter_ar_n_9 : STD_LOGIC;
  signal addr_arbiter_aw_n_10 : STD_LOGIC;
  signal addr_arbiter_aw_n_11 : STD_LOGIC;
  signal addr_arbiter_aw_n_12 : STD_LOGIC;
  signal addr_arbiter_aw_n_13 : STD_LOGIC;
  signal addr_arbiter_aw_n_14 : STD_LOGIC;
  signal addr_arbiter_aw_n_15 : STD_LOGIC;
  signal addr_arbiter_aw_n_19 : STD_LOGIC;
  signal addr_arbiter_aw_n_2 : STD_LOGIC;
  signal addr_arbiter_aw_n_21 : STD_LOGIC;
  signal addr_arbiter_aw_n_22 : STD_LOGIC;
  signal addr_arbiter_aw_n_23 : STD_LOGIC;
  signal addr_arbiter_aw_n_4 : STD_LOGIC;
  signal addr_arbiter_aw_n_5 : STD_LOGIC;
  signal addr_arbiter_aw_n_6 : STD_LOGIC;
  signal addr_arbiter_aw_n_7 : STD_LOGIC;
  signal addr_arbiter_aw_n_9 : STD_LOGIC;
  signal aresetn_d : STD_LOGIC;
  signal \gen_decerr_slave.decerr_slave_inst_n_4\ : STD_LOGIC;
  signal \gen_decerr_slave.decerr_slave_inst_n_6\ : STD_LOGIC;
  signal \gen_master_slots[0].reg_slice_mi_n_4\ : STD_LOGIC;
  signal \gen_master_slots[0].reg_slice_mi_n_42\ : STD_LOGIC;
  signal \gen_master_slots[0].reg_slice_mi_n_5\ : STD_LOGIC;
  signal \gen_master_slots[0].reg_slice_mi_n_6\ : STD_LOGIC;
  signal \gen_master_slots[1].reg_slice_mi_n_4\ : STD_LOGIC;
  signal \gen_master_slots[1].reg_slice_mi_n_41\ : STD_LOGIC;
  signal \gen_master_slots[1].reg_slice_mi_n_5\ : STD_LOGIC;
  signal \gen_master_slots[2].reg_slice_mi_n_1\ : STD_LOGIC;
  signal \gen_master_slots[2].reg_slice_mi_n_3\ : STD_LOGIC;
  signal \gen_master_slots[2].reg_slice_mi_n_44\ : STD_LOGIC;
  signal \gen_master_slots[2].reg_slice_mi_n_45\ : STD_LOGIC;
  signal \gen_master_slots[2].reg_slice_mi_n_6\ : STD_LOGIC;
  signal \gen_master_slots[2].reg_slice_mi_n_7\ : STD_LOGIC;
  signal \gen_master_slots[2].reg_slice_mi_n_8\ : STD_LOGIC;
  signal \gen_master_slots[3].reg_slice_mi_n_4\ : STD_LOGIC;
  signal \gen_master_slots[3].reg_slice_mi_n_6\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_5\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_7\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_0\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_1\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_10\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_12\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_13\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_14\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_2\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_7\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_8\ : STD_LOGIC;
  signal \gen_slave_slots[0].gen_si_write.wdata_router_w_n_2\ : STD_LOGIC;
  signal \^m_axi_arqos[3]\ : STD_LOGIC_VECTOR ( 56 downto 0 );
  signal m_ready_d : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m_ready_d_3 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mi_arready_3 : STD_LOGIC;
  signal mi_awready_3 : STD_LOGIC;
  signal mi_bready_3 : STD_LOGIC;
  signal mi_rready_3 : STD_LOGIC;
  signal p_100_out : STD_LOGIC;
  signal p_104_out : STD_LOGIC;
  signal p_15_in : STD_LOGIC;
  signal p_19_in : STD_LOGIC;
  signal p_36_out : STD_LOGIC;
  signal p_38_out : STD_LOGIC;
  signal p_42_out : STD_LOGIC;
  signal p_58_out : STD_LOGIC;
  signal p_60_out : STD_LOGIC;
  signal p_64_out : STD_LOGIC;
  signal p_78_out : STD_LOGIC;
  signal p_80_out : STD_LOGIC;
  signal p_84_out : STD_LOGIC;
  signal p_98_out : STD_LOGIC;
  signal r_issuing_cnt : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \r_pipe/p_1_in\ : STD_LOGIC;
  signal \r_pipe/p_1_in_0\ : STD_LOGIC;
  signal \r_pipe/p_1_in_1\ : STD_LOGIC;
  signal reset : STD_LOGIC;
  signal s_axi_rlast_i : STD_LOGIC;
  signal ss_aa_awready : STD_LOGIC;
  signal ss_wr_awready : STD_LOGIC;
  signal ss_wr_awvalid : STD_LOGIC;
  signal st_aa_artarget_hot : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal st_aa_awtarget_enc : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal st_aa_awtarget_hot : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal st_mr_bmesg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal st_mr_rmesg : STD_LOGIC_VECTOR ( 106 downto 0 );
  signal w_issuing_cnt : STD_LOGIC_VECTOR ( 24 downto 0 );
  signal wr_tmp_wready : STD_LOGIC_VECTOR ( 3 to 3 );
  signal write_cs : STD_LOGIC_VECTOR ( 1 to 1 );
begin
  E(0) <= \^e\(0);
  S_AXI_ARREADY(0) <= \^s_axi_arready\(0);
  \m_axi_arqos[3]\(56 downto 0) <= \^m_axi_arqos[3]\(56 downto 0);
addr_arbiter_ar: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter
     port map (
      D(1 downto 0) => st_aa_artarget_hot(1 downto 0),
      E(0) => \gen_master_slots[0].reg_slice_mi_n_4\,
      Q(0) => aa_mi_artarget_hot(3),
      SR(0) => reset,
      S_AXI_ARREADY(0) => \^s_axi_arready\(0),
      aa_mi_arvalid => aa_mi_arvalid,
      aclk => aclk,
      aresetn_d => aresetn_d,
      \gen_axi.s_axi_rlast_i_reg\ => addr_arbiter_ar_n_22,
      \gen_master_slots[0].r_issuing_cnt_reg[0]\ => addr_arbiter_ar_n_9,
      \gen_master_slots[0].r_issuing_cnt_reg[1]\ => addr_arbiter_ar_n_8,
      \gen_master_slots[1].r_issuing_cnt_reg[8]\ => addr_arbiter_ar_n_7,
      \gen_master_slots[1].r_issuing_cnt_reg[9]\ => addr_arbiter_ar_n_6,
      \gen_master_slots[2].r_issuing_cnt_reg[16]\ => addr_arbiter_ar_n_5,
      \gen_master_slots[2].r_issuing_cnt_reg[17]\ => addr_arbiter_ar_n_3,
      \gen_master_slots[3].r_issuing_cnt_reg[24]\ => addr_arbiter_ar_n_10,
      \gen_no_arbiter.m_target_hot_i_reg[0]_0\ => addr_arbiter_ar_n_16,
      \gen_no_arbiter.m_target_hot_i_reg[0]_1\ => addr_arbiter_ar_n_17,
      \gen_no_arbiter.m_target_hot_i_reg[0]_2\ => addr_arbiter_ar_n_18,
      \gen_no_arbiter.m_target_hot_i_reg[1]_0\ => addr_arbiter_ar_n_21,
      \gen_no_arbiter.m_target_hot_i_reg[3]_0\ => addr_arbiter_ar_n_15,
      \gen_no_arbiter.m_valid_i_reg_0\ => addr_arbiter_ar_n_14,
      \gen_single_thread.accept_cnt_reg[1]\ => \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_5\,
      \gen_single_thread.active_target_hot_reg[3]\ => \gen_master_slots[3].reg_slice_mi_n_4\,
      \m_axi_arqos[3]\(56 downto 0) => \^m_axi_arqos[3]\(56 downto 0),
      m_axi_arready(2 downto 0) => m_axi_arready(2 downto 0),
      m_axi_arvalid(2 downto 0) => m_axi_arvalid(2 downto 0),
      \m_payload_i_reg[34]\ => \gen_master_slots[2].reg_slice_mi_n_44\,
      \m_payload_i_reg[34]_0\ => \gen_master_slots[1].reg_slice_mi_n_41\,
      \m_payload_i_reg[34]_1\ => \gen_master_slots[0].reg_slice_mi_n_42\,
      m_valid_i_reg => \gen_master_slots[0].reg_slice_mi_n_5\,
      mi_arready_3 => mi_arready_3,
      r_issuing_cnt(5 downto 4) => r_issuing_cnt(17 downto 16),
      r_issuing_cnt(3 downto 2) => r_issuing_cnt(9 downto 8),
      r_issuing_cnt(1 downto 0) => r_issuing_cnt(1 downto 0),
      \s_axi_araddr[18]\(1) => \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_7\,
      \s_axi_araddr[18]\(0) => st_aa_artarget_hot(2),
      \s_axi_arqos[3]\(56 downto 0) => \s_axi_arqos[3]\(56 downto 0),
      s_axi_arvalid(0) => s_axi_arvalid(0)
    );
addr_arbiter_aw: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_addr_arbiter_0
     port map (
      D(1) => addr_arbiter_aw_n_2,
      D(0) => st_aa_awtarget_hot(1),
      E(0) => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_0\,
      Q(0) => aa_mi_awtarget_hot(3),
      SR(0) => reset,
      aa_sa_awvalid => aa_sa_awvalid,
      aclk => aclk,
      \gen_master_slots[0].w_issuing_cnt_reg[0]\ => addr_arbiter_aw_n_13,
      \gen_master_slots[0].w_issuing_cnt_reg[1]\ => addr_arbiter_aw_n_12,
      \gen_master_slots[1].w_issuing_cnt_reg[8]\ => addr_arbiter_aw_n_11,
      \gen_master_slots[1].w_issuing_cnt_reg[9]\ => addr_arbiter_aw_n_10,
      \gen_master_slots[2].w_issuing_cnt_reg[16]\ => addr_arbiter_aw_n_9,
      \gen_master_slots[2].w_issuing_cnt_reg[17]\ => addr_arbiter_aw_n_6,
      \gen_master_slots[2].w_issuing_cnt_reg[17]_0\ => addr_arbiter_aw_n_7,
      \gen_master_slots[3].w_issuing_cnt_reg[24]\ => addr_arbiter_aw_n_15,
      \gen_master_slots[3].w_issuing_cnt_reg[24]_0\ => addr_arbiter_aw_n_23,
      \gen_master_slots[3].w_issuing_cnt_reg[24]_1\ => \gen_master_slots[1].reg_slice_mi_n_4\,
      \gen_no_arbiter.m_target_hot_i_reg[1]_0\ => addr_arbiter_aw_n_4,
      \gen_no_arbiter.m_target_hot_i_reg[1]_1\ => addr_arbiter_aw_n_5,
      \gen_no_arbiter.m_target_hot_i_reg[3]_0\ => addr_arbiter_aw_n_21,
      \gen_no_arbiter.m_valid_i_reg_0\ => addr_arbiter_aw_n_19,
      \gen_single_thread.accept_cnt_reg[0]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_1\,
      \gen_single_thread.accept_cnt_reg[1]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_14\,
      \gen_single_thread.active_target_hot_reg[0]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_7\,
      \gen_single_thread.active_target_hot_reg[1]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_8\,
      \gen_single_thread.active_target_hot_reg[2]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_2\,
      \gen_single_thread.active_target_hot_reg[3]\(0) => active_target_hot_2(3),
      \m_axi_awqos[3]\(56 downto 0) => Q(56 downto 0),
      m_axi_awready(2 downto 0) => m_axi_awready(2 downto 0),
      m_axi_awvalid(2 downto 0) => m_axi_awvalid(2 downto 0),
      m_ready_d(1 downto 0) => m_ready_d_3(1 downto 0),
      m_ready_d_0(0) => m_ready_d(0),
      \m_ready_d_reg[1]\ => addr_arbiter_aw_n_14,
      \m_ready_d_reg[1]_0\ => addr_arbiter_aw_n_22,
      mi_awready_3 => mi_awready_3,
      p_42_out => p_42_out,
      \s_axi_awaddr[18]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_12\,
      \s_axi_awaddr[22]\(1) => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_10\,
      \s_axi_awaddr[22]\(0) => st_aa_awtarget_hot(0),
      \s_axi_awqos[3]\(56 downto 32) => D(24 downto 0),
      \s_axi_awqos[3]\(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_bready(0) => s_axi_bready(0),
      ss_aa_awready => ss_aa_awready,
      st_aa_awtarget_enc(0) => st_aa_awtarget_enc(0),
      w_issuing_cnt(6) => w_issuing_cnt(24),
      w_issuing_cnt(5 downto 4) => w_issuing_cnt(17 downto 16),
      w_issuing_cnt(3 downto 2) => w_issuing_cnt(9 downto 8),
      w_issuing_cnt(1 downto 0) => w_issuing_cnt(1 downto 0)
    );
aresetn_d_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => aresetn,
      Q => aresetn_d,
      R => '0'
    );
\gen_decerr_slave.decerr_slave_inst\: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_decerr_slave
     port map (
      Q(0) => active_target_hot_2(3),
      SR(0) => reset,
      aa_mi_arvalid => aa_mi_arvalid,
      aclk => aclk,
      aresetn_d => aresetn_d,
      \aresetn_d_reg[1]\ => \gen_master_slots[2].reg_slice_mi_n_6\,
      \gen_axi.s_axi_awready_i_reg_0\(0) => write_cs(1),
      \gen_axi.write_cs_reg[1]_0\ => \gen_slave_slots[0].gen_si_write.wdata_router_w_n_2\,
      \gen_no_arbiter.m_mesg_i_reg[35]\ => addr_arbiter_ar_n_22,
      \gen_no_arbiter.m_mesg_i_reg[40]\(7 downto 0) => \^m_axi_arqos[3]\(39 downto 32),
      \gen_no_arbiter.m_target_hot_i_reg[3]\(0) => aa_mi_artarget_hot(3),
      \gen_no_arbiter.m_target_hot_i_reg[3]_0\(0) => aa_mi_awtarget_hot(3),
      \gen_no_arbiter.m_valid_i_reg\ => addr_arbiter_ar_n_10,
      \gen_no_arbiter.m_valid_i_reg_0\ => addr_arbiter_aw_n_7,
      \m_ready_d_reg[1]\ => addr_arbiter_aw_n_15,
      m_valid_i_reg => \gen_decerr_slave.decerr_slave_inst_n_6\,
      mi_arready_3 => mi_arready_3,
      mi_awready_3 => mi_awready_3,
      mi_bready_3 => mi_bready_3,
      mi_rready_3 => mi_rready_3,
      p_19_in => p_19_in,
      p_42_out => p_42_out,
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_rlast_i => s_axi_rlast_i,
      s_ready_i_reg => \gen_decerr_slave.decerr_slave_inst_n_4\,
      wr_tmp_wready(0) => wr_tmp_wready(3)
    );
\gen_master_slots[0].r_issuing_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_ar_n_9,
      Q => r_issuing_cnt(0),
      R => reset
    );
\gen_master_slots[0].r_issuing_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_ar_n_8,
      Q => r_issuing_cnt(1),
      R => reset
    );
\gen_master_slots[0].reg_slice_mi\: entity work.ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice
     port map (
      D(2 downto 0) => st_aa_artarget_hot(2 downto 0),
      E(0) => \gen_master_slots[0].reg_slice_mi_n_4\,
      Q(0) => active_target_hot_2(0),
      aclk => aclk,
      aresetn_d => aresetn_d,
      \aresetn_d_reg[0]\ => \gen_master_slots[2].reg_slice_mi_n_3\,
      \aresetn_d_reg[1]\ => \gen_master_slots[2].reg_slice_mi_n_1\,
      \aresetn_d_reg[1]_0\ => \gen_master_slots[2].reg_slice_mi_n_6\,
      \gen_master_slots[0].r_issuing_cnt_reg[1]\(34) => p_100_out,
      \gen_master_slots[0].r_issuing_cnt_reg[1]\(33 downto 32) => st_mr_rmesg(1 downto 0),
      \gen_master_slots[0].r_issuing_cnt_reg[1]\(31 downto 0) => st_mr_rmesg(34 downto 3),
      \gen_master_slots[0].r_issuing_cnt_reg[1]_0\ => \gen_master_slots[0].reg_slice_mi_n_42\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_master_slots[0].reg_slice_mi_n_5\,
      \gen_no_arbiter.m_target_hot_i_reg[3]_0\ => \gen_master_slots[0].reg_slice_mi_n_6\,
      \gen_no_arbiter.s_ready_i_reg[0]\ => addr_arbiter_ar_n_14,
      \gen_single_thread.accept_cnt_reg[1]\ => \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_5\,
      \gen_single_thread.active_target_hot_reg[0]\(0) => active_target_hot(0),
      \gen_single_thread.active_target_hot_reg[0]_0\(0) => \r_pipe/p_1_in_1\,
      \gen_single_thread.active_target_hot_reg[3]\ => \gen_master_slots[3].reg_slice_mi_n_4\,
      m_axi_bready(0) => m_axi_bready(0),
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_bvalid(0) => m_axi_bvalid(0),
      m_axi_rdata(31 downto 0) => m_axi_rdata(31 downto 0),
      m_axi_rlast(0) => m_axi_rlast(0),
      \m_axi_rready[0]\ => M_AXI_RREADY(0),
      m_axi_rresp(1 downto 0) => m_axi_rresp(1 downto 0),
      m_axi_rvalid(0) => m_axi_rvalid(0),
      m_valid_i_reg => \gen_master_slots[2].reg_slice_mi_n_7\,
      m_valid_i_reg_0 => \gen_master_slots[1].reg_slice_mi_n_5\,
      m_valid_i_reg_1 => \gen_master_slots[2].reg_slice_mi_n_8\,
      p_104_out => p_104_out,
      p_98_out => p_98_out,
      r_issuing_cnt(1 downto 0) => r_issuing_cnt(1 downto 0),
      s_axi_awaddr(0) => s_axi_awaddr(31),
      \s_axi_awaddr[17]\ => addr_arbiter_aw_n_21,
      \s_axi_awaddr[22]\ => addr_arbiter_aw_n_4,
      \s_axi_awaddr[26]\ => addr_arbiter_aw_n_5,
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_rready(0) => s_axi_rready(0),
      st_mr_bmesg(1 downto 0) => st_mr_bmesg(1 downto 0),
      w_issuing_cnt(1 downto 0) => w_issuing_cnt(1 downto 0)
    );
\gen_master_slots[0].w_issuing_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_aw_n_13,
      Q => w_issuing_cnt(0),
      R => reset
    );
\gen_master_slots[0].w_issuing_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_aw_n_12,
      Q => w_issuing_cnt(1),
      R => reset
    );
\gen_master_slots[1].r_issuing_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_ar_n_7,
      Q => r_issuing_cnt(8),
      R => reset
    );
\gen_master_slots[1].r_issuing_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_ar_n_6,
      Q => r_issuing_cnt(9),
      R => reset
    );
\gen_master_slots[1].reg_slice_mi\: entity work.ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_1
     port map (
      D(0) => st_aa_awtarget_hot(1),
      E(0) => \r_pipe/p_1_in_0\,
      Q(0) => active_target_hot_2(1),
      aclk => aclk,
      \aresetn_d_reg[0]\ => \gen_master_slots[2].reg_slice_mi_n_3\,
      \aresetn_d_reg[1]\ => \gen_master_slots[2].reg_slice_mi_n_1\,
      \aresetn_d_reg[1]_0\ => \gen_master_slots[2].reg_slice_mi_n_6\,
      \gen_master_slots[1].r_issuing_cnt_reg[9]\(34) => p_80_out,
      \gen_master_slots[1].r_issuing_cnt_reg[9]\(33 downto 32) => st_mr_rmesg(36 downto 35),
      \gen_master_slots[1].r_issuing_cnt_reg[9]\(31 downto 0) => st_mr_rmesg(69 downto 38),
      \gen_master_slots[1].r_issuing_cnt_reg[9]_0\ => \gen_master_slots[1].reg_slice_mi_n_41\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_master_slots[1].reg_slice_mi_n_4\,
      \gen_no_arbiter.m_target_hot_i_reg[3]_0\ => \gen_master_slots[1].reg_slice_mi_n_5\,
      \gen_single_thread.active_target_hot_reg[1]\(0) => active_target_hot(1),
      \gen_single_thread.active_target_hot_reg[3]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_13\,
      m_axi_bready(0) => m_axi_bready(1),
      m_axi_bresp(1 downto 0) => m_axi_bresp(3 downto 2),
      m_axi_bvalid(0) => m_axi_bvalid(1),
      m_axi_rdata(31 downto 0) => m_axi_rdata(63 downto 32),
      m_axi_rlast(0) => m_axi_rlast(1),
      \m_axi_rready[1]\ => M_AXI_RREADY(1),
      m_axi_rresp(1 downto 0) => m_axi_rresp(3 downto 2),
      m_axi_rvalid(0) => m_axi_rvalid(1),
      m_valid_i_reg => \gen_master_slots[0].reg_slice_mi_n_6\,
      p_78_out => p_78_out,
      p_84_out => p_84_out,
      r_issuing_cnt(1 downto 0) => r_issuing_cnt(9 downto 8),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_rready(0) => s_axi_rready(0),
      st_aa_awtarget_enc(0) => st_aa_awtarget_enc(0),
      st_mr_bmesg(1 downto 0) => st_mr_bmesg(4 downto 3),
      w_issuing_cnt(2) => w_issuing_cnt(24),
      w_issuing_cnt(1 downto 0) => w_issuing_cnt(9 downto 8)
    );
\gen_master_slots[1].w_issuing_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_aw_n_11,
      Q => w_issuing_cnt(8),
      R => reset
    );
\gen_master_slots[1].w_issuing_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_aw_n_10,
      Q => w_issuing_cnt(9),
      R => reset
    );
\gen_master_slots[2].r_issuing_cnt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_ar_n_5,
      Q => r_issuing_cnt(16),
      R => reset
    );
\gen_master_slots[2].r_issuing_cnt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_ar_n_3,
      Q => r_issuing_cnt(17),
      R => reset
    );
\gen_master_slots[2].reg_slice_mi\: entity work.ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_2
     port map (
      E(0) => \r_pipe/p_1_in\,
      Q(0) => active_target_hot_2(2),
      aclk => aclk,
      aresetn => aresetn,
      \gen_master_slots[2].r_issuing_cnt_reg[17]\(34) => p_60_out,
      \gen_master_slots[2].r_issuing_cnt_reg[17]\(33 downto 32) => st_mr_rmesg(71 downto 70),
      \gen_master_slots[2].r_issuing_cnt_reg[17]\(31 downto 0) => st_mr_rmesg(104 downto 73),
      \gen_master_slots[2].r_issuing_cnt_reg[17]_0\ => \gen_master_slots[2].reg_slice_mi_n_44\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_master_slots[2].reg_slice_mi_n_7\,
      \gen_no_arbiter.m_target_hot_i_reg[3]_0\ => \gen_master_slots[2].reg_slice_mi_n_8\,
      \gen_single_thread.accept_cnt_reg[1]\ => \gen_master_slots[2].reg_slice_mi_n_45\,
      \gen_single_thread.active_target_hot_reg[2]\(0) => active_target_hot(2),
      m_axi_bready(0) => m_axi_bready(2),
      m_axi_bresp(1 downto 0) => m_axi_bresp(5 downto 4),
      m_axi_bvalid(0) => m_axi_bvalid(2),
      m_axi_rdata(31 downto 0) => m_axi_rdata(95 downto 64),
      m_axi_rlast(0) => m_axi_rlast(2),
      \m_axi_rready[2]\ => M_AXI_RREADY(2),
      m_axi_rresp(1 downto 0) => m_axi_rresp(5 downto 4),
      m_axi_rvalid(0) => m_axi_rvalid(2),
      m_valid_i_reg => \gen_master_slots[2].reg_slice_mi_n_1\,
      p_58_out => p_58_out,
      p_64_out => p_64_out,
      r_issuing_cnt(1 downto 0) => r_issuing_cnt(17 downto 16),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_rready(0) => s_axi_rready(0),
      s_ready_i_reg => \gen_master_slots[2].reg_slice_mi_n_3\,
      s_ready_i_reg_0 => \gen_master_slots[2].reg_slice_mi_n_6\,
      st_mr_bmesg(1 downto 0) => st_mr_bmesg(7 downto 6),
      w_issuing_cnt(1 downto 0) => w_issuing_cnt(17 downto 16)
    );
\gen_master_slots[2].w_issuing_cnt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_aw_n_9,
      Q => w_issuing_cnt(16),
      R => reset
    );
\gen_master_slots[2].w_issuing_cnt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_aw_n_6,
      Q => w_issuing_cnt(17),
      R => reset
    );
\gen_master_slots[3].r_issuing_cnt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_master_slots[3].reg_slice_mi_n_6\,
      Q => p_15_in,
      R => reset
    );
\gen_master_slots[3].reg_slice_mi\: entity work.ip_block_design_xbar_0_axi_register_slice_v2_1_9_axi_register_slice_3
     port map (
      Q(0) => active_target_hot(3),
      aclk => aclk,
      \aresetn_d_reg[0]\ => \gen_master_slots[2].reg_slice_mi_n_3\,
      \aresetn_d_reg[1]\ => \gen_master_slots[2].reg_slice_mi_n_1\,
      \gen_axi.s_axi_bvalid_i_reg\ => \gen_decerr_slave.decerr_slave_inst_n_6\,
      \gen_axi.s_axi_bvalid_i_reg_0\ => \gen_decerr_slave.decerr_slave_inst_n_4\,
      \gen_master_slots[3].r_issuing_cnt_reg[24]\ => \gen_master_slots[3].reg_slice_mi_n_6\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_master_slots[3].reg_slice_mi_n_4\,
      \gen_no_arbiter.m_valid_i_reg\ => addr_arbiter_ar_n_10,
      mi_bready_3 => mi_bready_3,
      mi_rready_3 => mi_rready_3,
      p_15_in => p_15_in,
      p_19_in => p_19_in,
      p_36_out => p_36_out,
      p_38_out => p_38_out,
      p_42_out => p_42_out,
      \s_axi_araddr[18]\(0) => \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_7\,
      s_axi_rlast_i => s_axi_rlast_i,
      s_axi_rready(0) => s_axi_rready(0),
      st_mr_rmesg(1 downto 0) => st_mr_rmesg(106 downto 105)
    );
\gen_master_slots[3].w_issuing_cnt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_aw_n_23,
      Q => w_issuing_cnt(24),
      R => reset
    );
\gen_slave_slots[0].gen_si_read.si_transactor_ar\: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor
     port map (
      D(1 downto 0) => st_aa_artarget_hot(1 downto 0),
      E(0) => \^s_axi_arready\(0),
      Q(3 downto 0) => active_target_hot(3 downto 0),
      SR(0) => reset,
      aclk => aclk,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_5\,
      \gen_single_thread.active_target_hot_reg[3]_0\(1) => \gen_slave_slots[0].gen_si_read.si_transactor_ar_n_7\,
      \gen_single_thread.active_target_hot_reg[3]_0\(0) => st_aa_artarget_hot(2),
      \m_payload_i_reg[0]\(0) => \r_pipe/p_1_in_1\,
      \m_payload_i_reg[0]_0\(0) => \r_pipe/p_1_in_0\,
      \m_payload_i_reg[0]_1\(0) => \r_pipe/p_1_in\,
      \m_payload_i_reg[34]\(0) => p_60_out,
      \m_payload_i_reg[34]_0\(0) => p_80_out,
      \m_payload_i_reg[34]_1\(0) => p_100_out,
      m_valid_i_reg => \gen_master_slots[2].reg_slice_mi_n_45\,
      p_36_out => p_36_out,
      p_38_out => p_38_out,
      p_58_out => p_58_out,
      p_78_out => p_78_out,
      p_98_out => p_98_out,
      \s_axi_araddr[18]\ => addr_arbiter_ar_n_16,
      \s_axi_araddr[22]\ => addr_arbiter_ar_n_17,
      \s_axi_araddr[26]\ => addr_arbiter_ar_n_15,
      \s_axi_araddr[26]_0\ => addr_arbiter_ar_n_18,
      \s_axi_araddr[29]\ => addr_arbiter_ar_n_21,
      \s_axi_araddr[31]\(9 downto 4) => \s_axi_arqos[3]\(31 downto 26),
      \s_axi_araddr[31]\(3 downto 0) => \s_axi_arqos[3]\(19 downto 16),
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rlast(0) => s_axi_rlast(0),
      s_axi_rready(0) => s_axi_rready(0),
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid(0) => s_axi_rvalid(0),
      st_mr_rmesg(103 downto 70) => st_mr_rmesg(106 downto 73),
      st_mr_rmesg(69 downto 36) => st_mr_rmesg(71 downto 38),
      st_mr_rmesg(35 downto 2) => st_mr_rmesg(36 downto 3),
      st_mr_rmesg(1 downto 0) => st_mr_rmesg(1 downto 0)
    );
\gen_slave_slots[0].gen_si_write.si_transactor_aw\: entity work.\ip_block_design_xbar_0_axi_crossbar_v2_1_10_si_transactor__parameterized0\
     port map (
      D(1) => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_10\,
      D(0) => st_aa_awtarget_hot(0),
      E(0) => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_0\,
      Q(3 downto 0) => active_target_hot_2(3 downto 0),
      SR(0) => reset,
      aclk => aclk,
      aresetn_d => aresetn_d,
      \gen_master_slots[0].w_issuing_cnt_reg[1]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_7\,
      \gen_master_slots[1].w_issuing_cnt_reg[9]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_8\,
      \gen_master_slots[2].w_issuing_cnt_reg[17]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_2\,
      \gen_master_slots[3].w_issuing_cnt_reg[24]\ => \gen_master_slots[1].reg_slice_mi_n_4\,
      \gen_no_arbiter.m_target_hot_i_reg[3]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_1\,
      \gen_no_arbiter.m_target_hot_i_reg[3]_0\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_13\,
      \gen_no_arbiter.m_valid_i_reg\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_14\,
      \gen_single_thread.active_target_hot_reg[3]_0\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_12\,
      \m_ready_d_reg[0]\ => addr_arbiter_aw_n_19,
      \m_ready_d_reg[0]_0\(0) => \^e\(0),
      p_104_out => p_104_out,
      p_42_out => p_42_out,
      p_64_out => p_64_out,
      p_84_out => p_84_out,
      s_axi_awaddr(4) => s_axi_awaddr(31),
      s_axi_awaddr(3 downto 0) => s_axi_awaddr(19 downto 16),
      \s_axi_awaddr[22]\ => addr_arbiter_aw_n_4,
      \s_axi_awaddr[26]\ => addr_arbiter_aw_n_5,
      \s_axi_awaddr[26]_0\(1) => addr_arbiter_aw_n_2,
      \s_axi_awaddr[26]_0\(0) => st_aa_awtarget_hot(1),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid(0) => s_axi_bvalid(0),
      st_aa_awtarget_enc(1 downto 0) => st_aa_awtarget_enc(1 downto 0),
      st_mr_bmesg(5 downto 4) => st_mr_bmesg(7 downto 6),
      st_mr_bmesg(3 downto 2) => st_mr_bmesg(4 downto 3),
      st_mr_bmesg(1 downto 0) => st_mr_bmesg(1 downto 0)
    );
\gen_slave_slots[0].gen_si_write.splitter_aw_si\: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter
     port map (
      E(0) => \^e\(0),
      aclk => aclk,
      aresetn_d => aresetn_d,
      m_ready_d(1 downto 0) => m_ready_d(1 downto 0),
      s_axi_awvalid(0) => s_axi_awvalid(0),
      ss_aa_awready => ss_aa_awready,
      ss_wr_awready => ss_wr_awready,
      ss_wr_awvalid => ss_wr_awvalid
    );
\gen_slave_slots[0].gen_si_write.wdata_router_w\: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_wdata_router
     port map (
      SR(0) => reset,
      aclk => aclk,
      \gen_axi.s_axi_wready_i_reg\ => \gen_slave_slots[0].gen_si_write.wdata_router_w_n_2\,
      \gen_axi.write_cs_reg[1]\(0) => write_cs(1),
      \gen_single_thread.active_target_enc_reg[1]\(0) => st_aa_awtarget_enc(1),
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_axi_wvalid(2 downto 0) => m_axi_wvalid(2 downto 0),
      m_ready_d(0) => m_ready_d(1),
      s_axi_awaddr(1) => s_axi_awaddr(31),
      s_axi_awaddr(0) => s_axi_awaddr(16),
      \s_axi_awaddr[18]\ => \gen_slave_slots[0].gen_si_write.si_transactor_aw_n_12\,
      \s_axi_awaddr[22]\ => addr_arbiter_aw_n_4,
      \s_axi_awaddr[26]\ => addr_arbiter_aw_n_5,
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_wlast(0) => s_axi_wlast(0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wvalid(0) => s_axi_wvalid(0),
      ss_wr_awready => ss_wr_awready,
      ss_wr_awvalid => ss_wr_awvalid,
      st_aa_awtarget_enc(0) => st_aa_awtarget_enc(0),
      wr_tmp_wready(0) => wr_tmp_wready(3)
    );
splitter_aw_mi: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_splitter_4
     port map (
      aa_sa_awvalid => aa_sa_awvalid,
      aclk => aclk,
      aresetn_d => aresetn_d,
      m_ready_d(1 downto 0) => m_ready_d_3(1 downto 0),
      \m_ready_d_reg[0]_0\ => addr_arbiter_aw_n_22,
      \m_ready_d_reg[1]_0\ => addr_arbiter_aw_n_14
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_buser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_aruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_ruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_awuser : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_wlast : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wuser : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_buser : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_aruser : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_ruser : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute C_AXI_ADDR_WIDTH : integer;
  attribute C_AXI_ADDR_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 32;
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 32;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_AXI_PROTOCOL : integer;
  attribute C_AXI_PROTOCOL of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_AXI_SUPPORTS_USER_SIGNALS : integer;
  attribute C_AXI_SUPPORTS_USER_SIGNALS of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_CONNECTIVITY_MODE : integer;
  attribute C_CONNECTIVITY_MODE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_DEBUG : integer;
  attribute C_DEBUG of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "artix7";
  attribute C_M_AXI_ADDR_WIDTH : string;
  attribute C_M_AXI_ADDR_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "96'b000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000";
  attribute C_M_AXI_BASE_ADDR : string;
  attribute C_M_AXI_BASE_ADDR of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "192'b000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000010000000000000100000000000000000000000000000000000000000000000011000000000000000000000000000000";
  attribute C_M_AXI_READ_CONNECTIVITY : string;
  attribute C_M_AXI_READ_CONNECTIVITY of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "96'b000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001";
  attribute C_M_AXI_READ_ISSUING : string;
  attribute C_M_AXI_READ_ISSUING of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "96'b000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010";
  attribute C_M_AXI_SECURE : string;
  attribute C_M_AXI_SECURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "96'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_M_AXI_WRITE_CONNECTIVITY : string;
  attribute C_M_AXI_WRITE_CONNECTIVITY of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "96'b000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001";
  attribute C_M_AXI_WRITE_ISSUING : string;
  attribute C_M_AXI_WRITE_ISSUING of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "96'b000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010";
  attribute C_NUM_ADDR_RANGES : integer;
  attribute C_NUM_ADDR_RANGES of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_NUM_MASTER_SLOTS : integer;
  attribute C_NUM_MASTER_SLOTS of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 3;
  attribute C_NUM_SLAVE_SLOTS : integer;
  attribute C_NUM_SLAVE_SLOTS of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute C_R_REGISTER : integer;
  attribute C_R_REGISTER of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute C_S_AXI_ARB_PRIORITY : integer;
  attribute C_S_AXI_ARB_PRIORITY of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute C_S_AXI_BASE_ID : integer;
  attribute C_S_AXI_BASE_ID of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute C_S_AXI_READ_ACCEPTANCE : integer;
  attribute C_S_AXI_READ_ACCEPTANCE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 2;
  attribute C_S_AXI_SINGLE_THREAD : integer;
  attribute C_S_AXI_SINGLE_THREAD of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute C_S_AXI_THREAD_ID_WIDTH : integer;
  attribute C_S_AXI_THREAD_ID_WIDTH of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute C_S_AXI_WRITE_ACCEPTANCE : integer;
  attribute C_S_AXI_WRITE_ACCEPTANCE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 2;
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "yes";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "axi_crossbar_v2_1_10_axi_crossbar";
  attribute P_ADDR_DECODE : integer;
  attribute P_ADDR_DECODE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute P_AXI3 : integer;
  attribute P_AXI3 of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute P_AXI4 : integer;
  attribute P_AXI4 of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 0;
  attribute P_AXILITE : integer;
  attribute P_AXILITE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 2;
  attribute P_AXILITE_SIZE : string;
  attribute P_AXILITE_SIZE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "3'b010";
  attribute P_FAMILY : string;
  attribute P_FAMILY of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "artix7";
  attribute P_INCR : string;
  attribute P_INCR of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "2'b01";
  attribute P_LEN : integer;
  attribute P_LEN of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 8;
  attribute P_LOCK : integer;
  attribute P_LOCK of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute P_M_AXI_ERR_MODE : string;
  attribute P_M_AXI_ERR_MODE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "96'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute P_M_AXI_SUPPORTS_READ : string;
  attribute P_M_AXI_SUPPORTS_READ of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "3'b111";
  attribute P_M_AXI_SUPPORTS_WRITE : string;
  attribute P_M_AXI_SUPPORTS_WRITE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "3'b111";
  attribute P_ONES : string;
  attribute P_ONES of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "65'b11111111111111111111111111111111111111111111111111111111111111111";
  attribute P_RANGE_CHECK : integer;
  attribute P_RANGE_CHECK of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is 1;
  attribute P_S_AXI_BASE_ID : string;
  attribute P_S_AXI_BASE_ID of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "64'b0000000000000000000000000000000000000000000000000000000000000000";
  attribute P_S_AXI_HIGH_ID : string;
  attribute P_S_AXI_HIGH_ID of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "64'b0000000000000000000000000000000000000000000000000000000000000000";
  attribute P_S_AXI_SUPPORTS_READ : string;
  attribute P_S_AXI_SUPPORTS_READ of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "1'b1";
  attribute P_S_AXI_SUPPORTS_WRITE : string;
  attribute P_S_AXI_SUPPORTS_WRITE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar : entity is "1'b1";
end ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar;

architecture STRUCTURE of ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar is
  signal \<const0>\ : STD_LOGIC;
  signal \^m_axi_araddr\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^m_axi_arburst\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^m_axi_arcache\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^m_axi_arlen\ : STD_LOGIC_VECTOR ( 23 downto 16 );
  signal \^m_axi_arlock\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_axi_arprot\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^m_axi_arqos\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^m_axi_arsize\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^m_axi_awaddr\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^m_axi_awburst\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^m_axi_awcache\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^m_axi_awlen\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^m_axi_awlock\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_axi_awprot\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^m_axi_awqos\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^m_axi_awsize\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^s_axi_wdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^s_axi_wlast\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_wstrb\ : STD_LOGIC_VECTOR ( 3 downto 0 );
begin
  \^s_axi_wdata\(31 downto 0) <= s_axi_wdata(31 downto 0);
  \^s_axi_wlast\(0) <= s_axi_wlast(0);
  \^s_axi_wstrb\(3 downto 0) <= s_axi_wstrb(3 downto 0);
  m_axi_araddr(95 downto 64) <= \^m_axi_araddr\(31 downto 0);
  m_axi_araddr(63 downto 32) <= \^m_axi_araddr\(31 downto 0);
  m_axi_araddr(31 downto 0) <= \^m_axi_araddr\(31 downto 0);
  m_axi_arburst(5 downto 4) <= \^m_axi_arburst\(1 downto 0);
  m_axi_arburst(3 downto 2) <= \^m_axi_arburst\(1 downto 0);
  m_axi_arburst(1 downto 0) <= \^m_axi_arburst\(1 downto 0);
  m_axi_arcache(11 downto 8) <= \^m_axi_arcache\(3 downto 0);
  m_axi_arcache(7 downto 4) <= \^m_axi_arcache\(3 downto 0);
  m_axi_arcache(3 downto 0) <= \^m_axi_arcache\(3 downto 0);
  m_axi_arid(2) <= \<const0>\;
  m_axi_arid(1) <= \<const0>\;
  m_axi_arid(0) <= \<const0>\;
  m_axi_arlen(23 downto 16) <= \^m_axi_arlen\(23 downto 16);
  m_axi_arlen(15 downto 8) <= \^m_axi_arlen\(23 downto 16);
  m_axi_arlen(7 downto 0) <= \^m_axi_arlen\(23 downto 16);
  m_axi_arlock(2) <= \^m_axi_arlock\(0);
  m_axi_arlock(1) <= \^m_axi_arlock\(0);
  m_axi_arlock(0) <= \^m_axi_arlock\(0);
  m_axi_arprot(8 downto 6) <= \^m_axi_arprot\(2 downto 0);
  m_axi_arprot(5 downto 3) <= \^m_axi_arprot\(2 downto 0);
  m_axi_arprot(2 downto 0) <= \^m_axi_arprot\(2 downto 0);
  m_axi_arqos(11 downto 8) <= \^m_axi_arqos\(3 downto 0);
  m_axi_arqos(7 downto 4) <= \^m_axi_arqos\(3 downto 0);
  m_axi_arqos(3 downto 0) <= \^m_axi_arqos\(3 downto 0);
  m_axi_arregion(11) <= \<const0>\;
  m_axi_arregion(10) <= \<const0>\;
  m_axi_arregion(9) <= \<const0>\;
  m_axi_arregion(8) <= \<const0>\;
  m_axi_arregion(7) <= \<const0>\;
  m_axi_arregion(6) <= \<const0>\;
  m_axi_arregion(5) <= \<const0>\;
  m_axi_arregion(4) <= \<const0>\;
  m_axi_arregion(3) <= \<const0>\;
  m_axi_arregion(2) <= \<const0>\;
  m_axi_arregion(1) <= \<const0>\;
  m_axi_arregion(0) <= \<const0>\;
  m_axi_arsize(8 downto 6) <= \^m_axi_arsize\(2 downto 0);
  m_axi_arsize(5 downto 3) <= \^m_axi_arsize\(2 downto 0);
  m_axi_arsize(2 downto 0) <= \^m_axi_arsize\(2 downto 0);
  m_axi_aruser(2) <= \<const0>\;
  m_axi_aruser(1) <= \<const0>\;
  m_axi_aruser(0) <= \<const0>\;
  m_axi_awaddr(95 downto 64) <= \^m_axi_awaddr\(31 downto 0);
  m_axi_awaddr(63 downto 32) <= \^m_axi_awaddr\(31 downto 0);
  m_axi_awaddr(31 downto 0) <= \^m_axi_awaddr\(31 downto 0);
  m_axi_awburst(5 downto 4) <= \^m_axi_awburst\(1 downto 0);
  m_axi_awburst(3 downto 2) <= \^m_axi_awburst\(1 downto 0);
  m_axi_awburst(1 downto 0) <= \^m_axi_awburst\(1 downto 0);
  m_axi_awcache(11 downto 8) <= \^m_axi_awcache\(3 downto 0);
  m_axi_awcache(7 downto 4) <= \^m_axi_awcache\(3 downto 0);
  m_axi_awcache(3 downto 0) <= \^m_axi_awcache\(3 downto 0);
  m_axi_awid(2) <= \<const0>\;
  m_axi_awid(1) <= \<const0>\;
  m_axi_awid(0) <= \<const0>\;
  m_axi_awlen(23 downto 16) <= \^m_axi_awlen\(7 downto 0);
  m_axi_awlen(15 downto 8) <= \^m_axi_awlen\(7 downto 0);
  m_axi_awlen(7 downto 0) <= \^m_axi_awlen\(7 downto 0);
  m_axi_awlock(2) <= \^m_axi_awlock\(0);
  m_axi_awlock(1) <= \^m_axi_awlock\(0);
  m_axi_awlock(0) <= \^m_axi_awlock\(0);
  m_axi_awprot(8 downto 6) <= \^m_axi_awprot\(2 downto 0);
  m_axi_awprot(5 downto 3) <= \^m_axi_awprot\(2 downto 0);
  m_axi_awprot(2 downto 0) <= \^m_axi_awprot\(2 downto 0);
  m_axi_awqos(11 downto 8) <= \^m_axi_awqos\(3 downto 0);
  m_axi_awqos(7 downto 4) <= \^m_axi_awqos\(3 downto 0);
  m_axi_awqos(3 downto 0) <= \^m_axi_awqos\(3 downto 0);
  m_axi_awregion(11) <= \<const0>\;
  m_axi_awregion(10) <= \<const0>\;
  m_axi_awregion(9) <= \<const0>\;
  m_axi_awregion(8) <= \<const0>\;
  m_axi_awregion(7) <= \<const0>\;
  m_axi_awregion(6) <= \<const0>\;
  m_axi_awregion(5) <= \<const0>\;
  m_axi_awregion(4) <= \<const0>\;
  m_axi_awregion(3) <= \<const0>\;
  m_axi_awregion(2) <= \<const0>\;
  m_axi_awregion(1) <= \<const0>\;
  m_axi_awregion(0) <= \<const0>\;
  m_axi_awsize(8 downto 6) <= \^m_axi_awsize\(2 downto 0);
  m_axi_awsize(5 downto 3) <= \^m_axi_awsize\(2 downto 0);
  m_axi_awsize(2 downto 0) <= \^m_axi_awsize\(2 downto 0);
  m_axi_awuser(2) <= \<const0>\;
  m_axi_awuser(1) <= \<const0>\;
  m_axi_awuser(0) <= \<const0>\;
  m_axi_wdata(95 downto 64) <= \^s_axi_wdata\(31 downto 0);
  m_axi_wdata(63 downto 32) <= \^s_axi_wdata\(31 downto 0);
  m_axi_wdata(31 downto 0) <= \^s_axi_wdata\(31 downto 0);
  m_axi_wid(2) <= \<const0>\;
  m_axi_wid(1) <= \<const0>\;
  m_axi_wid(0) <= \<const0>\;
  m_axi_wlast(2) <= \^s_axi_wlast\(0);
  m_axi_wlast(1) <= \^s_axi_wlast\(0);
  m_axi_wlast(0) <= \^s_axi_wlast\(0);
  m_axi_wstrb(11 downto 8) <= \^s_axi_wstrb\(3 downto 0);
  m_axi_wstrb(7 downto 4) <= \^s_axi_wstrb\(3 downto 0);
  m_axi_wstrb(3 downto 0) <= \^s_axi_wstrb\(3 downto 0);
  m_axi_wuser(2) <= \<const0>\;
  m_axi_wuser(1) <= \<const0>\;
  m_axi_wuser(0) <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_buser(0) <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_ruser(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\gen_samd.crossbar_samd\: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_crossbar
     port map (
      D(24 downto 21) => s_axi_awqos(3 downto 0),
      D(20 downto 17) => s_axi_awcache(3 downto 0),
      D(16 downto 15) => s_axi_awburst(1 downto 0),
      D(14 downto 12) => s_axi_awprot(2 downto 0),
      D(11) => s_axi_awlock(0),
      D(10 downto 8) => s_axi_awsize(2 downto 0),
      D(7 downto 0) => s_axi_awlen(7 downto 0),
      E(0) => s_axi_awready(0),
      M_AXI_RREADY(2 downto 0) => m_axi_rready(2 downto 0),
      Q(56 downto 53) => \^m_axi_awqos\(3 downto 0),
      Q(52 downto 49) => \^m_axi_awcache\(3 downto 0),
      Q(48 downto 47) => \^m_axi_awburst\(1 downto 0),
      Q(46 downto 44) => \^m_axi_awprot\(2 downto 0),
      Q(43) => \^m_axi_awlock\(0),
      Q(42 downto 40) => \^m_axi_awsize\(2 downto 0),
      Q(39 downto 32) => \^m_axi_awlen\(7 downto 0),
      Q(31 downto 0) => \^m_axi_awaddr\(31 downto 0),
      S_AXI_ARREADY(0) => s_axi_arready(0),
      aclk => aclk,
      aresetn => aresetn,
      \m_axi_arqos[3]\(56 downto 53) => \^m_axi_arqos\(3 downto 0),
      \m_axi_arqos[3]\(52 downto 49) => \^m_axi_arcache\(3 downto 0),
      \m_axi_arqos[3]\(48 downto 47) => \^m_axi_arburst\(1 downto 0),
      \m_axi_arqos[3]\(46 downto 44) => \^m_axi_arprot\(2 downto 0),
      \m_axi_arqos[3]\(43) => \^m_axi_arlock\(0),
      \m_axi_arqos[3]\(42 downto 40) => \^m_axi_arsize\(2 downto 0),
      \m_axi_arqos[3]\(39 downto 32) => \^m_axi_arlen\(23 downto 16),
      \m_axi_arqos[3]\(31 downto 0) => \^m_axi_araddr\(31 downto 0),
      m_axi_arready(2 downto 0) => m_axi_arready(2 downto 0),
      m_axi_arvalid(2 downto 0) => m_axi_arvalid(2 downto 0),
      m_axi_awready(2 downto 0) => m_axi_awready(2 downto 0),
      m_axi_awvalid(2 downto 0) => m_axi_awvalid(2 downto 0),
      m_axi_bready(2 downto 0) => m_axi_bready(2 downto 0),
      m_axi_bresp(5 downto 0) => m_axi_bresp(5 downto 0),
      m_axi_bvalid(2 downto 0) => m_axi_bvalid(2 downto 0),
      m_axi_rdata(95 downto 0) => m_axi_rdata(95 downto 0),
      m_axi_rlast(2 downto 0) => m_axi_rlast(2 downto 0),
      m_axi_rresp(5 downto 0) => m_axi_rresp(5 downto 0),
      m_axi_rvalid(2 downto 0) => m_axi_rvalid(2 downto 0),
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_axi_wvalid(2 downto 0) => m_axi_wvalid(2 downto 0),
      \s_axi_arqos[3]\(56 downto 53) => s_axi_arqos(3 downto 0),
      \s_axi_arqos[3]\(52 downto 49) => s_axi_arcache(3 downto 0),
      \s_axi_arqos[3]\(48 downto 47) => s_axi_arburst(1 downto 0),
      \s_axi_arqos[3]\(46 downto 44) => s_axi_arprot(2 downto 0),
      \s_axi_arqos[3]\(43) => s_axi_arlock(0),
      \s_axi_arqos[3]\(42 downto 40) => s_axi_arsize(2 downto 0),
      \s_axi_arqos[3]\(39 downto 32) => s_axi_arlen(7 downto 0),
      \s_axi_arqos[3]\(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arvalid(0) => s_axi_arvalid(0),
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid(0) => s_axi_bvalid(0),
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rlast(0) => s_axi_rlast(0),
      s_axi_rready(0) => s_axi_rready(0),
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid(0) => s_axi_rvalid(0),
      s_axi_wlast(0) => \^s_axi_wlast\(0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wvalid(0) => s_axi_wvalid(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_xbar_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_wlast : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_block_design_xbar_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_block_design_xbar_0 : entity is "ip_block_design_xbar_0,axi_crossbar_v2_1_10_axi_crossbar,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_block_design_xbar_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ip_block_design_xbar_0 : entity is "axi_crossbar_v2_1_10_axi_crossbar,Vivado 2016.2";
end ip_block_design_xbar_0;

architecture STRUCTURE of ip_block_design_xbar_0 is
  signal NLW_inst_m_axi_arid_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_aruser_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_awid_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_awuser_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_wid_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_wuser_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_buser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_ruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute C_AXI_ADDR_WIDTH : integer;
  attribute C_AXI_ADDR_WIDTH of inst : label is 32;
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of inst : label is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of inst : label is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of inst : label is 1;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of inst : label is 32;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of inst : label is 1;
  attribute C_AXI_PROTOCOL : integer;
  attribute C_AXI_PROTOCOL of inst : label is 0;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of inst : label is 1;
  attribute C_AXI_SUPPORTS_USER_SIGNALS : integer;
  attribute C_AXI_SUPPORTS_USER_SIGNALS of inst : label is 0;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of inst : label is 1;
  attribute C_CONNECTIVITY_MODE : integer;
  attribute C_CONNECTIVITY_MODE of inst : label is 1;
  attribute C_DEBUG : integer;
  attribute C_DEBUG of inst : label is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "artix7";
  attribute C_M_AXI_ADDR_WIDTH : string;
  attribute C_M_AXI_ADDR_WIDTH of inst : label is "96'b000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000";
  attribute C_M_AXI_BASE_ADDR : string;
  attribute C_M_AXI_BASE_ADDR of inst : label is "192'b000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000010000000000000100000000000000000000000000000000000000000000000011000000000000000000000000000000";
  attribute C_M_AXI_READ_CONNECTIVITY : string;
  attribute C_M_AXI_READ_CONNECTIVITY of inst : label is "96'b000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001";
  attribute C_M_AXI_READ_ISSUING : string;
  attribute C_M_AXI_READ_ISSUING of inst : label is "96'b000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010";
  attribute C_M_AXI_SECURE : string;
  attribute C_M_AXI_SECURE of inst : label is "96'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_M_AXI_WRITE_CONNECTIVITY : string;
  attribute C_M_AXI_WRITE_CONNECTIVITY of inst : label is "96'b000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001";
  attribute C_M_AXI_WRITE_ISSUING : string;
  attribute C_M_AXI_WRITE_ISSUING of inst : label is "96'b000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010";
  attribute C_NUM_ADDR_RANGES : integer;
  attribute C_NUM_ADDR_RANGES of inst : label is 1;
  attribute C_NUM_MASTER_SLOTS : integer;
  attribute C_NUM_MASTER_SLOTS of inst : label is 3;
  attribute C_NUM_SLAVE_SLOTS : integer;
  attribute C_NUM_SLAVE_SLOTS of inst : label is 1;
  attribute C_R_REGISTER : integer;
  attribute C_R_REGISTER of inst : label is 0;
  attribute C_S_AXI_ARB_PRIORITY : integer;
  attribute C_S_AXI_ARB_PRIORITY of inst : label is 0;
  attribute C_S_AXI_BASE_ID : integer;
  attribute C_S_AXI_BASE_ID of inst : label is 0;
  attribute C_S_AXI_READ_ACCEPTANCE : integer;
  attribute C_S_AXI_READ_ACCEPTANCE of inst : label is 2;
  attribute C_S_AXI_SINGLE_THREAD : integer;
  attribute C_S_AXI_SINGLE_THREAD of inst : label is 0;
  attribute C_S_AXI_THREAD_ID_WIDTH : integer;
  attribute C_S_AXI_THREAD_ID_WIDTH of inst : label is 0;
  attribute C_S_AXI_WRITE_ACCEPTANCE : integer;
  attribute C_S_AXI_WRITE_ACCEPTANCE of inst : label is 2;
  attribute DowngradeIPIdentifiedWarnings of inst : label is "yes";
  attribute P_ADDR_DECODE : integer;
  attribute P_ADDR_DECODE of inst : label is 1;
  attribute P_AXI3 : integer;
  attribute P_AXI3 of inst : label is 1;
  attribute P_AXI4 : integer;
  attribute P_AXI4 of inst : label is 0;
  attribute P_AXILITE : integer;
  attribute P_AXILITE of inst : label is 2;
  attribute P_AXILITE_SIZE : string;
  attribute P_AXILITE_SIZE of inst : label is "3'b010";
  attribute P_FAMILY : string;
  attribute P_FAMILY of inst : label is "artix7";
  attribute P_INCR : string;
  attribute P_INCR of inst : label is "2'b01";
  attribute P_LEN : integer;
  attribute P_LEN of inst : label is 8;
  attribute P_LOCK : integer;
  attribute P_LOCK of inst : label is 1;
  attribute P_M_AXI_ERR_MODE : string;
  attribute P_M_AXI_ERR_MODE of inst : label is "96'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute P_M_AXI_SUPPORTS_READ : string;
  attribute P_M_AXI_SUPPORTS_READ of inst : label is "3'b111";
  attribute P_M_AXI_SUPPORTS_WRITE : string;
  attribute P_M_AXI_SUPPORTS_WRITE of inst : label is "3'b111";
  attribute P_ONES : string;
  attribute P_ONES of inst : label is "65'b11111111111111111111111111111111111111111111111111111111111111111";
  attribute P_RANGE_CHECK : integer;
  attribute P_RANGE_CHECK of inst : label is 1;
  attribute P_S_AXI_BASE_ID : string;
  attribute P_S_AXI_BASE_ID of inst : label is "64'b0000000000000000000000000000000000000000000000000000000000000000";
  attribute P_S_AXI_HIGH_ID : string;
  attribute P_S_AXI_HIGH_ID of inst : label is "64'b0000000000000000000000000000000000000000000000000000000000000000";
  attribute P_S_AXI_SUPPORTS_READ : string;
  attribute P_S_AXI_SUPPORTS_READ of inst : label is "1'b1";
  attribute P_S_AXI_SUPPORTS_WRITE : string;
  attribute P_S_AXI_SUPPORTS_WRITE of inst : label is "1'b1";
begin
inst: entity work.ip_block_design_xbar_0_axi_crossbar_v2_1_10_axi_crossbar
     port map (
      aclk => aclk,
      aresetn => aresetn,
      m_axi_araddr(95 downto 0) => m_axi_araddr(95 downto 0),
      m_axi_arburst(5 downto 0) => m_axi_arburst(5 downto 0),
      m_axi_arcache(11 downto 0) => m_axi_arcache(11 downto 0),
      m_axi_arid(2 downto 0) => NLW_inst_m_axi_arid_UNCONNECTED(2 downto 0),
      m_axi_arlen(23 downto 0) => m_axi_arlen(23 downto 0),
      m_axi_arlock(2 downto 0) => m_axi_arlock(2 downto 0),
      m_axi_arprot(8 downto 0) => m_axi_arprot(8 downto 0),
      m_axi_arqos(11 downto 0) => m_axi_arqos(11 downto 0),
      m_axi_arready(2 downto 0) => m_axi_arready(2 downto 0),
      m_axi_arregion(11 downto 0) => m_axi_arregion(11 downto 0),
      m_axi_arsize(8 downto 0) => m_axi_arsize(8 downto 0),
      m_axi_aruser(2 downto 0) => NLW_inst_m_axi_aruser_UNCONNECTED(2 downto 0),
      m_axi_arvalid(2 downto 0) => m_axi_arvalid(2 downto 0),
      m_axi_awaddr(95 downto 0) => m_axi_awaddr(95 downto 0),
      m_axi_awburst(5 downto 0) => m_axi_awburst(5 downto 0),
      m_axi_awcache(11 downto 0) => m_axi_awcache(11 downto 0),
      m_axi_awid(2 downto 0) => NLW_inst_m_axi_awid_UNCONNECTED(2 downto 0),
      m_axi_awlen(23 downto 0) => m_axi_awlen(23 downto 0),
      m_axi_awlock(2 downto 0) => m_axi_awlock(2 downto 0),
      m_axi_awprot(8 downto 0) => m_axi_awprot(8 downto 0),
      m_axi_awqos(11 downto 0) => m_axi_awqos(11 downto 0),
      m_axi_awready(2 downto 0) => m_axi_awready(2 downto 0),
      m_axi_awregion(11 downto 0) => m_axi_awregion(11 downto 0),
      m_axi_awsize(8 downto 0) => m_axi_awsize(8 downto 0),
      m_axi_awuser(2 downto 0) => NLW_inst_m_axi_awuser_UNCONNECTED(2 downto 0),
      m_axi_awvalid(2 downto 0) => m_axi_awvalid(2 downto 0),
      m_axi_bid(2 downto 0) => B"000",
      m_axi_bready(2 downto 0) => m_axi_bready(2 downto 0),
      m_axi_bresp(5 downto 0) => m_axi_bresp(5 downto 0),
      m_axi_buser(2 downto 0) => B"000",
      m_axi_bvalid(2 downto 0) => m_axi_bvalid(2 downto 0),
      m_axi_rdata(95 downto 0) => m_axi_rdata(95 downto 0),
      m_axi_rid(2 downto 0) => B"000",
      m_axi_rlast(2 downto 0) => m_axi_rlast(2 downto 0),
      m_axi_rready(2 downto 0) => m_axi_rready(2 downto 0),
      m_axi_rresp(5 downto 0) => m_axi_rresp(5 downto 0),
      m_axi_ruser(2 downto 0) => B"000",
      m_axi_rvalid(2 downto 0) => m_axi_rvalid(2 downto 0),
      m_axi_wdata(95 downto 0) => m_axi_wdata(95 downto 0),
      m_axi_wid(2 downto 0) => NLW_inst_m_axi_wid_UNCONNECTED(2 downto 0),
      m_axi_wlast(2 downto 0) => m_axi_wlast(2 downto 0),
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_axi_wstrb(11 downto 0) => m_axi_wstrb(11 downto 0),
      m_axi_wuser(2 downto 0) => NLW_inst_m_axi_wuser_UNCONNECTED(2 downto 0),
      m_axi_wvalid(2 downto 0) => m_axi_wvalid(2 downto 0),
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_arcache(3 downto 0) => s_axi_arcache(3 downto 0),
      s_axi_arid(0) => '0',
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arlock(0) => s_axi_arlock(0),
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arqos(3 downto 0) => s_axi_arqos(3 downto 0),
      s_axi_arready(0) => s_axi_arready(0),
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_aruser(0) => '0',
      s_axi_arvalid(0) => s_axi_arvalid(0),
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awcache(3 downto 0) => s_axi_awcache(3 downto 0),
      s_axi_awid(0) => '0',
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awlock(0) => s_axi_awlock(0),
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awqos(3 downto 0) => s_axi_awqos(3 downto 0),
      s_axi_awready(0) => s_axi_awready(0),
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awuser(0) => '0',
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_bid(0) => NLW_inst_s_axi_bid_UNCONNECTED(0),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_buser(0) => NLW_inst_s_axi_buser_UNCONNECTED(0),
      s_axi_bvalid(0) => s_axi_bvalid(0),
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(0) => NLW_inst_s_axi_rid_UNCONNECTED(0),
      s_axi_rlast(0) => s_axi_rlast(0),
      s_axi_rready(0) => s_axi_rready(0),
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_ruser(0) => NLW_inst_s_axi_ruser_UNCONNECTED(0),
      s_axi_rvalid(0) => s_axi_rvalid(0),
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wid(0) => '0',
      s_axi_wlast(0) => s_axi_wlast(0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wuser(0) => '0',
      s_axi_wvalid(0) => s_axi_wvalid(0)
    );
end STRUCTURE;
