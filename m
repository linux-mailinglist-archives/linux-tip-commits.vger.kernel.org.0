Return-Path: <linux-tip-commits+bounces-2954-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECF9E0FBB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 01:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35111646F0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 00:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DBF2500AA;
	Tue,  3 Dec 2024 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwsXt9Bn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khzfDRam"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64AEDE;
	Tue,  3 Dec 2024 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185940; cv=none; b=ZIZnk5VXM45CaHSHv80E8B8kQFXuxLTzg5EIE80aJGs9xGLIcs9QNQkMscxxoXMYKhGbHQUm8ma/VFWZusuQAFkJd5Un5j7t9iqhWb93Yjx9pnU9ByFmd84/0469hlTTAGlSt5q7cAuWyYm0M0nq5JtJOwfLiTCTXdKTlDen8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185940; c=relaxed/simple;
	bh=N75jH3Rh5bdX6JlO30QHD3OQNsn1iGUFnV3e2gdU6Yg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Rt4nojl+GfTqtmkfWQ4s9SQ5L4SVLqc1bnm5YTpbkJcZsStXHgjm79EjaKXOCyGkmnCTbmAs3xxlDsS/1KpewdN7eKCs6Aq0qFOMD+AaJngzHEdHHZbbnYMsW5IEphiHxMa0FIEP9TCpCmB8LK7jbvQTLLL+Bp0IgcWNScAUAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwsXt9Bn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=khzfDRam; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 00:32:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733185936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PjF4wj4/mweFjj9R3zJ4SbtH4DI4BAw5srKs3oKRiwo=;
	b=CwsXt9BnR9dzBXCK4j7BIknqRM/yQ2A3Sy8nmNywhWP5Hrv/yJRAYWneOorpX2FghPIuy2
	AsPDu7rvUKLwo3vZPiSWXdBz9GEn3YzZ7muMXBTGpf9Z0Vj+sXTDbF+pLQYYN02LaNXOpJ
	mium5SYBMqAvg3Z837Mup2s0UbXI09jyBIc7Mc7SSiJqJfJG8k1/566VAWECi5B33uvGu3
	sJjPnc6BGHVe0bR1bGmnhTup0spy45ZaqzT4OK3BCbqsBFiuddysvdYQhY+jT/DntRbbBI
	nVqGean6OaCd1nd3iZ0OExwzbafoo8ox/J93+3o8ctDQjfi1FZWXyMWFkX+Amw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733185936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PjF4wj4/mweFjj9R3zJ4SbtH4DI4BAw5srKs3oKRiwo=;
	b=khzfDRam+FYvg8djTc49p4+69dE/Ko+awv6v4XYMXCMCH3n9tWg7af7YO4J7/stcSArEGu
	XF2EEKYs2vB9cGCg==
From: "tip-bot2 for Aruna Ramakrishna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pkeys: Ensure updated PKRU value is XRSTOR'd
Cc: Rudi Horn <rudi.horn@oracle.com>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173318593579.412.14908591298190854451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ae6012d72fa60c9ff92de5bac7a8021a47458e5b
Gitweb:        https://git.kernel.org/tip/ae6012d72fa60c9ff92de5bac7a8021a47458e5b
Author:        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
AuthorDate:    Tue, 19 Nov 2024 17:45:20 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 02 Dec 2024 15:25:29 -08:00

x86/pkeys: Ensure updated PKRU value is XRSTOR'd

When XSTATE_BV[i] is 0, and XRSTOR attempts to restore state component
'i' it ignores any value in the XSAVE buffer and instead restores the
state component's init value.

This means that if XSAVE writes XSTATE_BV[PKRU]=0 then XRSTOR will
ignore the value that update_pkru_in_sigframe() writes to the XSAVE buffer.

XSTATE_BV[PKRU] only gets written as 0 if PKRU is in its init state. On
Intel CPUs, basically never happens because the kernel usually
overwrites the init value (aside: this is why we didn't notice this bug
until now). But on AMD, the init tracker is more aggressive and will
track PKRU as being in its init state upon any wrpkru(0x0).
Unfortunately, sig_prepare_pkru() does just that: wrpkru(0x0).

This writes XSTATE_BV[PKRU]=0 which makes XRSTOR ignore the PKRU value
in the sigframe.

To fix this, always overwrite the sigframe XSTATE_BV with a value that
has XSTATE_BV[PKRU]==1.  This ensures that XRSTOR will not ignore what
update_pkru_in_sigframe() wrote.

The problematic sequence of events is something like this:

Userspace does:
	* wrpkru(0xffff0000) (or whatever)
	* Hardware sets: XINUSE[PKRU]=1
Signal happens, kernel is entered:
	* sig_prepare_pkru() => wrpkru(0x00000000)
	* Hardware sets: XINUSE[PKRU]=0 (aggressive AMD init tracker)
	* XSAVE writes most of XSAVE buffer, including
	  XSTATE_BV[PKRU]=XINUSE[PKRU]=0
	* update_pkru_in_sigframe() overwrites PKRU in XSAVE buffer
... signal handling
	* XRSTOR sees XSTATE_BV[PKRU]==0, ignores just-written value
	  from update_pkru_in_sigframe()

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
Suggested-by: Rudi Horn <rudi.horn@oracle.com>
Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241119174520.3987538-3-aruna.ramakrishna%40oracle.com
---
 arch/x86/kernel/fpu/xstate.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 6b2924f..aa16f1a 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -72,10 +72,22 @@ static inline u64 xfeatures_mask_independent(void)
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 mask, u32 pkru)
 {
+	u64 xstate_bv;
+	int err;
+
 	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
 		return 0;
+
+	/* Mark PKRU as in-use so that it is restored correctly. */
+	xstate_bv = (mask & xfeatures_in_use()) | XFEATURE_MASK_PKRU;
+
+	err =  __put_user(xstate_bv, &buf->header.xfeatures);
+	if (err)
+		return err;
+
+	/* Update PKRU value in the userspace xsave buffer. */
 	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));
 }
 
@@ -292,7 +304,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkr
 	clac();
 
 	if (!err)
-		err = update_pkru_in_sigframe(buf, pkru);
+		err = update_pkru_in_sigframe(buf, mask, pkru);
 
 	return err;
 }

