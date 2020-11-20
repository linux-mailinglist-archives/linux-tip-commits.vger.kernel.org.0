Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3A2BAA63
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKTMpA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgKTMow (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:44:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31012C0613CF;
        Fri, 20 Nov 2020 04:44:52 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:44:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605876290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0zv1qvvltnEh61Nr98A7r9RQZC6xx1vVx2MZ+eXxvI=;
        b=wafxEpy+R9To8obeiBdJ3xqeepM/HLgcN7jbfGjoF2slxzcAES5SzRrGJ9tgDX3P76C13+
        IirR1jsgKOTQ4FNXuHsXxPfzWRnkv2hMtYM1QUl5wKDI9uHr/3GI3tgrPWFvcEx4vPA34E
        ZDbRvwwxVr41/EQwrD3G67//KjzYT3DEqjwknM4POxjeLOPLdRU/FUeJ4M8pJr9EWdahK2
        emkwwRLLWIR23uH6OYYYjqSjTD8Nn7qLOKqRS4nzGvyKFJCMLxnAPxFccAD3pt+VwjnLNs
        djJphCx6VcE+ocUiLR0v5v8lNHtGR0mBFdwzBehwuxq32qBuuLff7qvYkD6mSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605876290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0zv1qvvltnEh61Nr98A7r9RQZC6xx1vVx2MZ+eXxvI=;
        b=RJsWE3bDM0gyM4wMVVET2m4RLVxbpBlATAFHHU+icBvJAzXFq8NXvfM2WO+fGA9zSPZ1BC
        VK0ybCDTyhsAtHCw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] sched: Detect call to schedule from critical entry code
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117151637.259084-4-frederic@kernel.org>
References: <20201117151637.259084-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160587628985.11244.633949364091885413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     9f68b5b74c48761bcbd7d90cf1426049bdbaabb7
Gitweb:        https://git.kernel.org/tip/9f68b5b74c48761bcbd7d90cf1426049bdbaabb7
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 16:16:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:42 +01:00

sched: Detect call to schedule from critical entry code

Detect calls to schedule() between user_enter() and user_exit(). Those
are symptoms of early entry code that either forgot to protect a call
to schedule() inside exception_enter()/exception_exit() or, in the case
of HAVE_CONTEXT_TRACKING_OFFSTACK, enabled interrupts or preemption in
a wrong spot.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201117151637.259084-4-frederic@kernel.org
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7..c23d7cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4291,6 +4291,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
+	SCHED_WARN_ON(ct_state() == CONTEXT_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
