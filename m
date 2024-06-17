Return-Path: <linux-tip-commits+bounces-1402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326E90B119
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC60D2863A9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B8A1A5318;
	Mon, 17 Jun 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2iJQexs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuHoSms2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DD1A92F4;
	Mon, 17 Jun 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630823; cv=none; b=OcoBeSBa2q/N0iduiosjwzevC8IxHysPcVVSg/Ju6bfJvTHyo09LJ6nOIyzmi3kF4ECbg8r3wjPuNgbDabJUkerXa0Vt+CLSl+ltoj4FXcf42xh52/cAsY/39bwKq7yeQDy4IJLllILOmJ0nkkkXfqXQO2S2IVqId5vL8LFvIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630823; c=relaxed/simple;
	bh=OJvAIGdXoAiQ5x0nnLDGDG/WlfUgXn8ZyWPe9ycRamE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=defWruamx95rFt2/nrtktio5lXJwFSJfMgYoC5wqBJQGgVQ0Os6YVsmDIut6W/vC4nhhhysOHijbjAHPj2oG08YecUa+O9nN6XNjiNi29LAY43rlNjGS2c0op4MaI+3TvYb5EfWYOgylqHoYNfZj243QDpfdzn7+ffzDQCTJJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2iJQexs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuHoSms2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718630820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eqnkrk9k9EBOMajRv3D+I10MRFZZTunhJ2pXW5r6rLs=;
	b=U2iJQexsJ4jPAE4+hBwfp1SslY/fNXpZMjwzBpVcn65WT+Royy87ufxob0PD93OilROsiX
	U+Bg1jDR8qFX6YwhL9Fe9lRZ4aY9ZhcAfISJgBT9GA2o+QEWfFaW61QlFseahFaySGrHsl
	hM3pWZXpxF9O6Pc0Y8BkNgjtodlBRUo1Y2GSUs5FapWm9RtiohGgR68hN2nRyhfeh8Pu/B
	kcaYbgqjz01/ZdQBU5mYiO5gnZWZyBo92ArdbavayHsisQ05kDFz4LlKxuEK7DZzchWOTC
	SkocPqfdJa9Xwk5WdOrDUEg7a7mhcgbsoZ4ilvIXDOYbsJuhszkeoJifflJ+gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718630820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eqnkrk9k9EBOMajRv3D+I10MRFZZTunhJ2pXW5r6rLs=;
	b=QuHoSms2mUW0hYtyjVYFGBK86LmRNqum6+297Q1QX83fauWlXwACanXsEmGEvGwHyRXg2U
	2aMlss0a6F6ylaCg==
From: "tip-bot2 for Stanislav Spassov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Reverse order of iteration in
 freeze_secondary_cpus()
Cc: Stanislav Spassov <stanspas@amazon.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240524160449.48594-1-stanspas@amazon.de>
References: <20240524160449.48594-1-stanspas@amazon.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863081993.10875.11129262468770860324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     fde78e4673afcb0bad382af8b81543476dc77655
Gitweb:        https://git.kernel.org/tip/fde78e4673afcb0bad382af8b81543476dc77655
Author:        Stanislav Spassov <stanspas@amazon.de>
AuthorDate:    Fri, 24 May 2024 16:04:49 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:17:44 +02:00

cpu/hotplug: Reverse order of iteration in freeze_secondary_cpus()

Whenever CPU hotplug state callbacks are registered, the startup callback
is invoked on CPUs that have already reached the provided state in order of
ascending CPU IDs.

In freeze_secondary_cpus() the teardown of CPUs happens in the same are
invoked in the same order. This is known to make a difference is the
current implementation of these callbacks in arch/x86/events/intel/uncore.c:

 - uncore_event_cpu_online() designates the first CPU it is invoked for
   on each package as the uncore event collector for that package

 - uncore_event_cpu_offline() if the CPU being offlined is the event
   collector for its package, transfers that responsibility over to
   the next (by ascending CPU id) one in the same package

With the current order of CPU teardowns in freeze_secondary_cpus(), the
latter ends up doing the ownership transfer work on every single CPU.  That
work involves a synchronize_rcu() call, ultimately unnecessarily degrading
the performance of CPU offlining.

To address this make freeze_secondary_cpus() iterate through the CPUs in
reverse order, so that the teardown happens in order of descending CPU IDs.

[ tglx: Massage change log ]

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240524160449.48594-1-stanspas@amazon.de

---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d..1979a99 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1891,8 +1891,8 @@ int freeze_secondary_cpus(int primary)
 	cpumask_clear(frozen_cpus);
 
 	pr_info("Disabling non-boot CPUs ...\n");
-	for_each_online_cpu(cpu) {
-		if (cpu == primary)
+	for (cpu = nr_cpu_ids - 1; cpu >= 0; cpu--) {
+		if (!cpu_online(cpu) || cpu == primary)
 			continue;
 
 		if (pm_wakeup_pending()) {

