Return-Path: <linux-tip-commits+bounces-4745-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB30A7F762
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 10:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE47179D82
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216E263C77;
	Tue,  8 Apr 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zj9/D7J4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQyl9otL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AE21B9C2;
	Tue,  8 Apr 2025 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099943; cv=none; b=WUhq2mpm14LOAeuFDU7YN6ec0sCMCLr44Tv/qsjCke7et0Ip35u1UfDl3xwnNNyM0/LM4bXDcYt3WzS5Jvdpv794n7mIJxlaeHRn23tFx8HGSbtf5hetM8UNzk4ARdLCSFNmmLyMNKDl8Q2ihrjIfsRNaivSeDr7K424pUfU8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099943; c=relaxed/simple;
	bh=lcqwwAZ1qfxQBD8Vxb/ZinQz9djbJMiM19YvBwJPd5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uOIzX7fyqQQsZQQLLT7Y6l5KsfIEjYdmhL9wS8qA/J2Ac2tsz+KcTx36bWEsBohh1B0yWQ/Ra+gOykJewDNfyMZwH1BmrM34oC4RGlxIFZzA3BTz/qZCYzdnSXTgDDY3HxkgxqN+8hzRgyPxoITZ86VujPeMTcvN/QrhClgRGyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zj9/D7J4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQyl9otL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 08:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744099939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vszxfyShc0++498NH0BgEFLXzhjs7aclqkUGT0A5z5Y=;
	b=Zj9/D7J4hfOLhXgFhaMBcIk5CNhHF5lRj7ooaJ/V3ehpqbqz58JHl1jv26WuclTAvXQPIh
	F/nIppJmI/ZAX98EjPtVKOY1wy/M64PP5/1XbSdD7Hv9FnAw6DoRZysLejvOpIZlIwOwKB
	rMj8WqSc6EqprJ6GAyOjpGrsT4vShdTfl3Kqa6wm2HcbdISsVfJuaDhwRsijbIh93ZM149
	w5xCzr+hkL6dm5H8qQ7BcI0qBq0uaUMZwa5WbkWmvn2RY7XZ1EMrm0AvgnKF/eEmwaozJh
	slvU16550ijpGmLYI+sbOk7WxXbZjPQ8ggE7EnaM+5ebZ8ZimDwrJ4yQOoHCfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744099939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vszxfyShc0++498NH0BgEFLXzhjs7aclqkUGT0A5z5Y=;
	b=BQyl9otLZfoKbNjQKWY/DhAZT/4fodIULb1ZWEimZbu/53vevGoNzRkRWZrq/wqxXtNkFK
	WkcXvyVlTSmvWVCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool, xen: Fix INSN_SYSCALL / INSN_SYSRET semantics
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <19453dfe9a0431b7f016e9dc16d031cad3812a50.1744095216.git.jpoimboe@kernel.org>
References:
 <19453dfe9a0431b7f016e9dc16d031cad3812a50.1744095216.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174409993428.31282.16321486770522273299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2dbbca9be4e5ed68d0972a2bcf4561d9cb85b7b7
Gitweb:        https://git.kernel.org/tip/2dbbca9be4e5ed68d0972a2bcf4561d9cb85b7b7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 00:02:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Apr 2025 09:14:12 +02:00

objtool, xen: Fix INSN_SYSCALL / INSN_SYSRET semantics

Objtool uses an arbitrary rule for INSN_SYSCALL and INSN_SYSRET that
almost works by accident: if it's in a function, control flow continues
after the instruction, otherwise it terminates.

That behavior should instead be based on the semantics of the underlying
instruction.  Change INSN_SYSCALL to always preserve control flow and
INSN_SYSRET to always terminate it.

The changed semantic for INSN_SYSCALL requires a tweak to the
!CONFIG_IA32_EMULATION version of xen_entry_SYSCALL_compat().  In Xen,
SYSCALL is a hypercall which usually returns.  But in this case it's a
hypercall to IRET which doesn't return.  Add UD2 to tell objtool to
terminate control flow, and to prevent undefined behavior at runtime.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com> # for the Xen part
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/19453dfe9a0431b7f016e9dc16d031cad3812a50.1744095216.git.jpoimboe@kernel.org
---
 arch/x86/xen/xen-asm.S |  4 +---
 tools/objtool/check.c  | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 109af12..461bb15 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -226,9 +226,7 @@ SYM_CODE_END(xen_early_idt_handler_array)
 	push %rax
 	mov  $__HYPERVISOR_iret, %eax
 	syscall		/* Do the IRET. */
-#ifdef CONFIG_MITIGATION_SLS
-	int3
-#endif
+	ud2		/* The SYSCALL should never return. */
 .endm
 
 SYM_CODE_START(xen_iret)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2dd89b0..69f94bc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3685,14 +3685,19 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_SYSCALL:
+			if (func && (!next_insn || !next_insn->hint)) {
+				WARN_INSN(insn, "unsupported instruction in callable function");
+				return 1;
+			}
+
+			break;
+
 		case INSN_SYSRET:
-			if (func) {
-				if (!next_insn || !next_insn->hint) {
-					WARN_INSN(insn, "unsupported instruction in callable function");
-					return 1;
-				}
-				break;
+			if (func && (!next_insn || !next_insn->hint)) {
+				WARN_INSN(insn, "unsupported instruction in callable function");
+				return 1;
 			}
+
 			return 0;
 
 		case INSN_STAC:
@@ -3888,9 +3893,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			return 1;
 
 		case INSN_SYSCALL:
+			break;
+
 		case INSN_SYSRET:
-			if (insn_func(insn))
-				break;
 			return 0;
 
 		case INSN_NOP:

