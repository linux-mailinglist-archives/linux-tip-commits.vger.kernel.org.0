Return-Path: <linux-tip-commits+bounces-3290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D82A1D38F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jan 2025 10:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B0F1886A3F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jan 2025 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1091FDA7A;
	Mon, 27 Jan 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s+83GYoS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbgi/yR6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AF1FCF54;
	Mon, 27 Jan 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970603; cv=none; b=jpnUFWyzk88MhmhFC0f2Y6qz0uKJCTh5s8U2NA+JYWwNKjG/mX70YPRBhy6fF9ig/7rTQY/79RAcyD5lyUm+rznHnbCNh2yDVwVGVnKAgLq9B9SxVQbecp0znK07T7I7FdpT0uwhH/6Dq15IzQO3oh7ES3BnY/XAy6WgijAhN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970603; c=relaxed/simple;
	bh=JCegycVo8RwdLgIm73c29gLSfo5se1riPnzzA37n07s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rFspNiIOW+H31mU1Kt+EBtL4T9Prw3F1GEPM888Ox1k7+x2JG7CkTd0J/KcOf2H0M8u+plbPaKvNosYaOOVPcm/WXElD+b+UDawqDQSeZMgLhqQPlDVqiTpKTI5z8gTXv7T7qpCbmeDLTrnQ4v0ur9mx7iK4fi9gOMaa+2M2QXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s+83GYoS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbgi/yR6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 09:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737970600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enBN5PDcF/5mxqUJKSNxKNDX96epR7rX0YCTHyJEHtc=;
	b=s+83GYoSRvuxLtMj0bVtH9s6p3U+3lBqPOds2r5k9v8HD6XduRpudonJCpx1NLOw7XE8GX
	LBXNu7f1+ETo1MQ7jBKiT6Vgbp2WpU73RZfdXGy0/GtwB9CxrDoIQdB1LexXlfjUeQX260
	KKkyW1XjD7mQI4RRWPgr32POW/wsAjOkWtw240u1zQUS5Wx54PRHsL2Kw+k5Iu2trf8DO/
	J9O6T1jDxYTrSljVbHyJOevq4rYnkEOaj5a9UVUAzY2KyUbFyJlLJurWcBT9yuWc4UHtNE
	O1jWxgJUgp1qMAts0MrYXRl+y4JeoMbHI7TB7IyEmb5aKqb/u0D+aXrCBTKWdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737970600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enBN5PDcF/5mxqUJKSNxKNDX96epR7rX0YCTHyJEHtc=;
	b=nbgi/yR6hiaovuhTCZLBUlS1V/YJYfKUSkcg22VOQCpF6ucJbh5e+zdebyTe7h60dMttc5
	jHb1tTBzpwmHdCBQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource: Use pr_info() for "Checking
 clocksource synchronization" message
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250125015442.3740588-1-longman@redhat.com>
References: <20250125015442.3740588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173797059950.31546.4230695600363853127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     1f566840a82982141f94086061927a90e79440e5
Gitweb:        https://git.kernel.org/tip/1f566840a82982141f94086061927a90e79440e5
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 24 Jan 2025 20:54:41 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Jan 2025 10:30:59 +01:00

clocksource: Use pr_info() for "Checking clocksource synchronization" message

The "Checking clocksource synchronization" message is normally printed
when clocksource_verify_percpu() is called for a given clocksource if
both the CLOCK_SOURCE_UNSTABLE and CLOCK_SOURCE_VERIFY_PERCPU flags
are set.

It is an informational message and so pr_info() is the correct choice.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250125015442.3740588-1-longman@redhat.com

---
 kernel/time/clocksource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7304d7c..77d9566 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -382,7 +382,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		return;
 	}
 	testcpu = smp_processor_id();
-	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
+		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
 	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;

