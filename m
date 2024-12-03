Return-Path: <linux-tip-commits+bounces-2955-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F59E0FBC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 01:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34EC282187
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 00:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0D5684;
	Tue,  3 Dec 2024 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oblaTx8u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxJStkgu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838451370;
	Tue,  3 Dec 2024 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185941; cv=none; b=ZqrAW4vUlovt9ZKauQ/bxC2o1dlCMS1DfJ3c3vZ3fsmhVmhNrkMxrWrXgOXBJDA7RHwdaGzaJeEphkc2rQQqzd7d7L12afpysQNE2eRCJr86pIjsmPAYJTaIy3w7WBgzSpt+gyJ+EKOo/WvpjBYL2mG2A2rkAzHaLmNwkvNkocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185941; c=relaxed/simple;
	bh=AJWNwhHsihu7emRR9Xx+g9ZAMfaqWsR2tzxr+IcI8OI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OismEzxJOIc1oogOlIiXRQsZ9Yzu9S8zpW63zpc/HcKAGDIFIvYpte2Ur0wuXh/5O84Q10ffaQ7ZGaGWznb4RarlrqWR+KVzRVBUaMGlGCefUJA/Y4Oaczm7w3YidFTtRZPGNkoePm82OGqPejdRVlQSpTC/lE0ZOLnq5a38BU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oblaTx8u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxJStkgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 00:32:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733185937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+CGFpIpf4XYOsin5q5a3utdvy/JpllAVdYr6cDzrqWo=;
	b=oblaTx8uUTvUruufUzFxazJvEyXrusEkeeOgmnWDGPocL/TYVKoAT6ql0qdwiBkt9HTZq4
	dhSU2nItSrrHqvWQz44i8Hge/PnIr5QIkJdtGqPwmvRrHXvK9pAqpGvctGXwm6T6+29YV9
	MHLC1W77zP34UBbH8hAMx3LPUBDDi4jQTi84e/Ej6HrOV3JX+FgV75jpH2G4UOqZBsSbaL
	eA984IjteKvbV/AE96kOa+9Razg/cSGF/zsZ5uIH69vg31gTkDxAp5NYhHc+COvBdDi3Mi
	htHO0EbndNmywhvgYdilJ/1uQmPXw5aEmdfa82DyoXRCoxYu/8S2VjgLWKVjGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733185937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+CGFpIpf4XYOsin5q5a3utdvy/JpllAVdYr6cDzrqWo=;
	b=bxJStkguzSrVKp3Py2KcIEdNDC0y/iPmNdWFz2snbswWsbbJtiUJe0SXbg4Xqnk9jQcS/3
	f3PpzUFu0wKTwFCQ==
From: "tip-bot2 for Aruna Ramakrishna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/pkeys: Change caller of update_pkru_in_sigframe()
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173318593666.412.7436081094216803091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6a1853bdf17874392476b552398df261f75503e0
Gitweb:        https://git.kernel.org/tip/6a1853bdf17874392476b552398df261f75503e0
Author:        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
AuthorDate:    Tue, 19 Nov 2024 17:45:19 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 02 Dec 2024 15:25:21 -08:00

x86/pkeys: Change caller of update_pkru_in_sigframe()

update_pkru_in_sigframe() will shortly need some information which
is only available inside xsave_to_user_sigframe(). Move
update_pkru_in_sigframe() inside the other function to make it
easier to provide it that information.

No functional changes.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241119174520.3987538-2-aruna.ramakrishna%40oracle.com
---
 arch/x86/kernel/fpu/signal.c | 20 ++------------------
 arch/x86/kernel/fpu/xstate.h | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 1065ab9..8f62e06 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -64,16 +64,6 @@ setfx:
 }
 
 /*
- * Update the value of PKRU register that was already pushed onto the signal frame.
- */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
-{
-	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
-		return 0;
-	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));
-}
-
-/*
  * Signal frame handlers.
  */
 static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
@@ -168,14 +158,8 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	int err = 0;
-
-	if (use_xsave()) {
-		err = xsave_to_user_sigframe(buf);
-		if (!err)
-			err = update_pkru_in_sigframe(buf, pkru);
-		return err;
-	}
+	if (use_xsave())
+		return xsave_to_user_sigframe(buf, pkru);
 
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 0b86a50..6b2924f 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -69,6 +69,16 @@ static inline u64 xfeatures_mask_independent(void)
 	return fpu_kernel_cfg.independent_features;
 }
 
+/*
+ * Update the value of PKRU register that was already pushed onto the signal frame.
+ */
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
+{
+	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
+		return 0;
+	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));
+}
+
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
@@ -256,7 +266,7 @@ static inline u64 xfeatures_need_sigframe_write(void)
  * The caller has to zero buf::header before calling this because XSAVE*
  * does not touch the reserved fields in the header.
  */
-static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
 	/*
 	 * Include the features which are not xsaved/rstored by the kernel
@@ -281,6 +291,9 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
 
+	if (!err)
+		err = update_pkru_in_sigframe(buf, pkru);
+
 	return err;
 }
 

