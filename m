Return-Path: <linux-tip-commits+bounces-3483-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F19A398EF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C020188C88A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE42246343;
	Tue, 18 Feb 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKoZGls7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5gN5NBBM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D324419A;
	Tue, 18 Feb 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874400; cv=none; b=F66XSpiJjTOsf1NNCJrhdZQqMyMv0KJp3ROd8w24xc2rcL4adVJq3hU0d3dMwnVyp6chxJDqsnJCHXGy1KW0pRHdGCU6QQKCSHWvsk6xelT5CrpgPiKEmZaIxmcFMAz457xXJ70ereV8JKNTbRenyp9QvXtIrmPv7ON9KRu4OSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874400; c=relaxed/simple;
	bh=m4NE3e9PzPSkIyFONYql8eOyf7PWTQsakuq5f2h4050=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BWY5xaqF5AoLaChPVNKWOo6ZxZkd2ktQm0lV3T13k0zJK/42BIf6AAOs3hCb1M+RaWJqa6wETQt711ISjox9vFvCDAmxzmc+Jibj66xlOAsVOKLiSfdFxrFyZIE3+lAJQQiJlyzMbZ9FpbvG3QluCQ8GtQQ5mh5A0WjBi2fIUko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKoZGls7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5gN5NBBM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl47pK7Yi8dpIAI0nK8tvZESrQ86O3buTX0KMxMp1hQ=;
	b=vKoZGls7V3ndVU9URbDIGYPfOTAYg0r5+Jc9rYiBy4jSfHMSact6cD10Ic+RCxSDjPVGOE
	nEwvdYSYV4QXGjBteOZk3bNEHcec2rm0JeS6YVStunyU90jilcG5i1fXiuwl2d9XJdtQ/H
	UDg3fcrG8OpzJW0spd6Nig2iJRJ5ZVeeGI132BCyz2XoGjIYHwzzryJZeTZIXaOmBekbh8
	7WR0dJFf41PsCtu3K8k1gbFjundErK0ogAB0Rsv5UesxkYqg48PGw5hoXvYkDXW+QyncRB
	ONUaMj7KIYPnbPLsN4XFlCH7Y/A43JiM1pdho15sH2vyKqgJnTx/t7UjQvdVfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl47pK7Yi8dpIAI0nK8tvZESrQ86O3buTX0KMxMp1hQ=;
	b=5gN5NBBMgq243rna3Wo9+Jx4AEXm0og9WJ3hbqUW6M9nOvJcVoD8miah3QasoVyCaSDzjs
	U03Z2MJMkD+WyVAg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drivers: perf: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C471ea3b829d14a4b4c3c7814dbe1ed13b15d47b8=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C471ea3b829d14a4b4c3c7814dbe1ed13b15d47b8=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439641.10177.16703387668206704562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     5f8401cf7b3af468b29770d31cc993c2b6e5f027
Gitweb:        https://git.kernel.org/tip/5f8401cf7b3af468b29770d31cc993c2b6e5f027
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

drivers: perf: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/471ea3b829d14a4b4c3c7814dbe1ed13b15d47b8.1738746904.git.namcao@linutronix.de

---
 drivers/perf/arm-ccn.c               | 5 ++---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 4 ++--
 drivers/perf/thunderx2_pmu.c         | 5 ++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index d5fcea3..1a0d0e1 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1273,9 +1273,8 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	/* No overflow interrupt? Have to use a timer instead. */
 	if (!ccn->irq) {
 		dev_info(ccn->dev, "No access to interrupts, using timer.\n");
-		hrtimer_init(&ccn->dt.hrtimer, CLOCK_MONOTONIC,
-				HRTIMER_MODE_REL);
-		ccn->dt.hrtimer.function = arm_ccn_pmu_timer_handler;
+		hrtimer_setup(&ccn->dt.hrtimer, arm_ccn_pmu_timer_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 
 	/* Pick one CPU which we will use to collect data from CCN... */
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 039fede..72ac17e 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1064,8 +1064,8 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
-	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ddr_pmu->hrtimer.function = cn10k_ddr_pmu_timer_handler;
+	hrtimer_setup(&ddr_pmu->hrtimer, cn10k_ddr_pmu_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	cpuhp_state_add_instance_nocalls(
 				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index cadd602..6ed4707 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -752,9 +752,8 @@ static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pmu *tx2_pmu)
 	tx2_pmu->cpu = cpu;
 
 	if (tx2_pmu->hrtimer_callback) {
-		hrtimer_init(&tx2_pmu->hrtimer,
-				CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx2_pmu->hrtimer.function = tx2_pmu->hrtimer_callback;
+		hrtimer_setup(&tx2_pmu->hrtimer, tx2_pmu->hrtimer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 
 	ret = tx2_uncore_pmu_register(tx2_pmu);

