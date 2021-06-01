Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239DC3944F9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 May 2021 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhE1P0s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 28 May 2021 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbhE1P0r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 28 May 2021 11:26:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8BC061574;
        Fri, 28 May 2021 08:25:12 -0700 (PDT)
Date:   Fri, 28 May 2021 15:25:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622215511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oo77QHgF/MrYTS+HDxOIpo4SFSpofkU0RfzmeV32RSI=;
        b=S0ffJ33shmtUsOvNhQrWk9qetclK78fSMR9czI7aAVQQWREjrfH794CCcrlVs/FSrfH5FQ
        cYbjGaCrwnm7iAM+6ai0V/V3T9K5AEBui2PLFLEj6i31lV0cnYxH6kiS+5UapzqMt5RgDf
        wfPXjhaUJuzq32JGOM6qU9cjNi73lA1fDDat0PzV8PANzy9oSudwWEL3Zk3slEKJqf/5jJ
        jVHFT85qX0yvGX4kiBwoIDjyaAvw6o+PUd0dldG4hL+AN9hsnQa6QphkhTbB3spwIcvPHF
        P5VX1AJIN4N6A8vM15LtA/NmRTxrHZgkDH8M7UH7O3TTtx1A1JI/ILHKoolEqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622215511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oo77QHgF/MrYTS+HDxOIpo4SFSpofkU0RfzmeV32RSI=;
        b=ra6EWi3Bqsj6dMEmh+FfnLQb0h0+qZi62ag+D6lNi70CZpDMMkZ3x5juH8M7Q8PjL4biwh
        sKOUr+99rBmGoYDA==
From:   "tip-bot2 for Muralidhara M K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types
Cc:     Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210526164601.66228-1-nchatrad@amd.com>
References: <20210526164601.66228-1-nchatrad@amd.com>
MIME-Version: 1.0
Message-ID: <162221551032.29796.5394705839147738528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     94a311ce248e0b53c76e110fd00511af47b72ffb
Gitweb:        https://git.kernel.org/tip/94a311ce248e0b53c76e110fd00511af47b72ffb
Author:        Muralidhara M K <muralimk@amd.com>
AuthorDate:    Wed, 26 May 2021 22:16:01 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 27 May 2021 20:08:14 +02:00

x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types

Add the (HWID, MCATYPE) tuples and names for new SMCA bank types.

Also, add their respective error descriptions to the MCE decoding module
edac_mce_amd. Also while at it, optimize the string names for some SMCA
banks.

 [ bp: Drop repeated comments, explain why UMC_V2 is a separate entry. ]

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi  <nchatrad@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20210526164601.66228-1-nchatrad@amd.com
---
 arch/x86/include/asm/mce.h    | 13 ++++--
 arch/x86/kernel/cpu/mce/amd.c | 55 ++++++++++++++++-----------
 drivers/edac/mce_amd.c        | 70 ++++++++++++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ddfb3ca..0607ec4 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -305,7 +305,7 @@ extern void apei_mce_report_mem_error(int corrected,
 /* These may be used by multiple smca_hwid_mcatypes */
 enum smca_bank_types {
 	SMCA_LS = 0,	/* Load Store */
-	SMCA_LS_V2,	/* Load Store */
+	SMCA_LS_V2,
 	SMCA_IF,	/* Instruction Fetch */
 	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_DE,	/* Decoder Unit */
@@ -314,17 +314,22 @@ enum smca_bank_types {
 	SMCA_FP,	/* Floating Point */
 	SMCA_L3_CACHE,	/* L3 Cache */
 	SMCA_CS,	/* Coherent Slave */
-	SMCA_CS_V2,	/* Coherent Slave */
+	SMCA_CS_V2,
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
+	SMCA_UMC_V2,
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
-	SMCA_PSP_V2,	/* Platform Security Processor */
+	SMCA_PSP_V2,
 	SMCA_SMU,	/* System Management Unit */
-	SMCA_SMU_V2,	/* System Management Unit */
+	SMCA_SMU_V2,
 	SMCA_MP5,	/* Microprocessor 5 Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
+	SMCA_PCIE_V2,
+	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
+	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
+	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
 	N_SMCA_BANK_TYPES
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e486f96..08831ac 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -77,27 +77,29 @@ struct smca_bank_name {
 };
 
 static struct smca_bank_name smca_names[] = {
-	[SMCA_LS]	= { "load_store",	"Load Store Unit" },
-	[SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
-	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
-	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
-	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
-	[SMCA_RESERVED]	= { "reserved",		"Reserved" },
-	[SMCA_EX]	= { "execution_unit",	"Execution Unit" },
-	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
-	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
-	[SMCA_CS]	= { "coherent_slave",	"Coherent Slave" },
-	[SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
-	[SMCA_PIE]	= { "pie",		"Power, Interrupts, etc." },
-	[SMCA_UMC]	= { "umc",		"Unified Memory Controller" },
-	[SMCA_PB]	= { "param_block",	"Parameter Block" },
-	[SMCA_PSP]	= { "psp",		"Platform Security Processor" },
-	[SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
-	[SMCA_SMU]	= { "smu",		"System Management Unit" },
-	[SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
-	[SMCA_MP5]	= { "mp5",		"Microprocessor 5 Unit" },
-	[SMCA_NBIO]	= { "nbio",		"Northbridge IO Unit" },
-	[SMCA_PCIE]	= { "pcie",		"PCI Express Unit" },
+	[SMCA_LS ... SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
+	[SMCA_IF]			= { "insn_fetch",	"Instruction Fetch Unit" },
+	[SMCA_L2_CACHE]			= { "l2_cache",		"L2 Cache" },
+	[SMCA_DE]			= { "decode_unit",	"Decode Unit" },
+	[SMCA_RESERVED]			= { "reserved",		"Reserved" },
+	[SMCA_EX]			= { "execution_unit",	"Execution Unit" },
+	[SMCA_FP]			= { "floating_point",	"Floating Point Unit" },
+	[SMCA_L3_CACHE]			= { "l3_cache",		"L3 Cache" },
+	[SMCA_CS ... SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
+	[SMCA_PIE]			= { "pie",		"Power, Interrupts, etc." },
+
+	/* UMC v2 is separate because both of them can exist in a single system. */
+	[SMCA_UMC]			= { "umc",		"Unified Memory Controller" },
+	[SMCA_UMC_V2]			= { "umc_v2",		"Unified Memory Controller v2" },
+	[SMCA_PB]			= { "param_block",	"Parameter Block" },
+	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
+	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
+	[SMCA_MP5]			= { "mp5",		"Microprocessor 5 Unit" },
+	[SMCA_NBIO]			= { "nbio",		"Northbridge IO Unit" },
+	[SMCA_PCIE ... SMCA_PCIE_V2]	= { "pcie",		"PCI Express Unit" },
+	[SMCA_XGMI_PCS]			= { "xgmi_pcs",		"Ext Global Memory Interconnect PCS Unit" },
+	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
+	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -155,6 +157,7 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
+	{ SMCA_UMC_V2,	 HWID_MCATYPE(0x96, 0x1)	},
 
 	/* Parameter Block MCA type */
 	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
@@ -175,6 +178,16 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* PCI Express Unit MCA type */
 	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0)	},
+	{ SMCA_PCIE_V2,	 HWID_MCATYPE(0x46, 0x1)	},
+
+	/* xGMI PCS MCA type */
+	{ SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)	},
+
+	/* xGMI PHY MCA type */
+	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
+
+	/* WAFL PHY MCA type */
+	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5dd905a..43ba0f9 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -323,6 +323,21 @@ static const char * const smca_umc_mce_desc[] = {
 	"AES SRAM ECC error",
 };
 
+static const char * const smca_umc2_mce_desc[] = {
+	"DRAM ECC error",
+	"Data poison error",
+	"SDP parity error",
+	"Reserved",
+	"Address/Command parity error",
+	"Write data parity error",
+	"DCQ SRAM ECC error",
+	"Reserved",
+	"Read data parity error",
+	"Rdb SRAM ECC error",
+	"RdRsp SRAM ECC error",
+	"LM32 MP errors",
+};
+
 static const char * const smca_pb_mce_desc[] = {
 	"An ECC error in the Parameter Block RAM array",
 };
@@ -400,6 +415,56 @@ static const char * const smca_pcie_mce_desc[] = {
 	"CCIX Non-okay write response with data error",
 };
 
+static const char * const smca_pcie2_mce_desc[] = {
+	"SDP Parity Error logging",
+};
+
+static const char * const smca_xgmipcs_mce_desc[] = {
+	"Data Loss Error",
+	"Training Error",
+	"Flow Control Acknowledge Error",
+	"Rx Fifo Underflow Error",
+	"Rx Fifo Overflow Error",
+	"CRC Error",
+	"BER Exceeded Error",
+	"Tx Vcid Data Error",
+	"Replay Buffer Parity Error",
+	"Data Parity Error",
+	"Replay Fifo Overflow Error",
+	"Replay FIfo Underflow Error",
+	"Elastic Fifo Overflow Error",
+	"Deskew Error",
+	"Flow Control CRC Error",
+	"Data Startup Limit Error",
+	"FC Init Timeout Error",
+	"Recovery Timeout Error",
+	"Ready Serial Timeout Error",
+	"Ready Serial Attempt Error",
+	"Recovery Attempt Error",
+	"Recovery Relock Attempt Error",
+	"Replay Attempt Error",
+	"Sync Header Error",
+	"Tx Replay Timeout Error",
+	"Rx Replay Timeout Error",
+	"LinkSub Tx Timeout Error",
+	"LinkSub Rx Timeout Error",
+	"Rx CMD Pocket Error",
+};
+
+static const char * const smca_xgmiphy_mce_desc[] = {
+	"RAM ECC Error",
+	"ARC instruction buffer parity error",
+	"ARC data buffer parity error",
+	"PHY APB error",
+};
+
+static const char * const smca_waflphy_mce_desc[] = {
+	"RAM ECC Error",
+	"ARC instruction buffer parity error",
+	"ARC data buffer parity error",
+	"PHY APB error",
+};
+
 struct smca_mce_desc {
 	const char * const *descs;
 	unsigned int num_descs;
@@ -418,6 +483,7 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_CS_V2]	= { smca_cs2_mce_desc,	ARRAY_SIZE(smca_cs2_mce_desc)	},
 	[SMCA_PIE]	= { smca_pie_mce_desc,	ARRAY_SIZE(smca_pie_mce_desc)	},
 	[SMCA_UMC]	= { smca_umc_mce_desc,	ARRAY_SIZE(smca_umc_mce_desc)	},
+	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
 	[SMCA_PB]	= { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
 	[SMCA_PSP]	= { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
 	[SMCA_PSP_V2]	= { smca_psp2_mce_desc,	ARRAY_SIZE(smca_psp2_mce_desc)	},
@@ -426,6 +492,10 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
 	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
 	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
+	[SMCA_PCIE_V2]	= { smca_pcie2_mce_desc,   ARRAY_SIZE(smca_pcie2_mce_desc)	},
+	[SMCA_XGMI_PCS]	= { smca_xgmipcs_mce_desc, ARRAY_SIZE(smca_xgmipcs_mce_desc)	},
+	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
+	[SMCA_WAFL_PHY]	= { smca_waflphy_mce_desc, ARRAY_SIZE(smca_waflphy_mce_desc)	},
 };
 
 static bool f12h_mc0_mce(u16 ec, u8 xec)
