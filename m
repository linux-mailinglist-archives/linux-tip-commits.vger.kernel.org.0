Return-Path: <linux-tip-commits+bounces-5112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1B7A9ADBE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 14:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126DF172961
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8025DD08;
	Thu, 24 Apr 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rh5AZas8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJAbNOyN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749351DEFC8;
	Thu, 24 Apr 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498494; cv=none; b=B2RI0euhPpuONhvvGqYji0dk7wUkcDnk1zKvATSFcMHeBwxcGo3iJBlfdzG6eZBrlj8Afa5blh2bljjAFK4Se0Tr5rXJxpchIdP/JUe60hoytFi/F8k4Odr7lDkWswRXomPDtsygRJqogEypVbZauJU1S2rXKWeS4/wjHpgMV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498494; c=relaxed/simple;
	bh=Ao0dg1JtVGrD54HmD0TeUgV+jkCOoUQZVd9T++hcFMQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=efrB8Icekbp81URw28z615OQSORgGBQv2aaJtQm9FCI0sw0lJrc1Gxwh2W9OizlRKCHDgTrhY/n2qqDexUESVCcVorwk+BGCntKOl/MN1rtIx8vu8JCZBwAJLytj9q/G2wTSpas2KW5dhpmlgLx7xgnBmg9GGjK51vTm9Bn7JPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rh5AZas8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJAbNOyN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 12:41:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745498490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1K02YRnYXcFgHWzTd2Acww7Rvsxw9kJk0oAf3uzO/kU=;
	b=rh5AZas8BVaaWs6IIldQWUPhD6gdGybk+V733fNXYZhx7x6GWIQS9P24BHauz1Ns9ff8wG
	SKjYzsL61UFQbo4EQnNmaQYI2Pxj2DHA+I6a/N7A0ciBX7tO4vzXBp7MANtWjGQSF8ElFm
	O52a4et3Is++9AsjF6IJy3dl0xxPL0IitMyxQgbdkgxgg9YAHR6TrJiwTju9DN2kEJLl5F
	v5dhd/SOQ3Jn294oBdsE397ImDZ2fOeu1ANYXUOupWs6GzWt62RXZgpRA1lUZGSeLV8W2M
	3JNXjDz7g0l4Nt7SRPST/7fzrK6ZCgKhNT0/w7wKr+LRjOWKkTxY+2rlvEYyvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745498490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1K02YRnYXcFgHWzTd2Acww7Rvsxw9kJk0oAf3uzO/kU=;
	b=qJAbNOyNLv64WB4SaK5TQ+hd27i/xldfZJm+8vE1YY6nJBB5bDvsHkXprYT6btA3Oz8lDu
	2jZbEF4n5ffPclDA==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Remove unused __round_jiffies(_up)
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418200803.427911-1-linux@treblig.org>
References: <20250418200803.427911-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174549848950.31282.3516934679529036592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     49916e22d9530d6cf027e635a5d824c7d698d67f
Gitweb:        https://git.kernel.org/tip/49916e22d9530d6cf027e635a5d824c7d698d67f
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Fri, 18 Apr 2025 21:08:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Apr 2025 14:31:35 +02:00

timers: Remove unused __round_jiffies(_up)

Remove two trivial but long unused functions.

__round_jiffies() has been unused since 2008's
commit 9c133c469d38 ("Add round_jiffies_up and related routines")

__round_jiffies_up() has been unused since 2019's
commit 7ae3f6e130e8 ("powerpc/watchdog: Use hrtimers for per-CPU
heartbeat")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250418200803.427911-1-linux@treblig.org

---
 include/linux/timer.h |  2 +--
 kernel/time/timer.c   | 42 +------------------------------------------
 2 files changed, 44 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 10596d7..e17aac7 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -172,12 +172,10 @@ extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
 
-unsigned long __round_jiffies(unsigned long j, int cpu);
 unsigned long __round_jiffies_relative(unsigned long j, int cpu);
 unsigned long round_jiffies(unsigned long j);
 unsigned long round_jiffies_relative(unsigned long j);
 
-unsigned long __round_jiffies_up(unsigned long j, int cpu);
 unsigned long __round_jiffies_up_relative(unsigned long j, int cpu);
 unsigned long round_jiffies_up(unsigned long j);
 unsigned long round_jiffies_up_relative(unsigned long j);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4d915c0..1b2a884 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -386,32 +386,6 @@ static unsigned long round_jiffies_common(unsigned long j, int cpu,
 }
 
 /**
- * __round_jiffies - function to round jiffies to a full second
- * @j: the time in (absolute) jiffies that should be rounded
- * @cpu: the processor number on which the timeout will happen
- *
- * __round_jiffies() rounds an absolute time in the future (in jiffies)
- * up or down to (approximately) full seconds. This is useful for timers
- * for which the exact time they fire does not matter too much, as long as
- * they fire approximately every X seconds.
- *
- * By rounding these timers to whole seconds, all such timers will fire
- * at the same time, rather than at various times spread out. The goal
- * of this is to have the CPU wake up less, which saves power.
- *
- * The exact rounding is skewed for each processor to avoid all
- * processors firing at the exact same time, which could lead
- * to lock contention or spurious cache line bouncing.
- *
- * The return value is the rounded version of the @j parameter.
- */
-unsigned long __round_jiffies(unsigned long j, int cpu)
-{
-	return round_jiffies_common(j, cpu, false);
-}
-EXPORT_SYMBOL_GPL(__round_jiffies);
-
-/**
  * __round_jiffies_relative - function to round jiffies to a full second
  * @j: the time in (relative) jiffies that should be rounded
  * @cpu: the processor number on which the timeout will happen
@@ -483,22 +457,6 @@ unsigned long round_jiffies_relative(unsigned long j)
 EXPORT_SYMBOL_GPL(round_jiffies_relative);
 
 /**
- * __round_jiffies_up - function to round jiffies up to a full second
- * @j: the time in (absolute) jiffies that should be rounded
- * @cpu: the processor number on which the timeout will happen
- *
- * This is the same as __round_jiffies() except that it will never
- * round down.  This is useful for timeouts for which the exact time
- * of firing does not matter too much, as long as they don't fire too
- * early.
- */
-unsigned long __round_jiffies_up(unsigned long j, int cpu)
-{
-	return round_jiffies_common(j, cpu, true);
-}
-EXPORT_SYMBOL_GPL(__round_jiffies_up);
-
-/**
  * __round_jiffies_up_relative - function to round jiffies up to a full second
  * @j: the time in (relative) jiffies that should be rounded
  * @cpu: the processor number on which the timeout will happen

