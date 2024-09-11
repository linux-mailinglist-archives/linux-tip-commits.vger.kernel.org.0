Return-Path: <linux-tip-commits+bounces-2296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF4974E99
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454D8287273
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5AA17BED4;
	Wed, 11 Sep 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+lTcswB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FyM4VTzp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798A1862BB;
	Wed, 11 Sep 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047180; cv=none; b=i6Zr6MsIxxgZFSbpjrCjIzIpKtXL53KE9+fUH2ukUyyzfQGD4wwR1ozzbdUZcRsIMQsBme4LZNWWZ+3x1IY3/VI9Th4j338sOOmwKyDmxaEHl7+ZSrs7XWXo9PzGl0IkBBNLkPQhuvJVujymT0OCasjzip3YaNTSWzoSZv6Cezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047180; c=relaxed/simple;
	bh=GzUrL/KfazhfJFuBbyuSRB2jQ92hbUYVcuzg6qsY6NU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ys3099MYWFBHdrASpCGxR0E2hNgcBKOLlG+duhG/4lIUWInxpQ9YBUqKc/LQamk9lXIFunol5Eymgzbpx28Q9Yne0nV+ezcQ5a9FgCxrc5qLyPkycweSS3oailKS1FjKMu6V+VK5VjqAr/0TthS3gv4nVxRPwOK8W/jSmnGJw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+lTcswB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FyM4VTzp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Sep 2024 09:32:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726047177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRvojFNRnwRuZATYeB4QdqgSwWpl3TiUBm0GlR7Wh+M=;
	b=l+lTcswBMhy0Qkoz7ECAPlS3rQ31q1r4m7ZeaWQdQkxNtJoj5tjcHVe7UUPUnmYy1F4sfE
	MYw7VmBjIDeJPFqe/m9nv/RbDWy4Oa44Gn7KYnEpOmV3UvyNIgthU/oeEibqj0EKZWscyx
	Q/MNKy5aeOsmmcAosJHNOTOqR0ez04UIyr/AbyQChz7Mzf7SS4OQZm5HEeVU3iRJxGPOE4
	fDijrC/d5+3E46n/9yPlrQKZUn670whUCO0CbZatSzHuUh7B5XzbTxzU5QCc3917ToLfxh
	5xQ6aeD8WPuEc3VS4v+3gnXPfZqGHJfsQM4mGo5+ExtERu8VihHirbn2z5+7yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726047177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRvojFNRnwRuZATYeB4QdqgSwWpl3TiUBm0GlR7Wh+M=;
	b=FyM4VTzpJjcHxSyyN+IvupbR2eJY552yRL5DreEXA3RK5OVBI0RY8ZNzb0Sod3lhXDtphg
	KynD2s1e7p/pjdDA==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-4-christian.loehle@arm.com>
References: <20240813144348.1180344-4-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172604717704.2215.15463514490818312946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4eb71e3b4550593d9a862cc0aa754fad98679783
Gitweb:        https://git.kernel.org/tip/4eb71e3b4550593d9a862cc0aa754fad98679783
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Sep 2024 11:25:10 +02:00

cpufreq/cppc: Use NSEC_PER_MSEC for deadline task

Convert the cppc deadline task attributes to use the available
definitions to make them more readable.
No functional change.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-4-christian.loehle@arm.com
---
 drivers/cpufreq/cppc_cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32d..1a5ad18 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -224,9 +224,9 @@ static void __init cppc_freq_invariance_init(void)
 		 * Fake (unused) bandwidth; workaround to "fix"
 		 * priority inheritance.
 		 */
-		.sched_runtime	= 1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
+		.sched_runtime	= NSEC_PER_MSEC,
+		.sched_deadline = 10 * NSEC_PER_MSEC,
+		.sched_period	= 10 * NSEC_PER_MSEC,
 	};
 	int ret;
 

