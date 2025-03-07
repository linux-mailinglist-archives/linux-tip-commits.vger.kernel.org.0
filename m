Return-Path: <linux-tip-commits+bounces-4047-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48CA56784
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C967A6883
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FC221767D;
	Fri,  7 Mar 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SHGmB75G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgoGIvye"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA71E1DE5;
	Fri,  7 Mar 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349398; cv=none; b=oZrBQQXmkm9SjlWw64k0Gs7OKnbE/9OhquloQCFQuo3D4paJaydNqy/bmnYIphxY+DOnwFMe3trdnZ/Nj3i8lQcw81qWDDL/TiioH35cedYZk3pkXxOVguMGX7lLNpwTBVqmpIXkVIUDDhnTiwE1+/NqKVtHBiSs2bzoUtoG2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349398; c=relaxed/simple;
	bh=QGDqhnVTkMxUD/s/oQfklPC6spqn0PHAdbKwzCq7oQU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P39ny2VGR3astKgBA9+8aPNRRCz6SbKxlspheZYdXWkpLgoLrUeuzD9BYcFaDo+LoP5BDKA1k1AKt3Z4HoYD5mqv8LLzkwVB1oo2S5oLV9G2mxpMMQyXLGyVDrZpep3G3SRIajrYxmpY5uwgDlun7IZkM/DMzyWVqYHG6UB/H5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SHGmB75G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgoGIvye; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 12:09:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741349392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UigKyD5FBJEO172t/PeVjmazgOFcEa1nbtu2g0lmZug=;
	b=SHGmB75Gj7sRmq31H9EmNfMuA2LJiC/VgFl21502hQ3pNgtmPdgdjun9qvtsucGO6fRjIA
	Z9Oa+uqkuyEL1DDivZrTcKbZ2rsMarsMrbQ2a5B+CVbsR5LH8WrQB5JmNGBFd04W3NN2DT
	K1pw3Nrkz0fZirDZsg5ZQ4tpWcm9HVrP4FfbfTmJLroxRePWLuCEkufv+l1sQ88chpKlLn
	COdpbjsAqgLJ5XZGIEZ9ypSinp+iLzzDZfXdMMJ6LgWXc7jkVbDc2MQRPfmw5fmSRMhuk3
	XOT3nGVUwaB+0qUAtJBTYPPP+3wAVf9zmWWEQBXbyFnavjANHkAZTChLOLWZNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741349392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UigKyD5FBJEO172t/PeVjmazgOFcEa1nbtu2g0lmZug=;
	b=qgoGIvyem2reeyyt+6bYhYvR7UPJYwSHU2g24LFnMGvuymA/phATJ8TXssMgOEsWQ7BrCi
	e3e0R0GGb8xfZOAQ==
From: "tip-bot2 for Maksim Davydov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/split_lock: Fix the delayed detection logic
Cc: Maksim Davydov <davydov-max@yandex-team.ru>,
 Ingo Molnar <mingo@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115131704.132609-1-davydov-max@yandex-team.ru>
References: <20250115131704.132609-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174134938906.14745.11174609071483438403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c929d08df8bee855528b9d15b853c892c54e1eee
Gitweb:        https://git.kernel.org/tip/c929d08df8bee855528b9d15b853c892c54e1eee
Author:        Maksim Davydov <davydov-max@yandex-team.ru>
AuthorDate:    Wed, 15 Jan 2025 16:17:04 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Mar 2025 13:01:02 +01:00

x86/split_lock: Fix the delayed detection logic

If the warning mode with disabled mitigation mode is used, then on each
CPU where the split lock occurred detection will be disabled in order to
make progress and delayed work will be scheduled, which then will enable
detection back.

Now it turns out that all CPUs use one global delayed work structure.
This leads to the fact that if a split lock occurs on several CPUs
at the same time (within 2 jiffies), only one CPU will schedule delayed
work, but the rest will not.

The return value of schedule_delayed_work_on() would have shown this,
but it is not checked in the code.

A diagram that can help to understand the bug reproduction:

 - sld_update_msr() enables/disables SLD on both CPUs on the same core

 - schedule_delayed_work_on() internally checks WORK_STRUCT_PENDING_BIT.
   If a work has the 'pending' status, then schedule_delayed_work_on()
   will return an error code and, most importantly, the work will not
   be placed in the workqueue.

Let's say we have a multicore system on which split_lock_mitigate=0 and
a multithreaded application is running that calls splitlock in multiple
threads. Due to the fact that sld_update_msr() affects the entire core
(both CPUs), we will consider 2 CPUs from different cores. Let the 2
threads of this application schedule to CPU0 (core 0) and to CPU 2
(core 1), then:

|                                 ||                                   |
|             CPU 0 (core 0)      ||          CPU 2 (core 1)           |
|_________________________________||___________________________________|
|                                 ||                                   |
| 1) SPLIT LOCK occured           ||                                   |
|                                 ||                                   |
| 2) split_lock_warn()            ||                                   |
|                                 ||                                   |
| 3) sysctl_sld_mitigate == 0     ||                                   |
|    (work = &sl_reenable)        ||                                   |
|                                 ||                                   |
| 4) schedule_delayed_work_on()   ||                                   |
|    (reenable will be called     ||                                   |
|     after 2 jiffies on CPU 0)   ||                                   |
|                                 ||                                   |
| 5) disable SLD for core 0       ||                                   |
|                                 ||                                   |
|    -------------------------    ||                                   |
|                                 ||                                   |
|                                 || 6) SPLIT LOCK occured             |
|                                 ||                                   |
|                                 || 7) split_lock_warn()              |
|                                 ||                                   |
|                                 || 8) sysctl_sld_mitigate == 0       |
|                                 ||    (work = &sl_reenable,          |
|                                 ||     the same address as in 3) )   |
|                                 ||                                   |
|            2 jiffies            || 9) schedule_delayed_work_on()     |
|                                 ||    fials because the work is in   |
|                                 ||    the pending state since 4).    |
|                                 ||    The work wasn't placed to the  |
|                                 ||    workqueue. reenable won't be   |
|                                 ||    called on CPU 2                |
|                                 ||                                   |
|                                 || 10) disable SLD for core 0        |
|                                 ||                                   |
|                                 ||     From now on SLD will          |
|                                 ||     never be reenabled on core 1  |
|                                 ||                                   |
|    -------------------------    ||                                   |
|                                 ||                                   |
|    11) enable SLD for core 0 by ||                                   |
|        __split_lock_reenable    ||                                   |
|                                 ||                                   |

If the application threads can be scheduled to all processor cores,
then over time there will be only one core left, on which SLD will be
enabled and split lock will be able to be detected; and on all other
cores SLD will be disabled all the time.

Most likely, this bug has not been noticed for so long because
sysctl_sld_mitigate default value is 1, and in this case a semaphore
is used that does not allow 2 different cores to have SLD disabled at
the same time, that is, strictly only one work is placed in the
workqueue.

In order to fix the warning mode with disabled mitigation mode,
delayed work has to be per-CPU. Implement it.

Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250115131704.132609-1-davydov-max@yandex-team.ru
---
 arch/x86/kernel/cpu/bus_lock.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 6cba85c..97222ef 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -192,7 +192,13 @@ static void __split_lock_reenable(struct work_struct *work)
 {
 	sld_update_msr(true);
 }
-static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+/*
+ * In order for each CPU to schedule its delayed work independently of the
+ * others, delayed work struct must be per-CPU. This is not required when
+ * sysctl_sld_mitigate is enabled because of the semaphore that limits
+ * the number of simultaneously scheduled delayed works to 1.
+ */
+static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
 
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
@@ -213,7 +219,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work;
+	struct delayed_work *work = NULL;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -235,11 +241,17 @@ static void split_lock_warn(unsigned long ip)
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
 		work = &sl_reenable_unlock;
-	} else {
-		work = &sl_reenable;
 	}
 
 	cpu = get_cpu();
+
+	if (!work) {
+		work = this_cpu_ptr(&sl_reenable);
+		/* Deferred initialization of per-CPU struct */
+		if (!work->work.func)
+			INIT_DELAYED_WORK(work, __split_lock_reenable);
+	}
+
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */

