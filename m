Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B564A149FF7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jan 2020 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgA0IjT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Jan 2020 03:39:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46082 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgA0IjT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Jan 2020 03:39:19 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ivzvQ-0007LH-L4; Mon, 27 Jan 2020 09:39:16 +0100
Date:   Mon, 27 Jan 2020 09:39:15 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: [PATCH] smp: Remove superfluous cond_func check in
 smp_call_function_many_cond()
Message-ID: <20200127083915.434tdkztorkklpdu@linutronix.de>
References: <20200117090137.1205765-3-bigeasy@linutronix.de>
 <157989512234.396.13725764794800050132.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157989512234.396.13725764794800050132.tip-bot2@tip-bot2>
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

It was requested to remove the cond_func check but the follow up patch
was overlooked. Here is an incremental update.

Link: https://lore.kernel.org/lkml/20200117131510.GA14914@hirez.programming.kicks-ass.net/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 3b7bedc97af38..d0ada39eb4d41 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -435,7 +435,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	/* Fastpath: do that cpu by itself. */
 	if (next_cpu >= nr_cpu_ids) {
-		if (!cond_func || (cond_func && cond_func(cpu, info)))
+		if (!cond_func || cond_func(cpu, info))
 			smp_call_function_single(cpu, func, info, wait);
 		return;
 	}
-- 
2.25.0

