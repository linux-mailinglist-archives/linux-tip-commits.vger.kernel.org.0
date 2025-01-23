Return-Path: <linux-tip-commits+bounces-3286-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366BA1AA1C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 20:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415FD1885995
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650FB1917ED;
	Thu, 23 Jan 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BaIKOs84";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWcQnXUf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A119F411;
	Thu, 23 Jan 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659602; cv=none; b=e6q8PTXlxquupvrFxkJg9p5rZU7UZWtirdSXftobzpFp7vsQZuGhNlkOv4DBXq/03iwsY/wc2A9KwYq3PNpLTGkm/VfSWEpbNbcDG1nE4DOLUx4ASuOSiVVaMdiSI1Kq+r+Xf4j6yq0Wrm6dBiXMMrtW6vLNKHN/wgOCIpsXxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659602; c=relaxed/simple;
	bh=bU0O4fZJ+mYi1mJWpHWkz71KbaVJ5AhoPnnh6R/qPwc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OMLNdVEwMC+k1K+OfhUK/PfRX5B9Fpk0b6v8uoOWPV1T05gAJldfaBR+PPL+j1DWbTeC2kcr6/GS+2+ovggf9uirCDXlkVX02IpDCoKXvSVu0chlk+ziTBEAaGI8AZkorHX8YfoinrY8WuPaKSrdNeHYNjotl8maHef8y21RKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BaIKOs84; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWcQnXUf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Jan 2025 19:13:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737659598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mS5vgGF6qoBU/0KVXl0bTanzAFHu7sc0DA3gIdk+bA=;
	b=BaIKOs84l6ZNuHxqeGea35lEp7ICrdYnWEr7TUVf7R/bYDH5I0VIoN8b9zfCqJjgi8EqV6
	m6QQ/zvCSH+KoLhyOrL1ROyd2VT+jaenKy8QBLovlAUueqvBOB/fEpFzxJRf0LOu01nzgc
	wI8LwKJRU72fZmPG27L/RBnxpdICbgnHPRT47Tzj4cIj5c8u96i6xBm1BCsYYOGVMJmP0X
	yk6IIhABdtZZP8wgPK0xGiKZDWOjF8H55CSZ+nv49iHmRB1PNjCwYJzDgbnV0nFJlxyC8X
	CtpAB6ZOzirD3FAuFVQfgGWFtgrFoSD6ldAv+LQlRCxTpCiBZCs8hhig6HZfPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737659598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mS5vgGF6qoBU/0KVXl0bTanzAFHu7sc0DA3gIdk+bA=;
	b=fWcQnXUfvpcGp0T7RjF6p0MaiDYtxWc0zsEl2MPzrt0dJ5HozYmK/sYrRfzlyHvVFyhYz3
	mLD8d5467egNV/Cw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] hrtimers: Mark is_migration_base() with __always_inline
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250116160745.243358-1-andriy.shevchenko@linux.intel.com>
References: <20250116160745.243358-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173765959806.31546.5482091923819197685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     27af31e44949fa85550176520ef7086a0d00fd7b
Gitweb:        https://git.kernel.org/tip/27af31e44949fa85550176520ef7086a0d00fd7b
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 16 Jan 2025 18:07:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jan 2025 20:06:35 +01:00

hrtimers: Mark is_migration_base() with __always_inline

When is_migration_base() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

kernel/time/hrtimer.c:156:20: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
  156 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
      |                    ^~~~~~~~~~~~~~~~~

Fix this by marking it with __always_inline.

[ tglx: Use __always_inline instead of __maybe_unused and move it into the
  	usage sites conditional ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250116160745.243358-1-andriy.shevchenko@linux.intel.com


---
 kernel/time/hrtimer.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f6d8df9..4fb81f8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -145,11 +145,6 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return base == &migration_base;
-}
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -275,11 +270,6 @@ again:
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return false;
-}
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 	__acquires(&timer->base->cpu_base->lock)
@@ -1370,6 +1360,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
 	}
 }
 
+#ifdef CONFIG_SMP
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+#else
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+#endif
+
 /*
  * This function is called on PREEMPT_RT kernels when the fast path
  * deletion of a timer failed because the timer callback function was

