Return-Path: <linux-tip-commits+bounces-2795-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E29BFB98
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7371F22B3A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B371946BB;
	Thu,  7 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FnPGFzP5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMYGaC6T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B93192B6F;
	Thu,  7 Nov 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943104; cv=none; b=K7nWaGKIXCz8UgyAk4mp+oj00vP5NU8T9SEzg8xKZrczIjbyUKqAseLJwmJBI22VcMWhrLw4Ka74/nFUJfNf6sWHKIBCjuTRf3XuVJZrduHvWTysNjLHNEPCPIzhneA0TqDMG+Ehw4Lskd4nQgshwDNBM3w+IuJ632u6OvoEQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943104; c=relaxed/simple;
	bh=SrWad8vfggJyan8IC7lTOvqzwis91i0pfkAKhfujLjA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qsLG0iKgja9QO2pU+RKgVPgUXe8BPuSYqiiCu82GrJZpP4q97qkFLr+0X2FRazLJ7XYsDtPRdSKUPnGiqL5rXCglkWizLltTjxe6YNNUQ6HQMQUQCQHbPV+fGIp++GorktUm6fR0pSATpe8FjrfUGqVtKPg+hcb1PEDgy5Wk7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FnPGFzP5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMYGaC6T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dlLDHKz5IZNl9otahgzg4CfArIxXqnRzbFqdG/R6aw=;
	b=FnPGFzP5AdasEGVNIORHGKyIzAFJK232rNMdr4wrmdOfaTcBcG9r8ZuNHNSFj17tm/+jpQ
	Cks21HEWa5lWJyrb+A/ZD7SAVfDwrotYQLQ4sPEwMsvPoEs/xY1UhqwyVA2eTONwEpJ042
	x4LjzFq3z0aoEiEAyJmvMwlnJKg3ptGLs/oBVqvCPsfPidz/yv0UagANpXM34AR/jtj8f8
	s7G8BwFITP9kQ6fJpF/9IBmm5qudNOgljmqnANG+KI0tPtMi7PAO4BrPgKP8ZoKkxSc5hI
	W9kevX/SVH3EXDoLCi1+zRmu0bTRbiuT5Gmr8I1I9EfC8jP8tPAqs//HLc3bvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dlLDHKz5IZNl9otahgzg4CfArIxXqnRzbFqdG/R6aw=;
	b=kMYGaC6TSTtthgFGgh9EVUuogce5GVhCUXS2jqbGCyu918BTT06RtwEwlGMXhDlDA3wtYz
	on8np3ioeamsmRBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Use dedicated flag for CPU timer
 nanosleep
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.238550394@linutronix.de>
References: <20241105064213.238550394@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094310087.32228.4688172468522182830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4cf7bf2a2f1a8ace4a49a1138c8123fdb5990093
Gitweb:        https://git.kernel.org/tip/4cf7bf2a2f1a8ace4a49a1138c8123fdb5990093
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:43 +01:00

posix-cpu-timers: Use dedicated flag for CPU timer nanosleep

POSIX CPU timer nanosleep creates a k_itimer on stack and uses the sigq
pointer to detect the nanosleep case in the expiry function.

Prepare for embedding sigqueue into struct k_itimer by using a dedicated
flag for nanosleep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.238550394@linutronix.de


---
 include/linux/posix-timers.h   | 2 ++
 kernel/time/posix-cpu-timers.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index b1de217..bcd0120 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -42,6 +42,7 @@ static inline int clockid_to_fd(const clockid_t clk)
  * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @nanosleep:	Timer is used for nanosleep and is not a regular posix-timer
  * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
@@ -50,6 +51,7 @@ struct cpu_timer {
 	struct pid			*pid;
 	struct list_head		elist;
 	bool				firing;
+	bool				nanosleep;
 	struct task_struct __rcu	*handling;
 };
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a282a3c..0c441d8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -596,7 +596,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 
 	timer->it_status = POSIX_TIMER_DISARMED;
 
-	if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(ctmr->nanosleep)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -1493,6 +1493,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+	timer.it.cpu.nanosleep = true;
 
 	if (!error) {
 		static struct itimerspec64 zero_it;

