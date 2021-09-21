Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5D412F66
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhIUH3Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhIUH3Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60147C061574;
        Tue, 21 Sep 2021 00:27:56 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc/MMuHyqd7I/n3xzJ1+Egb/wK64R9BAgpFLaI5t0h0=;
        b=Hm5Q1YxSIDbKQUaM9Wwu0lrt2yeCafqGs1BuaZq6EwNshbad+psSjfFXHFx+51Z2yCS0HM
        Z81kaQiqRmfy6N6hrIuYNp5NTRhMWshYEXH3bLxWgGsxhvxnOPuC+7ixUvA43Jj8Rqosqi
        Z49ot2IJyqrHor8bIk3nLTK64YuGvTrZ/w/qu/1o0frQpB7u7z/rvHlCXWcERROITAssLC
        woAPEDLrPse1e/OVMhhnG+xwi/lsGO6kapd5/fTSW+uI6tDQPwkK6QtRBiDedjMmBkut8W
        5RUbqI8vIoYoDBWhNgY0/qbn6El3I1q6hW0Ylz7Tmomg+yIQuuliRkntVa2LNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc/MMuHyqd7I/n3xzJ1+Egb/wK64R9BAgpFLaI5t0h0=;
        b=8esR/O/KsR+1DaNdqZBVKijxcHuOjWLo/WzGckA9+D+6KagXFAzTNsflpxiaCwDDXPwCra
        VZEgB1gX4sWoPHBw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/sched: Decrease further the priorities of SMT siblings
Cc:     Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210911011819.12184-2-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-2-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163220927404.25758.16115630571095886207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     014bfe892220077b8c623b97e31a91378d204137
Gitweb:        https://git.kernel.org/tip/014bfe892220077b8c623b97e31a91378d204137
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:14 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:39 +02:00

x86/sched: Decrease further the priorities of SMT siblings

When scheduling, it is better to prefer a separate physical core rather
than the SMT sibling of a high priority core. The existing formula to
compute priorities takes such fact in consideration. There may exist,
however, combinations of priorities (i.e., maximum frequencies) in which
the priority of high-numbered SMT siblings of high-priority cores collides
with the priority of low-numbered SMT siblings of low-priority cores.

Consider for instance an SMT2 system with CPUs [0, 1] with priority 60 and
[2, 3] with priority 30(CPUs in brackets are SMT siblings. In such a case,
the resulting priorities would be [120, 60], [60, 30]. Thus, to ensure
that CPU2 has higher priority than CPU1, divide the raw priority by the
squared SMT iterator. The resulting priorities are [120, 30]. [60, 15].

Originally-by: Len Brown <len.brown@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210911011819.12184-2-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/kernel/itmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 1afbdd1..9ff480e 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -198,7 +198,7 @@ void sched_set_itmt_core_prio(int prio, int core_cpu)
 		 * of the priority chain and only used when
 		 * all other high priority cpus are out of capacity.
 		 */
-		smt_prio = prio * smp_num_siblings / i;
+		smt_prio = prio * smp_num_siblings / (i * i);
 		per_cpu(sched_core_priority, cpu) = smt_prio;
 		i++;
 	}
