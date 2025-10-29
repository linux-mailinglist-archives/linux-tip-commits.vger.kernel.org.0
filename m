Return-Path: <linux-tip-commits+bounces-7054-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2643C19B0C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91DA560AB0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA8326D6B;
	Wed, 29 Oct 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QR5L88C6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkY56Iq7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909221A8F84;
	Wed, 29 Oct 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733412; cv=none; b=P0afiwxa7ANz15oUWkNbtzoQbj2moJ/yQLKLcarS57PLr+HID8hmQ5HpdoE1tXxVvRajPywd68MweO/rMHgL0C36nOhRS38BODew73lulLxtzxH3iUYzOgwMNFVxiFKQBnhgfUr8v5WY45lJBrQNPXL4D20ChhNDwm8vmXl6uhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733412; c=relaxed/simple;
	bh=iI++xISKpAYjjOnF/aoVEdapA/inxzwIT3tjLjtxn+o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z8F2uclBOzlNrqFTniY962DMG5ExlHkQbV+Brj/aQdVCh2T6E7EXHfBWR/GEeuT+XZgTOd1DSsyfo1D6zVt20xmZkrDSopBM5Nn/b/YDHpFEeoujb97nSJBoBeO40W8C77Nim4icjYhSjgz+cP1DgbgyfkWiJ1gJc1L07YZoSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QR5L88C6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkY56Iq7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/sCDI+aNlei/pZYW6Y5CWcn/IWVNDDBQoGfR9AL7B8=;
	b=QR5L88C65URMUKRPEnazkD/2gBfdq1Ptqig34fw7w0Mj4ojEH3xKm73cmVjkpi1lTLVpOR
	Jne2ZDOUAMZWYKz/lSGw3XLyZZCec6o0ytaymDqSLfyk6/8MQR8i0wxUzXoNbYqzdTvQay
	SMr+M/t/l7gxu57QqO3VgK5/veRc1lCMRgikkV6FuneLc/QBDY1hF+hBlxnaBC14Oqw5fg
	UQ/RNJzF9tGhZn45gRP9ZdUSPs0GOkLjDuDZoaHejrgxcbi0+4DaEp9UdbNmivlTz9EzKu
	9LIefCRYPQF4TTVSqR+Xg5B7E59grrTDR958yue/PaWWE5nQVWehe2AusYrS8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/sCDI+aNlei/pZYW6Y5CWcn/IWVNDDBQoGfR9AL7B8=;
	b=qkY56Iq76hyUMKxs0iShZBLxlUF9vAg2noqP3Q1reCyEJVGMWGiEmZ+08n8KEPtgZZY6I7
	sWJN5NWbGnqEeVDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Split up rseq_exit_to_user_mode()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.842785700@linutronix.de>
References: <20251027084307.842785700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173340745.2601451.11686523916129906509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     1b3dd1c538a82055a1de699cefdd4ac3b60f9e49
Gitweb:        https://git.kernel.org/tip/1b3dd1c538a82055a1de699cefdd4ac3b60=
f9e49
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:20 +01:00

rseq: Split up rseq_exit_to_user_mode()

Separate the interrupt and syscall exit handling. Syscall exit does not
require to clear the user_irq bit as it can't be set. On interrupt exit it
can be set when the interrupt did not result in a scheduling event and
therefore the return path did not invoke the TIF work handling, which would
have cleared it.

The debug check for the event state is also not really required even when
debug mode is enabled via the static key. Debug mode is largely aiding user
space by enabling a larger amount of validation checks, which cause a
segfault when a malformed critical section is detected. In production mode
the critical section handling takes the content mostly as is and lets user
space keep the pieces when it screwed up.

On kernel changes in that area the state check is useful, but that can be
done when lockdep is enabled, which is anyway a required test scenario for
fundamental changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.842785700@linutronix.de
---
 include/linux/irq-entry-common.h |  4 ++--
 include/linux/rseq_entry.h       | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 9621d40..3ee0f16 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -247,7 +247,7 @@ static __always_inline void __exit_to_user_mode_validate(=
void)
 static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs=
 *regs)
 {
 	__exit_to_user_mode_prepare(regs);
-	rseq_exit_to_user_mode();
+	rseq_syscall_exit_to_user_mode();
 	__exit_to_user_mode_validate();
 }
=20
@@ -261,7 +261,7 @@ static __always_inline void syscall_exit_to_user_mode_pre=
pare(struct pt_regs *re
 static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_reg=
s *regs)
 {
 	__exit_to_user_mode_prepare(regs);
-	rseq_exit_to_user_mode();
+	rseq_irqentry_exit_to_user_mode();
 	__exit_to_user_mode_validate();
 }
=20
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 9bf3d58..98d70a8 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -519,19 +519,31 @@ static __always_inline bool rseq_exit_to_user_mode_rest=
art(struct pt_regs *regs)
=20
 #endif /* CONFIG_GENERIC_ENTRY */
=20
-static __always_inline void rseq_exit_to_user_mode(void)
+static __always_inline void rseq_syscall_exit_to_user_mode(void)
 {
 	struct rseq_event *ev =3D &current->rseq.event;
=20
 	rseq_stat_inc(rseq_stats.exit);
=20
-	if (static_branch_unlikely(&rseq_debug_enabled))
+	/* Needed to remove the store for the !lockdep case */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
 		WARN_ON_ONCE(ev->sched_switch);
+		ev->events =3D 0;
+	}
+}
+
+static __always_inline void rseq_irqentry_exit_to_user_mode(void)
+{
+	struct rseq_event *ev =3D &current->rseq.event;
+
+	rseq_stat_inc(rseq_stats.exit);
+
+	lockdep_assert_once(!ev->sched_switch);
=20
 	/*
 	 * Ensure that event (especially user_irq) is cleared when the
 	 * interrupt did not result in a schedule and therefore the
-	 * rseq processing did not clear it.
+	 * rseq processing could not clear it.
 	 */
 	ev->events =3D 0;
 }
@@ -549,7 +561,8 @@ static inline bool rseq_exit_to_user_mode_restart(struct =
pt_regs *regs)
 {
 	return false;
 }
-static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_syscall_exit_to_user_mode(void) { }
+static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
=20

