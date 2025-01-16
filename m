Return-Path: <linux-tip-commits+bounces-3265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2256A134D9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 09:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609A23A692D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1017E1DD88B;
	Thu, 16 Jan 2025 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbkYn8Po";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdZlp6pw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101911AAA1D;
	Thu, 16 Jan 2025 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014946; cv=none; b=Skdk0ThvdqYcs/KmTcEcL2xfMEbeAURMUeWZ7C5HixtEajuxBRj7hi6bpOE6xJ/ZHvwhZaE5wEVU/wCltrmUSRMoD40XeStdl5fy+z5MwPMqFGirMawpEBp9g5p4PEFPil8lJ/tPa25zUivx09CqxlGmV8TRS7COX6HJCdcx+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014946; c=relaxed/simple;
	bh=hqIUSgPW6lr3S0nbRGVnUWbynWUAQB4mamSSbVo/SlY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KdZ0BXX4TGS/yt+MCKWpRGuTaQiBgVO5AWqWnFcftjDfjFywCI26mLqQwZF45//v9dLQJkHbduxLbRU9AnrUJzdAZDVa0u1VcQc37uX3+5fk7Fhbu2Urk9hbYoJ1/tu5WVpTyOOmVe6KS8eIiTJ+dnX3JRan+5PPaeTD1QRJb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbkYn8Po; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdZlp6pw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 08:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737014941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNC3zb3p6I/FlEMiNDMawgLj4+u+TwPeWBcDNBEMyys=;
	b=ZbkYn8PooCJHBXoSxihxMNMg03o6NrrP6VHIlvHR4l46eCCGG6CSTnrNK6ZYh8sV+39slD
	64+0MlbjAIwBx3fvxE7yvijyoLUU4MC7+kJPrSuM9cUHptxfyMbZ6Tq1wEEpUKrOdi/p65
	SYXH+pimjMNmvUToHZAcImrPGyUPOA6b9a816jM9Fzxufygnw/B2W1JCw6iKaPLbjb/3tR
	MHp75756ojJTK5L573boNfBahlzVe1fjqwQ5qrJFvpVTGfwuIgwCa4+zrbgB7x92BWzM1b
	zHGTCgsk338bcexvgtgZil4KYIMMFX/7s8g8crJCvPK9Tp/YRbbxT8eHGs1QoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737014941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNC3zb3p6I/FlEMiNDMawgLj4+u+TwPeWBcDNBEMyys=;
	b=SdZlp6pwGA/v0mUjOJtL9wjLQn273D6h+TJdLRSzixK0t2Nadu/oTa6UuPpzSDycKw6Dm0
	l2rfc66iI2AtqxDQ==
From: "tip-bot2 for Zhongqiu Han" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Optimize get_timer_[this_]cpu_base()
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241231150115.1978342-1-quic_zhonhan@quicinc.com>
References: <20241231150115.1978342-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173701493781.31546.11275183632173844475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3ec955713d9617059d2fc8f2816d0b95ace72256
Gitweb:        https://git.kernel.org/tip/3ec955713d9617059d2fc8f2816d0b95ace72256
Author:        Zhongqiu Han <quic_zhonhan@quicinc.com>
AuthorDate:    Tue, 31 Dec 2024 23:01:15 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 09:04:23 +01:00

timers: Optimize get_timer_[this_]cpu_base()

If a timer is deferrable and NO_HZ_COMMON is enabled, get_timer_cpu_base()
and get_timer_this_cpu_base() invoke per_cpu_ptr() and this_cpu_ptr()
twice.

While this seems to be cheap, get_timer_cpu_base() can be called in a loop
in lock_timer_base().

Optimize the functions by updating the base index for deferrable timers and
retrieving the actual base pointer once.

In both cases the resulting assembly code of those helpers becomes smaller,
which results in a ~30% execution time reduction for a lock_timer_base()
micro bench mark.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241231150115.1978342-1-quic_zhonhan@quicinc.com

---
 kernel/time/timer.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a5860bf..40706cb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -956,33 +956,29 @@ static int detach_if_pending(struct timer_list *timer, struct timer_base *base,
 static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 {
 	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
-	struct timer_base *base;
-
-	base = per_cpu_ptr(&timer_bases[index], cpu);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
 	 * to use the deferrable base.
 	 */
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
-		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
-	return base;
+		index = BASE_DEF;
+
+	return per_cpu_ptr(&timer_bases[index], cpu);
 }
 
 static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 {
 	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
-	struct timer_base *base;
-
-	base = this_cpu_ptr(&timer_bases[index]);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
 	 * to use the deferrable base.
 	 */
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
-		base = this_cpu_ptr(&timer_bases[BASE_DEF]);
-	return base;
+		index = BASE_DEF;
+
+	return this_cpu_ptr(&timer_bases[index]);
 }
 
 static inline struct timer_base *get_timer_base(u32 tflags)

