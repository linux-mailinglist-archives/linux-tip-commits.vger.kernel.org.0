Return-Path: <linux-tip-commits+bounces-2193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB696FB93
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A902837AE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE21CCB57;
	Fri,  6 Sep 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWeAJHzA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TU7B+tf0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9B3FB8B;
	Fri,  6 Sep 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649017; cv=none; b=lr1OPi4+Cauvi9bAgYhXhYzwCImq3cNO2kS4aWZf2+zLiBAVmg/HX5gqmR3GvTR8w8bIaS6FJ5f7k1ADM5/Fl0t6LTjtL5+08kt/tekDZH6mBKqz0RFR87ykY64TuvZIYEl6YanuHrY8JHp0PCj5LaUbrPNhfaIrU3s1V5l3EO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649017; c=relaxed/simple;
	bh=yW6imcC7Fs7WHA+m7Z01atRTESMjrKSVqtKogGYLb5A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cBfpBAawFhi0ZVMR3v1tFLQEUIA8q/CGm74pkAZxY/fAQWLh837/+EzcUUXEEW/czcr1lHI4VcmaJ5BD7Hec1VRwGwesJzYGEe3wnvWzm590isPcP7oXl7jJ8cEB+2H9d+ENvVmrHyq7cGn+y2taedgWbqReLMyra/upZJBZ+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWeAJHzA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TU7B+tf0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOzsMLGaesSUPYIgsQhy9TAd5oYny4KJ9zbnzNzkuz4=;
	b=VWeAJHzAheCIsMbLzUP1COsPAikvy87SJ9+acdd71EP99jxx+AdWklRZGIV2O8JVPqQz2t
	KmbOP+JNmTEBL9RLE4CxiGtZyPJiNk/Vbcfzc7oHIpKNS63sYhq1aTyURdd32+NJheH4jy
	+oENPnm5xrArBMXRUdsRg3gMMdfwo0/wn4VSTq1mUuVzmn/T1nRQcDQnIcw1hD0h0wMsiN
	aHUBPsMB86KS0hgAgVr9ex0TKFbJkTthr9vXcb1lEW/YDF0ESDGjyz/dHTmwZ7R3Kgk7Rp
	61OIYnQqaQ4np9UGwrlR7oBPuxYEgwACik/bWPar8YyR2zePeVmUyRbiHvh6rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOzsMLGaesSUPYIgsQhy9TAd5oYny4KJ9zbnzNzkuz4=;
	b=TU7B+tf0mPYYCMyhS1n2K5cJs+NKTmCN++3oJY/ANpNJ+ntoHibGZj7XiVhCYw76p2Z2At
	BE5/nF3IqSZhCkDA==
From: "tip-bot2 for Gaosheng Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/cadence-ttc: Add missing
 clk_disable_unprepare in ttc_setup_clockevent
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240803064253.331946-3-cuigaosheng1@huawei.com>
References: <20240803064253.331946-3-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901407.2215.3378983855992950922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2e02da1d86c97dfaa8ee083d98df1d069b28a526
Gitweb:        https://git.kernel.org/tip/2e02da1d86c97dfaa8ee083d98df1d069b28a526
Author:        Gaosheng Cui <cuigaosheng1@huawei.com>
AuthorDate:    Sat, 03 Aug 2024 14:42:53 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:21 +02:00

clocksource/drivers/cadence-ttc: Add missing clk_disable_unprepare in ttc_setup_clockevent

Add the missing clk_disable_unprepare() before return in
ttc_setup_clockevent().

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Reviewed-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/20240803064253.331946-3-cuigaosheng1@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-cadence-ttc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index ca7a064..b8a1cf5 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -435,7 +435,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
-		goto out_kfree;
+		goto out_clk_unprepare;
 	}
 
 	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
@@ -465,13 +465,15 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
 	if (err)
-		goto out_kfree;
+		goto out_clk_unprepare;
 
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
 
 	return 0;
 
+out_clk_unprepare:
+	clk_disable_unprepare(ttcce->ttc.clk);
 out_kfree:
 	kfree(ttcce);
 	return err;

