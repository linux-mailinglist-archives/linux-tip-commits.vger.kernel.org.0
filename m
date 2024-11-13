Return-Path: <linux-tip-commits+bounces-2853-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5739C7CD5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DB6B2DD0E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7E9209F3C;
	Wed, 13 Nov 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZx+jLKD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+vtK8GxD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AD2071F4;
	Wed, 13 Nov 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529255; cv=none; b=dtxO0dldw3gaCtgN2+TjCUVgIkh99iuua/xhk4Beq2q10AKmwe2kPOWVxRy9nYiOwbc62zIgu40NB9b9JCFIwyDuZTgFECTpNEVKin0j4AIZtSyZsO7szHSfNvex4jXbGMtxR6HS1lsFegAwC4cEQFrlzzNTxabGtd4lcmW/c4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529255; c=relaxed/simple;
	bh=E6KvrjjGHwzpLqor++nxIqkmOuMavQM4DMyMUSbtI1E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ec42OA74/rqPW7gR1GCmzQCmL6N6POkKC9duxZFaxMTHpZDpmy1CEiuH5mF5byINkP1/pg1tPHGeHDxUZ60A6sSARQUkJ8SN25m79NOGOwNy44ioJMnIT49J4A/riLTgPhMRNavQK1MLYwcFc38iwu+hG+ke7n3nJa2KsALF1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZx+jLKD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+vtK8GxD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73nrre7Z9cNuAoRMv57kLgL68MucMrFH6+v06Z1+GJI=;
	b=IZx+jLKDh7rTbf3W1vQrohiNlpIHqnEOw6Em006a+bNttHs4HokeVSDyIHd/qK052OPPke
	0pTbhyC1P5D0JkJNC4ejJuJixs61Vu3r0E4+MXnypMA/a3ZUAGr8cQ5lRjOd6iTFVWgYEe
	teGhdqPTIIvgZsWyyMgXZT7/L7Ij8jBcSrl1UzNMIa5vrgWtGn8+u+RwaEaQHaZ6SjHa4J
	t2htNT1eAL79MstOFmwInuF/W04Lc+nsua3tQSnepTuHGiwF5HKH/mgpa2801eIHVX3ato
	F9mGyO9GwTuAimimNEiFqofDps3Vp+cUvll70bNAMlwW2AOYDeT8JOHVNoPagw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73nrre7Z9cNuAoRMv57kLgL68MucMrFH6+v06Z1+GJI=;
	b=+vtK8GxDSc1zs4BXRTrP3NCIunlmpfBECAk+uTpV8Ee2+zSNOYtX8kRieG26BkWah6LVuF
	VMqfVF6LLyk1zfAw==
From: "tip-bot2 for Paul Burton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/mips-gic-timer: Always use
 cluster 0 counter as clocksource
Cc: Paul Burton <paulburton@kernel.org>, "Chao-ying Fu" <cfu@wavecomp.com>,
 Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Serge Semin <fancer.lancer@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241019071037.145314-6-arikalo@gmail.com>
References: <20241019071037.145314-6-arikalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152925057.32228.1494072647672030211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dfe101bcad840d025deb5e43150d54050ab7724d
Gitweb:        https://git.kernel.org/tip/dfe101bcad840d025deb5e43150d54050ab7724d
Author:        Paul Burton <paulburton@kernel.org>
AuthorDate:    Sat, 19 Oct 2024 09:10:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers/mips-gic-timer: Always use cluster 0 counter as clocksource

In a multi-cluster MIPS system, there are multiple GICs - one in each
cluster - each of which has its independent counter. The counters in
each GIC are not synchronized in any way, so they can drift relative
to one another through the lifetime of the system. This is problematic
for a clock source which ought to be global.

Avoid problems by always accessing cluster 0's counter, using
cross-cluster register access. This adds overhead so it is applied only
on multi-cluster systems.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20241019071037.145314-6-arikalo@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mips-gic-timer.c | 39 ++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 1103477..7907b74 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -166,6 +166,37 @@ static u64 gic_hpt_read(struct clocksource *cs)
 	return gic_read_count();
 }
 
+static u64 gic_hpt_read_multicluster(struct clocksource *cs)
+{
+	unsigned int hi, hi2, lo;
+	u64 count;
+
+	mips_cm_lock_other(0, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+	if (mips_cm_is64) {
+		count = read_gic_redir_counter();
+		goto out;
+	}
+
+	hi = read_gic_redir_counter_32h();
+	while (true) {
+		lo = read_gic_redir_counter_32l();
+
+		/* If hi didn't change then lo didn't wrap & we're done */
+		hi2 = read_gic_redir_counter_32h();
+		if (hi2 == hi)
+			break;
+
+		/* Otherwise, repeat with the latest hi value */
+		hi = hi2;
+	}
+
+	count = (((u64)hi) << 32) + lo;
+out:
+	mips_cm_unlock_other();
+	return count;
+}
+
 static struct clocksource gic_clocksource = {
 	.name			= "GIC",
 	.read			= gic_hpt_read,
@@ -203,6 +234,11 @@ static int __init __gic_clocksource_init(void)
 		gic_clocksource.rating = 200;
 	gic_clocksource.rating += clamp(gic_frequency / 10000000, 0, 99);
 
+	if (mips_cps_multicluster_cpus()) {
+		gic_clocksource.read = &gic_hpt_read_multicluster;
+		gic_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
+	}
+
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
 		pr_warn("Unable to register clocksource\n");
@@ -261,7 +297,8 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	 * stable CPU frequency or on the platforms with CM3 and CPU frequency
 	 * change performed by the CPC core clocks divider.
 	 */
-	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
+	if ((mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) &&
+	     !mips_cps_multicluster_cpus()) {
 		sched_clock_register(mips_cm_is64 ?
 				     gic_read_count_64 : gic_read_count_2x32,
 				     gic_count_width, gic_frequency);

