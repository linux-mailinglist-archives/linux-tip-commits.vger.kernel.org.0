Return-Path: <linux-tip-commits+bounces-2238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2CE9720B1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FDE1F24735
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE90189F3E;
	Mon,  9 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LpqMcpYm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I2BfCK84"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC894172BAE;
	Mon,  9 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902874; cv=none; b=ljx17LRYOjC5q9bnk4g8h7VxBVXWDKG5EPGPaunUaZiQ+j93o2fNEPFKYGI5/vwoPgENPThflwsFkGHAHxYRfJFS73nkXU9g4opuBvozEvLLuBqU1mPBhgnUqD8vAcQLRvyfsaSIbXoaUkad4sSj/TTNCUtsy+qXse8Y8SVRDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902874; c=relaxed/simple;
	bh=mhCT/npGMxBLAo6er2dIX0ga1jUyFRBBG5NX8Iqi0BE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HA1R6ojE0iz4kgTR/fMQVMisTaYdpkyQhAVwn3QN5GuPYHVzj4pMGHB30JIE5toyH4j8BpmyE2gigYYQe5R1597/27BSCCaRVliY9Z7Y+WCyHpbBXLLvScKLlGTMezoZ7/AsGis0RiozJG5zATpXkf810wUXYMpfHtXPRk9nwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LpqMcpYm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I2BfCK84; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4hvfk7pTni3z9ibXtuOXMLzncoc8hvPnhNL7HvdcGs=;
	b=LpqMcpYmaJfCxaB6A9Mdj7k+T7emTP59DvZH6b5X1n/O24YUs20lVO2zX8Zevw9WYGb7Od
	62EeBAYMXhTOqlUpFeUer7G427A/rqcZtJGQ6zFDj720c5jjQOWJ19MAA2E3bLZXnd231A
	aU/0VjbCTJz8jwiLsVwUoeqT0041VaH1gaXsf9N7sosq4Ja7WWuL9zZJKTBNhakdq7wRjb
	HP89BQsV+nP/v2zm5OMlAVZAkpuE0pwGdiLl7sDTmMfr37k8+yV1XiHfYY+dX4sZ8aGYkq
	QCujn1gsN6E6kMzgdzeSxdQ+0hlUio8/HD1HeeEe/D164+8+XDT+7QCmEkI5VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4hvfk7pTni3z9ibXtuOXMLzncoc8hvPnhNL7HvdcGs=;
	b=I2BfCK84MGmOaDUlvxjsJJwYnNUMk4YxooF2MswEbfKGMQ+YobjgTxjiYT9gEwyOBMeRWT
	pmPq4QqRvSGH/wCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Implement emergency sections
Cc: John Ogness <john.ogness@linutronix.de>,
 "Thomas Gleixner (Intel)" <tglx@linutronix.de>,
 Petr Mladek <pmladek@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-32-john.ogness@linutronix.de>
References: <20240820063001.36405-32-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286954.2215.6057290730811808400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     ecb5e1aa82c86642ec1eaafefd4e317dfba3a238
Gitweb:        https://git.kernel.org/tip/ecb5e1aa82c86642ec1eaafefd4e317dfba3a238
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:57 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 15:03:04 +02:00

printk: nbcon: Implement emergency sections

In emergency situations (something has gone wrong but the
system continues to operate), usually important information
(such as a backtrace) is generated via printk(). This
information should be pushed out to the consoles ASAP.

Add per-CPU emergency nesting tracking because an emergency
can arise while in an emergency situation.

Add functions to mark the beginning and end of emergency
sections where the urgent messages are generated.

Perform direct console flushing at the emergency priority if
the current CPU is in an emergency state and it is safe to do
so.

Note that the emergency state is not system-wide. While one CPU
is in an emergency state, another CPU may attempt to print
console messages at normal priority.

Also note that printk() already attempts to flush consoles in
the caller context for normal priority. However, follow-up
changes will introduce printing kthreads, in which case the
normal priority printk() calls will offload to the kthreads.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-32-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h  |  4 ++-
 kernel/printk/internal.h |  1 +-
 kernel/printk/nbcon.c    | 75 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 3706f94..9a13f91 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -553,10 +553,14 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern void nbcon_cpu_emergency_enter(void);
+extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 #else
+static inline void nbcon_cpu_emergency_enter(void) { }
+static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ba2e0f1..8e36d86 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -182,6 +182,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
+	case NBCON_PRIO_EMERGENCY:
 		if (have_nbcon_console && !have_boot_console)
 			ft->nbcon_atomic = true;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 18488d6..92ac5c5 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -972,6 +972,36 @@ update_con:
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/* Track the nbcon emergency nesting per CPU. */
+static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
+static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
+
+/**
+ * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
+ *
+ * Context:	For reading, any context. For writing, any context which could
+ *		not be migrated to another CPU.
+ * Return:	Either a pointer to the per CPU emergency nesting counter of
+ *		the current CPU or to the init data during early boot.
+ *
+ * The function is safe for reading per-CPU variables in any context because
+ * preemption is disabled if the current CPU is in the emergency state. See
+ * also nbcon_cpu_emergency_enter().
+ */
+static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
+{
+	/*
+	 * The value of __printk_percpu_data_ready gets set in normal
+	 * context and before SMP initialization. As a result it could
+	 * never change while inside an nbcon emergency section.
+	 */
+	if (!printk_percpu_data_ready())
+		return &early_nbcon_pcpu_emergency_nesting;
+
+	/* Open code this_cpu_ptr() without checking migration. */
+	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
+}
+
 /**
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
@@ -981,13 +1011,20 @@ update_con:
  *		context for printing.
  *
  * The function is safe for reading per-CPU data in any context because
- * preemption is disabled if the current CPU is in the panic state.
+ * preemption is disabled if the current CPU is in the emergency or panic
+ * state.
  */
 enum nbcon_prio nbcon_get_default_prio(void)
 {
+	unsigned int *cpu_emergency_nesting;
+
 	if (this_cpu_in_panic())
 		return NBCON_PRIO_PANIC;
 
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	if (*cpu_emergency_nesting)
+		return NBCON_PRIO_EMERGENCY;
+
 	return NBCON_PRIO_NORMAL;
 }
 
@@ -1247,6 +1284,42 @@ void nbcon_atomic_flush_unsafe(void)
 }
 
 /**
+ * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
+ *				messages for that CPU are flushed directly
+ *
+ * Context:	Any context. Disables preemption.
+ *
+ * When within an emergency section, printk() calls will attempt to flush any
+ * pending messages in the ringbuffer.
+ */
+void nbcon_cpu_emergency_enter(void)
+{
+	unsigned int *cpu_emergency_nesting;
+
+	preempt_disable();
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	(*cpu_emergency_nesting)++;
+}
+
+/**
+ * nbcon_cpu_emergency_exit - Exit an emergency section
+ *
+ * Context:	Within an emergency section. Enables preemption.
+ */
+void nbcon_cpu_emergency_exit(void)
+{
+	unsigned int *cpu_emergency_nesting;
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+
+	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
+		(*cpu_emergency_nesting)--;
+
+	preempt_enable();
+}
+
+/**
  * nbcon_alloc - Allocate and init the nbcon console specific data
  * @con:	Console to initialize
  *

