Return-Path: <linux-tip-commits+bounces-3428-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792C6A397AD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB633BA948
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02038243399;
	Tue, 18 Feb 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/9ulcCl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="doY87f49"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0C2417F2;
	Tue, 18 Feb 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872004; cv=none; b=PurjJfDExsWKwF+eW4tr26E6/sJp4LbHJ0gJ8eJcIgEJAuWDqt+1JcGWLR670IK240maeFJym0UYap2dhTBqe/61V0Exfuz6tk3kxNg3HeTitHAFAGMtgQ+fAJFtO0B4RavKVW9WzNQ5D1TP2tBu2vAIj7tCIIxp6fmBtaCWEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872004; c=relaxed/simple;
	bh=W0zZxe9CL3FGBKaflTdHuP5pc6cAKWucIxh+4UhG7YI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XtxHk7kJRrywdapjy1kCdxBvysFOs1STRzNQ2BYdKkxAgLTC3/yzw+z9r/DAiWug1kTySuBWYjfh9VqDupOJhzqijd6nc83Pxhd8XInI/+pKV6KPsxEOfY/gyYtaJ0dEHyPplr+NEvHWw7ApTiYlGAVZ+XfsEN4J0MOQ4wufC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/9ulcCl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=doY87f49; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vWy/0n6BL4TuVd+HLk4vyoZdLjSJyOPRND7dSrc66o=;
	b=P/9ulcClr4SXR3UKiTMPlV7g+uw2qKHaI59tRt/IbSFi4lL0bvPh8faWdBCD6wCjKoWu3/
	74GyU00oiwGTNfbr944W7yLwb9Qw8FwMBckbHMwsAUsOC8PJmuTpwTIrErMPyLITdF0RNa
	3I/DHoCK/FQAiExDbo7FAeh+ASqlz26MCmVeVkVVKK9KHxud6b3x0rw6OG+BauY2Zs8AlC
	BXxFjrmI7C/kmpbO/f4Et3lR2b9XGOLClIH7erR41fz0m/kXoetNp71sW2WKU6RQiEsl29
	mWKxB/eMM3zfM3MbIRS+QUs7zEd4nS+OgKHL9Ue7sxdayg/cxuBhj8yqOgxcbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vWy/0n6BL4TuVd+HLk4vyoZdLjSJyOPRND7dSrc66o=;
	b=doY87f49GD3HgRdNwHWTgEPDEgTXlZdmp1OPAKKwXOfjwU3nZ0Deep4QUfYQ80N5Xe1V7s
	wZiJ0yN2OTHYbFAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] ARM: imx: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Caff915511ee629b461fee98688b8e859075386ac=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Caff915511ee629b461fee98688b8e859075386ac=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200137.10177.11305074322582340237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     2f33de836402acc80c494ae56a5d74f5df5f4409
Gitweb:        https://git.kernel.org/tip/2f33de836402acc80c494ae56a5d74f5df5f4409
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

ARM: imx: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/aff915511ee629b461fee98688b8e859075386ac.1738746821.git.namcao@linutronix.de

---
 arch/arm/mach-imx/mmdc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index e898f7c..94e4f4a 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -509,9 +509,8 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	pmu_mmdc->devtype_data = device_get_match_data(&pdev->dev);
 
-	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-	pmu_mmdc->hrtimer.function = mmdc_pmu_timer_handler;
+	hrtimer_setup(&pmu_mmdc->hrtimer, mmdc_pmu_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	cpumask_set_cpu(raw_smp_processor_id(), &pmu_mmdc->cpu);
 

