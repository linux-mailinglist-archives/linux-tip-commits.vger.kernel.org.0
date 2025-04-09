Return-Path: <linux-tip-commits+bounces-4812-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118FAA83083
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5087C3A5E0C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C31E503C;
	Wed,  9 Apr 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfB3DDLN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/OVAaqLN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FD1E5018;
	Wed,  9 Apr 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226815; cv=none; b=fVmeVb/S2+7aH5ZLRoi6PwDorNu7k/Oowqx9rJwFX1jMhYn7SSDpr45DvPzAF0LnhbIwk81mWOWe/zsScEli3hYocsXp95/62U8NFcMxTDKZ7wwxh8EJQGfA1WNB27rIFe/zVhSAppOtw02ZTg4h2CAQhipK46xLeqM49EIPL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226815; c=relaxed/simple;
	bh=sA/bpj3BuSqZXVAYo031rA+ylGI/wpeddO9qtvpA41o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jC/chiGOYyR7h94jJQbLqmd6sXTwLX/3raZPioZ31o5fkv0CnGVdn/ta1PtWcNuiVXSbjHtGFM3AaU8p2gDV0rfgl5Xuu3X4Qu6StTf9QuX5mVg4FNxMF8pNoWuSXZ6hbHlIHshx42MonqdhbCGLwXzAXcYqmN5Zhfl31upDPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfB3DDLN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/OVAaqLN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 19:26:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744226811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUn0eHsxvYoiNDw7aVWqQVKnA1VQ9ZX/1DAcbgV/4jo=;
	b=PfB3DDLNT/F6w6ZA03da1PSVJ9zcU7DT4WD+o0U5J2Wxo2o4WnVOnbJ2cH8/fBSlb9O444
	dwtr9HMPTvlme8+jJmHPl7umyVLDn0to+1EJAJKcBw5xJKdJywCihs5BMJabsA+WFmD2Tx
	QZOt7qhkOTqe8U1xmyU0Jv21VaeAWTn+tFhpWdwIT8d/XUdvHjxIfN7poPV6fBbNgigo7I
	+VOhm+GL9f1itN5mIEQcij/lZBDp0Mh7hy39sQ370yhkyQWfbTkItx9Sn3L2AxtaEBrg1p
	NiHUGK6v7ENCsEB0urrTumLYKM7dRmNv+qjjv91UZX/k2JV0bHe3seSfDq+okA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744226811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUn0eHsxvYoiNDw7aVWqQVKnA1VQ9ZX/1DAcbgV/4jo=;
	b=/OVAaqLNA5ubwlKTTPt1zWlCppV3HZuwKn235aNVKIb7YA+lGjhGNRjIcs5jCpHpY07a5m
	N20oNKWgPtmLfoBw==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Initialize cache early and move
 pointer into __timer_data
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250402133114.253901-1-edumazet@google.com>
References: <20250402133114.253901-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422680979.31282.16193617108904580960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0df6db767a535472a46aeea93c280de067784a9f
Gitweb:        https://git.kernel.org/tip/0df6db767a535472a46aeea93c280de067784a9f
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Wed, 02 Apr 2025 13:31:14 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 21:21:36 +02:00

posix-timers: Initialize cache early and move pointer into __timer_data

Move posix_timers_cache initialization to posixtimer_init(). At that point
the memory subsystem is already up and running.

Also move the cache pointer to the __timer_data variable to avoid
potential false sharing, since it never was marked as __ro_after_init.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250402133114.253901-1-edumazet@google.com

---
 kernel/time/posix-timers.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 6222112..2053b1a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,8 +30,6 @@
 #include "timekeeping.h"
 #include "posix-timers.h"
 
-static struct kmem_cache *posix_timers_cache;
-
 /*
  * Timers are managed in a hash table for lockless lookup. The hash key is
  * constructed from current::signal and the timer ID and the timer is
@@ -49,10 +47,12 @@ struct timer_hash_bucket {
 static struct {
 	struct timer_hash_bucket	*buckets;
 	unsigned long			mask;
-} __timer_data __ro_after_init __aligned(2*sizeof(long));
+	struct kmem_cache		*cache;
+} __timer_data __ro_after_init __aligned(4*sizeof(long));
 
-#define timer_buckets	(__timer_data.buckets)
-#define timer_hashmask	(__timer_data.mask)
+#define timer_buckets		(__timer_data.buckets)
+#define timer_hashmask		(__timer_data.mask)
+#define posix_timers_cache	(__timer_data.cache)
 
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
@@ -283,14 +283,6 @@ static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 
-static __init int init_posix_timers(void)
-{
-	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer),
-					       __alignof__(struct k_itimer), SLAB_ACCOUNT, NULL);
-	return 0;
-}
-__initcall(init_posix_timers);
-
 /*
  * The siginfo si_overrun field and the return value of timer_getoverrun(2)
  * are of type int. Clamp the overrun value to INT_MAX
@@ -1556,6 +1548,11 @@ static int __init posixtimer_init(void)
 	unsigned long i, size;
 	unsigned int shift;
 
+	posix_timers_cache = kmem_cache_create("posix_timers_cache",
+					       sizeof(struct k_itimer),
+					       __alignof__(struct k_itimer),
+					       SLAB_ACCOUNT, NULL);
+
 	if (IS_ENABLED(CONFIG_BASE_SMALL))
 		size = 512;
 	else

