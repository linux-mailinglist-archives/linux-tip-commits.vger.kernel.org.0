Return-Path: <linux-tip-commits+bounces-7397-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A3C6B6EF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EB7A32940C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA652E889C;
	Tue, 18 Nov 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N16g9q3A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYkxBnt9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D422E1F02;
	Tue, 18 Nov 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494122; cv=none; b=uHdytrKBXgICUI0yK/SMVJI5N+zePdSDV+GZOgPIeuq7HAAHpfX2tIOF/JdrXiHWsNnLyX8LxXgSLTkQ6zG5/CcNzHB33scr2C1N3cl9jlnjzElHwmVD1GsEyts/In6quHBf504Y2LuZpkL4iwXZCR6nwbmxdh6BiKrE7sT8De8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494122; c=relaxed/simple;
	bh=XIYC5arlYYJy/c5mKCd8+DZ980lglruUmOeS6M2junU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=E8gtHEBhmWhK2iyAwiQE+r9Y9waBeCw+WF0/faJxj61SEKBXQIbQK8qMm1Nz0CdqvuLWUrrRaZGPqgbMQ0IdQmc3EbBFh8E4/IG82dGePYCWEaFbVRykFM4mQPpVdMgVUBKxdzuXxn3Y5KXl9KxOQSdlma6f2PSi8gir23C4Ap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N16g9q3A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYkxBnt9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=p1cZtm8yvhzrcIsac/Wy5fAwewLyQonukYk4VLAm9No=;
	b=N16g9q3AJmti7BXIEDI6NRZtiQ6O6Ud4ojrST2YXIVnPjpmWS6wjhI96DhciWFebdvMxUY
	DSl3KO/GT81E6n3BUHEgJ43ywfU6P0PMw7xi6nscd1CgVnoCqahv1FPTeNvgnwXxNh2p/H
	sSqHON0QwJdNQBc6pXND2HQ8/X268P7rWNWmJHXMREAryukIZZrCNuyMh/UTI4g7J6IaGr
	+8Nn2/ozj5yYkGs7XZi7WLpnEIgF66wOyaZk6tCtxHRPRRYmMrNkOlrcA0IdwlurL1LRh3
	Miv3BpnIJ5klpFK73qGJ+Ouia43zD+Yrl+tFDIvB1UDVdEV6yKW2yyEoK2pLoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=p1cZtm8yvhzrcIsac/Wy5fAwewLyQonukYk4VLAm9No=;
	b=cYkxBnt9pqetM08rBgATkkZBvvV2lM67hwcXxxMGxFlHjybJ3VxKIr+2HpnMF+eZhN2djr
	I1P+rBL1j9iWQFAA==
From: "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/traps: Communicate a LASS violation in #GP message
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349411851.498.6934114631763368671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     42fea0a3a707249cf88ee24aece1dfaba4953b97
Gitweb:        https://git.kernel.org/tip/42fea0a3a707249cf88ee24aece1dfaba49=
53b97
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Tue, 18 Nov 2025 10:29:08 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:26 -08:00

x86/traps: Communicate a LASS violation in #GP message

A LASS violation typically results in a #GP. With LASS active, any
invalid access to user memory (including the first page frame) would be
reported as a #GP, instead of a #PF.

Unfortunately, the #GP error messages provide limited information about
the cause of the fault. This could be confusing for kernel developers
and users who are accustomed to the friendly #PF messages.

To make the transition easier, enhance the #GP Oops message to include a
hint about LASS violations. Also, add a special hint for kernel NULL
pointer dereferences to match with the existing #PF message.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-7-sohil.mehta%40intel.c=
om
---
 arch/x86/kernel/traps.c | 44 ++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6b22611..1b9177b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -635,13 +635,23 @@ DEFINE_IDTENTRY(exc_bounds)
 enum kernel_gp_hint {
 	GP_NO_HINT,
 	GP_NON_CANONICAL,
-	GP_CANONICAL
+	GP_CANONICAL,
+	GP_LASS_VIOLATION,
+	GP_NULL_POINTER,
+};
+
+static const char * const kernel_gp_hint_help[] =3D {
+	[GP_NON_CANONICAL]	=3D "probably for non-canonical address",
+	[GP_CANONICAL]		=3D "maybe for address",
+	[GP_LASS_VIOLATION]	=3D "probably LASS violation for address",
+	[GP_NULL_POINTER]	=3D "kernel NULL pointer dereference",
 };
=20
 /*
  * When an uncaught #GP occurs, try to determine the memory address accessed=
 by
  * the instruction and return that address to the caller. Also, try to figure
- * out whether any part of the access to that address was non-canonical.
+ * out whether any part of the access to that address was non-canonical or
+ * across privilege levels.
  */
 static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 						 unsigned long *addr)
@@ -663,14 +673,28 @@ static enum kernel_gp_hint get_kernel_gp_address(struct=
 pt_regs *regs,
 		return GP_NO_HINT;
=20
 #ifdef CONFIG_X86_64
+	/* Operand is in the kernel half */
+	if (*addr >=3D ~__VIRTUAL_MASK)
+		return GP_CANONICAL;
+
+	/* The last byte of the operand is not in the user canonical half */
+	if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
+		return GP_NON_CANONICAL;
+
 	/*
-	 * Check that:
-	 *  - the operand is not in the kernel half
-	 *  - the last byte of the operand is not in the user canonical half
+	 * A NULL pointer dereference usually causes a #PF. However, it
+	 * can result in a #GP when LASS is active. Provide the same
+	 * hint in the rare case that the condition is hit without LASS.
 	 */
-	if (*addr < ~__VIRTUAL_MASK &&
-	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
-		return GP_NON_CANONICAL;
+	if (*addr < PAGE_SIZE)
+		return GP_NULL_POINTER;
+
+	/*
+	 * Assume that LASS caused the exception, because the address is
+	 * canonical and in the user half.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_LASS))
+		return GP_LASS_VIOLATION;
 #endif
=20
 	return GP_CANONICAL;
@@ -833,9 +857,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
=20
 	if (hint !=3D GP_NO_HINT)
 		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 (hint =3D=3D GP_NON_CANONICAL) ? "probably for non-canonical address"
-						    : "maybe for address",
-			 gp_addr);
+			 kernel_gp_hint_help[hint], gp_addr);
=20
 	/*
 	 * KASAN is interested only in the non-canonical case, clear it

