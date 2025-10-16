Return-Path: <linux-tip-commits+bounces-6914-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EFBE2945
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D488734765C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4031A54B;
	Thu, 16 Oct 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NyTAsjBG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6f2ef6F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD331D75C;
	Thu, 16 Oct 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608409; cv=none; b=kLUg8LQoiwLEDL8nVua2W1gd1j1Xq6Jx2LmUg21PGLkrfG7D+3YmQOHZ1J+idZ14L4xPLpUqVh9/2dAg9wTOe4LqxB3rK2GbZ10Q/3Al16U2VJFlnslJpqokKnIPw94ikUoiNFn8EdRVpU3g+RARkP0Qg6KUSAy3GI1NYnP8D44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608409; c=relaxed/simple;
	bh=dXRcfB2BxjXG9accYP4CWpo8iA6oFu166OJu9Cy1eDM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tOgmccjZ1YR/MXt5ujLGLz7nr2RWzeMCS9tX7MuXLCxk1P+7EHLPIhdPtzlD9Zp2caTnxKyEHX53nkgLdRWKbijEF8ooQysH0hBUE/XChtiF8D4d0bHVzRhNQ8CCgxDSNo7q2+Og7XrkZ55WtbcfvRHGYvDIKWUwJSPTUv8tb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NyTAsjBG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6f2ef6F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Sy0YZ7TXIC8PBojonV9yrDGP11Xj0ijaK0YFxQH83wk=;
	b=NyTAsjBGYVdIKL6RUkzQnpW3xFf5zx3DdKD4508COKwBTm6eu6Xiv+s4Pu0BVOV0yCZBt7
	2/cu8+uj97fiEsLbIAp0LP32eYaDLvRuVbGV0pdRHWldQZpn2HYRVtmdjv7B/Oh4yrPIJE
	Ic7a2RfJUW8Lng0lHyu1Rln8od11/lEpw9dF/lBiq0rEBx79DuZKhSOCJql0Uhg2uNNsCR
	ezvNzLKkgZMDnP3FJdrZNYrfiB8N2YJBTlwyDS4GJpJQ0cWdnlKa91bRraHnCMu6Vmmx71
	HJ91GEIUhpgKvha/7UDPQz+m2oU/dwyDlAN9VOafL7Jg/J6b1hURNk+ZpWugUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Sy0YZ7TXIC8PBojonV9yrDGP11Xj0ijaK0YFxQH83wk=;
	b=a6f2ef6FT7Ye9j0MEF4SmsFzxeGvzy4hue5e1CFJbFmNjHga/Pw2/Kz8MjFhPcTr6+gUlu
	PDM2AWJwx2mdm9Dw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] x86/alternative: Refactor INT3 call emulation selftest
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838835.709179.4748861208274527486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3049fc4b5f1d2320a84e2902b3ac5a735f60ca04
Gitweb:        https://git.kernel.org/tip/3049fc4b5f1d2320a84e2902b3ac5a735f6=
0ca04
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:18 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:22 -07:00

x86/alternative: Refactor INT3 call emulation selftest

The INT3 call emulation selftest is a bit fragile as it relies on the
compiler not inserting any extra instructions before the
int3_selftest_ip() definition.

Also, the int3_selftest_ip() symbol overlaps with the int3_selftest
symbol(), which can confuse objtool.

Fix those issues by slightly reworking the functionality and moving
int3_selftest_ip() to a separate asm function.  While at it, improve the
naming.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/alternative.c | 51 ++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff5..d19a3fd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2244,21 +2244,34 @@ int alternatives_text_reserved(void *start, void *end)
  * See entry_{32,64}.S for more details.
  */
=20
-/*
- * We define the int3_magic() function in assembly to control the calling
- * convention such that we can 'call' it from assembly.
- */
+extern void int3_selftest_asm(unsigned int *ptr);
=20
-extern void int3_magic(unsigned int *ptr); /* defined in asm */
+asm (
+"	.pushsection	.init.text, \"ax\", @progbits\n"
+"	.type		int3_selftest_asm, @function\n"
+"int3_selftest_asm:\n"
+	ANNOTATE_NOENDBR
+	/*
+	 * INT3 padded with NOP to CALL_INSN_SIZE. The INT3 triggers an
+	 * exception, then the int3_exception_nb notifier emulates a call to
+	 * int3_selftest_callee().
+	 */
+"	int3; nop; nop; nop; nop\n"
+	ASM_RET
+"	.size		int3_selftest_asm, . - int3_selftest_asm\n"
+"	.popsection\n"
+);
+
+extern void int3_selftest_callee(unsigned int *ptr);
=20
 asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
-"	.type		int3_magic, @function\n"
-"int3_magic:\n"
+"	.type		int3_selftest_callee, @function\n"
+"int3_selftest_callee:\n"
 	ANNOTATE_NOENDBR
-"	movl	$1, (%" _ASM_ARG1 ")\n"
+"	movl	$0x1234, (%" _ASM_ARG1 ")\n"
 	ASM_RET
-"	.size		int3_magic, .-int3_magic\n"
+"	.size		int3_selftest_callee, . - int3_selftest_callee\n"
 "	.popsection\n"
 );
=20
@@ -2267,7 +2280,7 @@ extern void int3_selftest_ip(void); /* defined in asm b=
elow */
 static int __init
 int3_exception_notify(struct notifier_block *self, unsigned long val, void *=
data)
 {
-	unsigned long selftest =3D (unsigned long)&int3_selftest_ip;
+	unsigned long selftest =3D (unsigned long)&int3_selftest_asm;
 	struct die_args *args =3D data;
 	struct pt_regs *regs =3D args->regs;
=20
@@ -2282,7 +2295,7 @@ int3_exception_notify(struct notifier_block *self, unsi=
gned long val, void *data
 	if (regs->ip - INT3_INSN_SIZE !=3D selftest)
 		return NOTIFY_DONE;
=20
-	int3_emulate_call(regs, (unsigned long)&int3_magic);
+	int3_emulate_call(regs, (unsigned long)&int3_selftest_callee);
 	return NOTIFY_STOP;
 }
=20
@@ -2298,19 +2311,11 @@ static noinline void __init int3_selftest(void)
 	BUG_ON(register_die_notifier(&int3_exception_nb));
=20
 	/*
-	 * Basically: int3_magic(&val); but really complicated :-)
-	 *
-	 * INT3 padded with NOP to CALL_INSN_SIZE. The int3_exception_nb
-	 * notifier above will emulate CALL for us.
+	 * Basically: int3_selftest_callee(&val); but really complicated :-)
 	 */
-	asm volatile ("int3_selftest_ip:\n\t"
-		      ANNOTATE_NOENDBR
-		      "    int3; nop; nop; nop; nop\n\t"
-		      : ASM_CALL_CONSTRAINT
-		      : __ASM_SEL_RAW(a, D) (&val)
-		      : "memory");
-
-	BUG_ON(val !=3D 1);
+	int3_selftest_asm(&val);
+
+	BUG_ON(val !=3D 0x1234);
=20
 	unregister_die_notifier(&int3_exception_nb);
 }

