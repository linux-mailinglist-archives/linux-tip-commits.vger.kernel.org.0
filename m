Return-Path: <linux-tip-commits+bounces-7173-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C9C2C790
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 15:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D985C4EDEFA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44D310647;
	Mon,  3 Nov 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2o3ncUZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHgKlZKO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E52459C6;
	Mon,  3 Nov 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181229; cv=none; b=pMqXck9Gi3sA76O6OMtVfWSt2gNDeJ7OAXnC/NJ/tQkp/N/QYIvqv6q3VKYYUrtomuQ8vA3OEXfPaSoPjDkqPZieb89NLGw4iq+lkdILAH/ENAPKU19mM9I43ZnoCl/qodV9QA4ll+/nvBf53W46B2pbNxd7kvAghbzImZIbHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181229; c=relaxed/simple;
	bh=8GbCpPnCgtTcskvKwvfzgwcFVu5wH1bYAuLrAQKM5mM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EioFg7An1AQpfPe9tmAqPRFTOwOyW2izPVlLxcw8fygISMqk7I4geahNgGxyZlVJFE2YyPWtPTHuQOr094+N3Pj8RHikQYszjsWlgaCo6n+VDKkK5h/k5pxbkYL/usnuG2igImldKxE9NY7heS7J2tEuvJMzbntbdJQJ9OL+xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2o3ncUZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHgKlZKO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZERJU7yEjersZn6rwoEtg1STD0J9OzHqzWldw8TBbM=;
	b=e2o3ncUZYvfw4MXJAYFUKtdkuVVIBWDkmWOFPGMGO3/tNxYFAjBeo6F3K28Ulxtq4vdxvq
	i1//thf7nl1fuuUEBWRVGxMGGiewqRkiul1vW+jS2Qnvb2pr7IjN7b5VCBPR+mo1+pta60
	LF08CwLg/ybD9o7hNCf1ozaPI5qNRAW6dYLMaAVlTTD1vM+rh1hf/+g2P+qLR2Ii2g7Zdy
	wWuZP4T0+apS1dpoEiW0PCZH0v4SJzhBSGq9M1ie/2TTpSYf4bWiKAIV+VVEUtg0/KoOeW
	oRHa7FUOxh/kdZvocrjrwg7ze7ImXm/8PyBl3fTGg4Kk3hWIuCNNu9Z/jIDANQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZERJU7yEjersZn6rwoEtg1STD0J9OzHqzWldw8TBbM=;
	b=nHgKlZKOkAbuDsHU1FazvoHDpZbXDLGyF0VLjreQw8wZpiYISOGfOVhwhejcyA/tEgwAL/
	IYZoqTQsA94IdRDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] x86/ptrace: Always inline trivial accessors
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031105435.GU4068168@noisy.programming.kicks-ass.net>
References: <20251031105435.GU4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218122354.2601451.1498424816220367556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     139772de6a9857e60dc49ae1f7f75452847daede
Gitweb:        https://git.kernel.org/tip/139772de6a9857e60dc49ae1f7f75452847=
daede
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 31 Oct 2025 12:04:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:23 +01:00

x86/ptrace: Always inline trivial accessors

A KASAN build bloats these single load/store helpers such that
it fails to inline them:

  vmlinux.o: error: objtool: irqentry_exit+0x5e8: call to instruction_pointer=
_set() with UACCESS enabled

Make sure the compiler isn't allowed to do stupid.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

