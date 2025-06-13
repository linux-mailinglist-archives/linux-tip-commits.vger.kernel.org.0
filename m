Return-Path: <linux-tip-commits+bounces-5810-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C8AD848B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C9171B32
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C832ECEB0;
	Fri, 13 Jun 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvkcfTeW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5SO3w7N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5D2EBDFA;
	Fri, 13 Jun 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800255; cv=none; b=iJ2XVAWJa+7i2TJ8To2oZZIIF6UZ5mTk419m8wwsdcC9Cf44hd1K5iwULbYUJoPXiwdBHmxh5nNpd9vJ17jQ4bZPCL35ZurWXZmjCRrZ2TiiZFGsbtgc3uTaNlNDcB03nRMjz+GinvzL0Dwhvb3P/rWO0GQAOE+eq480lAyZy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800255; c=relaxed/simple;
	bh=J0DjSD11m1yvi3288GoGxHHXpY6y3lOvNDTKcHftiCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j9gLfIn/7D3YYSxKVQ+0XVcO+SEf9k2lwh14UsNOuKJ82b8ddXo0yEx6e/8L+GLBd7hYeuOfnVIchpoKkJymo9VkV/ODq45uH/BNpP8V96ZtE7O7iOJ50q21I9qk0avK1HdxrfJuurAIYBwiF4Q806c+MOAhUKtEBGhmpgXQ2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvkcfTeW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5SO3w7N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpyphSlymWeqrC1sPlQUPsY27E/OKIQJhOv+9zq//ss=;
	b=jvkcfTeWtQoXqJU6abIMKgZTXAQcqN7KSQKtzw/8s9AfphOpCLR5Z5V7RMBH1Ubbm28ts3
	ZO9vsHLg7JqZr2qsjD8gDw81aYvt3np4+FK9wJ4Yd/a+CfeiWYo+07c4tbAyCl2vAqPicm
	Q4hVW8uMnM4Q9D91lfswre2lxAP50/MDImWfo5+MT1HwA/nogCZDQgJ5HPDsFhbggYBhup
	u4yM30HYnoTr1Xi65cj9NA7bw0ahwLix+Bn1gLCgjN7VcOZrsKmfqZgpkSfzWxU/uJZTGe
	NMgGIdR7uhcRD0flAAnuDE+b681gFQjnknc8IY7hjevo/G/ouvPP5gFxZCVJyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpyphSlymWeqrC1sPlQUPsY27E/OKIQJhOv+9zq//ss=;
	b=f5SO3w7N369P017Ub6s71FNWUYUxhLzczoqPJtEMOO4zUJY8kShsfvNQ7lSnIAhuCFO9a4
	Kxzpv6O85Om5B1AQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/psi.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-14-mingo@kernel.org>
References: <20250528080924.2273858-14-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025133.406.5247465925865801360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fd3db705f7496c5d6b56ce8d78570dd1da11cd30
Gitweb:        https://git.kernel.org/tip/fd3db705f7496c5d6b56ce8d78570dd1da11cd30
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:17 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/psi.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

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
Link: https://lore.kernel.org/r/20250528080924.2273858-14-mingo@kernel.org
---
 kernel/sched/psi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 333a7ba..5837cd8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1039,7 +1039,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 			psi_schedule_rtpoll_work(group, 1, false);
 	} while ((group = group->parent));
 }
-#endif
+#endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 /**
  * psi_memstall_enter - mark the beginning of a memory stall section
@@ -1655,7 +1655,7 @@ static const struct proc_ops psi_irq_proc_ops = {
 	.proc_poll	= psi_fop_poll,
 	.proc_release	= psi_fop_release,
 };
-#endif
+#endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 static int __init psi_proc_init(void)
 {

