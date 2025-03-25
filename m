Return-Path: <linux-tip-commits+bounces-4490-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62361A6EC8C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB43188F683
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0539319F121;
	Tue, 25 Mar 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E7aKHnoz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uiAigV4S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D481946AA;
	Tue, 25 Mar 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895320; cv=none; b=V1tb2Q6l/k/lnJQEVkQ9Kw5ilvYe5AaOsYxaCkqOV6/dS0nK7YFQPdoEgb+ZZMxgwBzXnJayK1UWwZf35s1hdLOH84ke6Npxct7sU6ckW412yGJhsdz/dCW5hFy0WMYE9HilNU1MN+Gzswm6Equrc38LD2re3cELPtS9sSdd0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895320; c=relaxed/simple;
	bh=DkR3DXkhNBPfjb2ifdzWPBSV7FbOhPbxGIwi/AkTVuQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JFw+FIqxnDhHa3PKIcKfubFTi3otGbOnzcw1EACNeTsEhI/gR+1FNpxQdLJO6KwLQ4/gQrA/BJBdVB4/o3mvyS5Br4AsaZzHJFlIYU4owTsTqIcoTObs18mqLxpdFUBXb6hM8ScEL8tH5MVHy5M52nVJXXxjuYTE4CqmBAHgvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E7aKHnoz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uiAigV4S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:35:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=en9AxHXlDqYVmzpY1Mcoo3sS9KFzHb1ZCkC7JJoVM7g=;
	b=E7aKHnoz6ava70y6nWafOsI9X5rzAirfjf/YobHhBCI1xLbOdXonqd2HugaLeYE/4SzG0f
	VXVDQFLs0Aj3wkWDpNQRmRviP4sbOVWEMkLlv6B/pQP8vZOHMEMLUj7JN9VACqHdriGG1z
	N8yQDLLTgcyZP9/opbvMe4lc27NuXdW8vmbxuXnBSf0EJrp1ByiUgHca7h3romuSD3Uezr
	TZKvcVZq1WgMNvK4IWRC9fy5dlHOdGs+i2/u1n9hu6nRosJdsQ5ZS14K+3E457/tSH9zjR
	j0RF/S+gvFYjHJ1236OLb2bu3b+pWpBdoxa/TZXVvqx5xVl9l8QZ3OFbwynImw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=en9AxHXlDqYVmzpY1Mcoo3sS9KFzHb1ZCkC7JJoVM7g=;
	b=uiAigV4SA56I/wJiA4d6E2KrZXyqnjzUF6GIeUe8jML0auNVAnHLsfZbOhdsUN+NUxgtKO
	5GWKxpDTwhOv5uAA==
From: "tip-bot2 for Maksim Davydov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] x86/split_lock: Simplify reenabling
Cc: Maksim Davydov <davydov-max@yandex-team.ru>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250325085807.171885-1-davydov-max@yandex-team.ru>
References: <20250325085807.171885-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289530945.14745.5047110425929375266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     0e1ff67d164be45e8ddfea5aaf5803224ede0805
Gitweb:        https://git.kernel.org/tip/0e1ff67d164be45e8ddfea5aaf5803224ede0805
Author:        Maksim Davydov <davydov-max@yandex-team.ru>
AuthorDate:    Tue, 25 Mar 2025 11:58:07 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:16:50 +01:00

x86/split_lock: Simplify reenabling

When split_lock_mitigate is disabled, each CPU needs its own delayed_work
structure. They are used to reenable split lock detection after its
disabling. But delayed_work structure must be correctly initialized after
its allocation.

Current implementation uses deferred initialization that makes the
split lock handler code unclear. The code can be simplified a bit
if the initialization is moved to the appropriate initcall.

sld_setup() is called before setup_per_cpu_areas(), thus it can't be used
for this purpose, so introduce an independent initcall for
the initialization.

[ mingo: Simplified the 'work' assignment line a bit more. ]

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250325085807.171885-1-davydov-max@yandex-team.ru
---
 arch/x86/kernel/cpu/bus_lock.c | 35 ++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 97222ef..237faf7 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -201,6 +201,26 @@ static void __split_lock_reenable(struct work_struct *work)
 static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
 
 /*
+ * Per-CPU delayed_work can't be statically initialized properly because
+ * the struct address is unknown. Thus per-CPU delayed_work structures
+ * have to be initialized during kernel initialization and after calling
+ * setup_per_cpu_areas().
+ */
+static int __init setup_split_lock_delayed_work(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct delayed_work *work = per_cpu_ptr(&sl_reenable, cpu);
+
+		INIT_DELAYED_WORK(work, __split_lock_reenable);
+	}
+
+	return 0;
+}
+pure_initcall(setup_split_lock_delayed_work);
+
+/*
  * If a CPU goes offline with pending delayed work to re-enable split lock
  * detection then the delayed work will be executed on some other CPU. That
  * handles releasing the buslock_sem, but because it executes on a
@@ -219,15 +239,16 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work = NULL;
+	struct delayed_work *work;
 	int cpu;
+	unsigned int saved_sld_mitigate = READ_ONCE(sysctl_sld_mitigate);
 
 	if (!current->reported_split_lock)
 		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, ip);
 	current->reported_split_lock = 1;
 
-	if (sysctl_sld_mitigate) {
+	if (saved_sld_mitigate) {
 		/*
 		 * misery factor #1:
 		 * sleep 10ms before trying to execute split lock.
@@ -240,18 +261,10 @@ static void split_lock_warn(unsigned long ip)
 		 */
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
-		work = &sl_reenable_unlock;
 	}
 
 	cpu = get_cpu();
-
-	if (!work) {
-		work = this_cpu_ptr(&sl_reenable);
-		/* Deferred initialization of per-CPU struct */
-		if (!work->work.func)
-			INIT_DELAYED_WORK(work, __split_lock_reenable);
-	}
-
+	work = saved_sld_mitigate ? &sl_reenable_unlock : per_cpu_ptr(&sl_reenable, cpu);
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */

