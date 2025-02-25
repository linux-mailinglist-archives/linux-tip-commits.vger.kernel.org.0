Return-Path: <linux-tip-commits+bounces-3615-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD7A44279
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7771895511
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C764126C18;
	Tue, 25 Feb 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfPooOmj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hzm3ieUv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A226B0AE;
	Tue, 25 Feb 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492970; cv=none; b=I1ogCmM9iSx5RNdgHIis/0EXGnUWCDzEvbDAi0QMgGlyjqzU+rq1xLExh3coUYRDIr3WBtZ+7qroenx+6Jz/nrKEcFKRrcXeeQEWiSpkUjFt0felbr/hKupK4MNzMHaIZeNdvBPb8B42WU83vVIbNqu7zCoXNpRYEJIPgtIg39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492970; c=relaxed/simple;
	bh=pJTQO/mo5uFe7xws3SD64jmtaFQL0b8pDr0d8wcGxlc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l1RTmVMLSpJBNraD7fjRTob1Pd+AzxxtmrNRBWYa0zWOnNbtfBk5PqD/lOX/Te5Ty1ihLtE9xX7KDXgqAgIaVMBb84FeKqiWtmK5ruegf7riFl28UIYOghi0fnUQdhRjWHv/fCQyEWjbzuB+iWcmRyCrdBC7INvCoBPAlCw1oXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfPooOmj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hzm3ieUv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 14:16:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740492965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHz0K5N3f9VXRwNDchqt5UubzO7Pzd+rRPq9C/EAnz4=;
	b=TfPooOmjsTgX7jD4pBgfM0uItH1+aV7GfXMHDfLk7coaqJD9qVtEi5nQIkQ6BmEI7LPnGl
	NfIfM0pr6H4SSdSEuudVKMemuyiSox06+l0qRnecC3LtYRwOm+F7oUZSgsPY/baQGDICY/
	X0J0wyJ5HS+SY7Y9Oz5bEyW3548GNSZJyO5hH4vH8Z4UwyKRyuY2x4O7deC8dc44ZkLtyo
	IMkcUe6ubGF0HBFEi6b/nYFYh3VZrkpj8lJis++g2un+UZSA/kHeC3NKhxB4nm83MRn+yG
	Z3y9PQ7C/2mYW0tZbMoXyCp2EUj9R4X4WkpDVtMqe6+47//zbOOFlZ6PF1XoWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740492965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHz0K5N3f9VXRwNDchqt5UubzO7Pzd+rRPq9C/EAnz4=;
	b=Hzm3ieUv6N9b2cC6NTsh4Vd7HkajA7Pmebrz5Ru8dMEwWk0P4gpFY5nTnnJmRsmCsKQ2WG
	/55ImqZQVka43MAg==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/nmi: Add an emergency handler in nmi_desc & use
 it in nmi_shootdown_cpus()
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250206191844.131700-1-longman@redhat.com>
References: <20250206191844.131700-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174049296478.10177.6489308146620693313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fe37c699ae3eed6e02ee55fbf5cb9ceb7fcfd76c
Gitweb:        https://git.kernel.org/tip/fe37c699ae3eed6e02ee55fbf5cb9ceb7fcfd76c
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 06 Feb 2025 14:18:44 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 14:38:43 +01:00

x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()

Depending on the type of panics, it was found that the
__register_nmi_handler() function can be called in NMI context from
nmi_shootdown_cpus() leading to a lockdep splat:

  WARNING: inconsistent lock state
  inconsistent {INITIAL USE} -> {IN-NMI} usage.

   lock(&nmi_desc[0].lock);
   <Interrupt>
     lock(&nmi_desc[0].lock);

  Call Trace:
    _raw_spin_lock_irqsave
    __register_nmi_handler
    nmi_shootdown_cpus
    kdump_nmi_shootdown_cpus
    native_machine_crash_shutdown
    __crash_kexec

In this particular case, the following panic message was printed before:

  Kernel panic - not syncing: Fatal hardware error!

This message seemed to be given out from __ghes_panic() running in
NMI context.

The __register_nmi_handler() function which takes the nmi_desc lock
with irq disabled shouldn't be called from NMI context as this can
lead to deadlock.

The nmi_shootdown_cpus() function can only be invoked once. After the
first invocation, all other CPUs should be stuck in the newly added
crash_nmi_callback() and cannot respond to a second NMI.

Fix it by adding a new emergency NMI handler to the nmi_desc
structure and provide a new set_emergency_nmi_handler() helper to set
crash_nmi_callback() in any context. The new emergency handler will
preempt other handlers in the linked list. That will eliminate the need
to take any lock and serve the panic in NMI use case.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250206191844.131700-1-longman@redhat.com
---
 arch/x86/include/asm/nmi.h |  2 ++-
 arch/x86/kernel/nmi.c      | 42 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/reboot.c   | 10 ++-------
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 41a0ebb..f677382 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -56,6 +56,8 @@ int __register_nmi_handler(unsigned int, struct nmiaction *);
 
 void unregister_nmi_handler(unsigned int, const char *);
 
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler);
+
 void stop_nmi(void);
 void restart_nmi(void);
 void local_touch_nmi(void);
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index ed163c8..9a95d00 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -40,8 +40,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
 
+/*
+ * An emergency handler can be set in any context including NMI
+ */
 struct nmi_desc {
 	raw_spinlock_t lock;
+	nmi_handler_t emerg_handler;
 	struct list_head head;
 };
 
@@ -132,9 +136,22 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
+	nmi_handler_t ehandler;
 	struct nmiaction *a;
 	int handled=0;
 
+	/*
+	 * Call the emergency handler, if set
+	 *
+	 * In the case of crash_nmi_callback() emergency handler, it will
+	 * return in the case of the crashing CPU to enable it to complete
+	 * other necessary crashing actions ASAP. Other handlers in the
+	 * linked list won't need to be run.
+	 */
+	ehandler = desc->emerg_handler;
+	if (ehandler)
+		return ehandler(type, regs);
+
 	rcu_read_lock();
 
 	/*
@@ -224,6 +241,31 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 }
 EXPORT_SYMBOL_GPL(unregister_nmi_handler);
 
+/**
+ * set_emergency_nmi_handler - Set emergency handler
+ * @type:    NMI type
+ * @handler: the emergency handler to be stored
+ *
+ * Set an emergency NMI handler which, if set, will preempt all the other
+ * handlers in the linked list. If a NULL handler is passed in, it will clear
+ * it. It is expected that concurrent calls to this function will not happen
+ * or the system is screwed beyond repair.
+ */
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler)
+{
+	struct nmi_desc *desc = nmi_to_desc(type);
+
+	if (WARN_ON_ONCE(desc->emerg_handler == handler))
+		return;
+	desc->emerg_handler = handler;
+
+	/*
+	 * Ensure the emergency handler is visible to other CPUs before
+	 * function return
+	 */
+	smp_wmb();
+}
+
 static void
 pci_serr_error(unsigned char reason, struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index dc1dd3f..9aaac1f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -926,15 +926,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	shootdown_callback = callback;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	/* Would it be better to replace the trap vector here? */
-	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
-				 NMI_FLAG_FIRST, "crash"))
-		return;		/* Return what? */
+
 	/*
-	 * Ensure the new callback function is set before sending
-	 * out the NMI
+	 * Set emergency handler to preempt other handlers.
 	 */
-	wmb();
+	set_emergency_nmi_handler(NMI_LOCAL, crash_nmi_callback);
 
 	apic_send_IPI_allbutself(NMI_VECTOR);
 

