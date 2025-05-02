Return-Path: <linux-tip-commits+bounces-5173-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C6AA6DB0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888CC3B9952
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E17269820;
	Fri,  2 May 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="codDo3iP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nQA89Cr/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDBE22E412;
	Fri,  2 May 2025 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176673; cv=none; b=jsVTD48KA88vtglHGbL0mIgpCIp4dDjagZbcUyTMJ5tU9bWyB5mVU87aHI/2fadY5W7DZOCo/aads0fn+wD1jyAGkQkvK/xxyDh1FICc5RWvo92HscRk1u3hMwFfd3sCNZzM4ywbFbt3KrqyiUoy4a1n4QcPBtqRJ6BjZyuaQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176673; c=relaxed/simple;
	bh=gAfpwhRy0PausGyXExpuYTcFnsAqoO/Rg6ex+WXRp18=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=f7gt926PXk2jNPooCu/IqnXPqtcAnKUZJsSQ1HXe3ADzPZffyILWh8h1h1X8/oCm914Az45LaNJ14cDabs6pO+x8enEPJ1G+IpNs9bBz5nSJAL03M28EkDuctR/VGez7imiWeygc6pUQdpVV39w33/Iy/a/02SR/w4tpmxO/gII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=codDo3iP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nQA89Cr/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vCCx+cl/KgyFWO+2MpwB6p8/gEIAgSU6eo2RisRWUJo=;
	b=codDo3iP+5ycBk2tqhh4wafziqwyBEXzheUzrgDAmx98Tp2uWqSjWXa7nHDooo0k6ND9GU
	baijUL0Nbv9lIakQvf6WBKBVVFORO+3zPnwoDy+Itw1ydBQoK2LEe5YcxqZgwqQ0nWc0kh
	s+tWEWmNv8hgmokgHjmsMl/CGGEvO65JN16MAPAP1rfCfBzDSA7dlCM4faY+kTauVMeRv6
	gM9gVLSqLhcZroW1/cbc/2FF+FsdEcvAH2pBVNkfW3P8IBRGtbHcvP7DA9K+RDovzwes3f
	EK57SvZXyN4b50usDzcdhfgaI5PMsSotQSD0+l4Ra0b7my2xuNn+jYNNc24ZRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vCCx+cl/KgyFWO+2MpwB6p8/gEIAgSU6eo2RisRWUJo=;
	b=nQA89Cr/p/bx0LodT0HbecpaRJR3QWO1UzXMycomWz/zAMXSodTi4DcbzAw9asQ+3xQ1rY
	c00/YFfhzqsB9QAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/msr: Move the EAX_EDX_*() methods from
 <asm/msr.h> to <asm/asm.h>
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666933.22196.17231571188397764274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     bdfda83a6b5988f1ac62cd0eaceb6c3b44dc2a31
Gitweb:        https://git.kernel.org/tip/bdfda83a6b5988f1ac62cd0eaceb6c3b44dc2a31
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 02 May 2025 10:13:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:18:19 +02:00

x86/msr: Move the EAX_EDX_*() methods from <asm/msr.h> to <asm/asm.h>

We are going to use them from multiple headers, and in any case,
such register access wrapper macros are better in <asm/asm.h>
anyway.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/asm.h | 19 +++++++++++++++++++
 arch/x86/include/asm/msr.h | 19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index cc28815..206e134 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -243,5 +243,24 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_FAULT)
 
+/*
+ * Both i386 and x86_64 returns 64-bit values in edx:eax for certain
+ * instructions, but GCC's "A" constraint has different meanings.
+ * For i386, "A" means exactly edx:eax, while for x86_64 it
+ * means rax *or* rdx.
+ *
+ * These helpers wrapping these semantic differences save one instruction
+ * clearing the high half of 'low':
+ */
+#ifdef CONFIG_X86_64
+# define EAX_EDX_DECLARE_ARGS(val, low, high)	unsigned long low, high
+# define EAX_EDX_VAL(val, low, high)		((low) | (high) << 32)
+# define EAX_EDX_RET(val, low, high)		"=a" (low), "=d" (high)
+#else
+# define EAX_EDX_DECLARE_ARGS(val, low, high)	u64 val
+# define EAX_EDX_VAL(val, low, high)		(val)
+# define EAX_EDX_RET(val, low, high)		"=A" (val)
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_X86_ASM_H */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index d57a94c..856d660 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -37,25 +37,6 @@ struct saved_msrs {
 };
 
 /*
- * Both i386 and x86_64 returns 64-bit values in edx:eax for certain
- * instructions, but GCC's "A" constraint has different meanings.
- * For i386, "A" means exactly edx:eax, while for x86_64 it
- * means rax *or* rdx.
- *
- * These helpers wrapping these semantic differences save one instruction
- * clearing the high half of 'low':
- */
-#ifdef CONFIG_X86_64
-# define EAX_EDX_DECLARE_ARGS(val, low, high)	unsigned long low, high
-# define EAX_EDX_VAL(val, low, high)		((low) | (high) << 32)
-# define EAX_EDX_RET(val, low, high)		"=a" (low), "=d" (high)
-#else
-# define EAX_EDX_DECLARE_ARGS(val, low, high)	u64 val
-# define EAX_EDX_VAL(val, low, high)		(val)
-# define EAX_EDX_RET(val, low, high)		"=A" (val)
-#endif
-
-/*
  * Be very careful with includes. This header is prone to include loops.
  */
 #include <asm/atomic.h>

