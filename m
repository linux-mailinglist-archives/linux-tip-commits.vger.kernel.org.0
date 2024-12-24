Return-Path: <linux-tip-commits+bounces-3143-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D529FC188
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905691885394
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1852135A3;
	Tue, 24 Dec 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wcI6y8Jr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ZOly+Jl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF02135A0;
	Tue, 24 Dec 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066485; cv=none; b=Zrpeo9RtbH991y1zlAW2mpy2LpKezJFuJ5qXRO1LDYHVWeMuWkms2+HqQ3uM0z8jwzraJEWexLa9ZWD5vr0IPZ7P4A71h7Jkw8i4hKV0zVc0XKIrcyU+i0GhZfmYN6AMtkAKIK6Z5edDkxS9cnGuCFe8sCsErCEU2AZodbADaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066485; c=relaxed/simple;
	bh=NvMmDuCbSiXevs9LTiUvSNMBOw2D4N2iHNgn0dxe+0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e7BVl67/+QuUkETBSqXI1abB5ti6kk8GBQaUhz/O5d6LnzmLC5fQgTmTbUXRsDIWYHyqfxc2/Bk3xQMtRQRVz5ytQiHOB5v1hNKde8zRCOmYxEkuLS8XYS3GrhXIYD+uxoCxvmFezpk6MfsTN45WYuJcZ0cX9ahDYxpDMDS232U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wcI6y8Jr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ZOly+Jl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmm0vIGxsdJMJbE43CSDPupewgWp4TJghgr0OdeIIyw=;
	b=wcI6y8JrA0myL6hoEwxdGhA8o4HwK+nlISto8/8MLIOiOsAM/OV6mojXq6rDitnQRcm82i
	vVOWDj67xCveH+ugJGpANfIWgvk5p11CWlA4Dyt1RBk4SRrcZsANFTlx8DMAfkc/nO5Okj
	mLQBG9ary51rCbcb13U4uQ6yezewjp3rZFFMqeP2fJJ/clt+ze00yCpv/Dh5BMaoPv4naI
	5v87fSulGSGXjqvYTaSVXWmBBsdFt1V8CisQBBpSMDHkJwicueb7+tTqVsGxvwZH5AuMil
	uhSxd8Zkhrc/pAqNK8Bo95yPIq1syEM9wJ1RtsbgNM6nrM0PRKfVuswc1c9+HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmm0vIGxsdJMJbE43CSDPupewgWp4TJghgr0OdeIIyw=;
	b=9ZOly+JlDolVG2o/JGk8tGAGbpc5zNa1Y/E9ziolkEYioqBWKGluQ5bwe5xMwuGc9VLLoG
	4OJTtRz3ODdKP6BQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Update comments after sched_tick() rename.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241219085839.302378-1-bigeasy@linutronix.de>
References: <20241219085839.302378-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506648163.399.16725762144492741903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ee8118c1f1864eab709fb660d3af8545cf11ae96
Gitweb:        https://git.kernel.org/tip/ee8118c1f1864eab709fb660d3af8545cf11ae96
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 19 Dec 2024 09:58:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:16 +01:00

sched/fair: Update comments after sched_tick() rename.

scheduler_tick() was renamed to sched_tick() in 86dd6c04ef9f2
("sched/balancing: Rename scheduler_tick() => sched_tick()").

Update comments still referring to scheduler_tick.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241219085839.302378-1-bigeasy@linutronix.de
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8f641c9..ae8095a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12868,9 +12868,9 @@ out:
 /*
  * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
  *
- * - directly from the local scheduler_tick() for periodic load balancing
+ * - directly from the local sched_tick() for periodic load balancing
  *
- * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
+ * - indirectly from a remote sched_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
 static __latent_entropy void sched_balance_softirq(void)

