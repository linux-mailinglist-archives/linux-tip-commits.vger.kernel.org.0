Return-Path: <linux-tip-commits+bounces-8099-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD1uC7b6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8099-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:23:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C726531E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9F0B5E7D04
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B013DA7D4;
	Thu, 22 Jan 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN7QaVJi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8dkYPWr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA913D669B;
	Thu, 22 Jan 2026 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076963; cv=none; b=IGKrJ2JA0pU8SHYyh3FDJp7cwcgyB5gXGS/lXCUnnk/9/1HR834a0KcoAcxqm09CZsGgw1vhNtFIm/zgqhwOl5+6/7btqhJP2KLXQKLSfyTfXAs5OdC4x+IZQxU2Db876WRlrpnfaY239xOgliAJzOQ5gOyIalan1KE4L0Xq2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076963; c=relaxed/simple;
	bh=X/gzEYIBleqRc2/gcoaqeWRR9fwQ/cgCs+ECdOeq4ag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tXw7YO600NwwgnczbYgQIlNuGYTYGEEyf75oEN9TS5slUdQtd7bditV3zssyWLgRNmyOVzpjcutWIZ0px7EHUytZG0ERMYw5LaSFFUXNY2Mh9qyvAyy8jV2sCTGHVaE2UvsMfuM1i+sxhMDsPJz7UCo64bhKwSd/McxX5ReGOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN7QaVJi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8dkYPWr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5a1ubWCdCedTQxp07kxO9YMS/xM5498xBDNrcgQW7w=;
	b=LN7QaVJi5oT4Vf0bjahDOGQ0dBJlnZMyFh8t2wUvSGsJYUCTRx/WcGLr8FdyTRLHgN+ITD
	0uWHFwaLqw8gyHSHzEE9MFlS8N1VxOhF2MO7v36vQu/pvcjMk6cnlmAjRJWWYolHgF8gRP
	Cb1T6YOS4KCRT5osOrHVnGFlfhCO0zGGCmvWtRfxCaHZwrn3gA4MqgMeS0/ymPyn0/iuLu
	kFfZRpREmVks6Rpl4FOJvMsa3AIp+bz8xHDwKtaCkRCyVTF3phiSCy/W2ZJvfajjSccqUR
	DkCe4RPK89RALmnlEOVMgZc+Z8veLV+oytsPIkSpiccgdIKPolzKdapRuIENHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5a1ubWCdCedTQxp07kxO9YMS/xM5498xBDNrcgQW7w=;
	b=h8dkYPWrjlHXMyEL/GNMtieVLR8UTqBh0j1iMI2Dxn/76nL2oMJkWNsxSTtrb8RgkSzmsA
	wIan09vLq9WCeXBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] entry: Hook up rseq time slice extension
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155709.258157362@linutronix.de>
References: <20251215155709.258157362@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907695845.510.9038697427680039433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto,linutronix.de:email,linutronix.de:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8099-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: A5C726531E
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3c78aaec19b0621bf952756670c8b066a55202fe
Gitweb:        https://git.kernel.org/tip/3c78aaec19b0621bf952756670c8b066a55=
202fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:19 +01:00

entry: Hook up rseq time slice extension

Wire the grant decision function up in exit_to_user_mode_loop()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155709.258157362@linutronix.de
---
 kernel/entry/common.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5c792b3..9ef63e4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -17,6 +17,27 @@ void __weak arch_do_signal_or_restart(struct pt_regs *regs=
) { }
 #define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK)
 #endif
=20
+/* TIF bits, which prevent a time slice extension. */
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * Since rseq slice ext has a direct correlation to the worst case
+ * scheduling latency (schedule is delayed after all), only have it affect
+ * LAZY reschedules on PREEMPT_RT for now.
+ *
+ * However, since this delay is only applicable to userspace, a value
+ * for rseq_slice_extension_nsec that is strictly less than the worst case
+ * kernel space preempt_disable() region, should mean the scheduling latency
+ * is not affected, even for !LAZY.
+ *
+ * However, since this value depends on the hardware at hand, it cannot be
+ * pre-determined in any sensible way. Hence punt on this problem for now.
+ */
+# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED_LAZY)
+#else
+# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
+#endif
+#define TIF_SLICE_EXT_DENY	(EXIT_TO_USER_MODE_WORK & ~TIF_SLICE_EXT_SCHED)
+
 static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs=
 *regs,
 							      unsigned long ti_work)
 {
@@ -28,8 +49,10 @@ static __always_inline unsigned long __exit_to_user_mode_l=
oop(struct pt_regs *re
=20
 		local_irq_enable_exit_to_user(ti_work);
=20
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
-			schedule();
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
+			if (!rseq_grant_slice_extension(ti_work & TIF_SLICE_EXT_DENY))
+				schedule();
+		}
=20
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);

