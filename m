Return-Path: <linux-tip-commits+bounces-1266-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1A8C825D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 10:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EBC1C22029
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41F2E62B;
	Fri, 17 May 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZJLyqTjU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yo1/S+FT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483328DB7;
	Fri, 17 May 2024 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933176; cv=none; b=INE3PWSS+hJ2tue/K3RJqZLjBF3rJJ7G6WXJ0XM0A0fVlMoo+QRj0hz/9M/SH8U12mJCxG79lphzqMv1fsaiPCnIUyOa8zfl37Xwry9KGMR+JuXNBOWu1BawC+VDXrwDZNoliAIlbaPrTWn3mX70v3StED6thLMWwFQLWgODDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933176; c=relaxed/simple;
	bh=I7vKyuuBa21buoq2JjLNZ10zt4Ov1stKHuENPHh67ec=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PgeYPpKQQmKOlipQXZ86LLeSsZU9I49pI14jKeMX9dYChP54YIWrHexTuj7f1rIHNMLmGQSqRIULph3ySgnGTLIS7sXw6pBgmCC8Q9KCW/rU8dIs5lAzG5Ds6vntS28nReb9b8WgOCs40k0tdCVEbGqhbmCZPH71PLTMZjTX65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZJLyqTjU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yo1/S+FT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 08:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715933171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfjV75NO9SZUF1uggmWNt6tuHqlxRKiRhZjsLp2Oy8c=;
	b=ZJLyqTjUAOGP+q9C0T355PG4hKWKv+W23F/CDGAvvKUwZCzpcSMOa6Tj4qFtXkAxLXcpe5
	0fjXYW80YUIKawKIHTWGTbUVyuDvebItIXBQpmyaG3pP/0p2gaRYin1U4MHqNtwbcqt/7A
	oD2yot78xRQcN6GXTDGreH/GgUGCuAvSlWtp9w1qsizTCJcn6sfdf3LKHGehXufC8XWGlF
	EKyQUyMxOyqhHd2I1tq4o3LNvc2JZiQsbeZe4o/w9yTdXcZBD5Za6bzI2qRDDouHqoscxE
	jdgw6/IaRaj2t4+LcKzhk3XJ74WMuXkAoIALXF9QQ8J525+Of/0NfavrwT9xeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715933171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfjV75NO9SZUF1uggmWNt6tuHqlxRKiRhZjsLp2Oy8c=;
	b=Yo1/S+FTeIV4A5EpbSXynjpmKMbyN5PGQo/GWwaYKeERVRi2234kxXo+riZ5Aj3YXwRGKZ
	TdSMqchlCgpUFODA==
From: "tip-bot2 for Vitalii Bursov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Allow disabling sched_balance_newidle
 with sched_relax_domain_level
Cc: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <bd6de28e80073c79466ec6401cdeae78f0d4423d.1714488502.git.vitaly@bursov.com>
References:
 <bd6de28e80073c79466ec6401cdeae78f0d4423d.1714488502.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171593317134.10875.3767772724461271480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a1fd0b9d751f840df23ef0e75b691fc00cfd4743
Gitweb:        https://git.kernel.org/tip/a1fd0b9d751f840df23ef0e75b691fc00cfd4743
Author:        Vitalii Bursov <vitaly@bursov.com>
AuthorDate:    Tue, 30 Apr 2024 18:05:23 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 May 2024 09:48:24 +02:00

sched/fair: Allow disabling sched_balance_newidle with sched_relax_domain_level

Change relax_domain_level checks so that it would be possible
to include or exclude all domains from newidle balancing.

This matches the behavior described in the documentation:

  -1   no request. use system default or follow request of others.
   0   no search.
   1   search siblings (hyperthreads in a core).

"2" enables levels 0 and 1, level_max excludes the last (level_max)
level, and level_max+1 includes all levels.

Fixes: 1d3504fcf560 ("sched, cpuset: customize sched domains, core")
Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/bd6de28e80073c79466ec6401cdeae78f0d4423d.1714488502.git.vitaly@bursov.com
---
 kernel/cgroup/cpuset.c  | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4237c87..da24187 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2948,7 +2948,7 @@ bool current_cpuset_is_being_rebound(void)
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
 {
 #ifdef CONFIG_SMP
-	if (val < -1 || val >= sched_domain_level_max)
+	if (val < -1 || val > sched_domain_level_max + 1)
 		return -EINVAL;
 #endif
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 63aecd2..67a777b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1475,7 +1475,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}

