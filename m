Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF72450962
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKOQUs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 11:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKOQUq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 11:20:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A98C061746;
        Mon, 15 Nov 2021 08:17:48 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:17:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636993066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtLv2VkbS5okETso3jOAjr/QK0xuErBref7wU1o7lL8=;
        b=suXGltxCc8nFG9DsKHRTvEGrw4OxVWN+R7GvnwN5f6mt9z0B52R0baX1i1DQyazDEpYWBD
        SJLsEyhUVrM/+k6ctQuxd0tQ3eX1qwwhA3w0tgEY6XxoIJC79Xcg6udCyDSceNmlDtqG+c
        a7ecWOVgKArllFNPWxzm+0AoK090L/IlWMMqwOzBbcrWiUu+g2+StDFnmKCQYHYoTCX+Qs
        YpfpGGlzbdRzTzSlHLjYNsyPNmFCDoY1bC51RQo9FttrGywiSJn/DgUv8JXxs8UjFu2uje
        j2669SyO1UbNwKXFSpRy9R8Rz8/Ct3Q1OZ87T60+1dGUHSzi0WfzSnvJz1LEkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636993066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtLv2VkbS5okETso3jOAjr/QK0xuErBref7wU1o7lL8=;
        b=Ux4WuhKLrFwLzkdHBwzJ38IzZ9s8SDmoye1D408DIKiKLKrPxQtHL9aAIpwrGdrT7KRoFS
        xhw7Ufxb1wxdO9AA==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Allow for DF Indirect Broadcast reads
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211028175728.121452-4-yazen.ghannam@amd.com>
References: <20211028175728.121452-4-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <163699306581.414.17847243127518017269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     448c3d6085b71aad58cd515469560ee76c982007
Gitweb:        https://git.kernel.org/tip/448c3d6085b71aad58cd515469560ee76c982007
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 28 Oct 2021 17:56:58 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Nov 2021 12:48:55 +01:00

EDAC/amd64: Allow for DF Indirect Broadcast reads

The DF Indirect Access method allows for "Broadcast" accesses in which
case no specific instance is targeted. Add support using a reserved
instance ID of 0xFF to indicate a broadcast access. Set the FICAA
register appropriately.

Define helpers functions for instance and broadcast reads and use them
where appropriate.

Drop the "amd_" prefix since these functions are all static.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211028175728.121452-4-yazen.ghannam@amd.com
---
 drivers/edac/amd64_edac.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 034d986..d41b9a0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1000,8 +1000,11 @@ static DEFINE_MUTEX(df_indirect_mutex);
  *
  * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
  * and FICAD HI registers but so far we only need the LO register.
+ *
+ * Use Instance Id 0xFF to indicate a broadcast read.
  */
-static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+#define DF_BROADCAST	0xFF
+static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
 {
 	struct pci_dev *F4;
 	u32 ficaa;
@@ -1014,7 +1017,7 @@ static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 
 	if (!F4)
 		goto out;
 
-	ficaa  = 1;
+	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;
 	ficaa |= reg & 0x3FC;
 	ficaa |= (func & 0x7) << 11;
 	ficaa |= instance_id << 16;
@@ -1038,6 +1041,16 @@ out:
 	return err;
 }
 
+static int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+{
+	return __df_indirect_read(node, func, reg, instance_id, lo);
+}
+
+static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
+{
+	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1055,7 +1068,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	bool hash_enabled = false;
 
 	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &tmp))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
@@ -1069,7 +1082,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x110 (DramBaseAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
@@ -1092,7 +1105,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x114 (DramLimitAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &tmp))
 		goto out_err;
 
 	intlv_num_sockets = (tmp >> 8) & 0x1;
@@ -1148,7 +1161,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
+		if (df_indirect_read_instance(nid, 0, 0x50, umc, &tmp))
 			goto out_err;
 
 		cs_fabric_id = (tmp >> 8) & 0xFF;
@@ -1165,7 +1178,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+			if (df_indirect_read_broadcast(nid, 1, 0x208, &tmp))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
@@ -1204,7 +1217,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
+		if (df_indirect_read_broadcast(nid, 0, 0x104, &tmp))
 			goto out_err;
 
 		dram_hole_base = tmp & GENMASK(31, 24);
