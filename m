Return-Path: <linux-tip-commits+bounces-5004-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23598A8B32D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AC35A1776
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62322F155;
	Wed, 16 Apr 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i06Z+Jf2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0AQV5+2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115A22256C;
	Wed, 16 Apr 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791440; cv=none; b=hmbf34vMggnBeSlSR64UITSfCXbHSRrgv7pyGeu6Yez0UvTKT9DUmHphb/wvlXxi7YnC7mtCcal6vSKI7wkJ940tliQqAs5rBd33kOcnbU1GxESWovgpW3dxpLaUg0ShAdFBYHqVLqAJ0oUhDk5WH+S0Jvcm9dunOAoBTyvV5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791440; c=relaxed/simple;
	bh=LgLV5M9rnB8Yxss8Xw0+25CiSdp1VbKI3oz7dDHcdlg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=azUCEeMTiC8XWASjh16DLoiAYc3P3UC0txQ0So9ylTcXfsUbozyfZTy/rEIH7nBoWCfD86YXCTxqDgGQ6CFridwQwodCMftawLfTXjLOtsevgX6DLmiEDkvG0p45uqndRJ7KF2Soc0FfMO+W5C1KIDb6c/OTLHCAEvEz49uEWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i06Z+Jf2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0AQV5+2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVwmUpzJfdp/EOYwG8MQDoMU8FhU6RV8TGuE+hTfZ2Y=;
	b=i06Z+Jf2itx3eE4L41UtMhlmmZE1m0vKmR9j3nphoj/4B/AMk6MCRPwPeHkEJWTHya1In6
	R0DsscDz4F9n5kjp+DYz5MNz6OT+C2oZ9B40lJ7RYd1TCDzg8TgHdU/JkVnTx/KxCHs+i4
	cKXDb/KLxaMFiEfK3eDdZnJRR9xvCXqH+xypBpmGzgtv0OwpDCJbx60tAqdH0XpZct7yI3
	mz9ITchFpVFJrFWvI4fk5b/A70z5jCp1Rodedpy2yz2J+Cemvt187MpEfq9iPnBqS7wXIk
	ieYotCpsP+SfFClkfq2GIY9tk4K93SjkX8T755kn+p0zvLwXpNpFY0MVJ+MTjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVwmUpzJfdp/EOYwG8MQDoMU8FhU6RV8TGuE+hTfZ2Y=;
	b=D0AQV5+2nDufYEnu9N9dwz4cs0aSHAh+6vIje1D0egS9YIL8cYjfDMkAcpyZisKbIrEH6P
	GfmayB8d+Dw78aCQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/pkeys: Simplify PKRU update in signal frame
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-9-chang.seok.bae@intel.com>
References: <20250416021720.12305-9-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479143631.31282.8518500838043326386.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     d1e420772cd1eb0afe5858619c73ce36f3e781a1
Gitweb:        https://git.kernel.org/tip/d1e420772cd1eb0afe5858619c73ce36f3e781a1
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:58 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 10:01:03 +02:00

x86/pkeys: Simplify PKRU update in signal frame

The signal delivery logic was modified to always set the PKRU bit in
xregs_state->header->xfeatures by this commit:

    ae6012d72fa6 ("x86/pkeys: Ensure updated PKRU value is XRSTOR'd")

However, the change derives the bitmask value using XGETBV(1), rather
than simply updating the buffer that already holds the value. Thus, this
approach induces an unnecessary dependency on XGETBV1 for PKRU handling.

Eliminate the dependency by using the established helper function.
Subsequently, remove the now-unused 'mask' argument.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250416021720.12305-9-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.h |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 4231e44..a0256ef 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -85,18 +85,15 @@ static inline int set_xfeature_in_sigframe(struct xregs_state __user *xbuf, u64 
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 mask, u32 pkru)
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	u64 xstate_bv;
 	int err;
 
 	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
 		return 0;
 
 	/* Mark PKRU as in-use so that it is restored correctly. */
-	xstate_bv = (mask & xfeatures_in_use()) | XFEATURE_MASK_PKRU;
-
-	err =  __put_user(xstate_bv, &buf->header.xfeatures);
+	err = set_xfeature_in_sigframe(buf, XFEATURE_MASK_PKRU);
 	if (err)
 		return err;
 
@@ -320,7 +317,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkr
 	clac();
 
 	if (!err)
-		err = update_pkru_in_sigframe(buf, mask, pkru);
+		err = update_pkru_in_sigframe(buf, pkru);
 
 	return err;
 }

