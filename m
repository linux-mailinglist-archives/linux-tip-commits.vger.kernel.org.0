Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED3E450965
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 17:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhKOQUt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhKOQUq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 11:20:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8243C061570;
        Mon, 15 Nov 2021 08:17:48 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:17:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636993066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PT74lwun97LaEUW8CbpRMGxpjrjTU+IF5+TIr1MQ0Q=;
        b=nWltzTbi3jHy64KO7XjyF40QTcXXfxXgyg0blZ5ysRPUqECqnq7aKE0in2zM0nKiaPCkmL
        /8GQF4BIV44AX+Ebe68IZj7qjee0EZLCeasaJzJurqWcuaDwsV96mCyi/OsNxSkY18/RUY
        xMSFh40VIirAj+LCHxG1KXpI0i6O7KOnZf4QcfCipJmfssYMcuG94q2s3bCdFpIePvcte/
        /8cO41+M2NqKk4kTujfci+4rqw7CJyd8GlYEYK27vj+9TMvPdzYH7fTdRgulppczc/ZGEc
        6NXiJV9YjQhc6ykIBW0ExscaMSEvCyujF+XRE4ecpD01UKkzL84mKOyIgUyYRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636993066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PT74lwun97LaEUW8CbpRMGxpjrjTU+IF5+TIr1MQ0Q=;
        b=i1K2umT4EKbHUdV8aIMeBiFDXWrVRxUMaDQg6lnmACFBNOYJ9hv2ZSFvvNKWQ/yiPGP2Pe
        dyOtVO9Zz/V1RRBQ==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Add context struct
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211028175728.121452-5-yazen.ghannam@amd.com>
References: <20211028175728.121452-5-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <163699306501.414.7821019175868850108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     70aeb807cf8649dedbcd59b70dfc38fb89bdf1bd
Gitweb:        https://git.kernel.org/tip/70aeb807cf8649dedbcd59b70dfc38fb89bdf1bd
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 28 Oct 2021 17:56:59 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Nov 2021 12:54:16 +01:00

EDAC/amd64: Add context struct

Define an address translation context struct. This will hold values that
will be passed between multiple functions.

Save return address, Node ID, and the Instance ID number to start.
Currently, the UMC number is used as the Instance ID, but future DF
versions may use another value.

Also include a "tmp" field to use when reading registers. This is to
avoid having to define a temporary variable in multiple functions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211028175728.121452-5-yazen.ghannam@amd.com
---
 drivers/edac/amd64_edac.c | 97 +++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d41b9a0..ca0c67b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1051,13 +1051,16 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
 	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
 }
 
+struct addr_ctx {
+	u64 ret_addr;
+	u32 tmp;
+	u16 nid;
+	u8 inst_id;
+};
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-	/* We start from the normalized address */
-	u64 ret_addr = norm_addr;
-
-	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
@@ -1067,35 +1070,45 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
+	struct addr_ctx ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* Start from the normalized address */
+	ctx.ret_addr = norm_addr;
+
+	ctx.nid = nid;
+	ctx.inst_id = umc;
+
 	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
+	if (ctx.tmp & BIT(0)) {
+		u64 hi_addr_offset = (ctx.tmp & GENMASK_ULL(31, 20)) << 8;
 
 		if (norm_addr >= hi_addr_offset) {
-			ret_addr -= hi_addr_offset;
+			ctx.ret_addr -= hi_addr_offset;
 			base = 1;
 		}
 	}
 
 	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &ctx.tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
-	if (!(tmp & BIT(0))) {
+	if (!(ctx.tmp & BIT(0))) {
 		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, tmp);
+			__func__, ctx.tmp);
 		goto out_err;
 	}
 
-	lgcy_mmio_hole_en = tmp & BIT(1);
-	intlv_num_chan	  = (tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (tmp >> 8) & 0x7;
-	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
+	lgcy_mmio_hole_en = ctx.tmp & BIT(1);
+	intlv_num_chan	  = (ctx.tmp >> 4) & 0xF;
+	intlv_addr_sel	  = (ctx.tmp >> 8) & 0x7;
+	dram_base_addr	  = (ctx.tmp & GENMASK_ULL(31, 12)) << 16;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
@@ -1105,12 +1118,12 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &ctx.tmp))
 		goto out_err;
 
-	intlv_num_sockets = (tmp >> 8) & 0x1;
-	intlv_num_dies	  = (tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
+	intlv_num_dies	  = (ctx.tmp >> 10) & 0x3;
+	dram_limit_addr	  = ((ctx.tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
 
 	intlv_addr_bit = intlv_addr_sel + 8;
 
@@ -1161,10 +1174,10 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (df_indirect_read_instance(nid, 0, 0x50, umc, &tmp))
+		if (df_indirect_read_instance(nid, 0, 0x50, umc, &ctx.tmp))
 			goto out_err;
 
-		cs_fabric_id = (tmp >> 8) & 0xFF;
+		cs_fabric_id = (ctx.tmp >> 8) & 0xFF;
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
@@ -1178,22 +1191,22 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (df_indirect_read_broadcast(nid, 1, 0x208, &tmp))
+			if (df_indirect_read_broadcast(nid, 1, 0x208, &ctx.tmp))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
 			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (tmp >> 24) & 0xF;
-			die_id_mask  = (tmp >> 8) & 0xFF;
+			die_id_shift = (ctx.tmp >> 24) & 0xF;
+			die_id_mask  = (ctx.tmp >> 8) & 0xFF;
 
 			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
 		if (intlv_num_sockets) {
-			socket_id_shift	= (tmp >> 28) & 0xF;
-			socket_id_mask	= (tmp >> 16) & 0xFF;
+			socket_id_shift	= (ctx.tmp >> 28) & 0xF;
+			socket_id_mask	= (ctx.tmp >> 16) & 0xFF;
 
 			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
 		}
@@ -1206,44 +1219,44 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
+		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
 		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
+		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
 	}
 
 	/* Add dram base address */
-	ret_addr += dram_base_addr;
+	ctx.ret_addr += dram_base_addr;
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (df_indirect_read_broadcast(nid, 0, 0x104, &tmp))
+		if (df_indirect_read_broadcast(nid, 0, 0x104, &ctx.tmp))
 			goto out_err;
 
-		dram_hole_base = tmp & GENMASK(31, 24);
-		if (ret_addr >= dram_hole_base)
-			ret_addr += (BIT_ULL(32) - dram_hole_base);
+		dram_hole_base = ctx.tmp & GENMASK(31, 24);
+		if (ctx.ret_addr >= dram_hole_base)
+			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
 	if (hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
-				(ret_addr >> 18) ^
-				(ret_addr >> 21) ^
-				(ret_addr >> 30) ^
+		hashed_bit =	(ctx.ret_addr >> 12) ^
+				(ctx.ret_addr >> 18) ^
+				(ctx.ret_addr >> 21) ^
+				(ctx.ret_addr >> 30) ^
 				cs_id;
 
 		hashed_bit &= BIT(0);
 
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
-			ret_addr ^= BIT(intlv_addr_bit);
+		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
+			ctx.ret_addr ^= BIT(intlv_addr_bit);
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-	if (ret_addr > dram_limit_addr)
+	if (ctx.ret_addr > dram_limit_addr)
 		goto out_err;
 
-	*sys_addr = ret_addr;
+	*sys_addr = ctx.ret_addr;
 	return 0;
 
 out_err:
