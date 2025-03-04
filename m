Return-Path: <linux-tip-commits+bounces-3917-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0DFA4DAD6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31CC3A5A08
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C28C1FFC69;
	Tue,  4 Mar 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m51X+OPx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jP+RI/D4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84E1FF1DA;
	Tue,  4 Mar 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084590; cv=none; b=vGeP9N4oGaNjRfIVCgmO6F1GeQylH/AGDwB0tOkAHCps+LaB2oUp88QuK5o/NM9Uld/tFHKLkB4ZYxcHl+rrhlQrMjtblgtAOsiTawi9L4UXk3swrO2mEZlVURfoKBgYSLmNfyxcJBuQUPd/+gLW8HwS+SIFmubykNPWA1ahmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084590; c=relaxed/simple;
	bh=+xWtS+nEXFqYIyyccgVLp2xUUXRABNVFa0luQrGPsGk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=S3kQUZ28vaK/oLIvG71AGKLBHy+1dDDPGfIxRuXxh0VQY66j+pusiIQgpxUS2x4D/JxVDIhni821TcXbQNUByUWCRUwIML1HLtDBSbxyJHMXP2srkzFTlzcbGls/dif7+ACz7kzr6Q95gonqSj+0sVsnWKW9mpx7vbetnKslM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m51X+OPx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jP+RI/D4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tOt0yAM4rrYikqbcR1mB34uOwA9jdWQ+I26BbnsOuSQ=;
	b=m51X+OPxR5R88K9q3AwRsf6W951dDhISHSVCTqY9B3toVb/6S5PWJmS0Y5D/1qKHQ7bROa
	NzWxs3xZAK8LZ1V+G/yfd3MF0WEhF7/aCinYheLqQY/pgiL/4TKlFF07JdR0dumAL+zqLo
	do1vJjvFntSq5Qbnp79yg1MJzORqDPCYUPlieoMnPPJ0plqI/+e8jbcPVT3rQ//BgLAkdu
	3Y3qGCrc19Wh4Io5eh9DrSWWm3OUyY2NYbPOM8pfjr6i/zdvYqgAv6BIdM8oMHaVaqaaq/
	TFS9MikmdjbzvY7zVQxH9X+jd9bUbcTgQHK87jSlCW2aU4fHEyRcVCK5LsANSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tOt0yAM4rrYikqbcR1mB34uOwA9jdWQ+I26BbnsOuSQ=;
	b=jP+RI/D4vEKhKZiNHtcmzMGZUHFgLuB9g4/eidV6JuXNydgvF+VhSM92Zkw+aXzaz/aKrb
	WqSbE8r5yJiqhACA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] KVM: VMX: Use named operands in inline asm
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458643.14745.15257465529400115378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e1c49eaee52384ec9e3734138b3929a35b64e0c3
Gitweb:        https://git.kernel.org/tip/e1c49eaee52384ec9e3734138b3929a35b64e0c3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:20:59 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:39 +01:00

KVM: VMX: Use named operands in inline asm

Convert the non-asm-goto version of the inline asm in __vmcs_readl() to
use named operands, similar to its asm-goto version.

Do this in preparation of changing the ASM_CALL_CONSTRAINT primitive.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/vmx/vmx_ops.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 633c87e..9667757 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -118,7 +118,7 @@ do_exception:
 
 #else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 
-	asm volatile("1: vmread %2, %1\n\t"
+	asm volatile("1: vmread %[field], %[output]\n\t"
 		     ".byte 0x3e\n\t" /* branch taken hint */
 		     "ja 3f\n\t"
 
@@ -127,24 +127,26 @@ do_exception:
 		      * @field, and bounce through the trampoline to preserve
 		      * volatile registers.
 		      */
-		     "xorl %k1, %k1\n\t"
+		     "xorl %k[output], %k[output]\n\t"
 		     "2:\n\t"
-		     "push %1\n\t"
-		     "push %2\n\t"
+		     "push %[output]\n\t"
+		     "push %[field]\n\t"
 		     "call vmread_error_trampoline\n\t"
 
 		     /*
 		      * Unwind the stack.  Note, the trampoline zeros out the
 		      * memory for @fault so that the result is '0' on error.
 		      */
-		     "pop %2\n\t"
-		     "pop %1\n\t"
+		     "pop %[field]\n\t"
+		     "pop %[output]\n\t"
 		     "3:\n\t"
 
 		     /* VMREAD faulted.  As above, except push '1' for @fault. */
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %1)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %[output])
 
-		     : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
+		     : ASM_CALL_CONSTRAINT, [output] "=&r" (value)
+		     : [field] "r" (field)
+		     : "cc");
 	return value;
 
 #endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */

