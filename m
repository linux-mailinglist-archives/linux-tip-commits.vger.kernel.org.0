Return-Path: <linux-tip-commits+bounces-3418-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F142A39771
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0437A4FD2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B4323ED71;
	Tue, 18 Feb 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HqlCKMP7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEnsv/ve"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8723AE9B;
	Tue, 18 Feb 2025 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871998; cv=none; b=CjBnT4xspJgwlIAwDunFA/XDWPd7Uf9kYg7zMwH4v7yz3DZfqSkrNSBxz/NLweXNbRZeEzV8b9hENhIZlwmg2tlY4vNCWsPNAWguR/5aNEhdtNYxgyNQ0v5VqjGbxRsI7EIZMo22YbazLKbRXZRpJxa6QZWpuucvMoMlqlQgMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871998; c=relaxed/simple;
	bh=Q6nFsc0o3vnUT3rpGir2wRZYMLDROejXh1thnzDRVZA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o9NJxVCdi4Zjx9fcrSBlsIUF0F+8RCAvsbVeqREZxmUi8k/VA93c4li59EoD4JqZJ8gzCdnzcLfCMqm4kgLyD1EyGMKkZDt8Wc29qYoGiaDIcyIzmlttbMQVZkdxbdzCXupbVYRhJZL55L45MMSnpykCxx9NpCvlXfjohngyWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HqlCKMP7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEnsv/ve; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMhKEolJJC1x/LzfL4InMB6hD7fxYXqFGOoIBP2xFK8=;
	b=HqlCKMP7lpu4ktofXYiHBylZkDiwmxHLys1JqL1NcZv5H0zNVWAoXdYiNTeiGMcEGr/SlX
	Kpty9CvGylANfdi/LXAJktat8iPF4RrCmYmvWTsUQ37jSWalAC9ZMBskS111+3T/2V4N49
	vC1ttujZDd+wVxPGDLShzh9LBCo+oyTqWsncVaEXj+8sv1oIRkUOc1pHrD+E/oioWsReLR
	K1kbcaSyYN5YdwasYvPSGz0Mnn7l6Dpy9SiYFYSpVyL4g8RbjGbxEzM+RlyYGvxtS3vlbh
	5AmrBv59NG2vXcTWfum1S2B/6dhLbRv+8DkOxx2QEY/KMjlA8W2v8pj5UnBR3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMhKEolJJC1x/LzfL4InMB6hD7fxYXqFGOoIBP2xFK8=;
	b=sEnsv/veY4Xsn/uCaO1CQsIL7ApGJdPe62/B9BQkRWCtGai/puPWFcRKhTqArTbKRjqaur
	Fbe5s/NnGaQkxoAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] perf: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf611e6d3fc6996bbcf0e19fe234f75edebe4332f=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cf611e6d3fc6996bbcf0e19fe234f75edebe4332f=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199513.10177.7780422647928863963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     022a223546e4fa03bde18fea4562d29b4e1a432a
Gitweb:        https://git.kernel.org/tip/022a223546e4fa03bde18fea4562d29b4e1a432a
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:32 +01:00

perf: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/f611e6d3fc6996bbcf0e19fe234f75edebe4332f.1738746821.git.namcao@linutronix.de

---
 kernel/events/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e0..db5792d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1147,8 +1147,8 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_pmu_context *cpc, int cpu)
 	cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * interval);
 
 	raw_spin_lock_init(&cpc->hrtimer_lock);
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	timer->function = perf_mux_hrtimer_handler;
+	hrtimer_setup(timer, perf_mux_hrtimer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
@@ -11367,8 +11367,7 @@ static void perf_swevent_init_hrtimer(struct perf_event *event)
 	if (!is_sampling_event(event))
 		return;
 
-	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	hwc->hrtimer.function = perf_swevent_hrtimer;
+	hrtimer_setup(&hwc->hrtimer, perf_swevent_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 
 	/*
 	 * Since hrtimers have a fixed rate, we can do a static freq->period

