Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A0346449
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 17:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhCWQBi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhCWQBe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 12:01:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0AC061574;
        Tue, 23 Mar 2021 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=s1rnzeJaFdIlYQvZ9i3bgmuzjxB/p3BQGaTx0DQuVsA=; b=m9nqrcnYIyktXzi2+3Isv3TofK
        F85APhp8BCTRP7iVx766AI50nhwNhpF9CD+V2lJemZK3GGXdY6uceAlI6IXR5USQCbhRmqnmZPiIC
        Dv0p7zPBfznf2IUelHlteXX7AXHQxTsWwp05115+vU4VwZF5ymqxosv+763gbxtChnPk5/WPNp8XR
        jMYtiGp5dB/HICWI2Wu6IjXe6HHyzELU2GkSxExaXxb4NilARnge7bEIR7z0psO2yDJNps96f99dQ
        16/Frd1WH+IoziO6yNuSHCPERcsAMONOltUzTC3WT8Y49Ij3vN/TV471RvxmdiJ8yo8WOCOWAskR4
        vNMF/Lyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOjHE-00AErg-11; Tue, 23 Mar 2021 15:49:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E60930377D;
        Tue, 23 Mar 2021 16:49:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08F4425E587B2; Tue, 23 Mar 2021 16:49:03 +0100 (CET)
Date:   Tue, 23 Mar 2021 16:49:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, jbaron@akamai.com,
        ardb@kernel.org, frederic@kernel.org
Subject: Re: [tip: locking/core] static_call: Fix function type mismatch
Message-ID: <YFoN7nCl8OfGtpeh@hirez.programming.kicks-ass.net>
References: <20210322214309.730556-1-arnd@kernel.org>
 <161645580767.398.731817901273202970.tip-bot2@tip-bot2>
 <YFmavWCgUOOfibXR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFmavWCgUOOfibXR@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Mar 23, 2021 at 08:37:33AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 11:30:07PM -0000, tip-bot2 for Arnd Bergmann wrote:
> > The following commit has been merged into the locking/core branch of tip:
> > 
> > Commit-ID:     335c73e7c8f7deb23537afbbbe4f8ab48bd5de52
> > Gitweb:        https://git.kernel.org/tip/335c73e7c8f7deb23537afbbbe4f8ab48bd5de52
> > Author:        Arnd Bergmann <arnd@arndb.de>
> > AuthorDate:    Mon, 22 Mar 2021 22:42:24 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Tue, 23 Mar 2021 00:08:53 +01:00
> > 
> > static_call: Fix function type mismatch
> > 
> > The __static_call_return0() function is declared to return a 'long',
> > while it aliases a couple of functions that all return 'int'. When
> > building with 'make W=1', gcc warns about this:
> > 
> >   kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
> >    5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
> > 
> > Change all these function to return 'long' as well, but remove the cast to
> > ensure we get a warning if any of the types ever change.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Link: https://lore.kernel.org/r/20210322214309.730556-1-arnd@kernel.org
> 
> So I strongly disagree and think the warning is bad and should be
> disabled. I'll go uncommit this patch.

How's this then? I haven't yet build GCC11 myself, but seeing how adding
the (void *) cast fixed the ftrace case, it should work here too.

And note that if you remove the (void *) cast, you get a nice warning:

  ../include/linux/static_call.h:121:41: error: initialization of ‘int (*)(void)’ from incompatible pointer type ‘long int (*)(void)’ [-Werror=incompatible-pointer-types]

No fancy new compiler fail^Wfeatures needed.

Also note the irony, how a warning that was supposed to strengthen types
leads to weakening them.

---
Subject: static_call: Relax static_call_update() function argument type

static_call_update() had stronger type requirements than regular C,
relax them to match. Instead of requiring the @func argument has the
exact matching type, allow any type which C is willing to promote to the
right (function) pointer type. Specifically this allows (void *)
arguments.

This cleans up a bunch of static_call_update() callers for
PREEMPT_DYNAMIC and should get around silly GCC11 warnings for free.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/static_call.h |  4 ++--
 kernel/sched/core.c         | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index e01b61ab86b1..fc94faa53b5b 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -118,9 +118,9 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define static_call_update(name, func)					\
 ({									\
-	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
+	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
-			     STATIC_CALL_TRAMP_ADDR(name), func);	\
+			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
 
 #define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3384ea74cad4..42f9bedc666c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5402,25 +5402,25 @@ static void sched_dynamic_update(int mode)
 	switch (mode) {
 	case preempt_dynamic_none:
 		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
-		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
-		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
-		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
-		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(cond_resched, (void *)&__static_call_return0);
+		static_call_update(might_resched, (void *)&__static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
