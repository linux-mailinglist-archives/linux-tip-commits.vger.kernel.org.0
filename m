Return-Path: <linux-tip-commits+bounces-3591-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA74A3FFBB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 20:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B01F189B8C3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B5252907;
	Fri, 21 Feb 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lHtikE3V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHz2xG18"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86824CEEE;
	Fri, 21 Feb 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166199; cv=none; b=WLLpqzOLBNLrjmIAxElejfx663811vFCD2kRjyfoZVH0xnmlDtZ12FQCGt8GRFxUEnT5VGju+HbXB4Dc1KNoXMNGz/PRbYv5zn+uLJoLFbbleaBBZ4Fp9C6nbApldpEATdJW+W/5cfkloM94wZnlTYVSQL2sEEHbfVXFXyK2we4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166199; c=relaxed/simple;
	bh=O+QqFhXxpYievekpx05AI6kQIcJEvUTk7Ux7o0b4D0w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jd81oV0fgzOCXLxbdvbx6CH9iE0OadblXR4E9TlCqyYVIws3TvUhtQpr4uqNGQmDyneJZ7AYIEoEDtrs8bkb0qXmSAXbGw/phHflbZ2z0ziIaQ3590C2jIHZuYVpZczC8KrjhpvJ8D1yRBcbbyYXGjbqi1Z5NSxJ/OIznVXkI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lHtikE3V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHz2xG18; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 19:29:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740166195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrb62EwKvwHX9mi58ZsaIKsZE3j++vHCFWswugpGoj0=;
	b=lHtikE3VJJvxSQKraM58vobS5fALXzE5kKviDfpoJoVvtJEMnzsVJMaqgdp/2YyOwIF01C
	teYowc+3Rv5kTYsMD0z4aEtwUix96tlF9+YV+RUv4lFr/YiAZNHGlMwP3Oae/RkkyZuQLF
	A+Uc62h1ZlXTeDxVcgpyd38UQR/xbzhwz8mxwZ3CyOPaEomfMrIRAPW9yejhrggUTAm6Vr
	FJzx3/SAIRdtnVt3WU8aDPHaQoadLlHH4WPnDLX1SVi9i6bGgODp+enSqERO29rQl8K7N+
	Q45YqeytYMWTvaTSwAMZOydw4uL4yUmBGyzmzkYU34FB3Fxbu2api9fi4kYXhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740166195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrb62EwKvwHX9mi58ZsaIKsZE3j++vHCFWswugpGoj0=;
	b=tHz2xG18kALvv/vlJ2J2CHcOtTjDkthE21uwdCrXRD3XEOkDzNzEhQ2LurwDxh/p6EKxc+
	tkrbLyY/O9QplOCw==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Add unlikey branch hints to several system calls
Cc: Colin Ian King <colin.i.king@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219142423.45516-1-colin.i.king@gmail.com>
References: <20250219142423.45516-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174016619525.10177.13718447246493744962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1a5d3492f8e14719184945893c610e0802c05533
Gitweb:        https://git.kernel.org/tip/1a5d3492f8e14719184945893c610e0802c05533
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Wed, 19 Feb 2025 14:24:23 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Feb 2025 20:19:13 +01:00

sched: Add unlikey branch hints to several system calls

Adding an unlikely() hint on early error return paths improves the
run-time performance of several sched related system calls.

Benchmarking on an i9-12900 shows the following per system call
performance improvements:

		       before     after     improvement
sched_getattr          182.4ns    170.6ns      ~6.5%
sched_setattr          284.3ns    267.6ns      ~5.9%
sched_getparam         161.6ns    148.1ns      ~8.4%
sched_setparam        1265.4ns   1227.6ns      ~3.0%
sched_getscheduler     129.4ns    118.2ns      ~8.7%
sched_setscheduler    1237.3ns   1216.7ns      ~1.7%

Results are based on running 20 tests with turbo disabled (to reduce
clock freq turbo changes), with 10 second run per test based on the
number of system calls per second. The % standard deviation of the
measurements for the 20 tests was 0.05% to 0.40%, so the results are
reliable.

Tested on kernel build with gcc 14.2.1

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250219142423.45516-1-colin.i.king@gmail.com
---
 kernel/sched/syscalls.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 456d339..9f40348 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -875,7 +875,7 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
 	struct sched_param lparam;
 
-	if (!param || pid < 0)
+	if (unlikely(!param || pid < 0))
 		return -EINVAL;
 	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
 		return -EFAULT;
@@ -984,7 +984,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	struct sched_attr attr;
 	int retval;
 
-	if (!uattr || pid < 0 || flags)
+	if (unlikely(!uattr || pid < 0 || flags))
 		return -EINVAL;
 
 	retval = sched_copy_attr(uattr, &attr);
@@ -1049,7 +1049,7 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 	struct task_struct *p;
 	int retval;
 
-	if (!param || pid < 0)
+	if (unlikely(!param || pid < 0))
 		return -EINVAL;
 
 	scoped_guard (rcu) {
@@ -1085,8 +1085,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	struct task_struct *p;
 	int retval;
 
-	if (!uattr || pid < 0 || usize > PAGE_SIZE ||
-	    usize < SCHED_ATTR_SIZE_VER0 || flags)
+	if (unlikely(!uattr || pid < 0 || usize > PAGE_SIZE ||
+		      usize < SCHED_ATTR_SIZE_VER0 || flags))
 		return -EINVAL;
 
 	scoped_guard (rcu) {

