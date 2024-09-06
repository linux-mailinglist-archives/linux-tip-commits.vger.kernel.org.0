Return-Path: <linux-tip-commits+bounces-2192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C1D96FB90
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DA41F29B1F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D151420D8;
	Fri,  6 Sep 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gl14vvDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wf+fi/yr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2282499;
	Fri,  6 Sep 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649017; cv=none; b=qtLEubf740J4/0Cx3vgFhjNaQafKzwqZ6yvGOw/gQDYRg+CkrZPRpgPTdX6p5ZNnigl5BU45yLD+hr1RXIgVrKGt5tRwmHe2pZF4WNH0bUfi6bFRp5pGFpFbGVMrvP2KHPL0JE22SVtmFOzPAxjv4mnb1X5BhrwYji/f3deX2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649017; c=relaxed/simple;
	bh=htEOfJBWpIhWUpS1BPyBR5czhjWgiTRTRl+x8LQXby8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jk8zqBkYue/lFqV3WSsJ4mOjUDUFz1w0PR3PXLmqHvbyxciJCgVViyni2VevilZ+eawg0spijCVcmK8Ch1gs5XeP8skmpjqbC00p44fNDw2oupln5b+x7p7rQDtCHlTihnEtt6xWNoSq4Jsh8zAcR/sR4ah+TcKWrRV0uqAOacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gl14vvDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wf+fi/yr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQJ3nVq1YYev5mWGJxXmnqJBdmcaSMgwkHvGAd0dmGw=;
	b=Gl14vvDR9GKTEF/izom/3DxLyM5375ZYg/I1m1B7aDmkpqTPLrITlgBRvpOGfgWBvmqLyk
	/BUDMcLlL4eN49eYtpxccU8rr8faIXQSneCiO0fO5m0hbKN0gJIdKvHtzp7nB1X88Ia2HN
	SHF8/OrjflzdhQ++t3Fx0bw08Hvd/6iEMV/nEY6ArQqDjz2ZjSwh7oPcUiMe3S6BCcN+Ax
	56uUMJlnv9H0uqIbnU1T0wq0RJWh9lrRCSG492uXQy/zqoQyxZ+jlm/JZfPQFpzLVclIf3
	qMUoLC6nb+nC1HW69oEa8brvhi2FE+6J22dhrFDm8rNpPys1k5tHQmx4szJh6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQJ3nVq1YYev5mWGJxXmnqJBdmcaSMgwkHvGAd0dmGw=;
	b=wf+fi/yrCZV9gfIqoL2kl341Jn0tGPp+H/0gEmWjF5w0eMFWmQGFEcguUQIrqIwvaFwE1z
	BWU+JS+PTaJ0ELBg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource/drivers/jcore: Use request_percpu_irq()
Cc: Uros Bizjak <ubizjak@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240902104810.21080-1-ubizjak@gmail.com>
References: <20240902104810.21080-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901349.2215.14060055479515951054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     69a9dcbd2d65217cf52f55dc57b50845dc9d8d3f
Gitweb:        https://git.kernel.org/tip/69a9dcbd2d65217cf52f55dc57b50845dc9d8d3f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 02 Sep 2024 12:48:04 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:21 +02:00

clocksource/drivers/jcore: Use request_percpu_irq()

Use request_percpu_irq() instead of request_irq() to solve
the following sparse warning:

jcore-pit.c:173:40: warning: incorrect type in argument 5 (different address spaces)
jcore-pit.c:173:40:    expected void *dev
jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static [assigned] [toplevel] jcore_pit_percpu

Compile tested only.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>
Link: https://lore.kernel.org/r/20240902104810.21080-1-ubizjak@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/jcore-pit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a4a9911..a3fe98c 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -120,7 +120,7 @@ static int jcore_pit_local_init(unsigned cpu)
 
 static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
 {
-	struct jcore_pit *pit = this_cpu_ptr(dev_id);
+	struct jcore_pit *pit = dev_id;
 
 	if (clockevent_state_oneshot(&pit->ced))
 		jcore_pit_disable(pit);
@@ -168,9 +168,8 @@ static int __init jcore_pit_init(struct device_node *node)
 		return -ENOMEM;
 	}
 
-	err = request_irq(pit_irq, jcore_timer_interrupt,
-			  IRQF_TIMER | IRQF_PERCPU,
-			  "jcore_pit", jcore_pit_percpu);
+	err = request_percpu_irq(pit_irq, jcore_timer_interrupt,
+				 "jcore_pit", jcore_pit_percpu);
 	if (err) {
 		pr_err("pit irq request failed: %d\n", err);
 		free_percpu(jcore_pit_percpu);

