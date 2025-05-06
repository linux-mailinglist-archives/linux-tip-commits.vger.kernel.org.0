Return-Path: <linux-tip-commits+bounces-5265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43559AAC31B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE913AE910
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A427C146;
	Tue,  6 May 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cLb8l2mp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="48n1YalE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B627BF70;
	Tue,  6 May 2025 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532479; cv=none; b=ciCGeEICWntwYBnyXW2buA/RTtuOye0SM4ZXzyQyYfnV+fZ8juoJ0txTJ41OahHqNslOdoQ7K8l8HuDS4ffVD6Bh81t+fcL9IkUcr1KdqhgVKeyLt9YSqcV/BvFkgiEJQchXaIKc7qSQeu6mqgF1RtYA+moamDEo9kJVEdFOcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532479; c=relaxed/simple;
	bh=AozbHgUnjFFmHlxsXVpfmP9D/2pqNPZ1ViDKGlIfoKE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ErSTWwq2k1WpTohVtaYw02kALmn8B/Wb9XroC38GjXonHls8XcSWR0Q64DTHTKi/Xj4RFc6ys6kW3fx1GQqOxOiwof1+S6JG4Sq9nTHU8wQL+vVi+JQ6ZX8GRJeEdMhrPUDIFoN3CP+bZdSJnF/If1BbrgZNjbWl3A+vU/Mgexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cLb8l2mp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=48n1YalE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 11:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746532472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=svfykVx/zq3dtJQeWWLNLLKxD2FUQceLBq/9f8wwR3U=;
	b=cLb8l2mpGSZN6Lwqwk5nJwGDSfBJGMaKHGEgSjwZ7u6LTRr/kXVE4KM7lqLi73JGpiRw03
	XqQyhcUE0tctgpw2D7J3ylzdkmCVQHslOJ7VPN9bz85C6/nxO607FdKosrRx/YD5fXCAjq
	0PKoZAo4bYqgkO3Nev3QLasKk94cU2CrRFSB3DrP88YoXLc9ObcuYd8hUrhHZPUhQTEIj9
	fPRhV5zxqzk3oNxlc9IJ/7WgE5XUF772hSkwJBsL3Kqsq6/JkNP+TOvsGT5912L0djwCq+
	MEmWFRq10+rmfWwqejY1+M4yKCVypm2cEjMrivkGxo3UCc00uqbsnMJv4Icheg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746532472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=svfykVx/zq3dtJQeWWLNLLKxD2FUQceLBq/9f8wwR3U=;
	b=48n1YalE+BOcZxixORNk8cKeXatjy4jbepg44/ThVPt+pIDt6DPRu3rXQGnTcooVUXmmq3
	Q5fYxZijmcdZyPBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/arch/x86: Move the <asm/amd-ibs.h> header to
 <asm/amd/ibs.h>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653247195.406.17814105641969847306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c1ab4ce3cb759f69fb9085a060e568b73e8f5cd8
Gitweb:        https://git.kernel.org/tip/c1ab4ce3cb759f69fb9085a060e568b73e8f5cd8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 06 May 2025 13:41:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 13:45:13 +02:00

tools/arch/x86: Move the <asm/amd-ibs.h> header to <asm/amd/ibs.h>

Synchronize with what we did with the kernel side header in:

  3846389c03a8 ("x86/platform/amd: Move the <asm/amd-ibs.h> header to <asm/amd/ibs.h>")

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/arch/x86/include/asm/amd-ibs.h | 153 +--------------------------
 tools/arch/x86/include/asm/amd/ibs.h | 153 ++++++++++++++++++++++++++-
 2 files changed, 153 insertions(+), 153 deletions(-)
 delete mode 100644 tools/arch/x86/include/asm/amd-ibs.h
 create mode 100644 tools/arch/x86/include/asm/amd/ibs.h

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
deleted file mode 100644
index cb1740b..0000000
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * From PPR Vol 1 for AMD Family 19h Model 01h B1
- * 55898 Rev 0.35 - Feb 5, 2021
- */
-
-#include "msr-index.h"
-
-/* IBS_OP_DATA2 DataSrc */
-#define IBS_DATA_SRC_LOC_CACHE			 2
-#define IBS_DATA_SRC_DRAM			 3
-#define IBS_DATA_SRC_REM_CACHE			 4
-#define IBS_DATA_SRC_IO				 7
-
-/* IBS_OP_DATA2 DataSrc Extension */
-#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
-#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
-#define IBS_DATA_SRC_EXT_DRAM			 3
-#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
-#define IBS_DATA_SRC_EXT_PMEM			 6
-#define IBS_DATA_SRC_EXT_IO			 7
-#define IBS_DATA_SRC_EXT_EXT_MEM		 8
-#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
-
-/*
- * IBS Hardware MSRs
- */
-
-/* MSR 0xc0011030: IBS Fetch Control */
-union ibs_fetch_ctl {
-	__u64 val;
-	struct {
-		__u64	fetch_maxcnt:16,/* 0-15: instruction fetch max. count */
-			fetch_cnt:16,	/* 16-31: instruction fetch count */
-			fetch_lat:16,	/* 32-47: instruction fetch latency */
-			fetch_en:1,	/* 48: instruction fetch enable */
-			fetch_val:1,	/* 49: instruction fetch valid */
-			fetch_comp:1,	/* 50: instruction fetch complete */
-			ic_miss:1,	/* 51: i-cache miss */
-			phy_addr_valid:1,/* 52: physical address valid */
-			l1tlb_pgsz:2,	/* 53-54: i-cache L1TLB page size
-					 *	  (needs IbsPhyAddrValid) */
-			l1tlb_miss:1,	/* 55: i-cache fetch missed in L1TLB */
-			l2tlb_miss:1,	/* 56: i-cache fetch missed in L2TLB */
-			rand_en:1,	/* 57: random tagging enable */
-			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
-					 *      (needs IbsFetchComp) */
-			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
-			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
-			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
-			reserved:2;	/* 62-63: reserved */
-	};
-};
-
-/* MSR 0xc0011033: IBS Execution Control */
-union ibs_op_ctl {
-	__u64 val;
-	struct {
-		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
-			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
-			op_en:1,	/* 17: op sampling enable */
-			op_val:1,	/* 18: op sample valid */
-			cnt_ctl:1,	/* 19: periodic op counter control */
-			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
-			reserved0:5,	/* 27-31: reserved */
-			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
-			ldlat_en:1;	/* 63: Load Latency enabled */
-	};
-};
-
-/* MSR 0xc0011035: IBS Op Data 1 */
-union ibs_op_data {
-	__u64 val;
-	struct {
-		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
-			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
-			reserved1:2,		/* 32-33: reserved */
-			op_return:1,		/* 34: return op */
-			op_brn_taken:1,		/* 35: taken branch op */
-			op_brn_misp:1,		/* 36: mispredicted branch op */
-			op_brn_ret:1,		/* 37: branch op retired */
-			op_rip_invalid:1,	/* 38: RIP is invalid */
-			op_brn_fuse:1,		/* 39: fused branch op */
-			op_microcode:1,		/* 40: microcode op */
-			reserved2:23;		/* 41-63: reserved */
-	};
-};
-
-/* MSR 0xc0011036: IBS Op Data 2 */
-union ibs_op_data2 {
-	__u64 val;
-	struct {
-		__u64	data_src_lo:3,	/* 0-2: data source low */
-			reserved0:1,	/* 3: reserved */
-			rmt_node:1,	/* 4: destination node */
-			cache_hit_st:1,	/* 5: cache hit state */
-			data_src_hi:2,	/* 6-7: data source high */
-			reserved1:56;	/* 8-63: reserved */
-	};
-};
-
-/* MSR 0xc0011037: IBS Op Data 3 */
-union ibs_op_data3 {
-	__u64 val;
-	struct {
-		__u64	ld_op:1,			/* 0: load op */
-			st_op:1,			/* 1: store op */
-			dc_l1tlb_miss:1,		/* 2: data cache L1TLB miss */
-			dc_l2tlb_miss:1,		/* 3: data cache L2TLB hit in 2M page */
-			dc_l1tlb_hit_2m:1,		/* 4: data cache L1TLB hit in 2M page */
-			dc_l1tlb_hit_1g:1,		/* 5: data cache L1TLB hit in 1G page */
-			dc_l2tlb_hit_2m:1,		/* 6: data cache L2TLB hit in 2M page */
-			dc_miss:1,			/* 7: data cache miss */
-			dc_mis_acc:1,			/* 8: misaligned access */
-			reserved:4,			/* 9-12: reserved */
-			dc_wc_mem_acc:1,		/* 13: write combining memory access */
-			dc_uc_mem_acc:1,		/* 14: uncacheable memory access */
-			dc_locked_op:1,			/* 15: locked operation */
-			dc_miss_no_mab_alloc:1,		/* 16: DC miss with no MAB allocated */
-			dc_lin_addr_valid:1,		/* 17: data cache linear address valid */
-			dc_phy_addr_valid:1,		/* 18: data cache physical address valid */
-			dc_l2_tlb_hit_1g:1,		/* 19: data cache L2 hit in 1GB page */
-			l2_miss:1,			/* 20: L2 cache miss */
-			sw_pf:1,			/* 21: software prefetch */
-			op_mem_width:4,			/* 22-25: load/store size in bytes */
-			op_dc_miss_open_mem_reqs:6,	/* 26-31: outstanding mem reqs on DC fill */
-			dc_miss_lat:16,			/* 32-47: data cache miss latency */
-			tlb_refill_lat:16;		/* 48-63: L1 TLB refill latency */
-	};
-};
-
-/* MSR 0xc001103c: IBS Fetch Control Extended */
-union ic_ibs_extd_ctl {
-	__u64 val;
-	struct {
-		__u64	itlb_refill_lat:16,	/* 0-15: ITLB Refill latency for sampled fetch */
-			reserved:48;		/* 16-63: reserved */
-	};
-};
-
-/*
- * IBS driver related
- */
-
-struct perf_ibs_data {
-	u32		size;
-	union {
-		u32	data[0];	/* data buffer starts here */
-		u32	caps;
-	};
-	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
-};
diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
new file mode 100644
index 0000000..300b6e0
--- /dev/null
+++ b/tools/arch/x86/include/asm/amd/ibs.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * From PPR Vol 1 for AMD Family 19h Model 01h B1
+ * 55898 Rev 0.35 - Feb 5, 2021
+ */
+
+#include "../msr-index.h"
+
+/* IBS_OP_DATA2 DataSrc */
+#define IBS_DATA_SRC_LOC_CACHE			 2
+#define IBS_DATA_SRC_DRAM			 3
+#define IBS_DATA_SRC_REM_CACHE			 4
+#define IBS_DATA_SRC_IO				 7
+
+/* IBS_OP_DATA2 DataSrc Extension */
+#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
+#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
+#define IBS_DATA_SRC_EXT_DRAM			 3
+#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
+#define IBS_DATA_SRC_EXT_PMEM			 6
+#define IBS_DATA_SRC_EXT_IO			 7
+#define IBS_DATA_SRC_EXT_EXT_MEM		 8
+#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
+
+/*
+ * IBS Hardware MSRs
+ */
+
+/* MSR 0xc0011030: IBS Fetch Control */
+union ibs_fetch_ctl {
+	__u64 val;
+	struct {
+		__u64	fetch_maxcnt:16,/* 0-15: instruction fetch max. count */
+			fetch_cnt:16,	/* 16-31: instruction fetch count */
+			fetch_lat:16,	/* 32-47: instruction fetch latency */
+			fetch_en:1,	/* 48: instruction fetch enable */
+			fetch_val:1,	/* 49: instruction fetch valid */
+			fetch_comp:1,	/* 50: instruction fetch complete */
+			ic_miss:1,	/* 51: i-cache miss */
+			phy_addr_valid:1,/* 52: physical address valid */
+			l1tlb_pgsz:2,	/* 53-54: i-cache L1TLB page size
+					 *	  (needs IbsPhyAddrValid) */
+			l1tlb_miss:1,	/* 55: i-cache fetch missed in L1TLB */
+			l2tlb_miss:1,	/* 56: i-cache fetch missed in L2TLB */
+			rand_en:1,	/* 57: random tagging enable */
+			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
+					 *      (needs IbsFetchComp) */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
+	};
+};
+
+/* MSR 0xc0011033: IBS Execution Control */
+union ibs_op_ctl {
+	__u64 val;
+	struct {
+		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
+			op_en:1,	/* 17: op sampling enable */
+			op_val:1,	/* 18: op sample valid */
+			cnt_ctl:1,	/* 19: periodic op counter control */
+			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
+			reserved0:5,	/* 27-31: reserved */
+			opcurcnt:27,	/* 32-58: periodic op counter current count */
+			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
+			ldlat_en:1;	/* 63: Load Latency enabled */
+	};
+};
+
+/* MSR 0xc0011035: IBS Op Data 1 */
+union ibs_op_data {
+	__u64 val;
+	struct {
+		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
+			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
+			reserved1:2,		/* 32-33: reserved */
+			op_return:1,		/* 34: return op */
+			op_brn_taken:1,		/* 35: taken branch op */
+			op_brn_misp:1,		/* 36: mispredicted branch op */
+			op_brn_ret:1,		/* 37: branch op retired */
+			op_rip_invalid:1,	/* 38: RIP is invalid */
+			op_brn_fuse:1,		/* 39: fused branch op */
+			op_microcode:1,		/* 40: microcode op */
+			reserved2:23;		/* 41-63: reserved */
+	};
+};
+
+/* MSR 0xc0011036: IBS Op Data 2 */
+union ibs_op_data2 {
+	__u64 val;
+	struct {
+		__u64	data_src_lo:3,	/* 0-2: data source low */
+			reserved0:1,	/* 3: reserved */
+			rmt_node:1,	/* 4: destination node */
+			cache_hit_st:1,	/* 5: cache hit state */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
+	};
+};
+
+/* MSR 0xc0011037: IBS Op Data 3 */
+union ibs_op_data3 {
+	__u64 val;
+	struct {
+		__u64	ld_op:1,			/* 0: load op */
+			st_op:1,			/* 1: store op */
+			dc_l1tlb_miss:1,		/* 2: data cache L1TLB miss */
+			dc_l2tlb_miss:1,		/* 3: data cache L2TLB hit in 2M page */
+			dc_l1tlb_hit_2m:1,		/* 4: data cache L1TLB hit in 2M page */
+			dc_l1tlb_hit_1g:1,		/* 5: data cache L1TLB hit in 1G page */
+			dc_l2tlb_hit_2m:1,		/* 6: data cache L2TLB hit in 2M page */
+			dc_miss:1,			/* 7: data cache miss */
+			dc_mis_acc:1,			/* 8: misaligned access */
+			reserved:4,			/* 9-12: reserved */
+			dc_wc_mem_acc:1,		/* 13: write combining memory access */
+			dc_uc_mem_acc:1,		/* 14: uncacheable memory access */
+			dc_locked_op:1,			/* 15: locked operation */
+			dc_miss_no_mab_alloc:1,		/* 16: DC miss with no MAB allocated */
+			dc_lin_addr_valid:1,		/* 17: data cache linear address valid */
+			dc_phy_addr_valid:1,		/* 18: data cache physical address valid */
+			dc_l2_tlb_hit_1g:1,		/* 19: data cache L2 hit in 1GB page */
+			l2_miss:1,			/* 20: L2 cache miss */
+			sw_pf:1,			/* 21: software prefetch */
+			op_mem_width:4,			/* 22-25: load/store size in bytes */
+			op_dc_miss_open_mem_reqs:6,	/* 26-31: outstanding mem reqs on DC fill */
+			dc_miss_lat:16,			/* 32-47: data cache miss latency */
+			tlb_refill_lat:16;		/* 48-63: L1 TLB refill latency */
+	};
+};
+
+/* MSR 0xc001103c: IBS Fetch Control Extended */
+union ic_ibs_extd_ctl {
+	__u64 val;
+	struct {
+		__u64	itlb_refill_lat:16,	/* 0-15: ITLB Refill latency for sampled fetch */
+			reserved:48;		/* 16-63: reserved */
+	};
+};
+
+/*
+ * IBS driver related
+ */
+
+struct perf_ibs_data {
+	u32		size;
+	union {
+		u32	data[0];	/* data buffer starts here */
+		u32	caps;
+	};
+	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
+};

