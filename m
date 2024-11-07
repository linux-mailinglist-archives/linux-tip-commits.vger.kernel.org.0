Return-Path: <linux-tip-commits+bounces-2816-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD39BFC25
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D284728410E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EC0194A6C;
	Thu,  7 Nov 2024 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5mzD6gX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cO43c+Tx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C84192B88;
	Thu,  7 Nov 2024 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944788; cv=none; b=jluGMcPBEExLG2jvKFZcfHNU4FoNfVcEHq4cjk8kiyYCyuAcaECmA1ZDLuAIMDHutMoFWhn0PpxixWTqXsGGpSVfsYx+dMofstdkAaqQd0iNCAhoazNiOWHTzMqChgqJ/gFu+gkfzpZbBlWVn9jSvnmsGywCkaXSIXlJQQ/7LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944788; c=relaxed/simple;
	bh=jfkvRgyWfTuS3N3zHimhd5UteNdwkUTiU8eEgdi+Hcc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a4uqhqFC76DOJtZwNB4bM472IF3D53KfDRZqZWxHbpxWFeMr1zDV+lQQCVW8honPgMRGVaw5iZvgX4g23r24toz2Zs0nMRRbEVlp/C857b/1UfYlJzXvvCUr5Lqt7MZSSxtwfkPG21o6m6hodnof+7uwgJ3SU66yS3Byp22j884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5mzD6gX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cO43c+Tx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilkI//JuR236VFevp1DJpPq7lmvxn9QYHZVAVOKW7TM=;
	b=N5mzD6gXlwhNgkbg5xVIdBsnZH3FDhCezbJpjMsRnV7PjqqXL3tRD83BCaM8GUGWvswYpE
	x8I+noiH4YYtNNEz63olLv3zg/kKsHqJAIiwMKc1CX6Kn+9qtMvRj+0bAfXDySRjNxJimU
	dQvhPJNfs4WXSaCntVJ1MD0Vz69BxcpYFxdSpcYEZKRRiLxXwpjRuX/fbmr/AtXc87+gzD
	2N/s/y86l9FWW96ZRr/Lx6l4LZowgPjHQET3tzgTNXgz0R5hBVxWwyGDUSiLVmCQ/qt0/n
	l4fMO1j438sMA81OKXqSi4RYSXJT4lvppuDPYWkAvEbLN1CR69TYz6pa9ilYUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilkI//JuR236VFevp1DJpPq7lmvxn9QYHZVAVOKW7TM=;
	b=cO43c+TxGaFZoavUqwNQvAFV8+qWbB1Z/F9yZQfUrYoFMsJ3QoNVJarohrGgTSK+5TxUkD
	8Htc8TfCAjw8NwBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Introduce hrtimer_setup() to replace
 hrtimer_init()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5057c1ddbfd4b92033cd93d37fe38e6b069d5ba6=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C5057c1ddbfd4b92033cd93d37fe38e6b069d5ba6=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478402.32228.4163708089059987204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     908a1d775422ba2e27a5e33d0c130b522419e121
Gitweb:        https://git.kernel.org/tip/908a1d775422ba2e27a5e33d0c130b522419e121
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:05 +01:00

hrtimers: Introduce hrtimer_setup() to replace hrtimer_init()

To initialize hrtimer, hrtimer_init() needs to be called and also
hrtimer::function must be set. This is error-prone and awkward to use.

Introduce hrtimer_setup() which does both of these things, so that users of
hrtimer can be simplified.

The new setup function also has a sanity check for the provided function
pointer. If NULL, a warning is emitted and a dummy callback installed.

hrtimer_init() will be removed as soon as all of its users have been
converted to the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/5057c1ddbfd4b92033cd93d37fe38e6b069d5ba6.1730386209.git.namcao@linutronix.de

---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 5aa9d57..bcc0715 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -228,6 +228,8 @@ static inline void hrtimer_cancel_wait_running(struct hrtimer *timer)
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
+extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
+			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 				  enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4b0507c..a5ef67e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1535,6 +1535,11 @@ static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 	return HRTIMER_BASE_MONOTONIC;
 }
 
+static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
+{
+	return HRTIMER_NORESTART;
+}
+
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
@@ -1571,6 +1576,18 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	timerqueue_init(&timer->node);
 }
 
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	__hrtimer_init(timer, clock_id, mode);
+
+	if (WARN_ON_ONCE(!function))
+		timer->function = hrtimer_dummy_timeout;
+	else
+		timer->function = function;
+}
+
 /**
  * hrtimer_init - initialize a timer to the given clock
  * @timer:	the timer to be initialized
@@ -1592,6 +1609,27 @@ void hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 EXPORT_SYMBOL_GPL(hrtimer_init);
 
 /**
+ * hrtimer_setup - initialize a timer to the given clock
+ * @timer:	the timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	the clock to be used
+ * @mode:       The modes which are relevant for initialization:
+ *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
+ *              HRTIMER_MODE_REL_SOFT
+ *
+ *              The PINNED variants of the above can be handed in,
+ *              but the PINNED bit is ignored as pinning happens
+ *              when the hrtimer is started
+ */
+void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
+		   clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup);
+
+/**
  * hrtimer_init_on_stack - initialize a timer in stack memory
  * @timer:	The timer to be initialized
  * @clock_id:	The clock to be used

