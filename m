Return-Path: <linux-tip-commits+bounces-3724-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5438A48AD9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 22:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF813B6DDD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A01EB5C0;
	Thu, 27 Feb 2025 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ygmE1kbB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PTUaby59"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C019227B8E;
	Thu, 27 Feb 2025 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693290; cv=none; b=SfL5GnLotCYKs+bZ6vaca9hPKu5n4S7e4PNY0cjZpTbF4sRjU4hizp//fUDTY+kby7gYv2+tdNvtB9qFd8OjT2ylYiULWYWnxEwxpP/mAXxfH0zG2p3VkLUgLUdIp2CUoureLVJN+DiLV+I8xczed/YUYvrnRJNg5YC04nqy0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693290; c=relaxed/simple;
	bh=khDrHLa4Qs8uPHw7+pEioVlzD4ve9ZF4w3CL3gs0viE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HjOzLp8Orkq8w+yFBx1jeSrZ6/c+AdxjxBhcmVqLMi14+LCNwH1Ad/24/eM9NfRt1V4uZ1dCmecuFpk7DAiopKvr5wVjdncoGtzUJBX7CUDBBGhPm/3Qs3/8fzXMFfJZjkGUzy04vp2qnoIhxMYdGODq02ydhEfrtzyDjroP4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ygmE1kbB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PTUaby59; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 21:54:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740693286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b90qhnh5htzwEX2HGzEv3NWBUtZTVRHmCfZTvn3nRC0=;
	b=ygmE1kbBxeI/Tb80BYZ31LB7LVKSLBi63tc+28H5+hyYqHf+qdCaHGhICp9dhX1UEua43A
	FXqZ0N1Jo1964ILn4ptMgV4NKZISP+nDAeOq+rB0/Hovz+D/3MOdmc66Cuhn+I4hnOqvKY
	pj57RAxzIZVLzaRXD0wztQ91U2Ir6QfXSVO58uTuhIQxaWhJv3dKiKWJPJgrsr4s5vwaLQ
	k3S2UvGINCfe6sFP+ubvlcCk4WujM6ldsF4Ia4yNS9H/qL6ofZxNaecZCQXJylQqHIBsl3
	8aUUAK23bKcBASh+0IrlvF6naDL+pYRvJpYSgsvuYYXwnubeuIOpmjA/YzESPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740693286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b90qhnh5htzwEX2HGzEv3NWBUtZTVRHmCfZTvn3nRC0=;
	b=PTUaby59nLxSPNE2XTOsqaGquMccNQxz2GzqPyHSGSURVkxpda3Chi0SJUXePk09BA6GZ2
	A2epY9lH0dAjgIAA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/ia32: Leave NULL selector values 0~3 unchanged
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241126184529.1607334-1-xin@zytor.com>
References: <20241126184529.1607334-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174069328263.10177.6796873487608898067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ad546940b5991d3e141238cd80a6d1894b767184
Gitweb:        https://git.kernel.org/tip/ad546940b5991d3e141238cd80a6d1894b767184
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 26 Nov 2024 10:45:28 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 22:46:11 +01:00

x86/ia32: Leave NULL selector values 0~3 unchanged

The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
GDT, selector values 0~3 all point to the NULL descriptor, thus values
0, 1, 2 and 3 are all valid NULL selector values.

When a NULL selector value is to be loaded into a segment register,
reload_segments() sets its RPL bits.  Later IRET zeros ES, FS, GS, and
DS segment registers if any of them is found to have any nonzero NULL
selector value.  The two operations offset each other to actually effect
a nop.

Besides, zeroing of RPL in NULL selector values is an information leak
in pre-FRED systems as userspace can spot any interrupt/exception by
loading a nonzero NULL selector, and waiting for it to become zero.
But there is nothing software can do to prevent it before FRED.

ERETU, the only legit instruction to return to userspace from kernel
under FRED, by design does NOT zero any segment register to avoid this
problem behavior.

As such, leave NULL selector values 0~3 unchanged and close the leak.

Do the same on 32-bit kernel as well.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241126184529.1607334-1-xin@zytor.com
---
 arch/x86/kernel/signal_32.c | 62 ++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef65453..98123ff 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -33,25 +33,55 @@
 #include <asm/smap.h>
 #include <asm/gsseg.h>
 
+/*
+ * The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
+ * and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
+ * GDT, selector values 0~3 all point to the NULL descriptor, thus values
+ * 0, 1, 2 and 3 are all valid NULL selector values.
+ *
+ * However IRET zeros ES, FS, GS, and DS segment registers if any of them
+ * is found to have any nonzero NULL selector value, which can be used by
+ * userspace in pre-FRED systems to spot any interrupt/exception by loading
+ * a nonzero NULL selector and waiting for it to become zero.  Before FRED
+ * there was nothing software could do to prevent such an information leak.
+ *
+ * ERETU, the only legit instruction to return to userspace from kernel
+ * under FRED, by design does NOT zero any segment register to avoid this
+ * problem behavior.
+ *
+ * As such, leave NULL selector values 0~3 unchanged.
+ */
+static inline u16 fixup_rpl(u16 sel)
+{
+	return sel <= 3 ? sel : sel | 3;
+}
+
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-	unsigned int cur;
+	u16 cur;
 
+	/*
+	 * Reload fs and gs if they have changed in the signal
+	 * handler.  This does not handle long fs/gs base changes in
+	 * the handler, but does not clobber them at least in the
+	 * normal case.
+	 */
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
+	if (fixup_rpl(sc->gs) != cur)
+		load_gs_index(fixup_rpl(sc->gs));
 	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
+	if (fixup_rpl(sc->fs) != cur)
+		loadsegment(fs, fixup_rpl(sc->fs));
+
 	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
+	if (fixup_rpl(sc->ds) != cur)
+		loadsegment(ds, fixup_rpl(sc->ds));
 	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	if (fixup_rpl(sc->es) != cur)
+		loadsegment(es, fixup_rpl(sc->es));
 }
 
 #define sigset32_t			compat_sigset_t
@@ -105,18 +135,12 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	regs->orig_ax = -1;
 
 #ifdef CONFIG_IA32_EMULATION
-	/*
-	 * Reload fs and gs if they have changed in the signal
-	 * handler.  This does not handle long fs/gs base changes in
-	 * the handler, but does not clobber them at least in the
-	 * normal case.
-	 */
 	reload_segments(&sc);
 #else
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	loadsegment(gs, fixup_rpl(sc.gs));
+	regs->fs = fixup_rpl(sc.fs);
+	regs->es = fixup_rpl(sc.es);
+	regs->ds = fixup_rpl(sc.ds);
 #endif
 
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);

