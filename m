Return-Path: <linux-tip-commits+bounces-8151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJYuFmMofWk0QgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1C7BEE6D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DF00301875D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 21:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5B352C37;
	Fri, 30 Jan 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L7wyUpYj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhL4QVkk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6F344D8C;
	Fri, 30 Jan 2026 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810012; cv=none; b=sH3eD8ejZY5vUq/Gr0x4A7Q/CXaDUwUvW5GFDJWdm3A65DouJtQ0SWLpJlnJshBFGF7yHLK+S0GWCQzDTKyqobB/e90uqvf4/LdEHRuk9GCM/L8LQTfqzHB1oYR3y+t5BluHYzuk740ZbhHwaPAQhGB8XAvxpLb+MtV3R4R4ovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810012; c=relaxed/simple;
	bh=vsBhdLTGndym5g0AB+K8S7jfjkAD0VhSM3gYgofLAgY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T3eMyhNBwl8a/DM76Y1ezcsVWTB/gCvACgy4bAPepNRPsuxDEhS2B/FyDGvtqf1OgtxUv1s6xc9kKMBX4aQhqlcBPHqXQlDsQSbnrvCMu0ugpytsn3GIKhf2aDf0NHPfJ96Z8vyzlkfwc3QDAh5/fqKBHQRXsddd4V01zSqjvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L7wyUpYj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nhL4QVkk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 21:53:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769810009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+tIXrcKO9D/xSwNs7agKWfGrCqWhkGeQYypHqker58=;
	b=L7wyUpYjSIAacXD3GRLKJPGssqme+FOchiaynjxdZHfJE8PRScGP7FqYgDoca76158Ut6a
	rGJlzUGFvgDUD+TRKLoLtxy84z+QCksZHHMohV2K+VfNvJhdrQTB8zrrYXXj5EAV9a4tov
	u8aVn0kQOSf5bHQ7VHpvUGZ2axAvZWOkaDDTg6os4Ds8YsIcRyNjkHm09WIWXm8bRM7U7y
	dDhf+o6qie7NP3U7flBJhNR1Jx7tmFCb2ArpS3KDZIusdu0qQ3B/vHx1vYlk0psywGEXBu
	aT8MQ5iT8nXf/E5FSQfxFRwp4PaKGj6fj9FjlGRVIrXGyli8f7pglxxtPwaAKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769810009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+tIXrcKO9D/xSwNs7agKWfGrCqWhkGeQYypHqker58=;
	b=nhL4QVkkT9fOs9198wqR4GEQUVpwRq9opHDDmHLCPCgTxhOHROGXJZJs73GzZH/Te5ghqq
	KOTg4BkMmX4pfcDQ==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Rework syscall_exit_to_user_mode_work() for
 architecture reuse
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128031934.3906955-10-ruanjinjie@huawei.com>
References: <20260128031934.3906955-10-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981000844.2495410.17565512971450394802.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8151-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,arm.com:email,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: BA1C7BEE6D
X-Rspamd-Action: no action

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     e1647100c22eb718e9833211722cbb78e339047c
Gitweb:        https://git.kernel.org/tip/e1647100c22eb718e9833211722cbb78e33=
9047c
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Wed, 28 Jan 2026 11:19:29 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 15:38:09 +01:00

entry: Rework syscall_exit_to_user_mode_work() for architecture reuse

syscall_exit_to_user_mode_work() invokes local_irq_disable_exit_to_user()
and syscall_exit_to_user_mode_prepare() after handling pending syscall exit
work.

The conversion of ARM64 to the generic entry code requires this to be split
up, so move the invocations of local_irq_disable_exit_to_user() and
syscall_exit_to_user_mode_prepare() into the only caller.

No functional change intended.

[ tglx: Massaged changelog and comments ]

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20260128031934.3906955-10-ruanjinjie@huawei.com
---
 include/linux/entry-common.h | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index e4a8287..5316004 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -122,17 +122,12 @@ static __always_inline long syscall_enter_from_user_mod=
e(struct pt_regs *regs, l
 void syscall_exit_work(struct pt_regs *regs, unsigned long work);
=20
 /**
- * syscall_exit_to_user_mode_work - Handle work before returning to user mode
+ * syscall_exit_to_user_mode_work - Handle one time work before returning to=
 user mode
  * @regs:	Pointer to currents pt_regs
  *
- * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
- * exit_to_user_mode() to perform the final transition to user mode.
+ * Step 1 of syscall_exit_to_user_mode() with the same calling convention.
  *
- * Calling convention is the same as for syscall_exit_to_user_mode() and it
- * returns with all work handled and interrupts disabled. The caller must
- * invoke exit_to_user_mode() before actually switching to user mode to
- * make the final state transitions. Interrupts must stay disabled between
- * return from this function and the invocation of exit_to_user_mode().
+ * The caller must invoke steps 2-3 of syscall_exit_to_user_mode() afterward=
s.
  */
 static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *r=
egs)
 {
@@ -155,15 +150,13 @@ static __always_inline void syscall_exit_to_user_mode_w=
ork(struct pt_regs *regs)
 	 */
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
-	local_irq_disable_exit_to_user();
-	syscall_exit_to_user_mode_prepare(regs);
 }
=20
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
  *
- * Invoked with interrupts enabled and fully valid regs. Returns with all
+ * Invoked with interrupts enabled and fully valid @regs. Returns with all
  * work handled, interrupts disabled such that the caller can immediately
  * switch to user mode. Called from architecture specific syscall and ret
  * from fork code.
@@ -176,6 +169,7 @@ static __always_inline void syscall_exit_to_user_mode_wor=
k(struct pt_regs *regs)
  *	- ptrace (single stepping)
  *
  *  2) Preparatory work
+ *	- Disable interrupts
  *	- Exit to user mode loop (common TIF handling). Invokes
  *	  arch_exit_to_user_mode_work() for architecture specific TIF work
  *	- Architecture specific one time work arch_exit_to_user_mode_prepare()
@@ -184,14 +178,17 @@ static __always_inline void syscall_exit_to_user_mode_w=
ork(struct pt_regs *regs)
  *  3) Final transition (lockdep, tracing, context tracking, RCU), i.e. the
  *     functionality in exit_to_user_mode().
  *
- * This is a combination of syscall_exit_to_user_mode_work() (1,2) and
- * exit_to_user_mode(). This function is preferred unless there is a
- * compelling architectural reason to use the separate functions.
+ * This is a combination of syscall_exit_to_user_mode_work() (1), disabling
+ * interrupts followed by syscall_exit_to_user_mode_prepare() (2) and
+ * exit_to_user_mode() (3). This function is preferred unless there is a
+ * compelling architectural reason to invoke the functions separately.
  */
 static __always_inline void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
 	syscall_exit_to_user_mode_work(regs);
+	local_irq_disable_exit_to_user();
+	syscall_exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	exit_to_user_mode();
 }

