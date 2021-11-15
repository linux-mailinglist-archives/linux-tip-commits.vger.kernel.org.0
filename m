Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB57C450964
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhKOQUs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 11:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKOQUq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 11:20:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897FC061714;
        Mon, 15 Nov 2021 08:17:49 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:17:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636993068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPnWIhMdZj42Z5XfWYz+N9YzQjE3cSxSV1Sd6VdJm1U=;
        b=orD8t2VtZS5Mmrz53aomoD3EjtKqSUQGlRti/3PTqqQ9YhL7oZ8x9gtsFlDasz+/6cWErU
        7tipTbl6+FbXrXz4BKQb3cs2hWF0V3CFP+IJ7KWxaPqTA2PMUcjXprUR4sN7CJQsR4CNrZ
        B38OIc+FasKpBRSOtBW+o6jQD+9aUkUI3XI6UMzZqIGwWckWzW1yhRAudKD5PlyiwBVMi0
        Dz0gvHFPNvmk3neE79zaerNE34Ll9Y1zyI7gR9vkrOAikZBql6tpSFr7hFhec+pKvA7o4j
        NY82hEugIAH8R+v9PNuO/Dk0UBZm+9koli8ha6h9vGPxjCYKghGx939qZBmYNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636993068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPnWIhMdZj42Z5XfWYz+N9YzQjE3cSxSV1Sd6VdJm1U=;
        b=MCNJqP8P3icVXI0VzNgVkT9OeshmYte/ban/N3GDqf5ZklqssqIZfBpZv6VLlf8mOIIi/w
        wF6hTBjjI7aG0KBw==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD, EDAC/amd64: Move address translation to
 AMD64 EDAC
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211028175728.121452-2-yazen.ghannam@amd.com>
References: <20211028175728.121452-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <163699306731.414.381449195214459920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     0b746e8c1e1e3fcc9e4036efe8d3ea3fd3e5d4c3
Gitweb:        https://git.kernel.org/tip/0b746e8c1e1e3fcc9e4036efe8d3ea3fd3e5d4c3
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 28 Oct 2021 17:56:56 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Nov 2021 12:36:32 +01:00

x86/MCE/AMD, EDAC/amd64: Move address translation to AMD64 EDAC

The address translation code used for current AMD systems is
non-architectural. So move it to EDAC.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211028175728.121452-2-yazen.ghannam@amd.com
---
 arch/x86/include/asm/mce.h    |   3 +-
 arch/x86/kernel/cpu/mce/amd.c | 200 +---------------------------------
 drivers/edac/amd64_edac.c     | 199 +++++++++++++++++++++++++++++++++-
 3 files changed, 199 insertions(+), 203 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 8f6395d..d58f4f2 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -345,7 +345,6 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
 enum smca_bank_types smca_get_bank_type(unsigned int bank);
 #else
 
@@ -353,8 +352,6 @@ static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
-static inline int
-umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index fc85eb1..2f35183 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -689,206 +689,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
-{
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-	/* We start from the normalized address */
-	u64 ret_addr = norm_addr;
-
-	u32 tmp;
-
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
-	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
-
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
-		goto out_err;
-
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
-		goto out_err;
-
-	/* Check if address range is valid. */
-	if (!(tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, tmp);
-		goto out_err;
-	}
-
-	lgcy_mmio_hole_en = tmp & BIT(1);
-	intlv_num_chan	  = (tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (tmp >> 8) & 0x7;
-	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
-
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
-		goto out_err;
-	}
-
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
-		goto out_err;
-
-	intlv_num_sockets = (tmp >> 8) & 0x1;
-	intlv_num_dies	  = (tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
-	intlv_addr_bit = intlv_addr_sel + 8;
-
-	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-	switch (intlv_num_chan) {
-	case 0:	intlv_num_chan = 0; break;
-	case 1: intlv_num_chan = 1; break;
-	case 3: intlv_num_chan = 2; break;
-	case 5:	intlv_num_chan = 3; break;
-	case 7:	intlv_num_chan = 4; break;
-
-	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
-		break;
-	default:
-		pr_err("%s: Invalid number of interleaved channels %d.\n",
-			__func__, intlv_num_chan);
-		goto out_err;
-	}
-
-	num_intlv_bits = intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		goto out_err;
-	}
-
-	num_intlv_bits += intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
-
-	/* Assert num_intlv_bits <= 4 */
-	if (num_intlv_bits > 4) {
-		pr_err("%s: Invalid interleave bits %d.\n",
-			__func__, num_intlv_bits);
-		goto out_err;
-	}
-
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
-
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
-			goto out_err;
-
-		cs_fabric_id = (tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (intlv_num_chan) {
-			die_id_bit = intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			cs_id	   = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
-				goto out_err;
-
-		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (tmp >> 24) & 0xF;
-			die_id_mask  = (tmp >> 8) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
-			socket_id_shift	= (tmp >> 28) & 0xF;
-			socket_id_mask	= (tmp >> 16) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
-		}
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
-	}
-
-	/* Add dram base address */
-	ret_addr += dram_base_addr;
-
-	/* If legacy MMIO hole enabled */
-	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
-			goto out_err;
-
-		dram_hole_base = tmp & GENMASK(31, 24);
-		if (ret_addr >= dram_hole_base)
-			ret_addr += (BIT_ULL(32) - dram_hole_base);
-	}
-
-	if (hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
-				(ret_addr >> 18) ^
-				(ret_addr >> 21) ^
-				(ret_addr >> 30) ^
-				cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
-			ret_addr ^= BIT(intlv_addr_bit);
-	}
-
-	/* Is calculated system address is above DRAM limit address? */
-	if (ret_addr > dram_limit_addr)
-		goto out_err;
-
-	*sys_addr = ret_addr;
-	return 0;
-
-out_err:
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(umc_normaddr_to_sysaddr);
-
 bool amd_mce_is_memory_error(struct mce *m)
 {
 	/* ErrCodeExt[20:16] */
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4fce750..d2ad9f0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -988,6 +988,205 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
+	/* We start from the normalized address */
+	u64 ret_addr = norm_addr;
+
+	u32 tmp;
+
+	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
+	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
+	u8 intlv_addr_sel, intlv_addr_bit;
+	u8 num_intlv_bits, hashed_bit;
+	u8 lgcy_mmio_hole_en, base = 0;
+	u8 cs_mask, cs_id = 0;
+	bool hash_enabled = false;
+
+	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
+	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
+		goto out_err;
+
+	/* Remove HiAddrOffset from normalized address, if enabled: */
+	if (tmp & BIT(0)) {
+		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
+
+		if (norm_addr >= hi_addr_offset) {
+			ret_addr -= hi_addr_offset;
+			base = 1;
+		}
+	}
+
+	/* Read D18F0x110 (DramBaseAddress). */
+	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
+		goto out_err;
+
+	/* Check if address range is valid. */
+	if (!(tmp & BIT(0))) {
+		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
+			__func__, tmp);
+		goto out_err;
+	}
+
+	lgcy_mmio_hole_en = tmp & BIT(1);
+	intlv_num_chan	  = (tmp >> 4) & 0xF;
+	intlv_addr_sel	  = (tmp >> 8) & 0x7;
+	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
+
+	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
+	if (intlv_addr_sel > 3) {
+		pr_err("%s: Invalid interleave address select %d.\n",
+			__func__, intlv_addr_sel);
+		goto out_err;
+	}
+
+	/* Read D18F0x114 (DramLimitAddress). */
+	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
+		goto out_err;
+
+	intlv_num_sockets = (tmp >> 8) & 0x1;
+	intlv_num_dies	  = (tmp >> 10) & 0x3;
+	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+
+	intlv_addr_bit = intlv_addr_sel + 8;
+
+	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
+	switch (intlv_num_chan) {
+	case 0:	intlv_num_chan = 0; break;
+	case 1: intlv_num_chan = 1; break;
+	case 3: intlv_num_chan = 2; break;
+	case 5:	intlv_num_chan = 3; break;
+	case 7:	intlv_num_chan = 4; break;
+
+	case 8: intlv_num_chan = 1;
+		hash_enabled = true;
+		break;
+	default:
+		pr_err("%s: Invalid number of interleaved channels %d.\n",
+			__func__, intlv_num_chan);
+		goto out_err;
+	}
+
+	num_intlv_bits = intlv_num_chan;
+
+	if (intlv_num_dies > 2) {
+		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
+			__func__, intlv_num_dies);
+		goto out_err;
+	}
+
+	num_intlv_bits += intlv_num_dies;
+
+	/* Add a bit if sockets are interleaved. */
+	num_intlv_bits += intlv_num_sockets;
+
+	/* Assert num_intlv_bits <= 4 */
+	if (num_intlv_bits > 4) {
+		pr_err("%s: Invalid interleave bits %d.\n",
+			__func__, num_intlv_bits);
+		goto out_err;
+	}
+
+	if (num_intlv_bits > 0) {
+		u64 temp_addr_x, temp_addr_i, temp_addr_y;
+		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+
+		/*
+		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
+		 * This is the fabric id for this coherent slave. Use
+		 * umc/channel# as instance id of the coherent slave
+		 * for FICAA.
+		 */
+		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
+			goto out_err;
+
+		cs_fabric_id = (tmp >> 8) & 0xFF;
+		die_id_bit   = 0;
+
+		/* If interleaved over more than 1 channel: */
+		if (intlv_num_chan) {
+			die_id_bit = intlv_num_chan;
+			cs_mask	   = (1 << die_id_bit) - 1;
+			cs_id	   = cs_fabric_id & cs_mask;
+		}
+
+		sock_id_bit = die_id_bit;
+
+		/* Read D18F1x208 (SystemFabricIdMask). */
+		if (intlv_num_dies || intlv_num_sockets)
+			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+				goto out_err;
+
+		/* If interleaved over more than 1 die. */
+		if (intlv_num_dies) {
+			sock_id_bit  = die_id_bit + intlv_num_dies;
+			die_id_shift = (tmp >> 24) & 0xF;
+			die_id_mask  = (tmp >> 8) & 0xFF;
+
+			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		}
+
+		/* If interleaved over more than 1 socket. */
+		if (intlv_num_sockets) {
+			socket_id_shift	= (tmp >> 28) & 0xF;
+			socket_id_mask	= (tmp >> 16) & 0xFF;
+
+			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+		}
+
+		/*
+		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
+		 * where III is the ID for this CS, and XXXXXXYYYYY are the
+		 * address bits from the post-interleaved address.
+		 * "num_intlv_bits" has been calculated to tell us how many "I"
+		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
+		 * there are (where "I" starts).
+		 */
+		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
+		temp_addr_i = (cs_id << intlv_addr_bit);
+		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
+		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+	}
+
+	/* Add dram base address */
+	ret_addr += dram_base_addr;
+
+	/* If legacy MMIO hole enabled */
+	if (lgcy_mmio_hole_en) {
+		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
+			goto out_err;
+
+		dram_hole_base = tmp & GENMASK(31, 24);
+		if (ret_addr >= dram_hole_base)
+			ret_addr += (BIT_ULL(32) - dram_hole_base);
+	}
+
+	if (hash_enabled) {
+		/* Save some parentheses and grab ls-bit at the end. */
+		hashed_bit =	(ret_addr >> 12) ^
+				(ret_addr >> 18) ^
+				(ret_addr >> 21) ^
+				(ret_addr >> 30) ^
+				cs_id;
+
+		hashed_bit &= BIT(0);
+
+		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
+			ret_addr ^= BIT(intlv_addr_bit);
+	}
+
+	/* Is calculated system address is above DRAM limit address? */
+	if (ret_addr > dram_limit_addr)
+		goto out_err;
+
+	*sys_addr = ret_addr;
+	return 0;
+
+out_err:
+	return -EINVAL;
+}
+
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
 
 /*
