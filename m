Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB8433AAF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhJSPiT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:38:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhJSPiG (ORCPT
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
        bh=tjENM1cuhSphHESG3ho75jIk68ot3IJolYJNmyHGvEQ=;
        b=3tMm7dwhwB2CCH9PWFgITNHYHrevm4/HNNwFcoaBgRNpSls4PbH655/PNumTxPzkm3nkWa
        bQIpNGNV44kLRJOgJjrAoQQ3P5BI5ZhXTTSlFK7IkD85cciaco6Y+/hga+upbfoWVlkpbR
        Lorw1WUkeFQtCq8mtZknMTvy1yjiiHjzBOKXl5LQEMPpyIF3zpgwhBIjbYXmw47nfmF7Z/
        Pkm/pAUWzDUIQiwlSo37cQDMS0IjWeQEXG2gTxwj614mHkAqjJly5zUwtYoTJTJN7HpKHD
        bXDwU2mvXThmGYR9jfn+jVZLrW2zIBkPxsaRWNb8moqjDQuin/L3Lky0XAH8rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjENM1cuhSphHESG3ho75jIk68ot3IJolYJNmyHGvEQ=;
        b=G+olvCDAMFtLRwmqZiwfXB8sg5gnTA3u3cvJUTwy/ei4M3YEr7ibiT7CghNaZe3di8z5tS
        Wl4xqPphKWdzaVAA==
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add mem_hops field in perf_mem_data_src structure
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006140654.298352-3-kjain@linux.ibm.com>
References: <20211006140654.298352-3-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <163465775096.25758.11158076319685088974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fec9cc6175d0ec1e13efe12be491d9bd4de62f80
Gitweb:        https://git.kernel.org/tip/fec9cc6175d0ec1e13efe12be491d9bd4de62f80
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Wed, 06 Oct 2021 19:36:52 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:00 +02:00

perf: Add mem_hops field in perf_mem_data_src structure

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

For ex: Encodings for mem_hops fields with L2 cache:

L2			- local L2
L2 | REMOTE | HOPS_0	- remote core, same node L2

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211006140654.298352-3-kjain@linux.ibm.com
---
 include/uapi/linux/perf_event.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index a74538c..bd8860e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1225,14 +1225,16 @@ union perf_mem_data_src {
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
@@ -1328,6 +1330,11 @@ union perf_mem_data_src {
 #define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
 #define PERF_MEM_BLK_SHIFT	40
 
+/* hop level */
+#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
+/* 2-7 available */
+#define PERF_MEM_HOPS_SHIFT	43
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
