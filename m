Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DC33E5A6B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhHJMwa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbhHJMw3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 08:52:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B21C061798;
        Tue, 10 Aug 2021 05:52:06 -0700 (PDT)
Date:   Tue, 10 Aug 2021 12:52:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628599921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8+ZNcEG78K1K+/wb9L2GpsrYYHI6RslCSun31vmXgY=;
        b=ID5hBlOfGmFK5EcLj7jWnGo06DYr26HyMvLAP/p7M9Cp4NeOz6Tdo1W6vRS0rVu6SF1zpl
        8WKFN9Bt19FO679EukvjaIs9mZQ7KEC24zHlk69ntH5ooC2wmkCZYVhtZxaK9Ywq2ow1KK
        zwVS1kkGKD62KYKbM5RuFKcUq+vl0MK6KLUKP8CRT1DlEVyHvmMno97nwGsNayOWAOOpkR
        Oxbcj8gRRW101RenNpSkxsargc5NXJG3xe6nOhRvvFfPZ6yY9IrA+DvRZ2EUAIfRaSFd0R
        OvJP9oeKIUpNjrD/0z9p9cDonNt0Rw0Gn8IqiI6jrpxXW9EA55rFEdEO2H3S8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628599921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8+ZNcEG78K1K+/wb9L2GpsrYYHI6RslCSun31vmXgY=;
        b=rIXrg/TGw94Onu0jIAd1HP01bX0+47vGjI0Y9/zs013Y63t8T8Id2dNbd3QieGvxpPWJg3
        3ZA0uq9YLn8RDVCw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mce/inject: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-10-bigeasy@linutronix.de>
References: <20210803141621.780504-10-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162859992037.395.6889909632575616379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8ae9e3f63865bc067c144817da9df025dbb667f2
Gitweb:        https://git.kernel.org/tip/8ae9e3f63865bc067c144817da9df025dbb667f2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:46:27 +02:00

x86/mce/inject: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-10-bigeasy@linutronix.de

---
 arch/x86/kernel/cpu/mce/inject.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 4e86d97..0bfc140 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -235,7 +235,7 @@ static void __maybe_unused raise_mce(struct mce *m)
 		unsigned long start;
 		int cpu;
 
-		get_online_cpus();
+		cpus_read_lock();
 		cpumask_copy(mce_inject_cpumask, cpu_online_mask);
 		cpumask_clear_cpu(get_cpu(), mce_inject_cpumask);
 		for_each_online_cpu(cpu) {
@@ -269,7 +269,7 @@ static void __maybe_unused raise_mce(struct mce *m)
 		}
 		raise_local();
 		put_cpu();
-		put_online_cpus();
+		cpus_read_unlock();
 	} else {
 		preempt_disable();
 		raise_local();
@@ -529,7 +529,7 @@ static void do_inject(void)
 		cpu = get_nbc_for_node(topology_die_id(cpu));
 	}
 
-	get_online_cpus();
+	cpus_read_lock();
 	if (!cpu_online(cpu))
 		goto err;
 
@@ -553,7 +553,7 @@ static void do_inject(void)
 	}
 
 err:
-	put_online_cpus();
+	cpus_read_unlock();
 
 }
 
