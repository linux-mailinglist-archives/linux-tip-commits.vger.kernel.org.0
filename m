Return-Path: <linux-tip-commits+bounces-1878-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C6941C89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1711F249C0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD51A254B;
	Tue, 30 Jul 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKFPew11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qeIwsqpo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581318E050;
	Tue, 30 Jul 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359196; cv=none; b=bWze8nwswBI19AL16bgphN83ExEgIsniNkRxuXMYb0aJBnaIrgwQ4dBcnklIe2TneJcAuds959zmcURYpf0ae6KeDp6RPHCXvxVJ+uC1zrByszKna0Fz9M+IWzTsQC2EHnElqifasZYLE1v/FoKSExINle9QUbil1U/0ldzpFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359196; c=relaxed/simple;
	bh=/fq4wexmvvnh9Tv202kdwUKU/dEYKvjiE5eIWBJnMUI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kblBB1VmLil4U/vbtlKn+gCdpRQbGkoniws/fzm8Nv5bGvbZRzvEw2dkcEK1F7LixZx5FRy8DTSDYIxAlEyoIkc4LU0QpT7Zr8OGGsY8Q+3l/avBCRMy0JH8g2SzRW+ZYUWK7nkitFnVUSXJmeSvB7viQrxKeQMS57cx/JbVriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKFPew11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qeIwsqpo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RBtN34cT4LpDP5Yu1t2e3xPqQwmScks59N7dKm5dimo=;
	b=rKFPew11sQl5RnoCpeWrh72SL7Q6jJRkRC7svDrcXcceqZDdwzvSwsm0P5sz8lR9toS4yb
	N+OsI/i73XMouc3HmUj/4pFaD51IiyTjTvuvdzBsp3R0kCz+DSP0ZAI4LnGXE1alHwE1Us
	ChEMMjtpHNmaXXhCIiMnl+mSwWfn/kSM50+mSZ1dYhqfTUfO4uv9kRwbwCtYd+3lvrZgdu
	ZYWXnDdjHIqsOBfDOnHhe5z7W9G9c2zHwTYt9er9fy+6rxoaj/LNhsOVcNBok+KDyEy5kl
	bumrMDwoBtE6EbGbM7tR92zn9GSmL5BkbmkFVUhffGmQ8ZFgy5BUY1BxLbAnlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RBtN34cT4LpDP5Yu1t2e3xPqQwmScks59N7dKm5dimo=;
	b=qeIwsqposkiLW85ExoEwPOBxd8vJi2ZIj5uq22JrRt6dQgJ0DWcK5qCH3ID7GwiPy+BepI
	Vz1SYbdwl0xkulBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919298.2215.4421183746655356881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5f9d4a1065949a64c107f93a89dc2b62f806c833
Gitweb:        https://git.kernel.org/tip/5f9d4a1065949a64c107f93a89dc2b62f806c833
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 13:16:02 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Handle SIGEV_NONE timers correctly in timer_set()

Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
timer_get(), but the posix CPU timer implementation returns 1 nsec.

Add the missing conditional.

This will be cleaned up in a follow up patch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index d70879d..cf89044 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -623,6 +623,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
@@ -706,7 +707,16 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 				old_expires = exp - val;
 				old->it_value = ns_to_timespec64(old_expires);
 			} else {
-				old->it_value.tv_nsec = 1;
+				/*
+				 * A single shot SIGEV_NONE timer must return 0, when it is
+				 * expired! Timers which have a real signal delivery mode
+				 * must return a remaining time greater than 0 because the
+				 * signal has not yet been delivered.
+				 */
+				if (sigev_none)
+					old->it_value.tv_nsec = 0;
+				else
+					old->it_value.tv_nsec = 1;
 				old->it_value.tv_sec = 0;
 			}
 		}

