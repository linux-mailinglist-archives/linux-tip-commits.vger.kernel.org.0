Return-Path: <linux-tip-commits+bounces-7737-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71023CC7B1B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B79EE30B11A7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBCC3446A7;
	Wed, 17 Dec 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQi+rkSL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9BwzisQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFB3446A5;
	Wed, 17 Dec 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975088; cv=none; b=ldEp5cGvW4J6p7l3O2NpP/k4M+2waUoS6ehzE6KZ0ZYc1cBIJaUoMzNNYjhN6RozUC2fjJxyARTs73q4pSaVdZMPi/E4Vg7mZ6W4SusSlSdT7mvqZ8HUbZD03uQywpoPVJU0l6ubCiMO64KobVDW9uow9QWGHKX+D5HYVxLnBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975088; c=relaxed/simple;
	bh=4Oh31wycVedHn7ty7CXsvPJgHE1cxlZQIwnPO/aXhNA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DVp72PiQWqPZSUciWEW2wJIxxlz+sYqywjHmTYRyMk4Rpo0BuYvCaCal48vu/o3L+p5lrXZCJcFWG3m9GTAW+v5jEV2Z0c2Xf1gTF/Psi0C8TCc+Wq3fb8FBE0aFIVfFEMg09XZ6uPU/sMWoGOF65rNqHUyCpH106LErEZO0Gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQi+rkSL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9BwzisQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2v+0uihnqxFkAEGdLMj1u3YKqiFxd4Gb/Zhb74o8gs=;
	b=WQi+rkSL4yqiz2zDvLHDluKtrXpnSoGDeAbm/+hx0I3pZzyFF4kpEpuYRy1iEGzaWiANnr
	RQjMdDZuudDiTw/2dmUideITCVVjumiaCZhmCoh1W0Jo0QIympPCynfvcql9PXSZH1whzy
	GzyEctVG6e6on0EqHDCLKI1R+/sOFwDg1S1VQAAHzlonHgPXqZjOTa1QaNk185v+np+8Hs
	RkK4kqYPPldYT1dkebBlKIxLOUwcmg6Pv2895SadXnO3Q1qeEREYPUjsF/OmGbLF0W71eM
	E/NNsTWbptCf6H6DMOmUe2ZyjG7OoIeA5BHLvoqLylJjJWCfTmgg1xD6zB3ciA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2v+0uihnqxFkAEGdLMj1u3YKqiFxd4Gb/Zhb74o8gs=;
	b=D9BwzisQsTDvS9Vtm8EhcyhU9KQH+N8zrvUFSxFjYWf+iuzHg6nrga+ktKJLXwLfN1mHsM
	d+52xKFCpjDhbiDg==
From: "tip-bot2 for Jens Remus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/unwind_user: Guard unwind_user_word_size() by
 UNWIND_USER
Cc: Jens Remus <jremus@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251208160352.1363040-4-jremus@linux.ibm.com>
References: <20251208160352.1363040-4-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508332.510.16184348850466898187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     aa6047ef7204ea1faa346b9123439abed0546f7e
Gitweb:        https://git.kernel.org/tip/aa6047ef7204ea1faa346b9123439abed05=
46f7e
Author:        Jens Remus <jremus@linux.ibm.com>
AuthorDate:    Mon, 08 Dec 2025 17:03:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:08 +01:00

x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER

The unwind user framework in general requires an architecture-specific
implementation of unwind_user_word_size() to be present for any unwind
method, whether that is fp or a future other method, such as potentially
sframe.

Guard unwind_user_word_size() by the availability of the UNWIND_USER
framework instead of the specific HAVE_UNWIND_USER_FP method.

This facilitates to selectively disable HAVE_UNWIND_USER_FP on x86
(e.g. for test purposes) once a new unwind method is added to unwind
user.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251208160352.1363040-4-jremus@linux.ibm.com
---
 arch/x86/include/asm/unwind_user.h | 30 ++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind=
_user.h
index 971ffe9..7f1229b 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,23 +2,11 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
=20
-#ifdef CONFIG_HAVE_UNWIND_USER_FP
+#ifdef CONFIG_UNWIND_USER
=20
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
=20
-#define ARCH_INIT_USER_FP_FRAME(ws)			\
-	.cfa_off	=3D  2*(ws),			\
-	.ra_off		=3D -1*(ws),			\
-	.fp_off		=3D -2*(ws),			\
-	.use_fp		=3D true,
-
-#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
-	.cfa_off	=3D  1*(ws),			\
-	.ra_off		=3D -1*(ws),			\
-	.fp_off		=3D 0,				\
-	.use_fp		=3D false,
-
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
 	/* We can't unwind VM86 stacks */
@@ -31,6 +19,22 @@ static inline int unwind_user_word_size(struct pt_regs *re=
gs)
 	return sizeof(long);
 }
=20
+#endif /* CONFIG_UNWIND_USER */
+
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
+#define ARCH_INIT_USER_FP_FRAME(ws)			\
+	.cfa_off	=3D  2*(ws),			\
+	.ra_off		=3D -1*(ws),			\
+	.fp_off		=3D -2*(ws),			\
+	.use_fp		=3D true,
+
+#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
+	.cfa_off	=3D  1*(ws),			\
+	.ra_off		=3D -1*(ws),			\
+	.fp_off		=3D 0,				\
+	.use_fp		=3D false,
+
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);

