Return-Path: <linux-tip-commits+bounces-1881-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF67941C92
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E81C232E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C301A4B5F;
	Tue, 30 Jul 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AoFe9/z/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtltWTLt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE31917E3;
	Tue, 30 Jul 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359198; cv=none; b=I3ndeevaA+UdHNxZXTzy2rjcZ9MPjsAAlyiJ41TV3FcUwJ1EEkNzEqmxD+lTsREXCrjwcLG9Ab9X1q4yNeWri2nE1xTlUPhWaogFUVm2M+JbaA/llW8srpITPNraWBTpdUTtw+72nOqTa4+QV2afuiqGE/zUSvU68pRBHuTDI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359198; c=relaxed/simple;
	bh=MCadaScRrwNXDZTCz8uMId1kiHkqaWtqpHsKEM2yRaM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QlNT2u8pb4AF0VY6M+m0ymmQTY9TUT6eliESedjdAuo/GbNPVugm5pRyNI9AAJZvHLK6pt8cAQuX64ZsKAISdiPLzpjDaVtT+XkDJnWAIKYWuxsufU7lvIo+asTlgK9cdD/AihfzGJhd2R2VrTveHSc7APZt+Ezrg26+z+2Yb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AoFe9/z/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtltWTLt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0MR6eqcqYMiBwBzJzQ5+BW/JTOcjfE41zc6E/lk96F8=;
	b=AoFe9/z/8t2eWq9vey3JEa5BRhjFtU7W0n+04FtndoNc/VHc26UOy3FbfE+kotVf3YijCP
	Pmwo/48qilUnUZq6YsVYPMtcEjt4eQYxZgI3D1+blrDffQe3CVwsa0sHEUkVYHEtg0KVFt
	SuNuN9S4SqtiRu4Ni3lwChV5B3sNTtSYN9gndJCOdhu9nNffTQeo4TWySC0JMxcU3IIoiP
	by3UVR2ClWiyrKHzt/0DQNleiAdiG531jw8C2ETRXzfRd8MvfeM+q3X+OWa0W8QbSwJmwB
	adxPYbjG6DWIQrob24vrpK9cG6WgTwqYU7hufrFU4Sy0qs+CzFroSO/79Zinnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0MR6eqcqYMiBwBzJzQ5+BW/JTOcjfE41zc6E/lk96F8=;
	b=TtltWTLtz4kRDbDL6Esvvbz1mMWC7bgRR6oI21QOPfSmtR/AOi4cC96n7nPWM1qrbbKWNN
	UaQ4c7qtAIqec5DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_get()
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
Message-ID: <172235919348.2215.1322782138016132974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d786b8ba9f01b361817033d06766b2dadf619c60
Gitweb:        https://git.kernel.org/tip/d786b8ba9f01b361817033d06766b2dadf619c60
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:17 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Handle SIGEV_NONE timers correctly in timer_get()

Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
timer_get(), but the posix CPU timer implementation returns 1 nsec.

Add the missing conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 92222ca..d70879d 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -787,15 +787,17 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	u64 expires, iv = timer->it_interval;
 
 	/*
 	 * Make sure that interval timers are moved forward for the
 	 * following cases:
+	 *  - SIGEV_NONE timers which are never armed
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
+	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
@@ -809,11 +811,13 @@ static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *i
 		itp->it_value = ns_to_timespec64(expires - now);
 	} else {
 		/*
-		 * The timer should have expired already, but the firing
-		 * hasn't taken place yet.  Say it's just about to expire.
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
-		itp->it_value.tv_nsec = 1;
-		itp->it_value.tv_sec = 0;
+		if (!sigev_none)
+			itp->it_value.tv_nsec = 1;
 	}
 }
 

