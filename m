Return-Path: <linux-tip-commits+bounces-2802-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDF9BFBF4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0878FB21425
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CABD17543;
	Thu,  7 Nov 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ddg1cOUO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2pcGNBax"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EB11713;
	Thu,  7 Nov 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944138; cv=none; b=UWV1y0A6Pr/cbbSRTtKOJXB3XWzx7FKcXkR7mySGflibKv1oblfVU1swbFte4yt4OBtnpUGEWUGdwYhZgGApsEwNNpqPs3vwEAMUYLI59Pqn674Jok1J+dHrZSiBIOTdBn0ss9g9VqH/mbYP6qVFQOhl/cH6W6Aepc0CCHzOByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944138; c=relaxed/simple;
	bh=JcGGCtoCGU7kjODFAHXN5+pKV/+f4cD/dtFd1g+2Wnk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d3vKxhod2xzjV0/DdMh4tQQbtPdLb1/KRsd6Rejd5Rr0JUijjd+plSxjm05IOXEIoGN5czK7VYuWsjSsbGRLkTOGppTlFqw7LQ6TXzfg7V3PUH4qNSTPT3Z+Vw9GGRSLwGNRaSehnc2knk56DzsceuO70M4mEnFwtVfvUuMY+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ddg1cOUO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2pcGNBax; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:48:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++EOA3u0Zns3GALsRdSY0WyVaGGOkK0S2F8IpA5ZMrA=;
	b=ddg1cOUOfJ76zb3iTc+7tDd1++DPDkWoYlyDg7GLGOnas9xK9Oo7pggfZGoIrD07wWXAOV
	mv0AIiwTjkfUJtkfDgAaLFd/nqgAApGxZ30TYOHHQSWmYgbSysT5XCExb9eVDRg2P7R5bw
	RE401m/g3PdGIIYazf/Vgp8CSMxpnROdN6ZJU+pI0QFifbA40VzmVvrOi3hH+AqxnD0gCc
	s2nL7K7v7UNNN/vL3c2KyW1RXN6VPAhBDS6FP1NsB+OIs7bRLIW25kkXTKWeUm88pQV8NX
	LWtCIh6SiH8p4tpy6zpOBtz/lgNM/vSwq0yDtBqxi+mXt2HbS27H4pnaikK0qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++EOA3u0Zns3GALsRdSY0WyVaGGOkK0S2F8IpA5ZMrA=;
	b=2pcGNBaxXMpV1MuVczb5zXnI8axjX0LIMviJCk/62LY0Rw3brvq+ycxuCYUSI6R78H9Bf4
	N4+3d+u7gUAXzmAA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] hrtimer: Use __raise_softirq_irqoff() to raise the softirq
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241106150419.2593080-2-bigeasy@linutronix.de>
References: <20241106150419.2593080-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094413475.32228.9162993593574104513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7a7f5065bc1dd8c463fc55f18ad43907c16571ee
Gitweb:        https://git.kernel.org/tip/7a7f5065bc1dd8c463fc55f18ad43907c16571ee
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 06 Nov 2024 15:51:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:44:38 +01:00

hrtimer: Use __raise_softirq_irqoff() to raise the softirq

Raising the hrtimer soft interrupt is always done from hard interrupt
context, so it can be reduced to just setting the HRTIMER soft interrupt
flag. The soft interrupt will be invoked on return from interrupt.

Use therefore __raise_softirq_irqoff() to raise the HRTIMER soft interrupt,
which is a trivial optimization.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241106150419.2593080-2-bigeasy@linutronix.de

---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cddcd08..5402e0f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1811,7 +1811,7 @@ retry:
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next = KTIME_MAX;
 		cpu_base->softirq_activated = 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 	}
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1906,7 +1906,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next = KTIME_MAX;
 		cpu_base->softirq_activated = 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 	}
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);

