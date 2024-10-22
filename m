Return-Path: <linux-tip-commits+bounces-2531-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F89AB91E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 23:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669ED1C22FE7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC331CEE92;
	Tue, 22 Oct 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1iDAK/tS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQ3YACrd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9011CDFBF;
	Tue, 22 Oct 2024 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634038; cv=none; b=qgQEmTC4VTLlueNBeb8OiSf3F6aEKGtXXyokjPRN7TyvgV3XrR/5a2CMSOScx6hqhzeKS5wq7x2CLeljxyEqVPfZ2pHWg2XbZwm1mNJX27bLhLxKnwJpHkzegYDKpWT1+1RI4xqSdeOeoInG0Fh9ParBuoEgqKztKdUIrrhPbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634038; c=relaxed/simple;
	bh=l34BD1j/1/oJ3uF7bii0oTpAYVriytCSRT+oMkf2eFU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aDszS6VXBmUZK/veU1+W7WDKj0Tknp2Fqxc3bw7AZaneE4fCgHGTW4Qpna/cmo0+zMEs4fhlH5si5fts6gIXgI9bJIFPUV87/cWUE7fzq7wciEX6c5SiL8iu32S01Iu9An9gORO0Oqg6ybnhRDfgIWwOE2HNQQbzOt5fqX+r7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1iDAK/tS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZQ3YACrd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 21:53:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729634034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mIb/PG4p052Kc0B5i5E5AIGLOvLh58J5dgVNcFy7FI=;
	b=1iDAK/tSpBXpRYZwVolgUMcKrREO1nImEQTH6/UYlq5QCTqX4Hh6Tbk4JFoSsZuYlbM6AC
	Lsv2rahph1p80iM3WHrHrixZebimo0mED9L1C3hnlOTcL6k8OqsPp5VYgq9OJPIfASeo6u
	3nRUWAVWHExGx74SWJOZIgSmuQRaKrx7F7RW+kYW8iUMzDUTkmElRBtnYmBy17kZcep6zz
	lEuVzG9YZR2HJzTLLvYh6aOgCs9vSGCh59Vzx5soluu6ZsrfptEg+0gzKlyWEkI8Ww3DB2
	+SPDPbSqDjfM3MSsLui2sSBowJ5Cay/O3ce68HSwciwIn6RYUPxfDkgrdZ15hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729634034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mIb/PG4p052Kc0B5i5E5AIGLOvLh58J5dgVNcFy7FI=;
	b=ZQ3YACrdLqTd29FqNsPo4MwX/ie16beWHmzRxymnaKBTj0eTYIvtIiNYYdC1qbWQ9miM8S
	oBDbERLDxS3BXnBA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add lockdep_cleanup_dead_cpu()
Cc: David Woodhouse <dwmw@amazon.co.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <f7bd2b3b999051bb3ef4be34526a9262008285f5.camel@infradead.org>
References: <f7bd2b3b999051bb3ef4be34526a9262008285f5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172963403399.1442.3576494229925339302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0784181b44af831a3fa52e1e5ff77c388d699dba
Gitweb:        https://git.kernel.org/tip/0784181b44af831a3fa52e1e5ff77c388d699dba
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 26 Sep 2024 16:17:37 +01:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 17 Oct 2024 20:07:22 -07:00

lockdep: Add lockdep_cleanup_dead_cpu()

Add a function to check that an offline CPU has left the tracing
infrastructure in a sane state.

Commit 9bb69ba4c177 ("ACPI: processor_idle: use raw_safe_halt() in
acpi_idle_play_dead()") fixed an issue where the acpi_idle_play_dead()
function called safe_halt() instead of raw_safe_halt(), which had the
side-effect of setting the hardirqs_enabled flag for the offline CPU.

On x86 this triggered warnings from lockdep_assert_irqs_disabled() when
the CPU was brought back online again later. These warnings were too
early for the exception to be handled correctly, leading to a
triple-fault.

Add lockdep_cleanup_dead_cpu() to check for this kind of failure mode,
print the events leading up to it, and correct it so that the CPU can
come online again correctly. Re-introducing the original bug now merely
results in this warning instead:

[   61.556652] smpboot: CPU 1 is now offline
[   61.556769] CPU 1 left hardirqs enabled!
[   61.556915] irq event stamp: 128149
[   61.556965] hardirqs last  enabled at (128149): [<ffffffff81720a36>] acpi_idle_play_dead+0x46/0x70
[   61.557055] hardirqs last disabled at (128148): [<ffffffff81124d50>] do_idle+0x90/0xe0
[   61.557117] softirqs last  enabled at (128078): [<ffffffff81cec74c>] __do_softirq+0x31c/0x423
[   61.557199] softirqs last disabled at (128065): [<ffffffff810baae1>] __irq_exit_rcu+0x91/0x100

[boqun: Capitalize the title and reword the message a bit]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/f7bd2b3b999051bb3ef4be34526a9262008285f5.camel@infradead.org
---
 include/linux/irqflags.h |  6 ++++++
 kernel/cpu.c             |  1 +
 kernel/locking/lockdep.c | 24 ++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3f003d5..57b074e 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -18,6 +18,8 @@
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
+struct task_struct;
+
 /* Currently lockdep_softirqs_on/off is used only by lockdep */
 #ifdef CONFIG_PROVE_LOCKING
   extern void lockdep_softirqs_on(unsigned long ip);
@@ -25,12 +27,16 @@
   extern void lockdep_hardirqs_on_prepare(void);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
+  extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
+				       struct task_struct *idle);
 #else
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on_prepare(void) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
+  static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
+					      struct task_struct *idle) {}
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52..c4aaf73 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1338,6 +1338,7 @@ static int takedown_cpu(unsigned int cpu)
 
 	cpuhp_bp_sync_dead(cpu);
 
+	lockdep_cleanup_dead_cpu(cpu, idle_thread_get(cpu));
 	tick_cleanup_dead_cpu(cpu);
 
 	/*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 536bd47..6fd4af2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4586,6 +4586,30 @@ void lockdep_softirqs_off(unsigned long ip)
 		debug_atomic_inc(redundant_softirqs_off);
 }
 
+/**
+ * lockdep_cleanup_dead_cpu - Ensure CPU lockdep state is cleanly stopped
+ *
+ * @cpu: index of offlined CPU
+ * @idle: task pointer for offlined CPU's idle thread
+ *
+ * Invoked after the CPU is dead. Ensures that the tracing infrastructure
+ * is left in a suitable state for the CPU to be subsequently brought
+ * online again.
+ */
+void lockdep_cleanup_dead_cpu(unsigned int cpu, struct task_struct *idle)
+{
+	if (unlikely(!debug_locks))
+		return;
+
+	if (unlikely(per_cpu(hardirqs_enabled, cpu))) {
+		pr_warn("CPU %u left hardirqs enabled!", cpu);
+		if (idle)
+			print_irqtrace_events(idle);
+		/* Clean it up for when the CPU comes online again. */
+		per_cpu(hardirqs_enabled, cpu) = 0;
+	}
+}
+
 static int
 mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {

