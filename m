Return-Path: <linux-tip-commits+bounces-4701-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3DFA7C858
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEE1189F7D0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F261E8349;
	Sat,  5 Apr 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPVSqKVM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtYRUmmp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC51DED42;
	Sat,  5 Apr 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842807; cv=none; b=rLRpjMbBZnbZMMbT9BN+odTP6JhimtPcXeYxkoA9zxXg0jIrCaxgFBOLQfoNHauBlA3Gt45gk4kzriT/4LT7LdJJQI+Uln3NffoKRUs/DC0um3UECaGTKB8Suizs8/+IIZ+LXmZABowQkiee6YtQtpQljiSROllzmS5JpZz/c2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842807; c=relaxed/simple;
	bh=VExB2QhqrXrQh/SZL1CREXEp5BX3HYt9U+YtBt1Yp/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pRczJ+Rfen99Dzk78xQ6lqe1DOs5Tin2TSbOEAVB867ybueMAc0Y2j5/oq/dvQivxcs2/nWMtqj0KILlgQFZw0OIvbzTDaU4vxlGI+SKl2D1yIWRZ6FVhzE0iDDq1TiHlhzJvhW6NnAv+yslln2ahi2HDrV1GxZyLu15Z7IBFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPVSqKVM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtYRUmmp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoHdvsz1RnATgDiMu5iUPlE0OssiLkpxYynuIxEg1iE=;
	b=CPVSqKVMMRjHZGsCYye8TLlVjXc8sHaHz3FNASRs2DDLcNt4pfCvu99iOWS7mN1sIiaKuq
	P7YGwHCZZgkNa0e49B/LTnENGwc0kfO0dQ8B/63VHgmaQPX+HyNxzm9dQdCFF2XeZ6eBfu
	Oxu/W9Lef4apL88efwIAThHUX8TUZCn739WQxlwftXHmuu9kY7SSkk0uc5NJ3sjfKfEfKE
	3ftwbKmBX9bbrxW2hMJIdFVaHYY7Ur46yKKTMTeOTD5WDxuohYkpzpGEZiUbjD0YHetG+j
	T1jnizojq8VBY2SZzXh3BjELH2FQfwYIG+cjUXd6BzMKG+krYP8+mtUBSUuM4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoHdvsz1RnATgDiMu5iUPlE0OssiLkpxYynuIxEg1iE=;
	b=TtYRUmmpqhAPHsdGRLbRGyfaBNV4xjmdxHZjEPogvFsda6iEu8hkidR/0EKfrM+6eUsEd9
	QZ/LDCz9WTomp9Dw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Delete hrtimer_init()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <174384280028.31282.6280570691186901361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     9779489a31d77a7b9cb6f20d2d2caced4e29dbe6
Gitweb:        https://git.kernel.org/tip/9779489a31d77a7b9cb6f20d2d2caced4e29dbe6
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

hrtimers: Delete hrtimer_init()

hrtimer_init() is now unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

