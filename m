Return-Path: <linux-tip-commits+bounces-7037-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9BC19676
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BAAB4EA796
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCEE32861D;
	Wed, 29 Oct 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmz9GZ9C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="csrrB76B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00A3081CE;
	Wed, 29 Oct 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730575; cv=none; b=JBvJB7uWd0f09u6qee12fDgiF7f8Q9LwMsQgdUG2F9L785O0TXbgYwKZkee/Idc1GhQ75fnk66z1Wrt+beaJJrWkNmMMFvjphurj+7UZg770RifWb1I0+Oisj2rfyNKeNvRVrhTVr9uD/rCLuiBHS7JK7xpdxuv++//W/wMsZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730575; c=relaxed/simple;
	bh=OpkaY7hyCA7UY5SsdvGS7etPcoLUabiKnPIVfywZwag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XhobXHdo3ESWhdKuSCuL0R00dbg+WlVzKdXiYMPodcSJCaHd9X/Vlo0l8qBY2/Zgxj7X8G+YxWrTXcPPFYsvSxLiiYGr20qOyMYxmqQ/qJoMEcQTbUp4ePm5xjNKWj1pi6CH1uv1tewCPkcEenkV+CTkaVXCvZYKnxvvJEkHNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmz9GZ9C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=csrrB76B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqC3ZFmWAokI5X4L6b+8fJ+TwopEyjawgywoSuXH3Pw=;
	b=cmz9GZ9CJiO1whVSCyfkz5X9CbXlCOcretxz5PjGkY/ccqnPKZPSELsA1/oF3COMIfsTzH
	ihFn+LylfQgsWD0IZxb48iPR6Xc2tDsD48w0qeGgVkmZ8cKK/jmL4IusPSWeAFYJVxrz0x
	UJ02q5H/PSlm4CnVspypqBNRPb8jWeBIBa3LVZnsgh0yRYswaZjyuJ61BcRxsU0Kry/NVW
	0aoxNg11BQR90TDWIbrtOpsBmpfCw8Qg88j11Sb8Oh8hgQ2rvSA6ESMYSCgsF6d1Xz7GK2
	8c7yzk6HMLy6SK6R9ZvxRP/mrsVXKvdpdfZSnWBfD0YgvtQWN0pYfJjyAsOGxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqC3ZFmWAokI5X4L6b+8fJ+TwopEyjawgywoSuXH3Pw=;
	b=csrrB76BfDtzbctTx7TyxnIf9gclp+m/ngCDZCJ40rGNfHpqYoDXIwTdBWCFcKDqp7fFMD
	+ycp5L97AFKbyEAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] unwind_user/x86: Enable frame pointer unwinding on x86
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250827193828.347397433@kernel.org>
References: <20250827193828.347397433@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173056943.2601451.14884503049263976236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     49cf34c0815f93fb2ea3ab5cfbac1124bd9b45d0
Gitweb:        https://git.kernel.org/tip/49cf34c0815f93fb2ea3ab5cfbac1124bd9=
b45d0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 27 Aug 2025 15:36:45 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:58 +01:00

unwind_user/x86: Enable frame pointer unwinding on x86

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
unwind_user interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20250827193828.347397433@kernel.org
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616..5cf1afc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -297,6 +297,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind=
_user.h
new file mode 100644
index 0000000..b166e10
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#include <asm/ptrace.h>
+
+#define ARCH_INIT_USER_FP_FRAME(ws)			\
+	.cfa_off	=3D  2*(ws),			\
+	.ra_off		=3D -1*(ws),			\
+	.fp_off		=3D -2*(ws),			\
+	.use_fp		=3D true,
+
+static inline int unwind_user_word_size(struct pt_regs *regs)
+{
+	/* We can't unwind VM86 stacks */
+	if (regs->flags & X86_VM_MASK)
+		return 0;
+#ifdef CONFIG_X86_64
+	if (!user_64bit_mode(regs))
+		return sizeof(int);
+#endif
+	return sizeof(long);
+}
+
+#endif /* _ASM_X86_UNWIND_USER_H */

