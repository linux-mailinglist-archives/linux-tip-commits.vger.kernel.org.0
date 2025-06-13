Return-Path: <linux-tip-commits+bounces-5813-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277CAD8493
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6528A178CDE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3962F2C60;
	Fri, 13 Jun 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcuJOPRG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9nS1XIS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7E2ED856;
	Fri, 13 Jun 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800259; cv=none; b=dEW3xUKNgs6OLFl6Vqox6XYkOCm6HHj3mGKoi6btsukk/9iL+jPdYZJiK+AIYgNgaWmdH/wmIs4ebKXlZGBFCdjJsTWIPVyzalBQU5fCdxwtJbCE0GFcm3azB1eW9+7M6jQZCe5N1U0oHJ3gmOv64pljUGj8ogxrIffxQk/bghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800259; c=relaxed/simple;
	bh=Ouj9sOMBHdLQ1XWFVVSG3/Odv9itUSB92BJ8JPtAdvQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X1v56Dn3dtWvMutgboK8yzVKtGKIFG7c50kMtTFTVDcN4mUloh1A4IoU42Fb2EzsqnzJKwphnkSmT6A6Imhgz73vQHGQyWEeY60uDc/9dNWXqPpD/kpHqT9GgO7YNDZUasdSiO6jNMOyFyKJhmGxubN53M0v5EZMYFrwh00AXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcuJOPRG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9nS1XIS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PksvKlWn4g1Rxf98ql4uVvN3CVVMTwVGINm+Sbchjmk=;
	b=CcuJOPRGZhGD6dYV7oIn6iTBACUg0p208eN/ffP2oU0P86teKfB4EWXXAkhoRghUhhVLsO
	nx7b8OLJ1mMYb4S1a10UMZ5h6MRM4UTllZqEpx45JQVJ+I6UK/Z74fxCSoPZPIJQgCVndn
	zvwaoSyUMMSzhLz+MHNR0ufwvQXEiSy+vZ/G5is4rokgCjQRZNpJC+N9wRAcMTVD/SyJ4u
	UDL3TlQmqpJ1fiKKlSWKizReyOWiksbxK3G8IYaAf4GXcBiK6gpIn8xSKjlex6qrg8scW3
	qpFGPAH0J3cwQnxgHQeW/m03fE9GopkjUUtIAGW9Yj7jsvHfjqXT+iYi64gG8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PksvKlWn4g1Rxf98ql4uVvN3CVVMTwVGINm+Sbchjmk=;
	b=L9nS1XIS5FGdQrXuFxAZdGW22wfzE9+4ygaRPwANTDk6jh9B7oUN2Cx+S4pSg83B+/DPE7
	n1bao2pofK0cjOBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/idle.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-11-mingo@kernel.org>
References: <20250528080924.2273858-11-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025376.406.18200314859296751611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     833840a94f4dfd86ed32f1b6222fe8d9ba1790a9
Gitweb:        https://git.kernel.org/tip/833840a94f4dfd86ed32f1b6222fe8d9ba1790a9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:16 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/idle.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

 - Fix whitespace noise and other inconsistencies.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-11-mingo@kernel.org
---
 kernel/sched/idle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index cd32986..43d6e00 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -52,7 +52,7 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 	return 1;
 }
 __setup("hlt", cpu_idle_nopoll_setup);
-#endif
+#endif /* CONFIG_GENERIC_IDLE_POLL_SETUP */
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
@@ -100,10 +100,10 @@ static inline void cond_tick_broadcast_exit(void)
 	if (static_branch_unlikely(&arch_needs_tick_broadcast))
 		tick_broadcast_exit();
 }
-#else
+#else /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE: */
 static inline void cond_tick_broadcast_enter(void) { }
 static inline void cond_tick_broadcast_exit(void) { }
-#endif
+#endif /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE */
 
 /**
  * default_idle_call - Default CPU idle routine.
@@ -444,7 +444,7 @@ balance_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	return WARN_ON_ONCE(1);
 }
-#endif
+#endif /* CONFIG_SMP */
 
 /*
  * Idle tasks are unconditionally rescheduled:

