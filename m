Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCED63E1158
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhHEJep (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:34:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41630 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhHEJep (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:45 -0400
Date:   Thu, 05 Aug 2021 09:34:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEAHZknF++Et7N8+LwWQnUXsoaB7469nwKfdX4QQoTA=;
        b=KXNxVZfXYpYhHr05LzUIqGM42KBxJH3flMxIywt5AwkY8iobeisYZ8n4iyEmMNK3CP3rxY
        Eqc8/IzcZ4SkSu7yI4+Qz/ulOI94mjt5Oxb2vk79whf9ayJQ4DasUMKd6JUZrhaFMc2d3b
        U8yEMCXwn9Go0lp6Nl8YifUrkNMBjj0z+vEUzgGgkSrKFD6/CZ1Ww9+heBbwXOJTzYevqk
        +tYX/Z0aO/0vG5OoUiipbkn8x+nOdKoKdnQVOTFbuwznVnX3Lsmn+rz8+MAMP/EsSfQAYh
        bamuGAXpEavRn44CzSlZflAlkuke1Yr66FH6xlMf8LBoHWkhPNIJaWFX3KUzfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEAHZknF++Et7N8+LwWQnUXsoaB7469nwKfdX4QQoTA=;
        b=VPXJBGkHNebI83ClPXjyJ0LGM6Kr4Yh3/x4k2eFWgRDLFugGf+Tg7gEw9dQJeim/OChS+M
        FPS/O/+UdSFqVmAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Fix out of bound MSR access
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Like Xu <likexu@tencent.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
References: <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162815606939.395.6416699769104597019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f4b4b45652578357031fbbef7f7a1b04f6fa2dc3
Gitweb:        https://git.kernel.org/tip/f4b4b45652578357031fbbef7f7a1b04f6fa2dc3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 29 Jul 2021 11:14:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:33 +02:00

perf/x86: Fix out of bound MSR access

On Wed, Jul 28, 2021 at 12:49:43PM -0400, Vince Weaver wrote:
> [32694.087403] unchecked MSR access error: WRMSR to 0x318 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106f854 (native_write_msr+0x4/0x20)
> [32694.101374] Call Trace:
> [32694.103974]  perf_clear_dirty_counters+0x86/0x100

The problem being that it doesn't filter out all fake counters, in
specific the above (erroneously) tries to use FIXED_BTS. Limit the
fixed counters indexes to the hardware supplied number.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
Tested-by: Like Xu <likexu@tencent.com>
Link: https://lkml.kernel.org/r/YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net
---
 arch/x86/events/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1eb4513..3092fbf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2489,13 +2489,15 @@ void perf_clear_dirty_counters(void)
 		return;
 
 	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
-		/* Metrics and fake events don't have corresponding HW counters. */
-		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
-			continue;
-		else if (i >= INTEL_PMC_IDX_FIXED)
+		if (i >= INTEL_PMC_IDX_FIXED) {
+			/* Metrics and fake events don't have corresponding HW counters. */
+			if ((i - INTEL_PMC_IDX_FIXED) >= hybrid(cpuc->pmu, num_counters_fixed))
+				continue;
+
 			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
-		else
+		} else {
 			wrmsrl(x86_pmu_event_addr(i), 0);
+		}
 	}
 
 	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
