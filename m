Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CE433AAE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhJSPiT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:38:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhJSPiG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:38:06 -0400
Date:   Tue, 19 Oct 2021 15:35:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKj2hvPM9AuCnf6A6Qg9jCBBsIiI0R6+dsnSi1nplok=;
        b=OIOd9zkBKKBPvO6z9SyalYOHI7GfdZc8MUrkG4iEP8GB/YnLDxQGOvpYgHg7NMtRT/ZCVr
        8ZzZprug63BS7feaMFa2D4/i33BMv+WsFKRA1HSCLvTO3GlDX7aEuel0w3uGti6qVbPctg
        +UKVS75hLRO3BZIQ9T0thEZiRNJeabptrbkd2w0afR0T4lrybHW/9yOqos2D1cNiV7fAiu
        yv2fMDigvQ0fsPS0cwi+ICsfyqUYls2R/CcOJzVxKEEqrodLaIFuuT6cunXoX3fwpAhjV/
        mpfLNTzAdAVsb0QCKeHqs8FRriGgNx9X5BDRQgq04OtvmS5wi0Os03s2sdZV2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKj2hvPM9AuCnf6A6Qg9jCBBsIiI0R6+dsnSi1nplok=;
        b=6CgZ2GJaZCkv3aJEevngvJ3SmH9zihUIF3ovdCOPbStthqYgTObv9l1w1B4vLlxGlxHvSh
        /ZDkkTPKKL4Yj/Bg==
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools/perf: Add mem_hops field in perf_mem_data_src
 structure
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006140654.298352-4-kjain@linux.ibm.com>
References: <20211006140654.298352-4-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <163465775021.25758.14824656256573836445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cae1d759065ee989de246d4a72bc2bfe9ad9d262
Gitweb:        https://git.kernel.org/tip/cae1d759065ee989de246d4a72bc2bfe9ad9d262
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Wed, 06 Oct 2021 19:36:53 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:00 +02:00

tools/perf: Add mem_hops field in perf_mem_data_src structure

Going forward, future generation systems can have more hierarchy
within the node/package level but currently we don't have any data source
encoding field in perf, which can be used to represent this level of data.

Add a new field called 'mem_hops' in the perf_mem_data_src structure
which can be used to represent intra-node/package or inter-node/off-package
details. This field is of size 3 bits where PERF_MEM_HOPS_{NA, 0..6} value
can be used to present different hop levels data.

Also add corresponding macros to define mem_hop field values
and shift value.

Currently we define macro for HOPS_0 which corresponds
to data coming from another core but same node.

Add functionality to represent mem_hop field data in
perf_mem__lvl_scnprintf function with the help of added string
array called mem_hops.

For ex: Encodings for mem_hops fields with L2 cache:

L2                      - local L2
L2 | REMOTE | HOPS_0    - remote core, same node L2

Since with the addition of HOPS field, now remote can be used to
denote cache access from the same node but different core, a check
is added in the c2c_decode_stats function to set mrem only when HOPS
is zero along with set remote field.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211006140654.298352-4-kjain@linux.ibm.com
---
 tools/include/uapi/linux/perf_event.h | 11 +++++++++--
 tools/perf/util/mem-events.c          | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index e1701e9..2fc0957 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1210,14 +1210,16 @@ union perf_mem_data_src {
 			mem_remote:1,   /* remote */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_blk:3,	/* access blocked */
-			mem_rsvd:21;
+			mem_hops:3,	/* hop level */
+			mem_rsvd:18;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:21,
+		__u64	mem_rsvd:18,
+			mem_hops:3,	/* hop level */
 			mem_blk:3,	/* access blocked */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_remote:1,   /* remote */
@@ -1313,6 +1315,11 @@ union perf_mem_data_src {
 #define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
 #define PERF_MEM_BLK_SHIFT	40
 
+/* hop level */
+#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
+/* 2-7 available */
+#define PERF_MEM_HOPS_SHIFT	43
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ff7289e..3167b46 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -301,6 +301,16 @@ static const char * const mem_lvlnum[] = {
 	[PERF_MEM_LVLNUM_NA] = "N/A",
 };
 
+static const char * const mem_hops[] = {
+	"N/A",
+	/*
+	 * While printing, 'Remote' will be added to represent
+	 * 'Remote core, same node' accesses as remote field need
+	 * to be set with mem_hops field.
+	 */
+	"core, same node",
+};
+
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l = 0;
@@ -325,6 +335,9 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 		l += 7;
 	}
 
+	if (mem_info && mem_info->data_src.mem_hops)
+		l += scnprintf(out + l, sz - l, "%s ", mem_hops[mem_info->data_src.mem_hops]);
+
 	printed = 0;
 	for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
 		if (!(m & 0x1))
@@ -471,8 +484,12 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	/*
 	 * Skylake might report unknown remote level via this
 	 * bit, consider it when evaluating remote HITMs.
+	 *
+	 * Incase of power, remote field can also be used to denote cache
+	 * accesses from the another core of same node. Hence, setting
+	 * mrem only when HOPS is zero along with set remote field.
 	 */
-	bool mrem  = data_src->mem_remote;
+	bool mrem  = (data_src->mem_remote && !data_src->mem_hops);
 	int err = 0;
 
 #define HITM_INC(__f)		\
