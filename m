Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577864547F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhKQODm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbhKQOCx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:02:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2FC061767;
        Wed, 17 Nov 2021 05:59:55 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThXd8Y+0vCwmSnOgY3TSnmt2AK6kV5fLGBFYQ27AAWw=;
        b=X+3q9g8vctBP5McYpA1towwhH/uizrtgc59N3DOOgbDmMmp+Bc8OBJHBiZ8KFlmhajH3V+
        hfaJwYba1lA03YMrip9plRlE0XuD37ea1p4bvSegivxgdpDV/yYGKf+7cBG8YxppzLmLRC
        RLBJO5w/EtymJwysuJPjrjzceokeAbJo1tPjdsuPkthnG05DDT1ToSDLYKDVg4Ur4GotRU
        5DRdBHGoOhsih4Yr0yYdo7FvtrJP/3eNJbWAwUWMmIv4oSXm9XMvc2bhi6s/P4AtIvaPB9
        a9Xap/1iluWUBaR0/2N52pGOYG9XaCwMk9VZRw/E51ymgvsygPaOCuVxRcYJpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThXd8Y+0vCwmSnOgY3TSnmt2AK6kV5fLGBFYQ27AAWw=;
        b=Hl6VDhl+AErKyCMxXguA4WNXYuqufVowCY4JFbtu1d4+zpMAU4hN+0pI4wKDVSN8VHgB1x
        yrQzHJBgykY12TAA==
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/perf: Fix snapshot_branch_stack warning in VM
Cc:     Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Like Xu <likexu@tencent.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112054510.2667030-1-songliubraving@fb.com>
References: <20211112054510.2667030-1-songliubraving@fb.com>
MIME-Version: 1.0
Message-ID: <163715759202.11128.17805416809718536710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f3fd84a3b7754b60df67ebfe64e1d90623895111
Gitweb:        https://git.kernel.org/tip/f3fd84a3b7754b60df67ebfe64e1d90623895111
Author:        Song Liu <songliubraving@fb.com>
AuthorDate:    Thu, 11 Nov 2021 21:45:10 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:43 +01:00

x86/perf: Fix snapshot_branch_stack warning in VM

When running in VM intel_pmu_snapshot_branch_stack triggers WRMSR warning
like:

 [ ] unchecked MSR access error: WRMSR to 0x3f1 (tried to write 0x0000000000000000) at rIP: 0xffffffff81011a5b (intel_pmu_snapshot_branch_stack+0x3b/0xd0)

This can be triggered with BPF selftests:

  tools/testing/selftests/bpf/test_progs -t get_branch_snapshot

This warning is caused by __intel_pmu_pebs_disable_all() in the VM.
Since it is not necessary to disable PEBS for LBR, remove it from
intel_pmu_snapshot_branch_stack and intel_pmu_snapshot_arch_branch_stack.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Like Xu <likexu@tencent.com>
Link: https://lore.kernel.org/r/20211112054510.2667030-1-songliubraving@fb.com
---
 arch/x86/events/intel/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 42cf01e..ec6444f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2211,7 +2211,6 @@ intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int 
 	/* must not have branches... */
 	local_irq_save(flags);
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
-	__intel_pmu_pebs_disable_all();
 	__intel_pmu_lbr_disable();
 	/*            ... until here */
 	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
@@ -2225,7 +2224,6 @@ intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned
 	/* must not have branches... */
 	local_irq_save(flags);
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
-	__intel_pmu_pebs_disable_all();
 	__intel_pmu_arch_lbr_disable();
 	/*            ... until here */
 	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
