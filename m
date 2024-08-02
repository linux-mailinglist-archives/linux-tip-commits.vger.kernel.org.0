Return-Path: <linux-tip-commits+bounces-1918-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF40945E42
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEC8281BA4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BCA1E486B;
	Fri,  2 Aug 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+78+Cxc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzAVBRxt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014A1E484E;
	Fri,  2 Aug 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603675; cv=none; b=sYfPHN+Gctt1YbjHh/qdvaMzE/F8pFMiQzaRRPK8WWgfU54fsca3EyBsypPCFKhnxYTWZHegkRAy/MlFltkjE8UUko6qNOjn5hHw0dbqxcY+I5he7+sxjKxIRSoDnvw2GKv5c6l+UMHCm9AYWt4kXSYs7J1XPWnWVzgjXBdq2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603675; c=relaxed/simple;
	bh=35E0IsSUuNibscKvgIOK3NhfHM+0z2W3AXtmVnWbz8o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bbxXZhNGiG/iqpXVi/n5vIY3e8rQ8oIYskrf6696EPyl2ooX0xwJSCVakxcH0/gedSBPLhpVbDtWA7aSw3VvsVvxaq565TiRHjz32PyZt9EjmxvzFV7ZyyQwDPOavdEhtlyXGcBNjS06jsTPsDbT3BPdtijgoBrY2vz3tIqTUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+78+Cxc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzAVBRxt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 13:01:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C500XJFbVsAhQYVTffxX4VFfEXezhnatdVvjxcpoYTE=;
	b=d+78+CxcaImm2WlF8IwJ1XkYaqcxo834S4zBMBy5dMfCY83YyHgvJytRWS+eWIVsufTNuP
	e3v+QH/7oV1hIHDfO0S0G7y33bX7go9WMesebBStk3XJJJsiLPkkUCDxBW5DgHiGNxWMtP
	W6xjyl0UVMep8vUBiW06ih8MCXJrTxcomN6KKiCSFPkGqIuMLcoo99dbweJCmCJLLiCnSj
	6+cmX938Dczkmmag3Zxm9L410Iwk17uxc0gyz6oAvM1HQiUofZcqt3MInWC+FjTymCArhu
	nhmkYm/YmBAdBips6hEeQP0skbKyINvLaH14n2FVqOJfIIXrhBTMYU8y3i2tVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C500XJFbVsAhQYVTffxX4VFfEXezhnatdVvjxcpoYTE=;
	b=bzAVBRxtK2wTd3dm88bYIVhS1XZJZQCsiud4IyeTttZiFHg0cd4AGWpvaw0LeZaR3+OwQR
	nK7r8FEqtTuxssBw==
From: "tip-bot2 for Aruna Ramakrishna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802061318.2140081-4-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-4-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260367162.2215.3003929887771122044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     70044df250d022572e26cd301bddf75eac1fe50e
Gitweb:        https://git.kernel.org/tip/70044df250d022572e26cd301bddf75eac1fe50e
Author:        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
AuthorDate:    Fri, 02 Aug 2024 06:13:16 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 14:12:21 +02:00

x86/pkeys: Update PKRU to enable all pkeys before XSAVE

If the alternate signal stack is protected by a different PKEY than the
current execution stack, copying XSAVE data to the sigaltstack will fail
if its PKEY is not enabled in the PKRU register.

It's unknown which pkey was used by the application for the altstack, so
enable all PKEYS before XSAVE.

But this updated PKRU value is also pushed onto the sigframe, which
means the register value restored from sigcontext will be different from
the user-defined one, which is incorrect.

Fix that by overwriting the PKRU value on the sigframe with the original,
user-defined PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802061318.2140081-4-aruna.ramakrishna@oracle.com

---
 arch/x86/kernel/fpu/signal.c | 11 +++++++++--
 arch/x86/kernel/signal.c     | 12 ++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 931c546..1065ab9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -168,8 +168,15 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	if (use_xsave())
-		return xsave_to_user_sigframe(buf);
+	int err = 0;
+
+	if (use_xsave()) {
+		err = xsave_to_user_sigframe(buf);
+		if (!err)
+			err = update_pkru_in_sigframe(buf, pkru);
+		return err;
+	}
+
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9dc77ad..5f44103 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -102,7 +102,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	u32 pkru = read_pkru();
+	u32 pkru;
 
 	/* redzone */
 	if (!ia32_frame)
@@ -157,9 +157,17 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 		return (void __user *)-1L;
 	}
 
+	/* Update PKRU to enable access to the alternate signal stack. */
+	pkru = sig_prepare_pkru();
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru)) {
+		/*
+		 * Restore PKRU to the original, user-defined value; disable
+		 * extra pkeys enabled for the alternate signal stack, if any.
+		 */
+		write_pkru(pkru);
 		return (void __user *)-1L;
+	}
 
 	return (void __user *)sp;
 }

