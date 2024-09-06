Return-Path: <linux-tip-commits+bounces-2195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C096FB97
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FB01C217D5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966A1D45F9;
	Fri,  6 Sep 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hk2XxY5u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+T5De+E5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1C155C98;
	Fri,  6 Sep 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649018; cv=none; b=fd5Hu7B1PFWi187J8o9y4vOiu98+P/dkOcmhMTRGDdyTWFDKrhSDHJ7kqqZ4BNtxDD50DeVxS+/NWtbq61CuihQWtpTuDTs5rcOaZcEB7+0Exd1HCc/SkogL93DQ6Lerqg7mJ6tS12zra3pgM0DUPnTAMXpLHIYcCzFp8hfuAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649018; c=relaxed/simple;
	bh=BUGg29swlhBRnL9JWo2Y1+rwoFkHiyImJZBI5b489Bs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d5dh8W+QaAHZhQn+JhqA7pTo81wb2zx+u3kw4/4cUwJvEJ1U0Wu2GcwESVsLjT++Gtc1QtuFrkkiWuLnjSZVCmxFAocOL0+Al5dxqIUeywA7b/Lys0TFfnrFdZ5XcD+Zrqome5AVwZPW/gva3tMrSDSIzGae3xfA7t1kbGMDoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hk2XxY5u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+T5De+E5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JpfC+iop9QzteGVMO4YU2+6UyycXj1R7kDKx7M+in8=;
	b=hk2XxY5u9Dk+yJOfSyXfVPJpPRuEQ1VwGr9NlMEfYBGfWV329ufGxMTqQqGSwTeHZz9No1
	nYYJHfpH6k1PH5SMaj+Wh6PadBNOEOLMGy5pNeaA+fkSWdKKXjUwcNtrfMuXKY6fQ6KsBS
	3LNxuEYDAAV+Qmdy0pfzvfL6/Yja9i1HlMUNV58Z8q3bnrUgM7VMANlVwIOOSvFcLvD6kL
	DRlQ+i9Y67XVTh2mfR6KkqALpkSpkUn6Nw2d4PjUZyf+Gm2EfKPqGW36SRlo31TjkTSITU
	NKt7XHdGB3zseoIoBRSFsqMjY6z+JiYV3ufH4/2yBTnIXVXsM//m1Et0Vdkv+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JpfC+iop9QzteGVMO4YU2+6UyycXj1R7kDKx7M+in8=;
	b=+T5De+E5vbG6yYmKvKmtS4e6xVjsQ7o3IOry3buO9tDgN3qLfihGf9V1h1JqvpWVe185Lw
	kBdqXAy9Bq78HXCg==
From: "tip-bot2 for Ankit Agrawal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/qcom: Add missing iounmap() on
 errors in msm_dt_timer_init()
Cc: Ankit Agrawal <agrawal.ag.ankit@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240713095713.GA430091@bnew-VirtualBox>
References: <20240713095713.GA430091@bnew-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901527.2215.12281825362291575862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ca140a0dc0a18acd4653b56db211fec9b2339986
Gitweb:        https://git.kernel.org/tip/ca140a0dc0a18acd4653b56db211fec9b2339986
Author:        Ankit Agrawal <agrawal.ag.ankit@gmail.com>
AuthorDate:    Sat, 13 Jul 2024 15:27:13 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:21 +02:00

clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Add the missing iounmap() when clock frequency fails to get read by the
of_property_read_u32() call, or if the call to msm_timer_init() fails.

Fixes: 6e3321631ac2 ("ARM: msm: Add DT support to msm_timer")
Signed-off-by: Ankit Agrawal <agrawal.ag.ankit@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240713095713.GA430091@bnew-VirtualBox
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-qcom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
index b4afe3a..eac4c95 100644
--- a/drivers/clocksource/timer-qcom.c
+++ b/drivers/clocksource/timer-qcom.c
@@ -233,6 +233,7 @@ static int __init msm_dt_timer_init(struct device_node *np)
 	}
 
 	if (of_property_read_u32(np, "clock-frequency", &freq)) {
+		iounmap(cpu0_base);
 		pr_err("Unknown frequency\n");
 		return -EINVAL;
 	}
@@ -243,7 +244,11 @@ static int __init msm_dt_timer_init(struct device_node *np)
 	freq /= 4;
 	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
 
-	return msm_timer_init(freq, 32, irq, !!percpu_offset);
+	ret = msm_timer_init(freq, 32, irq, !!percpu_offset);
+	if (ret)
+		iounmap(cpu0_base);
+
+	return ret;
 }
 TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
 TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);

