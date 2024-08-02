Return-Path: <linux-tip-commits+bounces-1919-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A0945E45
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C648281C5B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0AD1E4EE6;
	Fri,  2 Aug 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4REzJOK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3EbW0On"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4651E485B;
	Fri,  2 Aug 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603676; cv=none; b=WUPtoc71IJOgKZtyPSQ2SFn9dbJmpikxroir3TobMID6j1Zpf6l4PLIt5jABViodTH3ktzJ7lcvJzbkKd6kwej5sh1wBEtAhMRe9WS67xsp2IjWTV/DNLCmAlmt0SUReoboDRednBTHD90q/BDMPYJhRNzCJsIJTOJWA/1Ir0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603676; c=relaxed/simple;
	bh=d+nhXZCY4s6NxzGgau/hWpRMNkZvdKpoV5KoQ0WhBSQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D+Hos5I+1TBWCaaHhwyXpya5Ik4yQ4iHbKG1GUs73PJw5FELyH4UlAsTDTKc1IWyKkT7jrwn7rF6A7wODMdi0rN548ydyN+DyBOYHKPw4NDTSM1wAIhs9Rg1lqGaado4r4ykC7WeriWBep84D0PPf3o15657oxVzEA5MmG2gG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4REzJOK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3EbW0On; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 13:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urlHfVi3U8w4pm8yquBjVBEs1OkG+4RI76qI832S2N4=;
	b=f4REzJOKX8z+fZVx0ZKVwmFBXPtNly6cZO1vY4nQ4JA3/Gqu6PP3zgg0Gr9vIlmoowyd6c
	0jeeTAFZzdkTTJwQ9AQnSreCp43L492dc5jBdeHzL0XZEA+dNZiW2XRrHTZzXNqqdGqo4A
	IxDdYCMDVPyrOnxsjG3gu84mGMeKZj0u+oSICXFqTJSOSydcTUbwF+jDqK4ihySlOnD3tl
	vCbBX0G2v/AM9r32tYQcwQBUtKN1uSuJZmEh+h02/5lZ05aGN72dSq/gwmP0I7pwx9vWaK
	SLFsN4UQ6EfN9ljckt4nfYivzfzu6Pj/5XXnhXIkXQ6h36lLNqJ0h6N/kw1AWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urlHfVi3U8w4pm8yquBjVBEs1OkG+4RI76qI832S2N4=;
	b=O3EbW0OnwvRRAda8PTnAYRGqkktghjUxwO6jcU/WGQJ+a3DaSgYpZmdvYUe8Ov19Dvoxl8
	a8R3UwEdMYbw7kBQ==
From: "tip-bot2 for Aruna Ramakrishna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/pkeys: Add helper functions to update PKRU on the sigframe
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802061318.2140081-3-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-3-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260367217.2215.13764673539033105574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     84ee6e8d195e4af4c6c4c961bbf9266bdc8b90ac
Gitweb:        https://git.kernel.org/tip/84ee6e8d195e4af4c6c4c961bbf9266bdc8b90ac
Author:        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
AuthorDate:    Fri, 02 Aug 2024 06:13:15 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 14:12:21 +02:00

x86/pkeys: Add helper functions to update PKRU on the sigframe

In the case where a user thread sets up an alternate signal stack protected
by the default PKEY (i.e. PKEY 0), while the thread's stack is protected by
a non-zero PKEY, both these PKEYS have to be enabled in the PKRU register
for the signal to be delivered to the application correctly. However, the
PKRU value restored after handling the signal must not enable this extra
PKEY (i.e. PKEY 0) - i.e., the PKRU value in the sigframe has to be
overwritten with the user-defined value.

Add helper functions that will update PKRU value in the sigframe after
XSAVE.

Note that sig_prepare_pkru() makes no assumption about which PKEY could
be used to protect the altstack (i.e. it may not be part of init_pkru),
and so enables all PKEYS.

No functional change.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802061318.2140081-3-aruna.ramakrishna@oracle.com

---
 arch/x86/kernel/fpu/signal.c | 10 ++++++++++
 arch/x86/kernel/fpu/xstate.c | 13 +++++++++++++
 arch/x86/kernel/fpu/xstate.h |  2 ++
 arch/x86/kernel/signal.c     | 18 ++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 2b3b9e1..931c546 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -64,6 +64,16 @@ setfx:
 }
 
 /*
+ * Update the value of PKRU register that was already pushed onto the signal frame.
+ */
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
+{
+	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
+		return 0;
+	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));
+}
+
+/*
  * Signal frame handlers.
  */
 static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026f..fa7628b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -993,6 +993,19 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
+/*
+ * Given an xstate feature nr, calculate where in the xsave buffer the state is.
+ * The xsave buffer should be in standard format, not compacted (e.g. user mode
+ * signal frames).
+ */
+void __user *get_xsave_addr_user(struct xregs_state __user *xsave, int xfeature_nr)
+{
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return NULL;
+
+	return (void __user *)xsave + xstate_offsets[xfeature_nr];
+}
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c..5f057e5 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -54,6 +54,8 @@ extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void
 extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
 
+extern void __user *get_xsave_addr_user(struct xregs_state __user *xsave, int xfeature_nr);
+
 static inline u64 xfeatures_mask_supervisor(void)
 {
 	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 1f1e8e0..9dc77ad 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -61,6 +61,24 @@ static inline int is_x32_frame(struct ksignal *ksig)
 }
 
 /*
+ * Enable all pkeys temporarily, so as to ensure that both the current
+ * execution stack as well as the alternate signal stack are writeable.
+ * The application can use any of the available pkeys to protect the
+ * alternate signal stack, and we don't know which one it is, so enable
+ * all. The PKRU register will be reset to init_pkru later in the flow,
+ * in fpu__clear_user_states(), and it is the application's responsibility
+ * to enable the appropriate pkey as the first step in the signal handler
+ * so that the handler does not segfault.
+ */
+static inline u32 sig_prepare_pkru(void)
+{
+	u32 orig_pkru = read_pkru();
+
+	write_pkru(0);
+	return orig_pkru;
+}
+
+/*
  * Set up a signal frame.
  */
 

