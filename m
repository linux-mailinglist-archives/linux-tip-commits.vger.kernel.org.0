Return-Path: <linux-tip-commits+bounces-2204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C6970950
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 20:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A931F210C9
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABA17624F;
	Sun,  8 Sep 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gmc9Qe87";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmgqGQOL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57B2B9CD;
	Sun,  8 Sep 2024 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821889; cv=none; b=H1RVP+paMOaeQOXcpdBktyydYmQDJI2U8Tl2hFo48bQtwm9dgJVZ2GNkSBiOIiL07NWXgX2AL47QeapYQwhLSXNFoZ4ZwWr2+czvt/JEzHyZpTd08ghoUuRV9T0IkQIzKjZXtzkIMOyVHvb/vxPXnv+j5yuu+08dPzVuRngDaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821889; c=relaxed/simple;
	bh=BQIx09xeRqhNYh++vI745US6mEAfBBWGDf3rcBBT0YE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=twQL6tp13HoeTowvw0T7uwRcOMmI8pteJkk8nm4j2kUTgHTkPwkBaE45CJXbn+CsCoulda+sQWblBnxZPgi+9qHPxAIbINEPGYIGxtI1l86ag58fqyMJNQqA6rrwp6rkpoSkMM6SH4B1cYf7N1cpCKGKEZfTzX36rcpiFyprtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gmc9Qe87; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmgqGQOL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Sep 2024 18:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725821885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VE5I3W9lQJi6tg1/RJ/V8RGDKDKauaVsQ61Ww5w6dQ=;
	b=Gmc9Qe87QMtpTkXR2BrbSM4xbfkoZ6f1WeH91KUrEVwJol+uFWHDGwNVg9aiTLIo0pDMqn
	+tNroLXwwk7o+kR06pGTbjGhOTxgDLx7YQ1vnoMMbtTP4FlmAJIjEvYHtrnXboFiNyioW5
	gTsTZy+FFrrfdWt6hdRV/1YTIAPz8CJyQ9LsLLjOOVkSDFpt0ozn19KNfszNV4+PU02sXP
	IHW3t0bj0eJytKc30cg7vUUZvqa6DDsHL1yrw6x/0RtPm/jN6Hppyiugptj0+rHEawLqBL
	93wbkUK1gygw11czqkO5GlYmh4RIyvilGv1bAauVxTg6mcOkHhIe1CSCMJRb9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725821885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VE5I3W9lQJi6tg1/RJ/V8RGDKDKauaVsQ61Ww5w6dQ=;
	b=qmgqGQOLoV04p7ZqszlY0l6zolwqGRYZfDH3sdJgVQOBrfZmwplltdxYMiEE379IeaJxsV
	GSy0F1YnSHWLc6DQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Rename sleep_idle_range() to sleep_range_idle()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-5-e98760256370@linutronix.de>
References:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-5-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172582188502.2215.5044102209382270161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ad4890d40229151c3455b47d9c142def8105644c
Gitweb:        https://git.kernel.org/tip/ad4890d40229151c3455b47d9c142def8105644c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 15:04:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Sep 2024 20:47:41 +02:00

timers: Rename sleep_idle_range() to sleep_range_idle()

sleep_idle_range() is a variant of sleep_range(). Both are using
sleep_range_state() as a base. To be able to find all the related functions
in one go, rename it sleep_idle_range() to sleep_range_idle().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20240904-devel-anna-maria-b4-timers-flseep-v1-5-e98760256370@linutronix.de

---
 include/linux/delay.h | 2 +-
 mm/damon/core.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index ff9cda9..2bc586a 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -68,7 +68,7 @@ static inline void usleep_range(unsigned long min, unsigned long max)
 	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
 }
 
-static inline void usleep_idle_range(unsigned long min, unsigned long max)
+static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_IDLE);
 }
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7a87628..94fe2f1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1887,7 +1887,7 @@ static void kdamond_usleep(unsigned long usecs)
 	if (usecs > 20 * USEC_PER_MSEC)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
-		usleep_idle_range(usecs, usecs + 1);
+		usleep_range_idle(usecs, usecs + 1);
 }
 
 /* Returns negative error code if it's not activated but should return */

