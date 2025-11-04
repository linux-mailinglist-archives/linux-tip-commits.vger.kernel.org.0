Return-Path: <linux-tip-commits+bounces-7220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64878C2FCA0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A95A3AA98A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD832C15A3;
	Tue,  4 Nov 2025 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="llhOy7b5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9tqL75i1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610E28643A;
	Tue,  4 Nov 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244205; cv=none; b=Ua0BigdSYCKDrJZWNRA/MsnkFmVO6+Y8FW0yj6Yxk4Yg/0NK5+jftY4ya+oIC3cxHe4p11yT9nAVulfiY+riObGgeEE/aTtNUsbJ88qH9wNS6U4V+8WP6aE73RLM8MqUQdTCXBBz/5ERs051FalgPGiMd2QMvlzY12evsFFyXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244205; c=relaxed/simple;
	bh=XpEr3Omt9FDcgzQRQU4egLR8v7VRc9Nt53v4J2CFe+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D5UQoIq5pxgk7BwiaqfYlRxJJ5Yf+B7wOmD3a1urKLRw+1Q7hGbvAeByDEFKH2GHBFsiwj9Ls6AGbpWX+hQabB7RL/+e8YT+QhuH3ESVE4bX9mOKcZ6WEiArT/viAf+TPTRe2jpPjkXw2FBSVDut9egxOEyvUrpK+MrWe53aio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=llhOy7b5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9tqL75i1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:16:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lsi8kh+pSHXJsbaU21cWYgU6adMA6yJQYt75UO4ES4=;
	b=llhOy7b5aEVrnpIPLYLxqVTmldD1fp97dB2uCsWPWVWx+p+NolzdrnHvnoBsHe2VCbOc3s
	il0nTN5UZAOj04UXwCNoOG8VWaGX3YpqXm7JcM/6Q3fY7/Xsbq5hwLoGzcchwWBU3bdB5P
	3A0W/BblNH3Q1V8JW0f3i0ys12fn6EmX0kfmkud1SxjaL/k/inCS/plTD8+TkeZfqUU37Z
	cD0GvDhWK59/Z33vdZA299y74cOtN3QZ/CjT0heZW8/kM7w69Ha8b6hMWupe+vHfptrN4N
	mA9ZFhq+dEoe1r6mjSIl2SAyyRXVSXVWs7GoSNwgPe0MKGCF2Xbq574zaPpDMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lsi8kh+pSHXJsbaU21cWYgU6adMA6yJQYt75UO4ES4=;
	b=9tqL75i1zsY2sRdtn8RCqotj6+5+UYt2RK8GTUqR2yXnlLsSN3TfzWh45P5EGxkNLOVLg+
	I0LkkgyCdfA8hKBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] x86/ptrace: Always inline trivial accessors
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031105435.GU4068168@noisy.programming.kicks-ass.net>
References: <20251031105435.GU4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224419674.2601451.6509102952432717963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     1fe4002cf7f23d70c79bda429ca2a9423ebcfdfa
Gitweb:        https://git.kernel.org/tip/1fe4002cf7f23d70c79bda429ca2a9423eb=
cfdfa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 31 Oct 2025 12:04:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:36:20 +01:00

x86/ptrace: Always inline trivial accessors

A KASAN build bloats these single load/store helpers such that
it fails to inline them:

  vmlinux.o: error: objtool: irqentry_exit+0x5e8: call to instruction_pointer=
_set() with UACCESS enabled

Make sure the compiler isn't allowed to do stupid.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251031105435.GU4068168@noisy.programming.kic=
ks-ass.net
---
 arch/x86/include/asm/ptrace.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f7546..b5dec85 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -187,12 +187,12 @@ convert_ip_to_linear(struct task_struct *child, struct =
pt_regs *regs);
 extern void send_sigtrap(struct pt_regs *regs, int error_code, int si_code);
=20
=20
-static inline unsigned long regs_return_value(struct pt_regs *regs)
+static __always_inline unsigned long regs_return_value(struct pt_regs *regs)
 {
 	return regs->ax;
 }
=20
-static inline void regs_set_return_value(struct pt_regs *regs, unsigned long=
 rc)
+static __always_inline void regs_set_return_value(struct pt_regs *regs, unsi=
gned long rc)
 {
 	regs->ax =3D rc;
 }
@@ -277,34 +277,34 @@ static __always_inline bool ip_within_syscall_gap(struc=
t pt_regs *regs)
 }
 #endif
=20
-static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long kernel_stack_pointer(struct pt_regs *re=
gs)
 {
 	return regs->sp;
 }
=20
-static inline unsigned long instruction_pointer(struct pt_regs *regs)
+static __always_inline unsigned long instruction_pointer(struct pt_regs *reg=
s)
 {
 	return regs->ip;
 }
=20
-static inline void instruction_pointer_set(struct pt_regs *regs,
-		unsigned long val)
+static __always_inline
+void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
 {
 	regs->ip =3D val;
 }
=20
-static inline unsigned long frame_pointer(struct pt_regs *regs)
+static __always_inline unsigned long frame_pointer(struct pt_regs *regs)
 {
 	return regs->bp;
 }
=20
-static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
 	return regs->sp;
 }
=20
-static inline void user_stack_pointer_set(struct pt_regs *regs,
-		unsigned long val)
+static __always_inline
+void user_stack_pointer_set(struct pt_regs *regs, unsigned long val)
 {
 	regs->sp =3D val;
 }

