Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B319A2824B5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Oct 2020 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJCOW1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Oct 2020 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJCOW1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Oct 2020 10:22:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B1C0613E7;
        Sat,  3 Oct 2020 07:22:26 -0700 (PDT)
Date:   Sat, 03 Oct 2020 14:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601734945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofwHsK4s+6NveviB/3TeVW09UL8WbJfeCt6idkYx9UE=;
        b=O0tOaCrbeTqRIWUwtvghkLCTmYE9FHdz6EAF0r1UYpNF+8VxZx4auNmziUUf9gWF4tN7rh
        kKk0/tCEUIdMZSotnzfTYV5xgg/MA1ECsPNJQeCoJTGVkwSK1dbJBpJ4yaWFfL1y1duCVG
        EYvAct/JOmfpjQpr9ZvCEQXa2yQuv/eV2G3rnutRmernaSv8iBJTtURBqUy45IGOFjoX1D
        XViP/oRvfI1rf4usVtHxmfLT2qFkooyNWVcUvU5Fh2hQhjLUGi0qyGEl5JP8rYte9GIMd7
        ye84JA3/pweJOFzYJhL5RNpdkykvexJ9NGzwm4ics8M9vt2kP0T+uvBV6VmOXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601734945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofwHsK4s+6NveviB/3TeVW09UL8WbJfeCt6idkYx9UE=;
        b=IsNyP39MjvVssMNsVd+vTZHiwhcS4afYypJ3UaoR8qqw4f0GTkGteX4c2LVtE7HzfYAT0l
        5e4QDNawIRP0EXDg==
From:   "tip-bot2 for Steven Rostedt (VMware)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] tracepoint: Fix out of sync data passing by
 static caller
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CA+G9fYvPXVRO0NV7yL=FxCmFEMYkCwdz7R=9W+_votpT824YJA@mail.gmail.com>
References: <CA+G9fYvPXVRO0NV7yL=FxCmFEMYkCwdz7R=9W+_votpT824YJA@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <160173494423.7002.804175563693237793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     547305a64632813286700cb6d768bfe773df7d19
Gitweb:        https://git.kernel.org/tip/547305a64632813286700cb6d768bfe773df7d19
Author:        Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate:    Thu, 01 Oct 2020 21:27:57 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Oct 2020 21:18:25 +02:00

tracepoint: Fix out of sync data passing by static caller

Naresh reported a bug that appears to be a side effect of the static
calls. It happens when going from more than one tracepoint callback to
a single one, and removing the first callback on the list. The list of
tracepoint callbacks holds data and a function to call with the
parameters of that tracepoint and a handler to the associated data.

 old_list:
	0: func = foo; data = NULL;
	1: func = bar; data = &bar_struct;

 new_list:
	0: func = bar; data = &bar_struct;

	CPU 0				CPU 1
	-----				-----
   tp_funcs = old_list;
   tp_static_caller = tp_interator

   __DO_TRACE()

    data = tp_funcs[0].data = NULL;

				   tp_funcs = new_list;
				   tracepoint_update_call()
				      tp_static_caller = tp_funcs[0] = bar;
    tp_static_caller(data)
       bar(data)
         x = data->item = NULL->item

       BOOM!

To solve this, add a tracepoint_synchronize_unregister() between
changing tp_funcs and updating the static tracepoint, that does both a
synchronize_rcu() and synchronize_srcu(). This will ensure that when
the static call is updated to the single callback that it will be
receiving the data that it registered with.

Fixes: d25e37d89dd2f ("tracepoint: Optimize using static_call()")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/linux-next/CA+G9fYvPXVRO0NV7yL=FxCmFEMYkCwdz7R=9W+_votpT824YJA@mail.gmail.com
---
 kernel/tracepoint.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index e92f3fb..26efd22 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -221,7 +221,7 @@ static void *func_remove(struct tracepoint_func **funcs,
 	return old;
 }
 
-static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs)
+static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs, bool sync)
 {
 	void *func = tp->iterator;
 
@@ -229,8 +229,17 @@ static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func
 	if (!tp->static_call_key)
 		return;
 
-	if (!tp_funcs[1].func)
+	if (!tp_funcs[1].func) {
 		func = tp_funcs[0].func;
+		/*
+		 * If going from the iterator back to a single caller,
+		 * we need to synchronize with __DO_TRACE to make sure
+		 * that the data passed to the callback is the one that
+		 * belongs to that callback.
+		 */
+		if (sync)
+			tracepoint_synchronize_unregister();
+	}
 
 	__static_call_update(tp->static_call_key, tp->static_call_tramp, func);
 }
@@ -265,7 +274,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * include/linux/tracepoint.h using rcu_dereference_sched().
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
-	tracepoint_update_call(tp, tp_funcs);
+	tracepoint_update_call(tp, tp_funcs, false);
 	static_key_enable(&tp->key);
 
 	release_probes(old);
@@ -297,11 +306,12 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 			tp->unregfunc();
 
 		static_key_disable(&tp->key);
+		rcu_assign_pointer(tp->funcs, tp_funcs);
 	} else {
-		tracepoint_update_call(tp, tp_funcs);
+		rcu_assign_pointer(tp->funcs, tp_funcs);
+		tracepoint_update_call(tp, tp_funcs,
+				       tp_funcs[0].func != old[0].func);
 	}
-
-	rcu_assign_pointer(tp->funcs, tp_funcs);
 	release_probes(old);
 	return 0;
 }
