Return-Path: <linux-tip-commits+bounces-4679-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC6A7C281
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCFF1B60AF6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B9221544;
	Fri,  4 Apr 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUwuSery";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L66ZTIwC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7C21D5BF;
	Fri,  4 Apr 2025 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788055; cv=none; b=vDBNNHJmaz49LKnosEPqEnVwlkVoRgdmzGLL8lDJdIs5GnZDUtIxpNis8diVBP4rX27R7aw6YvTqOloFHSjwcAnDxqWux1JORsP4AP3PHzwjzN7Bu8BO1VIMpPhj8vEaF772ZqL2h4w11Lp8Yi8/qaxbbVLB6qHVpxWYdUVrA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788055; c=relaxed/simple;
	bh=Xq/c9441yejJ39714jb06l8LpBAPtM3FD/+lSJCUglo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VDi30cZv1p7DeSnrI1pkZGQDTdIY1Qp9fDIy5oYtd+5MuLVcQ1qU5UaYoe2l39HZuA83H+q0eLWUx7f1/gDgGaxbbY366BbOaPzgQqIu6dMzFTZWgy9ZFTj2nZ2c1j0rcFMh88lbWPk5kOxDlyI/nCWBkthsS/zNNgRxo56g/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUwuSery; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L66ZTIwC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPgRETb+UbQQmBG1CdsDikX+Aq6CVmzlp+bt8o6znes=;
	b=jUwuSerytlvrcHOfhFTMUlVjq9f9kCtN1hfba+g8IXFXKfQyM1XEoQto/aKw6vuOcZIMwL
	/aVcj+2AAWkyK91A7vYOXWMK2ZvDrewB0uEqwI4jujAtPQlH2i1icqvwaH5jag0QPsI32O
	1ndF7sZgS1zSkgp0l+ji5qGPwYELkSJQrQhWWiaphbGSch/qtOzifuorFZ+nDZ+gaceXQl
	s5GuotRIwLHrVpkVWoS40LuflYvtjh4DRTIfXrvz906rOWEaIz5LkzSt6pK+tXAC/5j8sx
	RohxJcECwGostMSb4ziQ2XvZUHj2qcXB0x5ciRf4W/9VHY2Uqo4EsBrepW4FKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPgRETb+UbQQmBG1CdsDikX+Aq6CVmzlp+bt8o6znes=;
	b=L66ZTIwCQ+EBNFXnTNsq4odCveBzneJtpn/gizX+lm4aLXJoPC/b+TzJ5TJMavSaYG5jJY
	AH5WQpEWT3ZsiFAg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Merge __hrtimer_init() into
 __hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8a0a847a35f711f66b2d05b57255aa44e7e61279=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C8a0a847a35f711f66b2d05b57255aa44e7e61279=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378805137.31282.15961667566839362279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     941b649f92f5060b767e856fddc6583c1c50fab0
Gitweb:        https://git.kernel.org/tip/941b649f92f5060b767e856fddc6583c1c50fab0
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:43 +02:00

hrtimers: Merge __hrtimer_init() into __hrtimer_setup()

__hrtimer_init() is only called by __hrtimer_setup(). Simplify by merging
__hrtimer_init() into __hrtimer_setup().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/8a0a847a35f711f66b2d05b57255aa44e7e61279.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2d2835c..163cde3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1592,8 +1592,9 @@ static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 	}
 }
 
-static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
@@ -1626,13 +1627,6 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
-}
-
-static void __hrtimer_setup(struct hrtimer *timer,
-			    enum hrtimer_restart (*function)(struct hrtimer *),
-			    clockid_t clock_id, enum hrtimer_mode mode)
-{
-	__hrtimer_init(timer, clock_id, mode);
 
 	if (WARN_ON_ONCE(!function))
 		timer->function = hrtimer_dummy_timeout;

