Return-Path: <linux-tip-commits+bounces-2271-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971F972BBA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230481F26476
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1E18FDD2;
	Tue, 10 Sep 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugsVcMBN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJBQqwDo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2718FDC1;
	Tue, 10 Sep 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955771; cv=none; b=SQVWmpumM3P8PNFiE5plXBQRU1zZlX/sQvUZyI4Csq2eRLTdqO94UATS6Ke+tYcwzAfdr1Zai7Xv1WhxDa9aZH5WxkUk14zPCXuvNgCsMlDCtwZfrroGWtVDX2UNpiT2wvbk8MfW1gf+d8/OCLkhcBP11nXxFmR7LDYth9SpF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955771; c=relaxed/simple;
	bh=ey8hHvc1fxDs7TrfFLZDsEexrUc6x5c2zH7RBbGDYe8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N0MFzGY2anN0jXBAtAj+fIotMFNiYyCsLuTJde8XDdFS5LPGViNqXfJ3TUAzHir8c+VJZTo3jV/kAZmNCD7FIG7MswjeiiIwOF2hxnD62YOQMhsPdCRF2QHs5ycqQEBp/31ahrOijqvFlfANhXTZDycxHKxAF6WtwT14h4yQW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugsVcMBN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJBQqwDo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnf4/CH50+gznD7jGowk6vz7cOa1sDgl/jSHC8wroZ4=;
	b=ugsVcMBNALK0ybNmqCKrPCu+iLILIWx0Tj+b2pjv7X4uj83JpKEsx8rnGJiycqaYcIrXba
	vVWIw369eQS2gwgTzIGCqEv4D6MYWY3df17NGlhrkcKbulFqqdkvy+2GdGHHnodY97dP1b
	veI06p4/W9IecEgHX0GjXJ1PAzwNey2eXzaQICsfmS6nChjdkDPQIZmGV7eDzYpUT1MIUh
	0l+ObIIkqNwFLp/jgoxYBrHICt+WM2a0wVv2sDlO7KgEuyCZS13ffJA+0pZNuRTTcapHEx
	l/WQPpBPAVShuk5NhMyE7UIQDZmFaDdFxtluSNU0+uMehgxyc/0cM/RfKXaZJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnf4/CH50+gznD7jGowk6vz7cOa1sDgl/jSHC8wroZ4=;
	b=tJBQqwDoAShuRaHtbfuuYOpzyAPzYrDzAQo459YHRr/nRLt6BCU/SeASbI744HS+dP9K3g
	BRfGUnPj8mFnTXBw==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpufreq: Use NSEC_PER_MSEC for deadline task
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-5-christian.loehle@arm.com>
References: <20240813144348.1180344-5-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576093.2215.291368724489277408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6cbbb91711c6b17da3802a3cf072d3311828ca33
Gitweb:        https://git.kernel.org/tip/6cbbb91711c6b17da3802a3cf072d3311828ca33
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:16 +02:00

sched/cpufreq: Use NSEC_PER_MSEC for deadline task

Convert the sugov deadline task attributes to use the available
definitions to make them more readable.
No functional change.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-5-christian.loehle@arm.com
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece624..43111a5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		 * Fake (unused) bandwidth; workaround to "fix"
 		 * priority inheritance.
 		 */
-		.sched_runtime	=  1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
+		.sched_runtime	= NSEC_PER_MSEC,
+		.sched_deadline = 10 * NSEC_PER_MSEC,
+		.sched_period	= 10 * NSEC_PER_MSEC,
 	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;

