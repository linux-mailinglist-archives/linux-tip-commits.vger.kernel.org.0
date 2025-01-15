Return-Path: <linux-tip-commits+bounces-3257-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67DA12B36
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 19:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837683A6E8C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3C1D7E26;
	Wed, 15 Jan 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2XxZ9V+d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awJeYK04"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9D1D6DB5;
	Wed, 15 Jan 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967269; cv=none; b=dll/kA8YqRJE4xnyupqtTdxASTzPa5ckSQ9Y4tJejZTtANnPwTE/LK9x9uEHZV3/euk/zhT7zC0mj/70h7gWM4PTP2F9aozYvY7NtS/zwC4V5Nd74X9eYOtSt++/mB+pRU3r6sUKCu85D9ywTl/t77h1nHKPFgKCf4uVpZsaEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967269; c=relaxed/simple;
	bh=oXTBy1zoBaUw+gHyQytg/N86yKrJY0r7bqiUVJpZ/54=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GLXkEmZ5xarXSogbDXtQTggV+0dnnRTZyB8IUwIl3Vdc0Ab9RucY8I8Zg1b6pKZbZN1EMZZ49oK6kX1FhFaGDJ7d1c3rliKkfHKbQRFgzDaIAxxQvdPqvLGX/GwPubCeNUVq3LyvlhgSNzUDWwbdDhIr682zpOHXOLdAHKGfzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2XxZ9V+d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awJeYK04; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 18:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736967264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbC2L5FeE7oVhLlq+vd32EGxUrbVJBp4KmzLqIMGHjc=;
	b=2XxZ9V+dj51voJVftG+4UgA4zaddfjEkKUwGVN5YIYcRb8bttuxPy+h6kwtaF96E4uA7i4
	/eOx1giChJOZBgKWh6vSvOohIv1h5jMBW9x7ttUI7cDc/TGRClT48EClz5garkOXZ1O9C7
	aBMTu8AITrqgcFpcyolPoqUUjCnKXNeDV4v7RjYwBzRRLWTzhu7a12fgcrTmiPzxpetpjA
	liKsMbAc/FMosLg0LzSQjD1ieMqEFqNmmZ75kQdgTlnwMT+Sn9TGc0j3vGtWvPrPf7RuZ9
	0o4rdfe9sZpU9daj3xpC7uJ0dE0PkU6exUPiqHlDkgpYOeIFHNKq/uvBfhHYhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736967264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbC2L5FeE7oVhLlq+vd32EGxUrbVJBp4KmzLqIMGHjc=;
	b=awJeYK04FLN9bW1vb10nwZIn35IFtUyoZDhibXil0WvCWS13JWznCr1xdeXwjNljPfdLMb
	lddboHARaJe73CBg==
From: "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource/wdtest: Print time values for short udelay(1)
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <717a2ddf-a80f-490b-aa3a-4e4b74fa56ca@paulmck-laptop>
References: <717a2ddf-a80f-490b-aa3a-4e4b74fa56ca@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696726437.31546.9958126258938404769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     776b194116d1a484b6d04abfe4b86272f0700144
Gitweb:        https://git.kernel.org/tip/776b194116d1a484b6d04abfe4b86272f0700144
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 12 Dec 2024 10:56:20 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 19:49:13 +01:00

clocksource/wdtest: Print time values for short udelay(1)

When a pair of clocksource reads separated by a udelay(1) claim less than a
full microsecond of elapsed time, print the measured delay as part of the
splat.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/717a2ddf-a80f-490b-aa3a-4e4b74fa56ca@paulmck-laptop


---
 kernel/time/clocksource-wdtest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index 62e7344..38dae59 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -137,7 +137,8 @@ static int wdtest_func(void *arg)
 	udelay(1);
 	j2 = clocksource_wdtest_ktime.read(&clocksource_wdtest_ktime);
 	pr_info("--- tsc-like times: %lu - %lu = %lu.\n", j2, j1, j2 - j1);
-	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
+	WARN_ONCE(time_before(j2, j1 + NSEC_PER_USEC),
+		  "Expected at least 1000ns, got %lu.\n", j2 - j1);
 
 	/* Verify tsc-like stability with various numbers of errors injected. */
 	max_retries = clocksource_get_max_watchdog_retry();

