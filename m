Return-Path: <linux-tip-commits+bounces-1269-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46748C903E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 11:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2271F22091
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679D029415;
	Sat, 18 May 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgU7ciUD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JpDmxsTA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425D28376;
	Sat, 18 May 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025496; cv=none; b=FnAN20w7Ab+a4bUm9F5nQt5VUQ/hZ9xGjOnMezEEhtFB8jf0/k4zeGsMx1LspnWnhhSBIy3jkqvWxBD4UflGtCYFI4D2PXBMClerblD8mkqJfqIvAemYFo29dIs4Dnihzkhzrzcjr9e0La/uTku022E5gQJxGBaWTuYuMMrIhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025496; c=relaxed/simple;
	bh=YnNbaHbLo6hEpCYus0gSKcmmmNiGpYvHLIWFn4j7U1k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EeKuh8C06yw0XQEeog2LvGRM2PJC08uXggZsGm+glAZLwMYoPluOd69guXOrahr90fLZuvBADJHHvhw6JgCa2mKiIAPHwW5x1ilNEimUNSbezYxyCIqI2tQqnxa50UpVI8AR/pQJW1IdGtXFGnL4LY3nNJDXcxMo9p4gbfdbdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgU7ciUD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JpDmxsTA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 18 May 2024 09:44:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MolmMBZt1LO4RiCedTEusJA5MaqJfY9Y/sAo5N3HZuA=;
	b=xgU7ciUD+TRqjQmg+z0Bze9aKGplO3j9URgi+hP9K0Nx0hhQfJHc3VlqziPOdNhIA/OlLh
	2KtUOJvY7ZgCHEWkFDINPQ9rzwsEB3/FqAyTQFrXBdZVRbnbQDu9MOZhtxcLoKSup/2849
	FupZL9KX5hnF2MrjEny2mI6KuLmJSfLdG6b6Ys1HQq9j8+9MrUOihxeG4AWHYqu7T6L7WP
	u7HTCbUroOnGCGLBeUbQWDMj8qB4mGb8UGVtx09FHyPBPpC3Z0d4dFIdj2eiqvUb15ItSa
	6ohtsTAsgMT2k+/LNXKJRCoj4UV0LC78/CVHYNiug6UGvFTVa76a2v46nzwelw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MolmMBZt1LO4RiCedTEusJA5MaqJfY9Y/sAo5N3HZuA=;
	b=JpDmxsTAKbAc13WAGBSRr45WmZVNel5k+na8V9Ecis6Po1oeg1xxKedr8GA4OjJ0slK0Uc
	H1w54zeemB5EICBg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/percpu: Introduce the __raw_cpu_read_const() macro
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240430091833.196482-4-ubizjak@gmail.com>
References: <20240430091833.196482-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171602549283.10875.15739867145799719700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     539615de7004a46778020183622856f4ca14e4ac
Gitweb:        https://git.kernel.org/tip/539615de7004a46778020183622856f4ca14e4ac
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 30 Apr 2024 11:17:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 18 May 2024 11:18:42 +02:00

x86/percpu: Introduce the __raw_cpu_read_const() macro

Introduce the __raw_cpu_read_const() macro to further reduce ifdeffery
and differences between configs w/ and w/o USE_X86_SEG_SUPPORT.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240430091833.196482-4-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index f360ac5..d202551 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -156,6 +156,8 @@ do {									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
 } while (0)
 
+#define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
+
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define __raw_cpu_read(size, qual, _var)				\
@@ -180,6 +182,12 @@ do {									\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
+/*
+ * The generic per-cpu infrastrucutre is not suitable for
+ * reading const-qualified variables.
+ */
+#define __raw_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
+
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define percpu_stable_op(size, op, _var)				\
@@ -470,16 +478,7 @@ do {									\
 #define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
 #endif
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-#define this_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
-#else /* CONFIG_USE_X86_SEG_SUPPORT */
-
-/*
- * The generic per-cpu infrastrucutre is not suitable for
- * reading const-qualified variables.
- */
-#define this_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
-#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+#define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
 
 #define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
 #define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)

