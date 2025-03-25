Return-Path: <linux-tip-commits+bounces-4428-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BFEA6EA9B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E286C188DB7A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B6253B54;
	Tue, 25 Mar 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCYVRy9F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwHu2X9G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668382040A7;
	Tue, 25 Mar 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888171; cv=none; b=rXnpBy9xJy+QZCUwCMaxsjco8sg+nup2/kMpOOSGznyfqC3cyxm0mOGuQdx0UaKIhuHv+M2PmGS96COa86cHFs+4aLC6EZWRc1See7ynun1T0Fy5c2MrEeVEHRuO0T7+BRoE93WcSndNKDJnjN3i1dxgzrdMJf5LLgyG9mhSWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888171; c=relaxed/simple;
	bh=sL+SIfje2Dzbdog7VczuCEGLsUpCBpaexSjQZL2P2b0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UWIOjKAmHUJjzADsX27+XQApqOM7WfUpTtNN2d+u3MoQ7RZdzwhsvJD131/T/KiZ0CzlFaaiS2BBdS5fdmg6ivDyksfX1O6Zet3piTnH2JDbWXom0nfLTTvakLbEXGGLAu+4+b7jMsjq8aOr+DF8XTEgmRkqZF9j6muGt4bey1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCYVRy9F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwHu2X9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJUCa6CcnIxSM/iXSM+hE5nxTfmFG9dHgRtsO0gVSPc=;
	b=hCYVRy9F8aUKAG3VjFhUBTtiVIPROWyQwQv3fWd70vyGuXbrWLiE4HzG3ljJyo6IUnHVyX
	fncoh2kSfZzzy/MF7wjHXrMR9u9UnS4i4ryR9ZEQp03Fp6AsPrkU5+YQqhrEy8XysTet7O
	4aTHVtmhovLAvf2znAyExR9J0RzMg3e2KY9X5nt4xU7XVj7QQ+k5Rh9xLBPu0Ll4xA2S0v
	LxSDlCy21845GFxUmM7e5oZMaUKDMnQ1S6X55cnufjYudJC5QMBQAQ+BM1gTVVVnxDcNcD
	MQY2pGY8X/b8jSeAaQXAGA0w7Eji2l4Y1GsFhbwQyXyHsvMjw+G9ViKVHRiGCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJUCa6CcnIxSM/iXSM+hE5nxTfmFG9dHgRtsO0gVSPc=;
	b=VwHu2X9Gcm4ceAKjSV3asBvp9c7mIw+509/q6kEQI1QNimLgnaKAR7Urff2AyT45VSElnf
	oHmWU+KVR64bqnAg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com>
References:
 <20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288816788.14745.10398589976376988106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c8c81458863ab686cda4fe1e603fccaae0f12460
Gitweb:        https://git.kernel.org/tip/c8c81458863ab686cda4fe1e603fccaae0f12460
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Thu, 20 Mar 2025 11:13:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:41:47 +01:00

x86/speculation: Remove the extra #ifdef around CALL_NOSPEC

Commit:

  010c4a461c1d ("x86/speculation: Simplify and make CALL_NOSPEC consistent")

added an #ifdef CONFIG_MITIGATION_RETPOLINE around the CALL_NOSPEC definition.
This is not required as this code is already under a larger #ifdef.

Remove the extra #ifdef, no functional change.

vmlinux size remains same before and after this change:

 CONFIG_MITIGATION_RETPOLINE=y:
      text       data        bss         dec        hex    filename
  25434752    7342290    2301212    35078254    217406e    vmlinux.before
  25434752    7342290    2301212    35078254    217406e    vmlinux.after

 # CONFIG_MITIGATION_RETPOLINE is not set:
      text       data        bss         dec        hex    filename
  22943094    6214994    1550152    30708240    1d49210    vmlinux.before
  22943094    6214994    1550152    30708240    1d49210    vmlinux.after

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 804b66a..29ea8fb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -435,12 +435,8 @@ static inline void call_depth_return_thunk(void) {}
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
-#ifdef CONFIG_MITIGATION_RETPOLINE
 #define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
 			"call __x86_indirect_thunk_%V[thunk_target]\n"
-#else
-#define CALL_NOSPEC	"call *%[thunk_target]\n"
-#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 

