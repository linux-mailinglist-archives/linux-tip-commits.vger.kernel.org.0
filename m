Return-Path: <linux-tip-commits+bounces-7241-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BEFC2FD22
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5272189DE93
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295303128AC;
	Tue,  4 Nov 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPzjLIwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/2KwMfHn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098A315D56;
	Tue,  4 Nov 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244252; cv=none; b=J3iFeKtdOPCVQ1KttCDSnfhQbe+1b+qOFtzvqjaoDmikZp+8vLIcoLs+vKFgcTg0XqteyEXjFvWysSf2b8gp/NsdISG6/pbLhQPl1GYJ89Rn64hQT58+IUul2sRPdXMdSNKEonaSNgF1kw2w1e+Lj7O8U/fInuB5wsYTxHbszpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244252; c=relaxed/simple;
	bh=VV5cxy1a+WUxysvFvNIqFXcOwbyS3bsDlkfl0O0P4Yc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BzinJgoM9EvPtpdshPn5VNkLvjgUCrRp23BqZNXvaNj9SdVnspk93uZzPZIr++Jfgr6/i1BScgG9EBy+wF3lPBeRh8uZ2u8RfZGXdOfg+EyxRqfAsbOzjT1FxfMW5TypG2hbCL20awXjFXjLRX0EKwF/Z4V8juGVQ6/kSTm8omM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPzjLIwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/2KwMfHn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCScyruuMkEa4Q1p1f/RYIXybj9V04+Hv7AY4/B1nac=;
	b=JPzjLIwlSGODZAp40Hf5ETgXYgZBW6jTC4AldoLWY/PH1wFKoLqdgs67hq+g3/O5Pa4iE6
	bfYrPTr67CMmlDJSHfc5X/d4y5MFQ5iN5uZjlcndLS6bH03D6oGvhsn9vsZODegvVMQZnY
	7z2b6bOOHBL6ESH4vmSsh0J3FM4RHcc7lYAstwbz3R+BWPL3R/MKJSqPyuZKZIB1TVmRW2
	NZMknu+hsfsY/ol93VPY+tBJyn5AhIRmoMjSvs+nbLPYl5rjQsshzIrCFWxGkeVeVeLJy0
	rbrTofKL8pLRoPIothu6DElBl88SvmAmy2/Io8BYQey8Eo1TjwfnNEhpFgO2NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCScyruuMkEa4Q1p1f/RYIXybj9V04+Hv7AY4/B1nac=;
	b=/2KwMfHnDuJ3qJpNa/fby1W4Y80/2zSovgZ8QqyZq0uiS8n01fcrsDQr/A+7F4irqMQMzB
	6CAF0duQv+hx7RDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/rseq] entry: Inline irqentry_enter/exit_from/to_user_mode()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.715309918@linutronix.de>
References: <20251027084306.715309918@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224424787.2601451.11085566326943855153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     7702a9c2856794b6bf961b408eba3bacb753bd5b
Gitweb:        https://git.kernel.org/tip/7702a9c2856794b6bf961b408eba3bacb75=
3bd5b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:31:47 +01:00

entry: Inline irqentry_enter/exit_from/to_user_mode()

There is no point to have this as a function which just inlines
enter_from_user_mode(). The function call overhead is larger than the
function itself.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.715309918@linutronix.de
---
 include/linux/irq-entry-common.h | 13 +++++++++++--
 kernel/entry/common.c            | 13 -------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 9b1f386..83c9d84 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -278,7 +278,10 @@ static __always_inline void exit_to_user_mode(void)
  *
  * The function establishes state (lockdep, RCU (context tracking), tracing)
  */
-void irqentry_enter_from_user_mode(struct pt_regs *regs);
+static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *re=
gs)
+{
+	enter_from_user_mode(regs);
+}
=20
 /**
  * irqentry_exit_to_user_mode - Interrupt exit work
@@ -293,7 +296,13 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
  * Interrupt exit is not invoking #1 which is the syscall specific one time
  * work.
  */
-void irqentry_exit_to_user_mode(struct pt_regs *regs);
+static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
=20
 #ifndef irqentry_state
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f62e1d1..70a16db 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -62,19 +62,6 @@ __always_inline unsigned long exit_to_user_mode_loop(struc=
t pt_regs *regs,
 	return ti_work;
 }
=20
-noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-}
-
-noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret =3D {

