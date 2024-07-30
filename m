Return-Path: <linux-tip-commits+bounces-1882-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E367E941C96
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DAF1C23738
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B971A3DAD;
	Tue, 30 Jul 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlyeXXex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gh9jLclR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1851A2C12;
	Tue, 30 Jul 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359198; cv=none; b=tDSEFqpeeW0xcDgwD1zXcT3PulkPMPGkuhYAdApakc8oY4FuLj9qrIEyxPzXdTipFOwhaLj/Q2/gDNXicb1YuoEajQ4Qb9c8KJm+EEmcKJPWNx66ar7UDLLzQKhCz8Vc2+t0A85EifEWeg+sR2eugtkrNhHVKQ6cYVMqvWYk5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359198; c=relaxed/simple;
	bh=ukGUbcK2fmqesfNDRYXPl2WOf+CN36CBT71MNYnKsyM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bO2ybkb8hMEzIi4u+isQMPOkJgVWivg1MYGUOUrGtT4Xev9ELj+P/Rikiz1+QgZGQlt52kv4FCrx/rzL+alLk4IbpXdQkaN6/H1Ongl38gQDTrwkZm6k2lY2OaxISUgmGpR0IZBC47Ku8IyXe4Jsy9NTvm69E5cLGSqNhWYVIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlyeXXex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gh9jLclR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Em4hOHVvNJ3ZTWBuiC0Zmb+NA4Mmw8zN//p+QrR3+50=;
	b=dlyeXXexjVEEEr2AEttGbxgFp8aw0o+V1m2q24PvbsMtJa1FnXNTqL7kb/0/+Qqe5AFvHH
	+xgCx969AYO6nc7FWlwjnyMjpl5UI+WOg0Yp2X4eFghNwyXANWGFjjLh/nkvcDASATzrSw
	+PmwpImfidwJMrQt5OwVBtNIICSQbLRKq69OYLYPqowSkV+bMtbam4NUEBJ5FogcmzNdHp
	mce5haV+l7ca66fn+gC1+TYWFuTcoKGZHX5HJN9uYcAkFrLX0TLmpmsaNAHwDvqX1p/scb
	c7ZURCAaNcgkRbB6bQO+h5UMZLXTzBTmdDHuwUpuS7MWfIAvjoh/stbCoFRHQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Em4hOHVvNJ3ZTWBuiC0Zmb+NA4Mmw8zN//p+QrR3+50=;
	b=gh9jLclRvq/jbSjqEC97X5UP35vTf5yLYsx4+fFNSrvwHxJEVdQCbCvRVklVypSxMQCCKs
	b5Aiz3k0v1REA4AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Split up posix_cpu_timer_get()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919486.2215.6148994457974388735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d859704bf18519739c231403d53461e008eea4bf
Gitweb:        https://git.kernel.org/tip/d859704bf18519739c231403d53461e008eea4bf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:14 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Split up posix_cpu_timer_get()

In preparation for addressing issues in the timer_get() and timer_set()
functions of posix CPU timers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 51 +++++++++++++++------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index e9c6f9d..558be8d 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -785,33 +785,9 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	return ret;
 }
 
-static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
-	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	u64 now, expires = cpu_timer_getexpires(ctmr);
-	struct task_struct *p;
-
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
-
-	/*
-	 * Easy part: convert the reload time.
-	 */
-	itp->it_interval = ktime_to_timespec64(timer->it_interval);
-
-	if (!expires)
-		goto out;
-
-	/*
-	 * Sample the clock to take the difference with the expiry time.
-	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		now = cpu_clock_sample(clkid, p);
-	else
-		now = cpu_clock_sample_group(clkid, p, false);
+	u64 expires = cpu_timer_getexpires(&timer->it.cpu);
 
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
@@ -823,7 +799,28 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 		itp->it_value.tv_nsec = 1;
 		itp->it_value.tv_sec = 0;
 	}
-out:
+}
+
+static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+{
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
+	struct task_struct *p;
+	u64 now;
+
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (p) {
+		itp->it_interval = ktime_to_timespec64(timer->it_interval);
+
+		if (cpu_timer_getexpires(&timer->it.cpu)) {
+			if (CPUCLOCK_PERTHREAD(timer->it_clock))
+				now = cpu_clock_sample(clkid, p);
+			else
+				now = cpu_clock_sample_group(clkid, p, false);
+
+			__posix_cpu_timer_get(timer, itp, now);
+		}
+	}
 	rcu_read_unlock();
 }
 

