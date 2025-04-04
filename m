Return-Path: <linux-tip-commits+bounces-4691-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA493A7C2F4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A99917D0EB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE612206BE;
	Fri,  4 Apr 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lInJAKAH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tW73W5Fe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D521D591;
	Fri,  4 Apr 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789280; cv=none; b=YD7p7+OHdcRQLfZSLU3dwwRFR8FpKnqAY9k52jcjlDGn1pT9X8DDN91uAi1BkBCB3rlJf1EDNmnQTuEJXS98w6vTo/iBlPxdE3+bkCeSEonGjA1BMymYAIuZz3If78FzbGmSs1uHUeAShAU1Ej2MXYs33odgdsFKLkGh7nQl7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789280; c=relaxed/simple;
	bh=KoTrF9MB4J2SZLgFyKYaQ9ck4kWO6vcogBAe0tq+f6s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ugl/FRQCmK6pwYXDNZteaD4Pom6vOFUsnk5ZzGhK4oK4+bHqG/Gv6Ihkqv+IdZO0AsVOFF5NKvVUbw3BxTdAcf6Bl/5oq9ZiJlkmVKbCTkq8NzFBOzGW7+DyyVotEKzjUQDwwrmZf59hQ/2g8zBQXbv6xGCMHj4YjXuIhZJfdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lInJAKAH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tW73W5Fe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F55AxrUYV1UqZud2j1tAWr8hVHs5YGGN29VHUnMfrDU=;
	b=lInJAKAHC4xtwEQUhWWgRhEDXsmqBtetGsg9dOBoFJakc1feN5j+rOyMTSro1/PtsjLIQC
	qToSgt+z3He8XKGGPRO3tAnrokqWwP3UWNXdC9+cJYrFeYsXUZodpuGcQNZyi5BrwK03+I
	t2fmU7jAX/GoDgDsjRzSBLhNOXkWgd+2IGMwkdQH9Cb1PRl1kFTxZ0SK96Gvpf+AkJ6Wce
	JTlFKTNN58kxr1rupFNHDbaI+p8MKKRbrCbcUlcWB2SZXjfCOAZxe+5R2mmWaWEqH8yjo1
	fqYOSAR/onOW3sCUFNFKIPx6vSwvFb4XMgWyDOHDO9PHEAAjvuk4OzWKaU+6GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F55AxrUYV1UqZud2j1tAWr8hVHs5YGGN29VHUnMfrDU=;
	b=tW73W5FeM6U8PFTTvXzOAPgBhKyD8DHvbllch2JVLvP4ryXpuwo0fyZQA4MIRAQ03z2zwB
	0MSmuEevhcxO7uBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Delete hrtimer_init()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C003722f60c7a2a4f8d4ed24fb741aa313b7e5136=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C003722f60c7a2a4f8d4ed24fb741aa313b7e5136=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927693.31282.6628449905878383237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     ac8bca2e8f6b3406af10700c427eb9b405c34265
Gitweb:        https://git.kernel.org/tip/ac8bca2e8f6b3406af10700c427eb9b405c34265
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:06 +02:00

hrtimers: Delete hrtimer_init()

hrtimer_init() is unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/003722f60c7a2a4f8d4ed24fb741aa313b7e5136.1738746927.git.namcao@linutronix.de

---
 include/linux/hrtimer.h       |  2 --
 include/linux/hrtimer_types.h |  2 +-
 kernel/time/hrtimer.c         | 20 --------------------
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 88e0788..1adcba3 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -231,8 +231,6 @@ static inline enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
 /* Exported timer functions: */
 
 /* Initialize timers: */
-extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
-			 enum hrtimer_mode mode);
 extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
 			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index ad66a30..7c5b27d 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -34,7 +34,7 @@ enum hrtimer_restart {
  * @is_hard:	Set if hrtimer will be expired in hard interrupt context
  *		even on RT.
  *
- * The hrtimer structure must be initialized by hrtimer_init()
+ * The hrtimer structure must be initialized by hrtimer_setup()
  */
 struct hrtimer {
 	struct timerqueue_node		node;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0cf8d39..b7555ba 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1641,26 +1641,6 @@ static void __hrtimer_setup(struct hrtimer *timer,
 }
 
 /**
- * hrtimer_init - initialize a timer to the given clock
- * @timer:	the timer to be initialized
- * @clock_id:	the clock to be used
- * @mode:       The modes which are relevant for initialization:
- *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
- *              HRTIMER_MODE_REL_SOFT
- *
- *              The PINNED variants of the above can be handed in,
- *              but the PINNED bit is ignored as pinning happens
- *              when the hrtimer is started
- */
-void hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-		  enum hrtimer_mode mode)
-{
-	debug_init(timer, clock_id, mode);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init);
-
-/**
  * hrtimer_setup - initialize a timer to the given clock
  * @timer:	the timer to be initialized
  * @function:	the callback function

