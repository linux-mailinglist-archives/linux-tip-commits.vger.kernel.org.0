Return-Path: <linux-tip-commits+bounces-7969-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94139D1BD61
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D94301FFAB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27461D5ABA;
	Wed, 14 Jan 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2aPkfKi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IHDIWlNT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E616DC28;
	Wed, 14 Jan 2026 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351492; cv=none; b=qV4gCzbAsgp3GjKOwJWyknV/6lug14doIcIlTgYi365X5z4RNIQcyLN1v36cKND1WuFAy2vanauTb86ubb4y4talcW49028Dd5xTTUboAvX8Pp6RsvH5yu0b7BwtKQ1KBm+qnkjcOOwRcI0+vVX1hTV8JwZU9/JjkLnZE5gwIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351492; c=relaxed/simple;
	bh=Hp0Y769X+FmhR8npP68FJboY/iKjdLhTNT9YT6oFml0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wi7BzKLLyJcW6l+LSOaJqK++LQAzpLXwtxhHV+ZNxFFspJ0cxGwG/ydwHpfhEgUfhjfTDAzFe3XUtL5hLIDakuWyST8yHlAj1a5guo8tnnfpsqAG8vGFiy5CbVvJ4JeIy9oi9hfK6wrnPK6p3g+gc4Dp3D4JrmRn7w+xkLyt3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2aPkfKi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IHDIWlNT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:44:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768351490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNgrBxShlDtefV/uhVt1DQ292Gir9BMUVJ7dk6x7E8w=;
	b=e2aPkfKik0K9UKq836UaQJ2iH/F3KO7AsoJiv4VuJ5dAQ1eNtKe+vc6HoIsIaD9RwhU5fU
	CZT/9hNAy+xODXtgHSvlVu/5H+USJXSHYF0N+UHIQaRsXjCdk3ccV7+6oTQEePAGZ+1AXJ
	MX9QjQuPq8HtT72z2jZGXBpXF2CkEFX6YmwStIIRPLq6VdOCSzmxxcEwaXkQC7nlsnIGA4
	5EXn4O8+trOy6h93UF6InkmbJs/p9UuMRKwVO/e8XyLvDoOdLiM9Gpgtdp9FzXADHQTp/+
	TauxJG5zDBay/agg8SlfUShpK50iaP2Fng44KFidnSfIytaX6cnEl+YddkzoBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768351490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNgrBxShlDtefV/uhVt1DQ292Gir9BMUVJ7dk6x7E8w=;
	b=IHDIWlNT5fUW8w+STY6STMXq0dxW9EKZyLWFxcXxYlw0uMnfLYNCOrG1hAWyQwaPiryMhY
	F/Ool7Iy6f6xi0DQ==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/entry] x86/entry/vdso32: When using int $0x80, use it directly
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-11-hpa@zytor.com>
References: <20251216212606.1325678-11-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176835148500.510.1892669351642514353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     36d83c249e0395a915144eceeb528ddc19b1fbe6
Gitweb:        https://git.kernel.org/tip/36d83c249e0395a915144eceeb528ddc19b=
1fbe6
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:26:04 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 16:37:58 -08:00

x86/entry/vdso32: When using int $0x80, use it directly

When neither sysenter32 nor syscall32 is available (on either
FRED-capable 64-bit hardware or old 32-bit hardware), there is no
reason to do a bunch of stack shuffling in __kernel_vsyscall.
Unfortunately, just overwriting the initial "push" instructions will
mess up the CFI annotations, so suffer the 3-byte NOP if not
applicable.

Similarly, inline the int $0x80 when doing inline system calls in the
vdso instead of calling __kernel_vsyscall.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-11-hpa@zytor.com
---
 arch/x86/entry/vdso/vdso32/system_call.S | 18 ++++++++++++++----
 arch/x86/include/asm/vdso/sys_call.h     |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/v=
dso32/system_call.S
index 7b1c0f1..9157cf9 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -14,6 +14,18 @@
 	ALIGN
 __kernel_vsyscall:
 	CFI_STARTPROC
+
+	/*
+	 * If using int $0x80, there is no reason to muck about with the
+	 * stack here. Unfortunately just overwriting the push instructions
+	 * would mess up the CFI annotations, but it is only a 3-byte
+	 * NOP in that case. This could be avoided by patching the
+	 * vdso symbol table (not the code) and entry point, but that
+	 * would a fair bit of tooling work or by simply compiling
+	 * two different vDSO images, but that doesn't seem worth it.
+	 */
+	ALTERNATIVE "int $0x80; ret", "", X86_FEATURE_SYSFAST32
+
 	/*
 	 * Reshuffle regs so that all of any of the entry instructions
 	 * will preserve enough state.
@@ -52,11 +64,9 @@ __kernel_vsyscall:
 	#define SYSENTER_SEQUENCE	"movl %esp, %ebp; sysenter"
 	#define SYSCALL_SEQUENCE	"movl %ecx, %ebp; syscall"
=20
-	/* If SYSENTER (Intel) or SYSCALL32 (AMD) is available, use it. */
-	ALTERNATIVE_2 "", SYSENTER_SEQUENCE, X86_FEATURE_SYSFAST32, \
-			  SYSCALL_SEQUENCE,  X86_FEATURE_SYSCALL32
+	ALTERNATIVE SYSENTER_SEQUENCE, SYSCALL_SEQUENCE, X86_FEATURE_SYSCALL32
=20
-	/* Enter using int $0x80 */
+	/* Re-enter using int $0x80 */
 	int	$0x80
 SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
=20
diff --git a/arch/x86/include/asm/vdso/sys_call.h b/arch/x86/include/asm/vdso=
/sys_call.h
index dcfd17c..5806b1c 100644
--- a/arch/x86/include/asm/vdso/sys_call.h
+++ b/arch/x86/include/asm/vdso/sys_call.h
@@ -20,7 +20,9 @@
 # define __sys_reg4	"r10"
 # define __sys_reg5	"r8"
 #else
-# define __sys_instr	"call __kernel_vsyscall"
+# define __sys_instr	ALTERNATIVE("ds;ds;ds;int $0x80",		\
+				    "call __kernel_vsyscall",		\
+				    X86_FEATURE_SYSFAST32)
 # define __sys_clobber	"memory"
 # define __sys_nr(x,y)	__NR_ ## x ## y
 # define __sys_reg1	"ebx"

