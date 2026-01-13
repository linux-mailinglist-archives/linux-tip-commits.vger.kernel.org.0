Return-Path: <linux-tip-commits+bounces-7901-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB70D181D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AA9E30146E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3D347FF4;
	Tue, 13 Jan 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LX/rPCgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HiFXikWl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F4349B19;
	Tue, 13 Jan 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301010; cv=none; b=ifQ8MoLPpBnibAD8iR440XxhOC4Jz30+FyS4SYK9uQMOrGu8iA8iD4qtTZlnyyUzo+nkIO5dMAbQK33uIXSzrnxpdX5ABtnOk687Dl7q1qrhQanMpw9TDr9538csrSBTlLB7BwLad8XvK8kT3krjrprM0NzkVj5KcLUTa+HuMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301010; c=relaxed/simple;
	bh=6sCmWi6KYP6SgQqumK4V4r46ZZG7V9u3NVaicixAspU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=A3Xg1DA4dDCJWs35OlhuXck2jZuuqblEVNf/SwTeRVbiocvhNP4oB4uc+lDsOi66hQHBzZJciHM8qJScXGZfAJBR9GI7xgu175hpEw4uPfuIIbkrwtbl+DraPAWsqPr2SOd+m9RYPHHDaJtePY8KRX6g+mNgcsPT6PxGoJbwG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LX/rPCgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HiFXikWl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Mbyg9FtChcxuJjTecaMKuSuVbWBm7oHNHGhaIx4FAaM=;
	b=LX/rPCgPL10BDivEnGI+GePoNvx1Fq7+Oj2/R+XAZJPNc+fjKti8SQ2BoNZYOxxvgQpgjq
	5HtWaJc+6KVecMwbMCkaEJein1bJSRiIj7l3rWKjuQlTOmxdEEqP0Pv3KgLoCEDrh8X+Kr
	cFnvxlWcG5wOjbJhYYoNDBB7SFJM6gZmdm74lVaGMhEIb9aPJN5sed2rQ9CZDKYvBZaJZQ
	NUFE0tVnekaUNFpBzhWuHHnxaoISkH29J+IYTAJI8/OJnSYHBZobZyMz/kZ6vnwjo8oU2W
	yaoSEMXe/kCGzgVYvJbhkJOAy0XcE2ckwDB+sv9gLI2WXY8mvpYdB6+Zb9DU3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Mbyg9FtChcxuJjTecaMKuSuVbWBm7oHNHGhaIx4FAaM=;
	b=HiFXikWl3gL6Frd73DU2CIw2PgKyC/L91L0lCGI5rQQx4vFarRolcxp8QgG1iVAKCYmaU5
	FDK3CpuDBRMRHxCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Provide idle_rq() helper
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830100511.510.6520514784156590194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     1e0a2ba7afb1b60f02599093d84b72ce62ad11c0
Gitweb:        https://git.kernel.org/tip/1e0a2ba7afb1b60f02599093d84b72ce62a=
d11c0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 13 Jan 2026 10:50:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:37:52 +01:00

sched: Provide idle_rq() helper

A fix for the dl_server 'requires' idle_cpu() usage, which made me
note that it and available_idle_cpu() are extern function calls.

And while idle_cpu() is used outside of kernel/sched/,
available_idle_cpu() is not.

This makes it hard to make idle_cpu() an inline helper, so provide
idle_rq() and implement idle_cpu() and available_idle_cpu() using
that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |  1 -
 kernel/sched/sched.h    | 22 ++++++++++++++++++++++
 kernel/sched/syscalls.c | 30 +-----------------------------
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d395f28..da01335 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1874,7 +1874,6 @@ static inline int task_nice(const struct task_struct *p)
 extern int can_nice(const struct task_struct *p, const int nice);
 extern int task_curr(const struct task_struct *p);
 extern int idle_cpu(int cpu);
-extern int available_idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_=
param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struc=
t sched_param *);
 extern void sched_set_fifo(struct task_struct *p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6..e885a93 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1364,6 +1364,28 @@ static inline u32 sched_rng(void)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
=20
+static inline bool idle_rq(struct rq *rq)
+{
+	return rq->curr =3D=3D rq->idle && !rq->nr_running && !rq->ttwu_pending;
+}
+
+/**
+ * available_idle_cpu - is a given CPU idle for enqueuing work.
+ * @cpu: the CPU in question.
+ *
+ * Return: 1 if the CPU is currently idle. 0 otherwise.
+ */
+static inline bool available_idle_cpu(int cpu)
+{
+	if (!idle_rq(cpu_rq(cpu)))
+		return 0;
+
+	if (vcpu_is_preempted(cpu))
+		return 0;
+
+	return 1;
+}
+
 #ifdef CONFIG_SCHED_PROXY_EXEC
 static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
 {
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0496dc2..cb337de 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -180,35 +180,7 @@ int task_prio(const struct task_struct *p)
  */
 int idle_cpu(int cpu)
 {
-	struct rq *rq =3D cpu_rq(cpu);
-
-	if (rq->curr !=3D rq->idle)
-		return 0;
-
-	if (rq->nr_running)
-		return 0;
-
-	if (rq->ttwu_pending)
-		return 0;
-
-	return 1;
-}
-
-/**
- * available_idle_cpu - is a given CPU idle for enqueuing work.
- * @cpu: the CPU in question.
- *
- * Return: 1 if the CPU is currently idle. 0 otherwise.
- */
-int available_idle_cpu(int cpu)
-{
-	if (!idle_cpu(cpu))
-		return 0;
-
-	if (vcpu_is_preempted(cpu))
-		return 0;
-
-	return 1;
+	return idle_rq(cpu_rq(cpu));
 }
=20
 /**

