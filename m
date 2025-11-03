Return-Path: <linux-tip-commits+bounces-7176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD60C2C7AA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 15:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07BF04EE68D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D30313E38;
	Mon,  3 Nov 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROAZkcNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkZAqqj6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0D313E07;
	Mon,  3 Nov 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181232; cv=none; b=ldajDmJsqQHxL657RSzmNDXL3vWE9HtvovwIk9aBxn5T4SSTd4gzz5SsNE32pIkkqVS73WDgxpxdfuCEJuIMfIGBxS2LpAORWFfGf/wkpOaFQ4X2uFEC0adODRqz86jVJ/jBYQSpJcT9x3ne5Lq/H4/Y6/DeQUEhJdEGBonwMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181232; c=relaxed/simple;
	bh=b++M+Ln3XhdPe2vCIab9wTKK3fGVQ4xa5tT3ttq/tsQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rbkYmgIWN2UwvOhRUUFetVVnuHRHEPqlVCg4BssZx0ny1wiU5FvA+53/v7OU6k8cuVAe67M5FD6JIUIG5p3Yw7mmi5Acwn3i4wqHguAqni8ELNhDiHbBTsxJmnSZmpE38a1rVci5QM/frjGHoCwkmS25YJ1vIrwMmgw5ADzb0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROAZkcNk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkZAqqj6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+0zqLVKas2d5kPU+7pWjzfoGQXD2sJZ8+lGEq5KWmG8=;
	b=ROAZkcNkqI+woyicBq+ydzmWN4nw3J5vQuuHtePTVRqdUA0chEj6ekl4srXyVWK9sbultG
	q5wcCa1+VC4C1rXUPdEPtIIuIxkCUh84CbsMGTJBl6sX57NsL/627S/Hz8E+ZyoZs8lzFk
	qRfePhGZ6jpaYa6zPjRKbt3u3C4jXMDaBGMSNc42gAamDIA7RaR5ZIWwRPFGcodqVY9RaN
	EVoaF1m5DJ7XIPOIMdzBJ6E71chLbwHx6e6nQ7ShdY+q60BoC2yAb61/1C5rvszmHSTZXx
	S5KTW+X5YfNscMB83gET8Z3cjl7ouDCdGgF+YvYOO+K2iFHEKhp133fC04LyCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+0zqLVKas2d5kPU+7pWjzfoGQXD2sJZ8+lGEq5KWmG8=;
	b=PkZAqqj6vjDkdEpf6rrbjc3mXT5KBHY9KlQKang2/okCM8MvtmRsO8l1OAJZkJuvoiyxOe
	m3PY+wFB47DqqaBA==
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
Message-ID: <176218122779.2601451.3655516719435434999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     a2fc232771d36c41d1fc4efe005578bcf3e060c7
Gitweb:        https://git.kernel.org/tip/a2fc232771d36c41d1fc4efe005578bcf3e=
060c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:22 +01:00

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
 include/linux/irq-entry-common.h |  6 ++---
 include/linux/rseq_entry.h       | 36 +++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 5ea6172..bc5d178 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -240,7 +240,7 @@ static __always_inline void __exit_to_user_mode_validate(=
void)
 static __always_inline void exit_to_user_mode_prepare_legacy(struct pt_regs =
*regs)
 {
 	__exit_to_user_mode_prepare(regs);
-	rseq_exit_to_user_mode();
+	rseq_exit_to_user_mode_legacy();
 	__exit_to_user_mode_validate();
 }
=20
@@ -254,7 +254,7 @@ static __always_inline void exit_to_user_mode_prepare_leg=
acy(struct pt_regs *reg
 static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs=
 *regs)
 {
 	__exit_to_user_mode_prepare(regs);
-	rseq_exit_to_user_mode();
+	rseq_syscall_exit_to_user_mode();
 	__exit_to_user_mode_validate();
 }
=20
@@ -268,7 +268,7 @@ static __always_inline void syscall_exit_to_user_mode_pre=
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
index 3f13be7..958a63e 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -521,7 +521,37 @@ static __always_inline bool rseq_exit_to_user_mode_resta=
rt(struct pt_regs *regs)
 static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs) { re=
turn false; }
 #endif /* !CONFIG_GENERIC_ENTRY */
=20
-static __always_inline void rseq_exit_to_user_mode(void)
+static __always_inline void rseq_syscall_exit_to_user_mode(void)
+{
+	struct rseq_event *ev =3D &current->rseq.event;
+
+	rseq_stat_inc(rseq_stats.exit);
+
+	/* Needed to remove the store for the !lockdep case */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		WARN_ON_ONCE(ev->sched_switch);
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
+
+	/*
+	 * Ensure that event (especially user_irq) is cleared when the
+	 * interrupt did not result in a schedule and therefore the
+	 * rseq processing could not clear it.
+	 */
+	ev->events =3D 0;
+}
+
+/* Required to keep ARM64 working */
+static __always_inline void rseq_exit_to_user_mode_legacy(void)
 {
 	struct rseq_event *ev =3D &current->rseq.event;
=20
@@ -551,7 +581,9 @@ static inline bool rseq_exit_to_user_mode_restart(struct =
pt_regs *regs)
 {
 	return false;
 }
-static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_syscall_exit_to_user_mode(void) { }
+static inline void rseq_irqentry_exit_to_user_mode(void) { }
+static inline void rseq_exit_to_user_mode_legacy(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
=20

