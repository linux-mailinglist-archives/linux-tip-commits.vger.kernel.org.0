Return-Path: <linux-tip-commits+bounces-2594-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046DB9B0C8A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D081F25567
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DE21744D;
	Fri, 25 Oct 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEN6UpiW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yv3NXgwC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9509216DF4;
	Fri, 25 Oct 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879291; cv=none; b=BjXLpIQdqPz2VI/H6vvFJxOxFQ+IVaWphGay6e42oyVfUc5/Nh09J+QnoBQ+YwUuS+sPR5Amn34RlYyFck8iy/K5jkW2ff4ETOdqJKExxFkZZTQcneqQekZ1Gk/kra0qaGF6k8guGG322YB/BkUD1WYC9+iqyD+dycYHfknmTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879291; c=relaxed/simple;
	bh=HEiihj+IrYD8kZlpnmqPHw7yDtcx2sIM6GYYlBTNM4Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bfYCCv5GZTKGkZqeHK1Jyul2AKGsyOB4EUmWy2a4aCH3rsCUF/SfxXy4lMZI371aX4RcCAYgsebjpPRMLudH9Pi/wrq8dC/mQgccNOech07Fs0AVOmZBOut9JWw8Abvfg/7NhT4fQFArFbejEQhknfmKZv/vpUmLVylyH3U8ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEN6UpiW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yv3NXgwC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBQ6ob1P5I1rQdixnMCMwHb4TehA5mgKVDSe9Dpo8ms=;
	b=WEN6UpiWKtWOhG7aJARZ0B6bn52BO3lW8NlUqnda+u6mnTdGO2acuWAB1oChodBzhaShTM
	AcNXBAXCPepxCsqTUjpp0hCyab26RiuRCcc2COLT4ZGERUmkrYzRegIH6FrUu75UA2atMg
	gcSBj9et0TjBnD7MAzDEzrKuFFHKLPzyJ01UWDK+FIcyUlvW36rGrzVKTLi2MU4H01hT6E
	cGaboju9a6e/KpF2cxlvYzkA5vyVak03Y9edGXyGAspLz+H81uDEwLyE9lwf3mmiLMCjx8
	OCnlWe97Gahj2pliqE6Y6v86WdOKNZm9OVI0cABj7K1ndrJk6iDpXhM8L/2VEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBQ6ob1P5I1rQdixnMCMwHb4TehA5mgKVDSe9Dpo8ms=;
	b=yv3NXgwCV76XGEyxwfh8KOlsEp8r+8i51eBpSAKGY3EhucYcqP/xdgCH2ukVusJhAq7x59
	qjn6n6UV/hlfcxAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Encapsulate locking/unlocking of
 timekeeper_lock
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-8-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-8-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928529.1442.17064746701978445916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dbdcf8c4caeca8192daa43429ccf23a1feec126c
Gitweb:        https://git.kernel.org/tip/dbdcf8c4caeca8192daa43429ccf23a1feec126c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:13 +02:00

timekeeping: Encapsulate locking/unlocking of timekeeper_lock

timekeeper_lock protects updates of timekeeper (tk_core). It is also used
by vdso_update_begin/end() and not only internally by the timekeeper code.

As long as there is only a single timekeeper, this works fine.  But when
the timekeeper infrastructure will be reused for per ptp clock timekeepers,
timekeeper_lock needs to be part of tk_core..

Therefore encapuslate locking/unlocking of timekeeper_lock and make the
lock static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-8-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c          | 15 ++++++++++++++-
 kernel/time/timekeeping_internal.h |  3 ++-
 kernel/time/vsyscall.c             |  5 ++---
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 848d2b1..77e0a0f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -41,7 +41,7 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
 
-DEFINE_RAW_SPINLOCK(timekeeper_lock);
+static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 
 /*
  * The most important data for readout fits into a single 64 byte
@@ -114,6 +114,19 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.base[1] = FAST_TK_INIT,
 };
 
+unsigned long timekeeper_lock_irqsave(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	return flags;
+}
+
+void timekeeper_unlock_irqrestore(unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+}
+
 /*
  * Multigrain timestamps require tracking the latest fine-grained timestamp
  * that has been issued, and never returning a coarse-grained timestamp that is
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 0bbae82..b3dca83 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -49,6 +49,7 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 #endif
 
 /* Semi public for serialization of non timekeeper VDSO updates. */
-extern raw_spinlock_t timekeeper_lock;
+unsigned long timekeeper_lock_irqsave(void);
+void timekeeper_unlock_irqrestore(unsigned long flags);
 
 #endif /* _TIMEKEEPING_INTERNAL_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 9193d61..98488b2 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -151,9 +151,8 @@ void update_vsyscall_tz(void)
 unsigned long vdso_update_begin(void)
 {
 	struct vdso_data *vdata = __arch_get_k_vdso_data();
-	unsigned long flags;
+	unsigned long flags = timekeeper_lock_irqsave();
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	vdso_write_begin(vdata);
 	return flags;
 }
@@ -172,5 +171,5 @@ void vdso_update_end(unsigned long flags)
 
 	vdso_write_end(vdata);
 	__arch_sync_vdso_data(vdata);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	timekeeper_unlock_irqrestore(flags);
 }

