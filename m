Return-Path: <linux-tip-commits+bounces-2460-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31E99FB89
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D6DB228F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15991E4120;
	Tue, 15 Oct 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFel2nOC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4AfBX0Pm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F861D63E2;
	Tue, 15 Oct 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032087; cv=none; b=kaHxgLIUacMb9sxyNV34zdev/kdXGcMu/0BHeG9LoacVpTavltTSsxMgX5xzvynYDCdzClDzGqPp29HUB8tqid4TAwsu9kSzqYIjBdpitevWAQ9DvOIPI0BzR5mRagbd32LVgvdVSRfL7qRCBBOym6ZwR9oZIMpqBnDHVshwXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032087; c=relaxed/simple;
	bh=KJ8ioktieNM9LWi3e4qDTfWOki1ABbVJTQK2Fg0+Xzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fE1EbSW3ceg6+8kh6YLDBFZki3PIQoK6aoxm5QJmHWLrCDQSxaYpcFWUc4zK+HKlJEjTv7HSwo9Yzo+Yw9ET8nHhSAERnEVkqoEDCNHQYzJwCuLffMjGMwcojh/DzxptPrBbGdTuKUPSba50M6PTdgOhphH7Wkpsgd+L1MvaPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFel2nOC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4AfBX0Pm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgpV3zqmOq8uwEGtKE1FHR+E87c3KbfGIH83VYdqtdo=;
	b=nFel2nOCELOLaxdFfIrb31zIlkHo9mSkqiLHJU+1EA6yM/wGmJHBrvrzmvmOj1Bbu8NRni
	9tD4TWuE/55UMJzIT2ZcMUk0PS9Gfofbkmfi7JBA3GRxYCNEI33vmr4IdL4WBykuUfcCsH
	8WVE3/ZvnY22N38EkjSENVyT20wuhQcblk2+8rw+GyUpnqjDWX5cfrRtYLgsJZ5CEJkeU/
	SMFEkcqQAA97fJahxj0T+UbkRzKtfEqr++yXqFgEBRGbFipZVC2+Pl83aSjtB7sUpQ8aLu
	DrxSR2TCWvxMjTESNOw0noSbNenNyOcWGjjzsPZwXVZUEcIG6fL1bipum62AlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgpV3zqmOq8uwEGtKE1FHR+E87c3KbfGIH83VYdqtdo=;
	b=4AfBX0PmVxiBsG3zeHglqihDXbFgD0DcaBKd11lDGp6Ua+6WlL0Pz4Ivq4C5j7aosx51nq
	1BI5LG/JdRBA7UDA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Adjust flseep() to reflect reality
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-7-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-7-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208361.1442.4954895259529965152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     82e11e47c1880362e05c065bef7dbe28a749555c
Gitweb:        https://git.kernel.org/tip/82e11e47c1880362e05c065bef7dbe28a749555c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:47 +02:00

timers: Adjust flseep() to reflect reality

fsleep() simply implements the recommendations of the outdated
documentation in "Documentation/timers/timers-howto.rst". This should be a
user friendly interface to choose always the best timeout function
approach:

- udelay() for very short sleep durations shorter than 10 microseconds
- usleep_range() for sleep durations until 20 milliseconds
- msleep() for the others

The actual implementation has several problems:

- It does not take into account that HZ resolution also has an impact on
  granularity of jiffies and has also an impact on the granularity of the
  buckets of timer wheel levels. This means that accuracy for the timeout
  does not have an upper limit. When executing fsleep(20000) on a HZ=100
  system, the possible additional slack will be 50% as the granularity of
  the buckets in the lowest level is 10 milliseconds.

- The upper limit of usleep_range() is twice the requested timeout. When no
  other interrupts occur in this range, the maximum value is used. This
  means that the requested sleep length has then an additional delay of
  100%.

Change the thresholds for the decisions in fsleep() to make sure the
maximum slack which is added to the sleep duration is 25%.

Note: Outdated documentation will be updated in a followup patch.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-7-dc8b907cb62f@linutronix.de

---
 include/linux/delay.h | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 2de509e..89866ba 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -11,6 +11,7 @@
 
 #include <linux/math.h>
 #include <linux/sched.h>
+#include <linux/jiffies.h>
 
 extern unsigned long loops_per_jiffy;
 
@@ -102,15 +103,35 @@ static inline void ssleep(unsigned int seconds)
 	msleep(seconds * 1000);
 }
 
-/* see Documentation/timers/timers-howto.rst for the thresholds */
+static const unsigned int max_slack_shift = 2;
+#define USLEEP_RANGE_UPPER_BOUND	((TICK_NSEC << max_slack_shift) / NSEC_PER_USEC)
+
+/**
+ * fsleep - flexible sleep which autoselects the best mechanism
+ * @usecs:	requested sleep duration in microseconds
+ *
+ * flseep() selects the best mechanism that will provide maximum 25% slack
+ * to the requested sleep duration. Therefore it uses:
+ *
+ * * udelay() loop for sleep durations <= 10 microseconds to avoid hrtimer
+ *   overhead for really short sleep durations.
+ * * usleep_range() for sleep durations which would lead with the usage of
+ *   msleep() to a slack larger than 25%. This depends on the granularity of
+ *   jiffies.
+ * * msleep() for all other sleep durations.
+ *
+ * Note: When %CONFIG_HIGH_RES_TIMERS is not set, all sleeps are processed with
+ * the granularity of jiffies and the slack might exceed 25% especially for
+ * short sleep durations.
+ */
 static inline void fsleep(unsigned long usecs)
 {
 	if (usecs <= 10)
 		udelay(usecs);
-	else if (usecs <= 20000)
-		usleep_range(usecs, 2 * usecs);
+	else if (usecs < USLEEP_RANGE_UPPER_BOUND)
+		usleep_range(usecs, usecs + (usecs >> max_slack_shift));
 	else
-		msleep(DIV_ROUND_UP(usecs, 1000));
+		msleep(DIV_ROUND_UP(usecs, USEC_PER_MSEC));
 }
 
 #endif /* defined(_LINUX_DELAY_H) */

