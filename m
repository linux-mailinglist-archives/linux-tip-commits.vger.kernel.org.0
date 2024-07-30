Return-Path: <linux-tip-commits+bounces-1879-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B3941C90
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A661F24C68
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80831A4B43;
	Tue, 30 Jul 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ijk8VY5A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/1Z3gpR0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A21917FA;
	Tue, 30 Jul 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359197; cv=none; b=KcUpLuW9HKeLDkttGHQbZlacoiScGvl/H6kKKlzr93/KPOktvgQgYyS8/C+KcmO98RHUOKB6Xm8ewl5mB/TKCrM1TOi/GIjGVt25R9zWHEQbdPCM51hNs2JMM4o2U2DIVT1bsbsL6D9CulkUciN8pggozDCrlGy+91t0umjtLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359197; c=relaxed/simple;
	bh=LNIgbCHaUSDU4s46+KTqUGzyzoMUlKyp9ba6A/ANoi8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=T4M8YD8iIqbnZnO5224W5ar9eyNP08plQhOCakD2iYw0aSqUhe5arYRY6ToPzjVnYPEl3MEy/cldexwyFMuYBcVlZGulNSNCx7SX/4uppR/nOfXTP8LQeqLV9q6YxvvIDSiCc84VH41emQGSVtM+t/nduFgzZKAP0xwsgnsK9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ijk8VY5A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/1Z3gpR0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZrH8uqBk8dqTDv5Hj9lO+aPhDyG7o75cJGtWmvOTd64=;
	b=ijk8VY5Ai4VbJwPNgjqI96vnPgRS/z+ifaGGm2tOfHXa+LTb2BzhpuZFUzDAKKP/edSE26
	c2BSKqNXC0KpmtOl/LDO5yzbYcDZeMobCsnMOp4zfkt4JQJcBGdT5hZROS5Bc9jhf6KgM9
	D28gDURZT13KI+WNhgyobSB1hau5XN0o47OOKbHkk/LDDWtihwMIn2N2eW6nRMoZKK8NKU
	71QlWrjTgTG0m3d3OFfP66nI9E2iV6hZw9JCMpOKHNvouh7qwxpO0g+IlvfCHxxqG4WV3s
	wpxBT7uLjfAW1fcZm1/ocUlARQF4lYjtz/cTtQr12uuTTbUhe4iUDAOeUXlGUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZrH8uqBk8dqTDv5Hj9lO+aPhDyG7o75cJGtWmvOTd64=;
	b=/1Z3gpR02j5b7auq06ZgYPqStrBYvuiTXQX6HqM47/0pKSzX/FFlK/a4pSAkU6e6tE5l3c
	s/NecmmeKhF3ykAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Handle interval timers correctly
 in timer_get()
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
Message-ID: <172235919392.2215.7532602221089653506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1c5028425793ea98fcb403852331664662d97226
Gitweb:        https://git.kernel.org/tip/1c5028425793ea98fcb403852331664662d97226
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:16 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Handle interval timers correctly in timer_get()

timer_gettime() must return the remaining time to the next expiry of a
timer or 0 if the timer is not armed and no signal pending, but posix CPU
timers fail to forward a timer which is already expired.

Add the required logic to address that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5aac088..92222ca 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -787,8 +787,24 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
-	u64 expires = cpu_timer_getexpires(&timer->it.cpu);
+	u64 expires, iv = timer->it_interval;
 
+	/*
+	 * Make sure that interval timers are moved forward for the
+	 * following cases:
+	 *  - Timers which expired, but the signal has not yet been
+	 *    delivered
+	 */
+	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
+		expires = bump_cpu_timer(timer, now);
+	else
+		expires = cpu_timer_getexpires(&timer->it.cpu);
+
+	/*
+	 * Expired interval timers cannot have a remaining time <= 0.
+	 * The kernel has to move them forward so that the next
+	 * timer expiry is > @now.
+	 */
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
 	} else {

