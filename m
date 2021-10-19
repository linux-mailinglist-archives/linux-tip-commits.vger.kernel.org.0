Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA47433AAC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhJSPiR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhJSPiF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:38:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D813AC06174E;
        Tue, 19 Oct 2021 08:35:51 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:35:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNE70PjiuJdS6btyghl42nn03yQzqlHm9zKYuJS+SiI=;
        b=qtzttS3S6EykIWtxTYKdrD0i0iJXjpW/nBJVtlN/ecI3SAcJunFpBw1gyfQKd95JlenZYa
        IWduW767qbRZd7WDd4TTKUyRSu1trCOuTTG9CdxEFgRGR4N7JQ9ovk8fCXeYv9VA7fMWUw
        /USaG6xsyGQ5H+gDGB3T+VJRBu7gfg87H77bAk8i+8bgFoTuu5zrebfFb+s9PFsQ6m3YFt
        jcCxCZehJwTYS3IchVOEVjTBE0g2YRNU58eYvXk+NbIAU/nKyffY02oCcvBnzSj0teRL3K
        35mHi4SSLgjgJtxowVKiPa7ISFv/Iidqu8teh+z6Dyxbbqa58+w2V60BWoteAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNE70PjiuJdS6btyghl42nn03yQzqlHm9zKYuJS+SiI=;
        b=/J+HzV8gLTou24pZQSXNcj3LE68b42ywJr9ghWZotHaRwIn6eS/eeH4b6EA/L9nAEGcbOK
        El8HJxa98PJlOEAg==
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] powerpc/perf: Fix data source encodings for L2.1 and
 L3.1 accesses
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006140654.298352-5-kjain@linux.ibm.com>
References: <20211006140654.298352-5-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <163465774951.25758.5851239817797159789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     26da4abfb38201c3cbe127daeded76d4c2bc9077
Gitweb:        https://git.kernel.org/tip/26da4abfb38201c3cbe127daeded76d4c2bc9077
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Wed, 06 Oct 2021 19:36:54 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:01 +02:00

powerpc/perf: Fix data source encodings for L2.1 and L3.1 accesses

Fix the data source encodings to represent L2.1/L3.1(another core's
L2/L3 on the same node) accesses properly for power10 and older
plaforms.

Add new macros(LEVEL/REM) which can be used to add mem_lvl_num and remote
field data inside perf_mem_data_src structure.

Result in power9 system with patch changes:

localhost:~/linux/tools/perf # ./perf mem report | grep Remote
     0.01%             1  252           Remote core, same node L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff7f25eb90
anon               HitM          N/A                     No       N/A        0              0
     0.01%             1  220           Remote core, same node L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff77776d90
anon               HitM          N/A                     No       N/A        0              0
     0.01%             1  220           Remote core, same node L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff817d9410
anon               HitM          N/A                     No       N/A        0              0

Fixes: 79e96f8f930d ("powerpc/perf: Export memory hierarchy info to user space")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211006140654.298352-5-kjain@linux.ibm.com
---
 arch/powerpc/perf/isa207-common.c | 26 +++++++++++++++++++++-----
 arch/powerpc/perf/isa207-common.h |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index f92bf5f..7ea873a 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -238,11 +238,27 @@ static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
 		ret |= P(SNOOP, HIT);
 		break;
 	case 5:
-		ret = PH(LVL, REM_CCE1);
-		if ((sub_idx == 0) || (sub_idx == 2) || (sub_idx == 4))
-			ret |= P(SNOOP, HIT);
-		else if ((sub_idx == 1) || (sub_idx == 3) || (sub_idx == 5))
-			ret |= P(SNOOP, HITM);
+		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+			ret = REM | P(HOPS, 0);
+
+			if (sub_idx == 0 || sub_idx == 4)
+				ret |= PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HIT);
+			else if (sub_idx == 1 || sub_idx == 5)
+				ret |= PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HITM);
+			else if (sub_idx == 2 || sub_idx == 6)
+				ret |= PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
+			else if (sub_idx == 3 || sub_idx == 7)
+				ret |= PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
+		} else {
+			if (sub_idx == 0)
+				ret = PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx == 1)
+				ret = PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+			else if (sub_idx == 2 || sub_idx == 4)
+				ret = PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx == 3 || sub_idx == 5)
+				ret = PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+		}
 		break;
 	case 6:
 		ret = PH(LVL, REM_CCE2);
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 4a2cbc3..ff12260 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -273,6 +273,8 @@
 #define P(a, b)				PERF_MEM_S(a, b)
 #define PH(a, b)			(P(LVL, HIT) | P(a, b))
 #define PM(a, b)			(P(LVL, MISS) | P(a, b))
+#define LEVEL(x)			P(LVLNUM, x)
+#define REM				P(REMOTE, REMOTE)
 
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp, u64 event_config1);
 int isa207_compute_mmcr(u64 event[], int n_ev,
