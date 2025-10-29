Return-Path: <linux-tip-commits+bounces-7069-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33535C19B72
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FD31B24617
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC543346B9;
	Wed, 29 Oct 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTX1/qnb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vO5ejgOD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CC334689;
	Wed, 29 Oct 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733431; cv=none; b=WRnXC5L4CTHebAZK3J8HpPN/UAucbAMgisQhH6IjdyfltsAozHVdeiCEjrxvw0OdoUJfliO+Z4yDVcga7B//QcUD2Qwm2YAx3Y3WrgoM0uNpfS30K6dgXqaIz9eX0QCzHVroH263AUl0/XdQUvmBwCRWaCSiFos3JlyORDMedFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733431; c=relaxed/simple;
	bh=fBYJ1ufulFQGEuSbxbOvt+c5u7b9KCzIt0G9YZymy3g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AkIgw7GumWNwimzKd1GkG9s9ymJPuV4qWSvJefxvkLOFMUUAgBQE/Kbtuo4Vk3KRl0FxWCQ+YC/ZckVWopgqvemg2f3WrazMkZjTBAnLmDmZCXn/u1L9YxZz2+w4jKOVXL00fcXdOsAE6xtxIm6Pj5S9LOMLqPM/x/fPjtNvPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTX1/qnb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vO5ejgOD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtDyRVdhK0AM5Y8anFsK7mtv2lgWjwTSWTs4xzmEzUQ=;
	b=jTX1/qnbDhuKbaBJGYmLmUTF2yV13ZrtR6tDykafcsuN8/W+V2iMb0pgqrlIa9NJCzrrWO
	KzXUBMfcIDjcMhwOP6cGHjkj/lVMMAB1kUXxvOK2YdiYKtHKcQoA4FZFWIQzxOuUEToArW
	QjYYcXqsHj3YOaZ03qmwgGliIU1M6tdw0YxVKcj1CWsM3/9hOHEVfUlt1oe1XskvTI+Hap
	pYPhDNhNaFl1QgXySyUAzgGurqpOeCUJhnU2ijZyfnWE0SIpauEy4CYjOO2ozIz7W+k+fQ
	utbrWA15ZsxFodB1dquM23WXwKyoCKHw5Ug3fHYvRMo6iIpuK12TAJGoRkcTwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtDyRVdhK0AM5Y8anFsK7mtv2lgWjwTSWTs4xzmEzUQ=;
	b=vO5ejgODNXK4sz0GNFBUMHmqNKh1hMAYh7w2UO5eregvpTQBAoOGkI+kXQsJSgXR78Rmmn
	gSeYbYYBkL5EMwDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Record interrupt from user space
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <176173342660.2601451.8578438992125984247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     3cdfc5701dcd290c100ece742bcd13c2e6415cda
Gitweb:        https://git.kernel.org/tip/3cdfc5701dcd290c100ece742bcd13c2e64=
15cda
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:15 +01:00

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
index 88067a6..eb0dd13 100644
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

