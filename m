Return-Path: <linux-tip-commits+bounces-7238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96842C2FD46
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B5EA4F7146
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103BE317706;
	Tue,  4 Nov 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iV5PwMvU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OG7w8AdE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A723164A0;
	Tue,  4 Nov 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244248; cv=none; b=iqRUrJPwjBRv/CxJFaaohIF5I2CNsj6xKncSxY5WNDq8P0/mt95dwh8hI5El1kyT3MXq3zkccgD3T3xbBbqUC4cCCriSFTOfBYUu7xgfJJ+WTHscqPUW1C+BkWrYePyBtF7pv6s3x8yJyKGn9DKwBhniIh9Y59VF7ai9bifYPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244248; c=relaxed/simple;
	bh=Zfl2s+Bae3HW3+vHIwCyEkMYI1cJT0k1Enbe0i0vZG8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mmDWNWEpLbR2k26D7ybQ6ba/SwFPtULzf1wEUgHIwrACqHcCktQaE8Ydj7m3bObGGYqngn+RZXE/Uzx1HjGKX+6foPBbwx6wJ9YwWCiJObKN6CYMG7PdYJLoDooFEzGRb8Y4a36zAoZUJ01sKvbMU/pFEd1fuyG09R5g2WyVyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iV5PwMvU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OG7w8AdE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKQ+8pGkwc2m+hPRS08pBA0M/B0htn7cH82WakRiS4g=;
	b=iV5PwMvUFCy2MhQsVnLa8oY7hOplaOpSZYyerdhhrOsm/i71Cm5HTgUHXi+FH23iYTIQyh
	4MDHSi7J09n7N/OApQS/y64R1Zzfd0dDaN3lKVLUIL1trZqvmPjwfNv51crSuK2zB8NvmG
	hllE4Ig51AWlkTkAzRdGLb5KncimblysgV3PYNjkzNloj0DFGDmt/RF1LY5+cAjfKCX4Ck
	TkfhmTriZ8DErflwWxU0eoT0sIXtsmclMM/R3FvnQrsOiYMH/gQ9FdXWnbZBC54s+nspJ9
	LRA0vCmXYohGzwlAeKQynN23Vviks1xbUGxv8tEZabT00vowrQ144Cr9vUv3Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKQ+8pGkwc2m+hPRS08pBA0M/B0htn7cH82WakRiS4g=;
	b=OG7w8AdE5pD/OSWQQ2T9BOP4m0dyTKE9tNtfgWiU6AJFHsgkUZeMJhBc+nFocA3RrBU3e8
	0KJVhLBI9QNZNsAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Record interrupt from user space
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.905067101@linutronix.de>
References: <20251027084306.905067101@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224424329.2601451.16740352113792369925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2fc0e4b4126caadfa5772ba69276b350609584dd
Gitweb:        https://git.kernel.org/tip/2fc0e4b4126caadfa5772ba69276b350609=
584dd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:48 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:32:23 +01:00

rseq: Record interrupt from user space

For RSEQ the only relevant reason to inspect and eventually fixup (abort)
user space critical sections is when user space was interrupted and the
task was scheduled out.

If the user to kernel entry was from a syscall no fixup is required. If
user space invokes a syscall from a critical section it can keep the
pieces as documented.

This is only supported on architectures which utilize the generic entry
code. If your architecture does not use it, bad luck.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.905067101@linutronix.de
---
 include/linux/irq-entry-common.h |  3 ++-
 include/linux/rseq.h             | 16 +++++++++++-----
 include/linux/rseq_entry.h       | 18 ++++++++++++++++++
 include/linux/rseq_types.h       |  2 ++
 4 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/rseq_entry.h

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 83c9d84..cb31fb8 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -4,7 +4,7 @@
=20
 #include <linux/context_tracking.h>
 #include <linux/kmsan.h>
-#include <linux/rseq.h>
+#include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
 #include <linux/tick.h>
@@ -281,6 +281,7 @@ static __always_inline void exit_to_user_mode(void)
 static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *re=
gs)
 {
 	enter_from_user_mode(regs);
+	rseq_note_user_irq_entry();
 }
=20
 /**
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index d315a92..a200836 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -31,11 +31,17 @@ static inline void rseq_sched_switch_event(struct task_st=
ruct *t)
=20
 static __always_inline void rseq_exit_to_user_mode(void)
 {
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
-				 current->rseq.event.events))
-			current->rseq.event.events =3D 0;
-	}
+	struct rseq_event *ev =3D &current->rseq.event;
+
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+		WARN_ON_ONCE(ev->sched_switch);
+
+	/*
+	 * Ensure that event (especially user_irq) is cleared when the
+	 * interrupt did not result in a schedule and therefore the
+	 * rseq processing did not clear it.
+	 */
+	ev->events =3D 0;
 }
=20
 /*
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
new file mode 100644
index 0000000..ce30e87
--- /dev/null
+++ b/include/linux/rseq_entry.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RSEQ_ENTRY_H
+#define _LINUX_RSEQ_ENTRY_H
+
+#ifdef CONFIG_RSEQ
+#include <linux/rseq.h>
+
+static __always_inline void rseq_note_user_irq_entry(void)
+{
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
+		current->rseq.event.user_irq =3D true;
+}
+
+#else /* CONFIG_RSEQ */
+static inline void rseq_note_user_irq_entry(void) { }
+#endif /* !CONFIG_RSEQ */
+
+#endif /* _LINUX_RSEQ_ENTRY_H */
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 40901b0..80f6c39 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -12,6 +12,7 @@ struct rseq;
  * @all:		Compound to initialize and clear the data efficiently
  * @events:		Compound to access events with a single load/store
  * @sched_switch:	True if the task was scheduled out
+ * @user_irq:		True on interrupt entry from user mode
  * @has_rseq:		True if the task has a rseq pointer installed
  */
 struct rseq_event {
@@ -22,6 +23,7 @@ struct rseq_event {
 				u16		events;
 				struct {
 					u8	sched_switch;
+					u8	user_irq;
 				};
 			};
=20

