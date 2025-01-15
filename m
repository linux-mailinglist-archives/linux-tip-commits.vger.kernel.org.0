Return-Path: <linux-tip-commits+bounces-3221-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF5A11D34
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8281D7A13AC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A17236EB4;
	Wed, 15 Jan 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERiyvDMF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDhTkiUF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688A1EEA3D;
	Wed, 15 Jan 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932639; cv=none; b=QrhdBejuD15cOE1/BLdtO5jPVwzZVqsbMGhfZ0wrr8i9HDpqpjfCZbg2f1CBEJyUr7wEErfIyKzsGW3kxBeNcS5g+ESAH6lQg0uiEiJjWKHF9W8hlkow+xxVi1DxkWKiOuaQE22L5LNsofU2fTgKs4+zP+lle65/wk+2eF59xx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932639; c=relaxed/simple;
	bh=Ed8YhxxH0tc4sIVF6t2FT/vjE70JCdJvWwN8baYzQCY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sttm5i6QmIaTn6SyFqPN1n6sJ5yF7Qhh27oqDx7RuSr8impi4DxW3xu6GLt9/K7cz+Dkce3uc2AK7Lqyp1074t8+P7Eoqv2hI7oBz8OPVjqfzcKas9QGDYmWr7RkHtmTDBe1TxMgbxzM2nJhC+4mGXYhwQhp/S+Bj7lo6a89gM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERiyvDMF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jDhTkiUF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMa1e4Lt8pI1rEZtwwgTMisSWpfEBV60+MoCFYqeXAo=;
	b=ERiyvDMFYv7Lgg0DolEJ5AZ6UBJnc3lYJld6YdLwM1mdNyoxGRKJEgLt71H7KzmnC8cNGz
	YwKVKDe9Ab2cZF8k2x8Lfhlp4iunYeGrt5UZwWR9cU8cfN+D5FhY8DisZL4x7Mz23rR2fr
	93yNaeTKVeDGEfwxzwljsSRjbQAf3VBf+9GSzaro4VmQ7v6BtVdjpCMJ9K18gDnBlBlsxC
	+rOXGM6lDYKerVUQjGMcInyerBpQnhgctT50Yo2a6mn4ZTRAo9lzXp5d7oyz+vPgsXMvJy
	DiaxngnZmB2QrdTSa6QytVfA+rR8ZARpvTKPjOsc7spmgFmJHk1J+ROQBvGj/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMa1e4Lt8pI1rEZtwwgTMisSWpfEBV60+MoCFYqeXAo=;
	b=jDhTkiUFGKyHtmS+tSm8K9vP5gH4jSpKKy4pVSfySL4EYDmACBcp0sMV3Uq+LuDzo1Jk1+
	oI1SVNnn8CADVODw==
From: "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Define sched_clock_irqtime as static key
Cc: Yafang Shao <laoar.shao@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, mkoutny@suse.com,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250103022409.2544-2-laoar.shao@gmail.com>
References: <20250103022409.2544-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263486.31546.10051301284393438661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8722903cbb8f0d51057fbf9ef1c680756b74119e
Gitweb:        https://git.kernel.org/tip/8722903cbb8f0d51057fbf9ef1c680756b7=
4119e
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Fri, 03 Jan 2025 10:24:06 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:25 +01:00

sched: Define sched_clock_irqtime as static key

Since CPU time accounting is a performance-critical path, let's define
sched_clock_irqtime as a static key to minimize potential overhead.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250103022409.2544-2-laoar.shao@gmail.com
---
 kernel/sched/cputime.c | 16 +++++++---------
 kernel/sched/sched.h   | 13 +++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0bed0fa..5d9143d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -9,6 +9,8 @@
=20
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
=20
+DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
+
 /*
  * There are no locks covering percpu hardirq/softirq time.
  * They are only modified in vtime_account, on corresponding CPU
@@ -22,16 +24,14 @@
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
=20
-static int sched_clock_irqtime;
-
 void enable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime =3D 1;
+	static_branch_enable(&sched_clock_irqtime);
 }
=20
 void disable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime =3D 0;
+	static_branch_disable(&sched_clock_irqtime);
 }
=20
 static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
@@ -57,7 +57,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned=
 int offset)
 	s64 delta;
 	int cpu;
=20
-	if (!sched_clock_irqtime)
+	if (!irqtime_enabled())
 		return;
=20
 	cpu =3D smp_processor_id();
@@ -90,8 +90,6 @@ static u64 irqtime_tick_accounted(u64 maxtime)
=20
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
=20
-#define sched_clock_irqtime	(0)
-
 static u64 irqtime_tick_accounted(u64 dummy)
 {
 	return 0;
@@ -478,7 +476,7 @@ void account_process_tick(struct task_struct *p, int user=
_tick)
 	if (vtime_accounting_enabled_this_cpu())
 		return;
=20
-	if (sched_clock_irqtime) {
+	if (irqtime_enabled()) {
 		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
@@ -507,7 +505,7 @@ void account_idle_ticks(unsigned long ticks)
 {
 	u64 cputime, steal;
=20
-	if (sched_clock_irqtime) {
+	if (irqtime_enabled()) {
 		irqtime_account_idle_ticks(ticks);
 		return;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 300db6f..3da237c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3233,6 +3233,12 @@ struct irqtime {
 };
=20
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
+DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
+
+static inline int irqtime_enabled(void)
+{
+	return static_branch_likely(&sched_clock_irqtime);
+}
=20
 /*
  * Returns the irqtime minus the softirq time computed by ksoftirqd.
@@ -3253,6 +3259,13 @@ static inline u64 irq_time_read(int cpu)
 	return total;
 }
=20
+#else
+
+static inline int irqtime_enabled(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
=20
 #ifdef CONFIG_CPU_FREQ

