Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7383F8380
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhHZIKj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhHZIKi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:38 -0400
Date:   Thu, 26 Aug 2021 08:09:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X049UQc1UpAPEeIa5KhN5S44ZqWEsRTfrUeb19g4BwE=;
        b=KP7YZYLjogND40D9QJII7exL+BZzq8TiYEbb40ahS6ER0BZwYDuol7OocMjeoaCh9b5FWT
        wYWS1jztImtqSyz/thrVbGT6nkoF/73sZLRK37VZESBhz7MjGeCMLxw8HTrpSwKnnyq6Z2
        xEc6wY7Mj+lute1vnSFf/uZuutwuQdrdAsEoXl3mE/0x40v+y7THvEMo7DGvDmNqPizFnh
        DR3BzFvVS2eewTSCQfDHLdATAxf/u/ZNm5AkYjqvQx4UFj9nH3ztJOC8rXlCtuejUuNrTo
        r1wWzqWYRnR3QpiJr0SFE6FoWexeLXN+suhCj9BvpMcqMSSOXmlYjYVULasAeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X049UQc1UpAPEeIa5KhN5S44ZqWEsRTfrUeb19g4BwE=;
        b=vQQvjRmJ+3mD72P5bBEcBWKOsEy/wt+mkfTbXBW8LLQJigH5tbc4+HtyjfWa0UOlTJLvlf
        Hn5Kt1CMIGfx41BQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/ibs: Add bitfield definitions in new
 <asm/amd-ibs.h> header
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-9-kim.phillips@amd.com>
References: <20210817221048.88063-9-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162996538920.25758.14659348674636268320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6a371bafe613b7746c3d3ac486bdb3035f77e029
Gitweb:        https://git.kernel.org/tip/6a371bafe613b7746c3d3ac486bdb3035f77e029
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:48 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

perf/x86/amd/ibs: Add bitfield definitions in new <asm/amd-ibs.h> header

Add <asm/amd-ibs.h> with bitfield definitions for IBS MSRs,
and demonstrate usage within the driver.

Also move 'struct perf_ibs_data' where it can be shared with
the perf tool that will soon be using it.

No functional changes.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210817221048.88063-9-kim.phillips@amd.com
---
 arch/x86/events/amd/ibs.c      |  23 ++----
 arch/x86/include/asm/amd-ibs.h | 132 ++++++++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 14 deletions(-)
 create mode 100644 arch/x86/include/asm/amd-ibs.h

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index ccc9ee1..9739019 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -26,6 +26,7 @@ static u32 ibs_caps;
 #include <linux/hardirq.h>
 
 #include <asm/nmi.h>
+#include <asm/amd-ibs.h>
 
 #define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
 #define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
@@ -100,15 +101,6 @@ struct perf_ibs {
 	u64				(*get_count)(u64 config);
 };
 
-struct perf_ibs_data {
-	u32		size;
-	union {
-		u32	data[0];	/* data buffer starts here */
-		u32	caps;
-	};
-	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
-};
-
 static int
 perf_event_set_period(struct hw_perf_event *hwc, u64 min, u64 max, u64 *hw_period)
 {
@@ -329,11 +321,14 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
 
 static u64 get_ibs_fetch_count(u64 config)
 {
-	return (config & IBS_FETCH_CNT) >> 12;
+	union ibs_fetch_ctl fetch_ctl = (union ibs_fetch_ctl)config;
+
+	return fetch_ctl.fetch_cnt << 4;
 }
 
 static u64 get_ibs_op_count(u64 config)
 {
+	union ibs_op_ctl op_ctl = (union ibs_op_ctl)config;
 	u64 count = 0;
 
 	/*
@@ -341,12 +336,12 @@ static u64 get_ibs_op_count(u64 config)
 	 * and the lower 7 bits of CurCnt are randomized.
 	 * Otherwise CurCnt has the full 27-bit current counter value.
 	 */
-	if (config & IBS_OP_VAL) {
-		count = (config & IBS_OP_MAX_CNT) << 4;
+	if (op_ctl.op_val) {
+		count = op_ctl.opmaxcnt << 4;
 		if (ibs_caps & IBS_CAPS_OPCNTEXT)
-			count += config & IBS_OP_MAX_CNT_EXT_MASK;
+			count += op_ctl.opmaxcnt_ext << 20;
 	} else if (ibs_caps & IBS_CAPS_RDWROPCNT) {
-		count = (config & IBS_OP_CUR_CNT) >> 32;
+		count = op_ctl.opcurcnt;
 	}
 
 	return count;
diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
new file mode 100644
index 0000000..46e1df4
--- /dev/null
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * From PPR Vol 1 for AMD Family 19h Model 01h B1
+ * 55898 Rev 0.35 - Feb 5, 2021
+ */
+
+#include <asm/msr-index.h>
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
+			reserved:5;	/* 59-63: reserved */
+	};
+};
+
+/* MSR 0xc0011033: IBS Execution Control */
+union ibs_op_ctl {
+	__u64 val;
+	struct {
+		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
+			reserved0:1,	/* 16: reserved */
+			op_en:1,	/* 17: op sampling enable */
+			op_val:1,	/* 18: op sample valid */
+			cnt_ctl:1,	/* 19: periodic op counter control */
+			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
+			reserved1:5,	/* 27-31: reserved */
+			opcurcnt:27,	/* 32-58: periodic op counter current count */
+			reserved2:5;	/* 59-63: reserved */
+	};
+};
+
+/* MSR 0xc0011035: IBS Op Data 2 */
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
+		__u64	data_src:3,	/* 0-2: data source */
+			reserved0:1,	/* 3: reserved */
+			rmt_node:1,	/* 4: destination node */
+			cache_hit_st:1,	/* 5: cache hit state */
+			reserved1:57;	/* 5-63: reserved */
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
