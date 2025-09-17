Return-Path: <linux-tip-commits+bounces-6663-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B40B7CB97
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918997A331E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7032BDC02;
	Wed, 17 Sep 2025 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECtHg01O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9GPyFrC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68E299949;
	Wed, 17 Sep 2025 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089802; cv=none; b=UsQkww21LAjNcdS5irtfZSrjdMnQaTwm0s+8GxXXyx9uXM5Fp4bVw3D1qdyJWZoABvLUQqdxGTnOsHoodHNRKjmjanXc7Jee/P88wHkohyvmDYSUMyxxUaDKW0l7kObiMGXx5NAc95YMooFGFQtXeaFBM6xOda/wCZ0kOt0NKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089802; c=relaxed/simple;
	bh=MoypvVkivEYhDiX//qEo1mXiTQJr5q8PYY5Iz+pqzZ8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dqf2TRnCHAmsLCcxX4T+aViWIW8hOYtqJar74CpOgL/sEqGaariwOw7eHZfSG5xv8ucToIqTfHf9PspgIHwcYX/IzuI9Xyd1fIDGsjkIbqKxXJyCAb3qIuJQKIZRi0daxbw5HhCHm1p476NF4KdDWD+YHjzic+bcynaj/1k/eO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ECtHg01O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V9GPyFrC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 06:16:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758089799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Le3FfqniARPqLAECgD8dD/MQaY/38o7MrXU6AeHW5Kk=;
	b=ECtHg01Ot/lShaUNb5CMjydAUsrBq0LW043Rj9YDdCt0ugAOG/OlmpQoBPFvzLCkq5ti5H
	97p53sCSqDeIcSRWmrKvfYvKnk97eItz19GIdwXsfiNuNTPgKePVOx++nv7zux/Iyekhsx
	pJCwVDtxV5KAVxVAZKvRwt5g7ORAiq60BIbGSFsix9qWV4IzFBsgFh4o7QXygOUdpyO4dF
	oUi69ZMXNYoSumTNm2cvIStYhbAd9nQV7chjp/ff78GeqKdYCpSZ5ofdqeAntVDNHqkhUi
	t2YoWoJAk18rXFvHoBZZUi/0dMuigsurseNzKug/taMZvx/OP/XK0Yc1DeI8UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758089799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Le3FfqniARPqLAECgD8dD/MQaY/38o7MrXU6AeHW5Kk=;
	b=V9GPyFrC8JiONfeCDw+AyQZjL65aOSMZ8UxW2lx6UtgbKOs38NheyWwNG1EMeUPkIpA/mf
	OWB/Dey3YhznA+Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] asm-generic: Provide generic TIF infrastructure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908212927.247766392@linutronix.de>
References: <20250908212927.247766392@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175808979777.709179.5989064059695349525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     29589343488e116ac31f6f3cfa83e43949a2207a
Gitweb:        https://git.kernel.org/tip/29589343488e116ac31f6f3cfa83e43949a=
2207a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 08 Sep 2025 23:32:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 08:14:03 +02:00

asm-generic: Provide generic TIF infrastructure

Common TIF bits do not have to be defined by every architecture. They can
be defined in a generic header.

That allows adding generic TIF bits without chasing a gazillion of
architecture headers, which is again a unjustified burden on anyone who
works on generic infrastructure as it always needs a boat load of work to
keep existing architecture code working when adding new stuff.

While it is not as horrible as the ignorance of the generic entry
infrastructure, it is a welcome mechanism to make architecture people
rethink their approach of just leaching generic improvements into
architecture code and thereby making it accumulatingly harder to maintain
and improve generic code. It's about time that this changes.

Provide the infrastructure and split the TIF space in half, 16 generic and
16 architecture specific bits.

This could probably be extended by TIF_SINGLESTEP and BLOCKSTEP, but those
are only used in architecture specific code. So leave them alone for now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/Kconfig                          |  4 ++-
 include/asm-generic/thread_info_tif.h | 48 ++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+)
 create mode 100644 include/asm-generic/thread_info_tif.h

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd..c20df40 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1730,6 +1730,10 @@ config ARCH_VMLINUX_NEEDS_RELOCS
 	  relocations preserved. This is used by some architectures to
 	  construct bespoke relocation tables for KASLR.
=20
+# Select if architecture uses the common generic TIF bits
+config HAVE_GENERIC_TIF_BITS
+       bool
+
 source "kernel/gcov/Kconfig"
=20
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thre=
ad_info_tif.h
new file mode 100644
index 0000000..ee3793e
--- /dev/null
+++ b/include/asm-generic/thread_info_tif.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_THREAD_INFO_TIF_H_
+#define _ASM_GENERIC_THREAD_INFO_TIF_H_
+
+#include <vdso/bits.h>
+
+/* Bits 16-31 are reserved for architecture specific purposes */
+
+#define TIF_NOTIFY_RESUME	0	// callback before returning to user
+#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
+
+#define TIF_SIGPENDING		1	// signal pending
+#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
+
+#define TIF_NOTIFY_SIGNAL	2	// signal notifications exist
+#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
+
+#define TIF_MEMDIE		3	// is terminating due to OOM killer
+#define _TIF_MEMDIE		BIT(TIF_MEMDIE)
+
+#define TIF_NEED_RESCHED	4	// rescheduling necessary
+#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
+
+#ifdef HAVE_TIF_NEED_RESCHED_LAZY
+# define TIF_NEED_RESCHED_LAZY	5	// Lazy rescheduling needed
+# define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
+#endif
+
+#ifdef HAVE_TIF_POLLING_NRFLAG
+# define TIF_POLLING_NRFLAG	6	// idle is polling for TIF_NEED_RESCHED
+# define _TIF_POLLING_NRFLAG	BIT(TIF_POLLING_NRFLAG)
+#endif
+
+#define TIF_USER_RETURN_NOTIFY	7	// notify kernel of userspace return
+#define _TIF_USER_RETURN_NOTIFY	BIT(TIF_USER_RETURN_NOTIFY)
+
+#define TIF_UPROBE		8	// breakpointed or singlestepping
+#define _TIF_UPROBE		BIT(TIF_UPROBE)
+
+#define TIF_PATCH_PENDING	9	// pending live patching update
+#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
+
+#ifdef HAVE_TIF_RESTORE_SIGMASK
+# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal() */
+# define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
+#endif
+
+#endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */

