Return-Path: <linux-tip-commits+bounces-7972-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616BD1BD6D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BA430392AF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29F223DFB;
	Wed, 14 Jan 2026 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yF+TBofo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RE9EeuE4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AC1D5ABA;
	Wed, 14 Jan 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351498; cv=none; b=ThYpG06j0Dz37J0tdg9W3S5OOZ5HkFpM7wkRbunNarsefH5e8n4XK8akZLB/RIo3iS5bxbiaWxdwQSjV7ZAjp9R7KRFfAwwGzmS8+OySn/UKVmKLbuyPcDMNbDZB5X7uIxPyAIzsTvz8sEd3Qo9ttEI2Xm1Y9t3iWOvNartr8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351498; c=relaxed/simple;
	bh=PILRBTweOdya9L4OvF96GAfK/dME+l4AKOfUZU+vozA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zpuhh/VBAwCnEJiUN0TxNGcpmu2gPVfLKlkUiGyOBl0q3ELG+kc2P3ga0VjPAAHcJBfgK6HTH+d3Tai9krvZu+3xyti2D5G3UyzI5Kxcq4H8dc3d0DskohD7zMFLUWtsQpIdgQ3/UKxg9JLhswKTqJ6nQ/zedm/3Qf1R+0oteOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yF+TBofo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RE9EeuE4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768351495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y24+GgFtJdw4D6Y/TzqPS+TGn+kOyiYv1k/zdygBJWY=;
	b=yF+TBofoyO6R+UPc2tKG06P1W//dfsx66LkPYuBBmXcLqFCxEur5uJY5SK4J22djoYHzxz
	dTt3UVIcwpB7FR0pFoL0HsIOnTdyXal1DVwk9tVEQ/4DHeHNpR7t5k2O2Psaxx/dhLtfue
	/M0VP2qUABnFz64GOhNCaQsZUV+SsDeNUmvCBGQHBX/+RWjIgVYj7/Si0a8jVSSbu+22HD
	ezQXLU+eCH+hDfRL508zdlnkFS65RaJPoQPILpdW4IQD4MHZz2WubmiKIs6k6cLWI0O1ZL
	Son6vQsiaGwEa23yLB1aoDtcIbHzQS2404Zj/i0UsJk8+IqlgqJtSy5GaZ4H9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768351495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y24+GgFtJdw4D6Y/TzqPS+TGn+kOyiYv1k/zdygBJWY=;
	b=RE9EeuE42YsLWrVX/ny7rUxcGVkgwVzuMG//nU8RhT4/TmvsliIG5akRV3X4VKnv+ZWX3w
	KjnCbnPSAywS9gCg==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso32: Remove SYSCALL_ENTER_KERNEL macro
 in sigreturn.S
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-6-hpa@zytor.com>
References: <20251216212606.1325678-6-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176835149466.510.11885289203772426485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     98d3e996513ad00b7824ea3bece506fc645547dd
Gitweb:        https://git.kernel.org/tip/98d3e996513ad00b7824ea3bece506fc645=
547dd
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:25:59 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 16:37:58 -08:00

x86/entry/vdso32: Remove SYSCALL_ENTER_KERNEL macro in sigreturn.S

A macro SYSCALL_ENTER_KERNEL was defined in sigreturn.S, with the
ability of overriding it. The override capability, however, is not
used anywhere, and the macro name is potentially confusing because it
seems to imply that sysenter/syscall could be used here, which is NOT
true: the sigreturn system calls MUST use int $0x80.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-6-hpa@zytor.com
---
 arch/x86/entry/vdso/vdso32/sigreturn.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vds=
o32/sigreturn.S
index 1bd068f..965900c 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -3,10 +3,6 @@
 #include <asm/unistd_32.h>
 #include <asm/asm-offsets.h>
=20
-#ifndef SYSCALL_ENTER_KERNEL
-#define	SYSCALL_ENTER_KERNEL	int $0x80
-#endif
-
 	.text
 	.globl __kernel_sigreturn
 	.type __kernel_sigreturn,@function
@@ -16,7 +12,7 @@ __kernel_sigreturn:
 .LSTART_sigreturn:
 	popl %eax		/* XXX does this mean it needs unwind info? */
 	movl $__NR_sigreturn, %eax
-	SYSCALL_ENTER_KERNEL
+	int $0x80
 .LEND_sigreturn:
 SYM_INNER_LABEL(vdso32_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop
@@ -28,7 +24,7 @@ SYM_INNER_LABEL(vdso32_sigreturn_landing_pad, SYM_L_GLOBAL)
 __kernel_rt_sigreturn:
 .LSTART_rt_sigreturn:
 	movl $__NR_rt_sigreturn, %eax
-	SYSCALL_ENTER_KERNEL
+	int $0x80
 .LEND_rt_sigreturn:
 SYM_INNER_LABEL(vdso32_rt_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop

