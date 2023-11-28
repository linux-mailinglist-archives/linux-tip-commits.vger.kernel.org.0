Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBA7FC1D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Nov 2023 19:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbjK1OYH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 28 Nov 2023 09:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbjK1OYH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 28 Nov 2023 09:24:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BD18D;
        Tue, 28 Nov 2023 06:24:11 -0800 (PST)
Date:   Tue, 28 Nov 2023 14:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701181450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vXtJ7ouyFa4vv/89UU1Smy7b+Uiv2Ja8kp8Rcsc4gY=;
        b=cI/6vebRNPOeCi3IV0mz97o50/btp6Pgng2UCijuYrirl4zkRMkYxrw7ffSticD+XHuqOJ
        rsECufy49rA5QOskrEcYaKDrYO5hNuQAKQEpFd7n9ql3h8WEp3KiqxPbn+lN4xaDBJ1Idn
        U2Ej9tempXdkD6LuFW8AbUuEUhgLnqQzctEvegWYBNLn5DGZLpn3CU9tHxMyKVDm9+zbIM
        RIzH2iM5ivIVrVHMuDTs3LVtAZdEPXmfeib+5pt+wUAdcTgU+nc7cxpD6UtpfwRPz5DxuU
        MRwNtdCmSfQva5UoYvA9tccMsIbp8mvSs08L36u5f7AvBC2T5zlgdtXlvkXePQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701181450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vXtJ7ouyFa4vv/89UU1Smy7b+Uiv2Ja8kp8Rcsc4gY=;
        b=BQEVf/gdJClEEe3RXXzw76QHjC/EB3dDDzw4TW7qCoyR8jDs1YzhFnCI9vAD/qRl5m4Ryg
        bjGfabf8IjDuvAAg==
From:   "tip-bot2 for Muralidhara M K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/mce_amd: Remove SMCA Extended Error code descriptions
Cc:     Muralidhara M K <muralidhara.mk@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231102114225.2006878-2-muralimk@amd.com>
References: <20231102114225.2006878-2-muralimk@amd.com>
MIME-Version: 1.0
Message-ID: <170118144939.398.4425112446206874252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     9f988030e85fafa2b03910d467302853ad29a300
Gitweb:        https://git.kernel.org/tip/9f988030e85fafa2b03910d467302853ad29a300
Author:        Muralidhara M K <muralidhara.mk@amd.com>
AuthorDate:    Thu, 02 Nov 2023 11:42:22 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 28 Nov 2023 15:17:09 +01:00

EDAC/mce_amd: Remove SMCA Extended Error code descriptions

On AMD systems with Scalable MCA each machine check error of a SMCA bank
type has an associated bit position in the bank's control (CTL)
register.

An error's bit position in the CTL register is used during error decoding
for offsetting into the corresponding bank's error description structure.
As new errors are being added in newer AMD systems for existing SMCA bank
types, the underlying SMCA architecture guarantees that the bit positions
of existing errors are not altered.

However, on some AMD systems some of the existing bit definitions in the
CTL register of SMCA bank type are reassigned without defining new HWID
and McaType. Consequently, the errors whose bit definitions have been
reassigned in the CTL register are being erroneously decoded.

Remove SMCA Extended Error Code descriptions, this avoids decoding
issues for incorrectly reassigned bits, and avoids the related
maintenance burden in the kernel. But the bank type and Extended Error
Code value for an error will continue to be printed as a convenience.

The decoding of SMCA Extended Error Code description can be done by
referring to AMD documentation or use external tools such as rasdaemon.

Offline decoding can be done using below option in rasdaemon. For example:

  $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca

Also, the user can pass particular family and model to decode the error
string.

$ rasdaemon -p --status <STATUS> --ipid <IPID> --smca --family <CPU Family>
	--model <CPU Model> --bank <BANK_NUM>

Refer to the rasdaemon commit for details:

  https://github.com/mchehab/rasdaemon/commit/932118b04a04104dfac6b8536

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20231102114225.2006878-2-muralimk@amd.com
---
 drivers/edac/mce_amd.c | 480 +----------------------------------------
 1 file changed, 480 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 28363eb..ec8b6c9 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -143,482 +143,6 @@ static const char * const mc6_mce_desc[] = {
 	"Status Register File",
 };
 
-/* Scalable MCA error strings */
-static const char * const smca_ls_mce_desc[] = {
-	"Load queue parity error",
-	"Store queue parity error",
-	"Miss address buffer payload parity error",
-	"Level 1 TLB parity error",
-	"DC Tag error type 5",
-	"DC Tag error type 6",
-	"DC Tag error type 1",
-	"Internal error type 1",
-	"Internal error type 2",
-	"System Read Data Error Thread 0",
-	"System Read Data Error Thread 1",
-	"DC Tag error type 2",
-	"DC Data error type 1 and poison consumption",
-	"DC Data error type 2",
-	"DC Data error type 3",
-	"DC Tag error type 4",
-	"Level 2 TLB parity error",
-	"PDC parity error",
-	"DC Tag error type 3",
-	"DC Tag error type 5",
-	"L2 Fill Data error",
-};
-
-static const char * const smca_ls2_mce_desc[] = {
-	"An ECC error was detected on a data cache read by a probe or victimization",
-	"An ECC error or L2 poison was detected on a data cache read by a load",
-	"An ECC error was detected on a data cache read-modify-write by a store",
-	"An ECC error or poison bit mismatch was detected on a tag read by a probe or victimization",
-	"An ECC error or poison bit mismatch was detected on a tag read by a load",
-	"An ECC error or poison bit mismatch was detected on a tag read by a store",
-	"An ECC error was detected on an EMEM read by a load",
-	"An ECC error was detected on an EMEM read-modify-write by a store",
-	"A parity error was detected in an L1 TLB entry by any access",
-	"A parity error was detected in an L2 TLB entry by any access",
-	"A parity error was detected in a PWC entry by any access",
-	"A parity error was detected in an STQ entry by any access",
-	"A parity error was detected in an LDQ entry by any access",
-	"A parity error was detected in a MAB entry by any access",
-	"A parity error was detected in an SCB entry state field by any access",
-	"A parity error was detected in an SCB entry address field by any access",
-	"A parity error was detected in an SCB entry data field by any access",
-	"A parity error was detected in a WCB entry by any access",
-	"A poisoned line was detected in an SCB entry by any access",
-	"A SystemReadDataError error was reported on read data returned from L2 for a load",
-	"A SystemReadDataError error was reported on read data returned from L2 for an SCB store",
-	"A SystemReadDataError error was reported on read data returned from L2 for a WCB store",
-	"A hardware assertion error was reported",
-	"A parity error was detected in an STLF, SCB EMEM entry or SRB store data by any access",
-};
-
-static const char * const smca_if_mce_desc[] = {
-	"Op Cache Microtag Probe Port Parity Error",
-	"IC Microtag or Full Tag Multi-hit Error",
-	"IC Full Tag Parity Error",
-	"IC Data Array Parity Error",
-	"Decoupling Queue PhysAddr Parity Error",
-	"L0 ITLB Parity Error",
-	"L1 ITLB Parity Error",
-	"L2 ITLB Parity Error",
-	"BPQ Thread 0 Snoop Parity Error",
-	"BPQ Thread 1 Snoop Parity Error",
-	"L1 BTB Multi-Match Error",
-	"L2 BTB Multi-Match Error",
-	"L2 Cache Response Poison Error",
-	"System Read Data Error",
-	"Hardware Assertion Error",
-	"L1-TLB Multi-Hit",
-	"L2-TLB Multi-Hit",
-	"BSR Parity Error",
-	"CT MCE",
-};
-
-static const char * const smca_l2_mce_desc[] = {
-	"L2M Tag Multiple-Way-Hit error",
-	"L2M Tag or State Array ECC Error",
-	"L2M Data Array ECC Error",
-	"Hardware Assert Error",
-};
-
-static const char * const smca_de_mce_desc[] = {
-	"Micro-op cache tag parity error",
-	"Micro-op cache data parity error",
-	"Instruction buffer parity error",
-	"Micro-op queue parity error",
-	"Instruction dispatch queue parity error",
-	"Fetch address FIFO parity error",
-	"Patch RAM data parity error",
-	"Patch RAM sequencer parity error",
-	"Micro-op buffer parity error",
-	"Hardware Assertion MCA Error",
-};
-
-static const char * const smca_ex_mce_desc[] = {
-	"Watchdog Timeout error",
-	"Physical register file parity error",
-	"Flag register file parity error",
-	"Immediate displacement register file parity error",
-	"Address generator payload parity error",
-	"EX payload parity error",
-	"Checkpoint queue parity error",
-	"Retire dispatch queue parity error",
-	"Retire status queue parity error",
-	"Scheduling queue parity error",
-	"Branch buffer queue parity error",
-	"Hardware Assertion error",
-	"Spec Map parity error",
-	"Retire Map parity error",
-};
-
-static const char * const smca_fp_mce_desc[] = {
-	"Physical register file (PRF) parity error",
-	"Freelist (FL) parity error",
-	"Schedule queue parity error",
-	"NSQ parity error",
-	"Retire queue (RQ) parity error",
-	"Status register file (SRF) parity error",
-	"Hardware assertion",
-};
-
-static const char * const smca_l3_mce_desc[] = {
-	"Shadow Tag Macro ECC Error",
-	"Shadow Tag Macro Multi-way-hit Error",
-	"L3M Tag ECC Error",
-	"L3M Tag Multi-way-hit Error",
-	"L3M Data ECC Error",
-	"SDP Parity Error or SystemReadDataError from XI",
-	"L3 Victim Queue Parity Error",
-	"L3 Hardware Assertion",
-};
-
-static const char * const smca_cs_mce_desc[] = {
-	"Illegal Request",
-	"Address Violation",
-	"Security Violation",
-	"Illegal Response",
-	"Unexpected Response",
-	"Request or Probe Parity Error",
-	"Read Response Parity Error",
-	"Atomic Request Parity Error",
-	"Probe Filter ECC Error",
-};
-
-static const char * const smca_cs2_mce_desc[] = {
-	"Illegal Request",
-	"Address Violation",
-	"Security Violation",
-	"Illegal Response",
-	"Unexpected Response",
-	"Request or Probe Parity Error",
-	"Read Response Parity Error",
-	"Atomic Request Parity Error",
-	"SDP read response had no match in the CS queue",
-	"Probe Filter Protocol Error",
-	"Probe Filter ECC Error",
-	"SDP read response had an unexpected RETRY error",
-	"Counter overflow error",
-	"Counter underflow error",
-};
-
-static const char * const smca_pie_mce_desc[] = {
-	"Hardware Assert",
-	"Register security violation",
-	"Link Error",
-	"Poison data consumption",
-	"A deferred error was detected in the DF"
-};
-
-static const char * const smca_umc_mce_desc[] = {
-	"DRAM ECC error",
-	"Data poison error",
-	"SDP parity error",
-	"Advanced peripheral bus error",
-	"Address/Command parity error",
-	"Write data CRC error",
-	"DCQ SRAM ECC error",
-	"AES SRAM ECC error",
-};
-
-static const char * const smca_umc2_mce_desc[] = {
-	"DRAM ECC error",
-	"Data poison error",
-	"SDP parity error",
-	"Reserved",
-	"Address/Command parity error",
-	"Write data parity error",
-	"DCQ SRAM ECC error",
-	"Reserved",
-	"Read data parity error",
-	"Rdb SRAM ECC error",
-	"RdRsp SRAM ECC error",
-	"LM32 MP errors",
-};
-
-static const char * const smca_pb_mce_desc[] = {
-	"An ECC error in the Parameter Block RAM array",
-};
-
-static const char * const smca_psp_mce_desc[] = {
-	"An ECC or parity error in a PSP RAM instance",
-};
-
-static const char * const smca_psp2_mce_desc[] = {
-	"High SRAM ECC or parity error",
-	"Low SRAM ECC or parity error",
-	"Instruction Cache Bank 0 ECC or parity error",
-	"Instruction Cache Bank 1 ECC or parity error",
-	"Instruction Tag Ram 0 parity error",
-	"Instruction Tag Ram 1 parity error",
-	"Data Cache Bank 0 ECC or parity error",
-	"Data Cache Bank 1 ECC or parity error",
-	"Data Cache Bank 2 ECC or parity error",
-	"Data Cache Bank 3 ECC or parity error",
-	"Data Tag Bank 0 parity error",
-	"Data Tag Bank 1 parity error",
-	"Data Tag Bank 2 parity error",
-	"Data Tag Bank 3 parity error",
-	"Dirty Data Ram parity error",
-	"TLB Bank 0 parity error",
-	"TLB Bank 1 parity error",
-	"System Hub Read Buffer ECC or parity error",
-};
-
-static const char * const smca_smu_mce_desc[] = {
-	"An ECC or parity error in an SMU RAM instance",
-};
-
-static const char * const smca_smu2_mce_desc[] = {
-	"High SRAM ECC or parity error",
-	"Low SRAM ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"System Hub Read Buffer ECC or parity error",
-	"PHY RAM ECC error",
-};
-
-static const char * const smca_mp5_mce_desc[] = {
-	"High SRAM ECC or parity error",
-	"Low SRAM ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-};
-
-static const char * const smca_mpdma_mce_desc[] = {
-	"Main SRAM [31:0] bank ECC or parity error",
-	"Main SRAM [63:32] bank ECC or parity error",
-	"Main SRAM [95:64] bank ECC or parity error",
-	"Main SRAM [127:96] bank ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"System Hub Read Buffer ECC or parity error",
-	"MPDMA TVF DVSEC Memory ECC or parity error",
-	"MPDMA TVF MMIO Mailbox0 ECC or parity error",
-	"MPDMA TVF MMIO Mailbox1 ECC or parity error",
-	"MPDMA TVF Doorbell Memory ECC or parity error",
-	"MPDMA TVF SDP Slave Memory 0 ECC or parity error",
-	"MPDMA TVF SDP Slave Memory 1 ECC or parity error",
-	"MPDMA TVF SDP Slave Memory 2 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 0 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 1 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 2 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 3 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 4 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 5 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 6 ECC or parity error",
-	"MPDMA PTE Command FIFO ECC or parity error",
-	"MPDMA PTE Hub Data FIFO ECC or parity error",
-	"MPDMA PTE Internal Data FIFO ECC or parity error",
-	"MPDMA PTE Command Memory DMA ECC or parity error",
-	"MPDMA PTE Command Memory Internal ECC or parity error",
-	"MPDMA PTE DMA Completion FIFO ECC or parity error",
-	"MPDMA PTE Tablewalk Completion FIFO ECC or parity error",
-	"MPDMA PTE Descriptor Completion FIFO ECC or parity error",
-	"MPDMA PTE ReadOnly Completion FIFO ECC or parity error",
-	"MPDMA PTE DirectWrite Completion FIFO ECC or parity error",
-	"SDP Watchdog Timer expired",
-};
-
-static const char * const smca_nbio_mce_desc[] = {
-	"ECC or Parity error",
-	"PCIE error",
-	"SDP ErrEvent error",
-	"SDP Egress Poison Error",
-	"IOHC Internal Poison Error",
-};
-
-static const char * const smca_pcie_mce_desc[] = {
-	"CCIX PER Message logging",
-	"CCIX Read Response with Status: Non-Data Error",
-	"CCIX Write Response with Status: Non-Data Error",
-	"CCIX Read Response with Status: Data Error",
-	"CCIX Non-okay write response with data error",
-};
-
-static const char * const smca_pcie2_mce_desc[] = {
-	"SDP Parity Error logging",
-};
-
-static const char * const smca_xgmipcs_mce_desc[] = {
-	"Data Loss Error",
-	"Training Error",
-	"Flow Control Acknowledge Error",
-	"Rx Fifo Underflow Error",
-	"Rx Fifo Overflow Error",
-	"CRC Error",
-	"BER Exceeded Error",
-	"Tx Vcid Data Error",
-	"Replay Buffer Parity Error",
-	"Data Parity Error",
-	"Replay Fifo Overflow Error",
-	"Replay Fifo Underflow Error",
-	"Elastic Fifo Overflow Error",
-	"Deskew Error",
-	"Flow Control CRC Error",
-	"Data Startup Limit Error",
-	"FC Init Timeout Error",
-	"Recovery Timeout Error",
-	"Ready Serial Timeout Error",
-	"Ready Serial Attempt Error",
-	"Recovery Attempt Error",
-	"Recovery Relock Attempt Error",
-	"Replay Attempt Error",
-	"Sync Header Error",
-	"Tx Replay Timeout Error",
-	"Rx Replay Timeout Error",
-	"LinkSub Tx Timeout Error",
-	"LinkSub Rx Timeout Error",
-	"Rx CMD Packet Error",
-};
-
-static const char * const smca_xgmiphy_mce_desc[] = {
-	"RAM ECC Error",
-	"ARC instruction buffer parity error",
-	"ARC data buffer parity error",
-	"PHY APB error",
-};
-
-static const char * const smca_nbif_mce_desc[] = {
-	"Timeout error from GMI",
-	"SRAM ECC error",
-	"NTB Error Event",
-	"SDP Parity error",
-};
-
-static const char * const smca_sata_mce_desc[] = {
-	"Parity error for port 0",
-	"Parity error for port 1",
-	"Parity error for port 2",
-	"Parity error for port 3",
-	"Parity error for port 4",
-	"Parity error for port 5",
-	"Parity error for port 6",
-	"Parity error for port 7",
-};
-
-static const char * const smca_usb_mce_desc[] = {
-	"Parity error or ECC error for S0 RAM0",
-	"Parity error or ECC error for S0 RAM1",
-	"Parity error or ECC error for S0 RAM2",
-	"Parity error for PHY RAM0",
-	"Parity error for PHY RAM1",
-	"AXI Slave Response error",
-};
-
-static const char * const smca_gmipcs_mce_desc[] = {
-	"Data Loss Error",
-	"Training Error",
-	"Replay Parity Error",
-	"Rx Fifo Underflow Error",
-	"Rx Fifo Overflow Error",
-	"CRC Error",
-	"BER Exceeded Error",
-	"Tx Fifo Underflow Error",
-	"Replay Buffer Parity Error",
-	"Tx Overflow Error",
-	"Replay Fifo Overflow Error",
-	"Replay Fifo Underflow Error",
-	"Elastic Fifo Overflow Error",
-	"Deskew Error",
-	"Offline Error",
-	"Data Startup Limit Error",
-	"FC Init Timeout Error",
-	"Recovery Timeout Error",
-	"Ready Serial Timeout Error",
-	"Ready Serial Attempt Error",
-	"Recovery Attempt Error",
-	"Recovery Relock Attempt Error",
-	"Deskew Abort Error",
-	"Rx Buffer Error",
-	"Rx LFDS Fifo Overflow Error",
-	"Rx LFDS Fifo Underflow Error",
-	"LinkSub Tx Timeout Error",
-	"LinkSub Rx Timeout Error",
-	"Rx CMD Packet Error",
-	"LFDS Training Timeout Error",
-	"LFDS FC Init Timeout Error",
-	"Data Loss Error",
-};
-
-struct smca_mce_desc {
-	const char * const *descs;
-	unsigned int num_descs;
-};
-
-static struct smca_mce_desc smca_mce_descs[] = {
-	[SMCA_LS]	= { smca_ls_mce_desc,	ARRAY_SIZE(smca_ls_mce_desc)	},
-	[SMCA_LS_V2]	= { smca_ls2_mce_desc,	ARRAY_SIZE(smca_ls2_mce_desc)	},
-	[SMCA_IF]	= { smca_if_mce_desc,	ARRAY_SIZE(smca_if_mce_desc)	},
-	[SMCA_L2_CACHE]	= { smca_l2_mce_desc,	ARRAY_SIZE(smca_l2_mce_desc)	},
-	[SMCA_DE]	= { smca_de_mce_desc,	ARRAY_SIZE(smca_de_mce_desc)	},
-	[SMCA_EX]	= { smca_ex_mce_desc,	ARRAY_SIZE(smca_ex_mce_desc)	},
-	[SMCA_FP]	= { smca_fp_mce_desc,	ARRAY_SIZE(smca_fp_mce_desc)	},
-	[SMCA_L3_CACHE]	= { smca_l3_mce_desc,	ARRAY_SIZE(smca_l3_mce_desc)	},
-	[SMCA_CS]	= { smca_cs_mce_desc,	ARRAY_SIZE(smca_cs_mce_desc)	},
-	[SMCA_CS_V2]	= { smca_cs2_mce_desc,	ARRAY_SIZE(smca_cs2_mce_desc)	},
-	[SMCA_PIE]	= { smca_pie_mce_desc,	ARRAY_SIZE(smca_pie_mce_desc)	},
-	[SMCA_UMC]	= { smca_umc_mce_desc,	ARRAY_SIZE(smca_umc_mce_desc)	},
-	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
-	[SMCA_PB]	= { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
-	[SMCA_PSP]	= { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
-	[SMCA_PSP_V2]	= { smca_psp2_mce_desc,	ARRAY_SIZE(smca_psp2_mce_desc)	},
-	[SMCA_SMU]	= { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
-	[SMCA_SMU_V2]	= { smca_smu2_mce_desc,	ARRAY_SIZE(smca_smu2_mce_desc)	},
-	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
-	[SMCA_MPDMA]	= { smca_mpdma_mce_desc,	ARRAY_SIZE(smca_mpdma_mce_desc)	},
-	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
-	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
-	[SMCA_PCIE_V2]	= { smca_pcie2_mce_desc,   ARRAY_SIZE(smca_pcie2_mce_desc)	},
-	[SMCA_XGMI_PCS]	= { smca_xgmipcs_mce_desc, ARRAY_SIZE(smca_xgmipcs_mce_desc)	},
-	/* NBIF and SHUB have the same error descriptions, for now. */
-	[SMCA_NBIF]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
-	[SMCA_SHUB]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
-	[SMCA_SATA]	= { smca_sata_mce_desc, ARRAY_SIZE(smca_sata_mce_desc)	},
-	[SMCA_USB]	= { smca_usb_mce_desc,	ARRAY_SIZE(smca_usb_mce_desc)	},
-	[SMCA_GMI_PCS]	= { smca_gmipcs_mce_desc,  ARRAY_SIZE(smca_gmipcs_mce_desc)	},
-	/* All the PHY bank types have the same error descriptions, for now. */
-	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-	[SMCA_WAFL_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-	[SMCA_GMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-};
-
 static bool f12h_mc0_mce(u16 ec, u8 xec)
 {
 	bool ret = false;
@@ -1220,10 +744,6 @@ static void decode_smca_error(struct mce *m)
 
 	pr_emerg(HW_ERR "%s Ext. Error Code: %d", smca_get_long_name(bank_type), xec);
 
-	/* Only print the decode of valid error codes */
-	if (xec < smca_mce_descs[bank_type].num_descs)
-		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
-
 	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
 	    xec == 0 && decode_dram_ecc)
 		decode_dram_ecc(topology_die_id(m->extcpu), m);
