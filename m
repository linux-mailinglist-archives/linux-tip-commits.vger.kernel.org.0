Return-Path: <linux-tip-commits+bounces-1261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0734D8C8253
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 10:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47EB28139F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD71B94D;
	Fri, 17 May 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YM5HLagf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZx9Eu6m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31511199A2;
	Fri, 17 May 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933173; cv=none; b=W7iHAyRETcmeRue8Kt/iL0wXaloWh/FgFNtQDi9PlZiObxd759WP2hKSs0hqcK2IA8byiNVOgCSNtccjQYGNh5rGhfLgOb9s1CIf4Ck+lVTds3I5Uu+WjdsNYuGQUsU7uhGJcOY0XIbqBCc1MTSzv4CmrJlW5xMVcjSIdb0ff3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933173; c=relaxed/simple;
	bh=jNneO9bmaMNPBJVCxleElN3bh9dEZfqgRo76Tfh7peA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nOuE8YdKB5HILmPxx8c34fS8rExyyFUOwk9CEQ76LNnMx7Q4Qkme7WBaV/J/VBRZZmug4eQo+ASWl7tOwunA/+u5TxTjGLNpZJjBCV4TPTadM1KqUkE8tT7P3MuHXzW0fztmzYBBfqj40mxH5bll9KRVq7NCzsyNu/zlLbl3VnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YM5HLagf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZx9Eu6m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 08:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715933170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3Iy5KH4Ri+raN2Ol1VdPOOeuFVq4IBOP5b//7P0Fc0=;
	b=YM5HLagftmIMLVzgvXBYEUBO4lbj5JaKnFPVpucjpf/LxxD/Hr4R/T8iNt0MWECMt0mIyl
	0pw4fh2JObCaEL3n/qwl5ri6aSjPKDkY/kPiOFrZ7ztjYQ2na0apHwCGtpG3stWs71ZzxT
	lpZ2cchey2UFpWdFrax2+21vyHnVzoO3U0V+xuu3AhfGw0/59ONigyecal79pXp7IiuybL
	mETGAhISBUC7qPa+25ghJls4WBIoZuWjS+PnzfmrQZh0zBiPSgUReWQ2qkDJhIUB/KnzvS
	NYTfKwABO2CiUwYREKa2Ie2556B2aV5rysBpCBM/Ha4wisqO++7yXG9x3PoKug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715933170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3Iy5KH4Ri+raN2Ol1VdPOOeuFVq4IBOP5b//7P0Fc0=;
	b=nZx9Eu6mr8roCLa2tSdI8BF1gWGAINSU9VdclMOkGhc9GH1CPC7PjUjddl/ue+Qupp04fP
	us0Bv/e1DLJStCAw==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Remove stale FREQUENCY_UTIL comment
Cc: Christian Loehle <christian.loehle@arm.com>,
 Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0e2833ee-0939-44e0-82a2-520a585a0153@arm.com>
References: <0e2833ee-0939-44e0-82a2-520a585a0153@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171593317034.10875.13671501551374746016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     7cb7fb5b49399fc59f1c44686d82c0df0776c8c6
Gitweb:        https://git.kernel.org/tip/7cb7fb5b49399fc59f1c44686d82c0df0776c8c6
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 05 Mar 2024 15:18:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 May 2024 09:51:54 +02:00

sched/fair: Remove stale FREQUENCY_UTIL comment

On 05/03/2024 15:05, Vincent Guittot wrote:

I'm fine with either and that was my first thought here, too, but it did seem like
the comment was mostly placed there to justify the 'unexpected' high utilization
when explicitly passing FREQUENCY_UTIL and the need to clamp it then.
So removing did feel slightly more natural to me anyway.

So alternatively:

From: Christian Loehle <christian.loehle@arm.com>
Date: Tue, 5 Mar 2024 09:34:41 +0000
Subject: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL mention

effective_cpu_util() flags were removed, so remove mentioning of the
flag.

commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
reworked effective_cpu_util() removing enum cpu_util_type. Modify the
comment accordingly.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/0e2833ee-0939-44e0-82a2-520a585a0153@arm.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9009787..9744b50 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7900,8 +7900,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * Performance domain frequency: utilization clamping
 		 * must be considered since it affects the selection
 		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the
-		 * FREQUENCY_UTIL's utilization can be max OPP.
+		 * NOTE: in case RT tasks are running, by default the min
+		 * utilization can be max OPP.
 		 */
 		eff_util = effective_cpu_util(cpu, util, &min, &max);
 

