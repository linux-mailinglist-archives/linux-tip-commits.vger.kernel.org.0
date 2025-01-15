Return-Path: <linux-tip-commits+bounces-3220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F121A11DDD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A63A45A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86A236A65;
	Wed, 15 Jan 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwLoPkNY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2SkLwZrL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACC204583;
	Wed, 15 Jan 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932639; cv=none; b=r5mg+NKvbO0CbtdCWN5XF4w/yg7LQ2utvc21enRDtMVqfqakkENL2XfTEI6mnxaGWTA408hxfpnR/aCvYdUMvtl+BeuNnwCkVTzNmZZt1YRJyodfkBssS3GBumT+bbAz6aJHiQgKAj1rFtyFYaukmBLLtpwdpILnIa2rf/Hz9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932639; c=relaxed/simple;
	bh=e58fmtXzDAJFtN8vDT8/8K54WmAaJ7M94nwmJ8RG7v0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YwCjlAYw4NDN+tDZegRmZDAxQwtKnBA9dFpsYfttmxyT67d7pjAPOFGsPu+vADlIufDnNP+YssANEJwL2gKfVKbpU6LWtjZyeo/skH+7ULYP6e2jXhIBc8i1TEDg+wWr15FujfncmHXgp9D0KKrjLY4yCxMCRIv7YoQZ88FUsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwLoPkNY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2SkLwZrL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CZ37U+VGKd6ED334PpfVo0bwnkS5loYk2WU0XYAsaE=;
	b=hwLoPkNYbVzLAyqderig9Yrn7ZEADUcfjhc79UwFfz8ws8GeFdLIvgcrGg9EbbEYosiGpv
	9UkDyKdquX5IAvoZRD0kK6S/HZAdbkiB8TbwBMZyyv4i1XEdAkQW+AmiVuy/rZcHcuYZ7C
	Rjem0kn63IMOpJw+N/V6XrEHztQaoBihOFNcdk7vKqcXiYtyfDf0tTvETZfKzgjAvFhkfU
	phafcBTYcDDjX5pYxKJyGjxe8nKnqL0lQVYfxScKaRmr9InCPIeWB9PBg6VPWzIODssmKI
	beH9fRqb7GENRIaNSV1PXM1dY8rsZouPxxBRV7Y7pPgY4np0pZ7rv/nUeatDCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CZ37U+VGKd6ED334PpfVo0bwnkS5loYk2WU0XYAsaE=;
	b=2SkLwZrL9FwTCe/UdN5RAbEzuoVmAlqMvt7k2mRdKMdXTvukr7YhJle2aKuzmXoxEQq6JE
	PCyK+XYUGRV9lTDw==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Do not compute overloaded status
 unnecessarily during lb
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241223043407.1611-8-kprateek.nayak@amd.com>
References: <20241223043407.1611-8-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263520.31546.5236428820362363150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3229adbe787534b43430f92e10175c9b77f2d27c
Gitweb:        https://git.kernel.org/tip/3229adbe787534b43430f92e10175c9b77f2d27c
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 23 Dec 2024 04:34:06 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:25 +01:00

sched/fair: Do not compute overloaded status unnecessarily during lb

Only set sg_overloaded when computing sg_lb_stats() at the highest sched
domain since rd->overloaded status is updated only when load balancing
at the highest domain. While at it, move setting of sg_overloaded below
idle_cpu() check since an idle CPU can never be overloaded.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20241223043407.1611-8-kprateek.nayak@amd.com
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 650d698..98ac49c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10410,6 +10410,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      bool *sg_overutilized)
 {
 	int i, nr_running, local_group, sd_flags = env->sd->flags;
+	bool balancing_at_rd = !env->sd->parent;
 
 	memset(sgs, 0, sizeof(*sgs));
 
@@ -10427,9 +10428,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
 
-		if (nr_running > 1)
-			*sg_overloaded = 1;
-
 		if (cpu_overutilized(i))
 			*sg_overutilized = 1;
 
@@ -10442,6 +10440,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 		}
 
+		/* Overload indicator is only updated at root domain */
+		if (balancing_at_rd && nr_running > 1)
+			*sg_overloaded = 1;
+
 #ifdef CONFIG_NUMA_BALANCING
 		/* Only fbq_classify_group() uses this to classify NUMA groups */
 		if (sd_flags & SD_NUMA) {

