Return-Path: <linux-tip-commits+bounces-4694-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBBA7C84A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2866B177604
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650241DB951;
	Sat,  5 Apr 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gilk6vyx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFA9p8Wd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34291B87C9;
	Sat,  5 Apr 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842804; cv=none; b=rIqMotouFkJ4atS5PN40167vXhhOlZ4AKjzR0PnzkC8cESK9Xqx9H1Ypj2Rf//72968NvlMo7qz14P55+hIZ+iwhyALGcoqMsgghM/7G5YPPqmT7Oe8W3s6dw+D5rKmVyp7bnKKjvX84FETmHen97JNI82XfZCBkCILhbWUZcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842804; c=relaxed/simple;
	bh=IYitlTjVcPDz6mNynKP8KbvGV1x4q7JuPjJjnaU/s1k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OMbOUqJzWJ40bmCuLjJJtiMs7vWCEDmSKWINWDIcpYNe58cg8uGkssdNroHmnbcwkSTA6tayBo329Q66tewNEEnYFyrbbRtgoGQ8m+C6wwhHg9IjwcdvYUasFERAdIPiabP8Bt0AwAVGBwLDjTTpCYxrf5rbz6Am5+kr8eItsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gilk6vyx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFA9p8Wd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEmE5H74BezLYhChlKQwNrNmBn8dkyse5SSbJSxHXeg=;
	b=gilk6vyxscYrjcC0YXtfG7eFg1/6pz+XquDE3GNUntDzebbVF6rUyKwtwaXw8eMa0bGFMc
	NuSsmyR0O1dVzc8bb2OeVBcIaeEYWgvVExfzqtQwHkE7kK6B1VkQDIoxAErWlY8eA1s9XZ
	/xg1rlDX9PkuloKSGIzMP0HaXx3vNC+psrEoC4HA9P/ZqyDu2n/AkMEJAAQHZ7ky9Ecxaq
	HCmRWf/JRPobXRNywBWXjfMsnX50/pkWjx254WBb3CiXN867jAKtR0FqdEil/zWwPuYsDR
	UV2lw0fnp0k81i1buy7R+nlBdvVl4wL8gkcmazsTf/fcHE2VbmoU/BrB/CSwjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEmE5H74BezLYhChlKQwNrNmBn8dkyse5SSbJSxHXeg=;
	b=GFA9p8Wd/8pU73802e9Y2k3gbj6qUhZ/mhJkDHku715yQX6thlHMdqsUjePfWsd0pO6XEw
	2DfYZjeo98Qj1FBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename debug_init() to debug_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174384279393.31282.8824980074719438452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e9ef2093ad9edec8d8a060e14891952570c82b8b
Gitweb:        https://git.kernel.org/tip/e9ef2093ad9edec8d8a060e14891952570c82b8b
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

hrtimers: Rename debug_init() to debug_setup()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init() to debug_setup() as well, to keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/4b730c1f79648b16a1c5413f928fdc2e138dfc43.1738746927.git.namcao@linutronix.de
---
 kernel/time/hrtimer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8cb2c85..472c298 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -465,9 +465,7 @@ static inline void debug_hrtimer_activate(struct hrtimer *timer,
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 #endif
 
-static inline void
-debug_init(struct hrtimer *timer, clockid_t clockid,
-	   enum hrtimer_mode mode)
+static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, enum hrtimer_mode mode)
 {
 	debug_hrtimer_init(timer);
 	trace_hrtimer_init(timer, clockid, mode);
@@ -1648,7 +1646,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
 		   clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init(timer, clock_id, mode);
+	debug_setup(timer, clock_id, mode);
 	__hrtimer_setup(timer, function, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);

