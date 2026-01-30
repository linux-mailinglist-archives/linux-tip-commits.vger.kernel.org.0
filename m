Return-Path: <linux-tip-commits+bounces-8150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eERyMF0ofWk0QgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA1BEE57
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26CD300A63F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97E346A0A;
	Fri, 30 Jan 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NN5wOX92";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzzY7iUd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307B344056;
	Fri, 30 Jan 2026 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810011; cv=none; b=gFOXYiRHiPEu52A/XNxiJHfJV388FzTHIfUbSWHHcN/ZxNNbiotFzRopHtW3qS5YL3Z2NkgQm8AprqKFBmksKPaE+YCzGmTNIX6BoMrrlfto3S6qsFiIJoBF33V4fbE1IXkjlsCuqhd5g8bgJTyfRI82DwPDxGrP5LXkEyE+dOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810011; c=relaxed/simple;
	bh=GWuckb+tTH1Dv1SSzVMDY2ZDz3wUq/NymLoA1plEhJs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TITw+Icphe0mPd7KwMxK7iQBFJGbnmSL6xsKeAw0rPPqeQ/5jwDtflARr1EUaiwbDJmhKGr4oCjASpyDof6SdPD5H/TIgx5iBbb4jpIyk2NTWTXXZRQekZDyvVxJqAkZQAxJloz2CLFq1VsQ0JhfskC7XtI4OMxEV7ISwL8CHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NN5wOX92; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzzY7iUd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 21:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769810008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRSLvIbVNw0//gBQXo46EVAXrV3zBfBX1JyDhN10WqU=;
	b=NN5wOX92Z6AT4adGr3kbaz/KJeUui7kYKKn9wL3veAk1h5aqX5csXTESvbdr4I7F+0Ax4d
	1r/+f/Ldzyz43OlRNJ8lAHusssdFJEc/MKGaMfhbBuZqywkrk9je94dX5L3jQH7EwE136s
	8CqyWmzGRgYdxSUp0e4xd9EfJC25zQ77tLxRU4L4bCCHb2gA5hZTeIGF6O+oiZzYULKkJp
	WyI644ivQJu94vPzctBx0Raaqswy3vYM+WpOz3QDtM+HGYkwufiVls9RRHbgNXdagYLjgG
	Kch373Wkfi/DzmJxUdlb8TpqCbThIvKOBhcpG/7uMEpSwNiVTgewCUGve6L2Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769810008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRSLvIbVNw0//gBQXo46EVAXrV3zBfBX1JyDhN10WqU=;
	b=kzzY7iUd7X9wfuMtgKUMYwZ6AoMugTKE3LiQm3wtMKEzTm2rP8aNktg5gk34pCWTs1yAPg
	kaOzcai1N1QTlLBA==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Add arch_ptrace_report_syscall_entry/exit()
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128031934.3906955-11-ruanjinjie@huawei.com>
References: <20260128031934.3906955-11-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981000740.2495410.9749775703469431126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8150-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 20EA1BEE57
X-Rspamd-Action: no action

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     578b21fd3ab2d9901ce40ed802e428a41a40610d
Gitweb:        https://git.kernel.org/tip/578b21fd3ab2d9901ce40ed802e428a41a4=
0610d
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Wed, 28 Jan 2026 11:19:30 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 15:38:09 +01:00

entry: Add arch_ptrace_report_syscall_entry/exit()

ARM64 requires a architecture specific ptrace wrapper as it needs to save
and restore scratch registers.

Provide arch_ptrace_report_syscall_entry/exit() wrappers which fall back to
ptrace_report_syscall_entry/exit() if the architecture does not provide
them.

No functional change intended.

[ tglx: Massaged changelog and comments ]

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Link: https://patch.msgid.link/20260128031934.3906955-11-ruanjinjie@huawei.com
---
 include/linux/entry-common.h  | 36 ++++++++++++++++++++++++++++++++++-
 kernel/entry/syscall-common.c |  4 ++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 5316004..bea207e 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -45,6 +45,24 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
=20
+/**
+ * arch_ptrace_report_syscall_entry - Architecture specific ptrace_report_sy=
scall_entry() wrapper
+ *
+ * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
+ *
+ * This allows architecture specific ptrace_report_syscall_entry()
+ * implementations. If not defined by the architecture this falls back to
+ * to ptrace_report_syscall_entry().
+ */
+static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *=
regs);
+
+#ifndef arch_ptrace_report_syscall_entry
+static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *=
regs)
+{
+	return ptrace_report_syscall_entry(regs);
+}
+#endif
+
 long syscall_trace_enter(struct pt_regs *regs, unsigned long work);
=20
 /**
@@ -113,6 +131,24 @@ static __always_inline long syscall_enter_from_user_mode=
(struct pt_regs *regs, l
 }
=20
 /**
+ * arch_ptrace_report_syscall_exit - Architecture specific ptrace_report_sys=
call_exit()
+ *
+ * This allows architecture specific ptrace_report_syscall_exit()
+ * implementations. If not defined by the architecture this falls back to
+ * to ptrace_report_syscall_exit().
+ */
+static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *=
regs,
+							    int step);
+
+#ifndef arch_ptrace_report_syscall_exit
+static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *=
regs,
+							    int step)
+{
+	ptrace_report_syscall_exit(regs, step);
+}
+#endif
+
+/**
  * syscall_exit_work - Handle work before returning to user mode
  * @regs:	Pointer to current pt_regs
  * @work:	Current thread syscall work
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index e6237b5..bb5f61f 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -33,7 +33,7 @@ long syscall_trace_enter(struct pt_regs *regs, unsigned lon=
g work)
=20
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret =3D ptrace_report_syscall_entry(regs);
+		ret =3D arch_ptrace_report_syscall_entry(regs);
 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
 	}
@@ -99,5 +99,5 @@ void syscall_exit_work(struct pt_regs *regs, unsigned long =
work)
=20
 	step =3D report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		ptrace_report_syscall_exit(regs, step);
+		arch_ptrace_report_syscall_exit(regs, step);
 }

