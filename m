Return-Path: <linux-tip-commits+bounces-5009-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6CA8B33A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282F41905BF1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0B233D8C;
	Wed, 16 Apr 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCGF69QK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMQYKGdk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E3233705;
	Wed, 16 Apr 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791446; cv=none; b=ma+1jZctE6WK4Qu5zR7AAESEtc8i+XM0gc7i7awzEbDFLuT/oXLaL15izPlk4ctWSiofMdBSFwHuY5IzSCJW5psNbcQOoiXzpD6J/JlOXiMzdBmdRfFYV5BTbpFucC2gQhjzqsGhb3p65dTWusnFA560RT18+xXAINVWzDqFmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791446; c=relaxed/simple;
	bh=g0d4fF/sMr3d9s261bzmvroo5ibomVGH7a6fl4rKLaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lnXDtFFukqnayRte8sTJ8on4Bx6aVBmbP9nvNQMcVbV3bDoZzJdpRi31SMjImh+B3vObJmFd9qtdI+gNm1YGG1vXeny6uFhURujbqF3bUSnq0uU2WYFqpa7UIGUeg2bOOgpqaz5/iSHdH2uG/q27XhCj0nN9+Y5XPWNuspuZWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCGF69QK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OMQYKGdk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oWpK4igDBmFi3LJxCW7dM8VhB+n8XyEkHYc2KQ3ZxU=;
	b=CCGF69QKid7wO39ixYTRBuvkpEcaVz7hQ4OdyP3eXNmxIhtOxJpnGjcvkhWNrSLNUH5FkS
	7OdPAY9ozGZNeWlJVFA1YGswhF0ZxZKXjvLcsHmbCIX7KYXr3idgcrW6Uc1P5kDh06sMld
	M3Uc0J7Nq439uBFrBWBMaVEdbgHtivLuxq+Fhu2ETyvTmZV8c9Iq0EvRc3YnQcijPZxEEC
	ZPnLpgMir20foT+XKqnYGma8kJHpi6+xS9jw7LAHWFsVMrt0a7yYWBjU3q60zq/ZTGy7X1
	g5ZM2elFsNBO8EdiaMNHeZDb39aYOc2e/AD+WY5I4+W+mhfijyi93SI/E5EfgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oWpK4igDBmFi3LJxCW7dM8VhB+n8XyEkHYc2KQ3ZxU=;
	b=OMQYKGdk+dLZfJXtUGIMptmu9UaMDDZ/UARqsUtv7kM0xWGPG2NW7iGpNe302ocMPd4wPG
	WIQZ8Ter4DDiHbBA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/apx: Disallow conflicting MPX presence
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-4-chang.seok.bae@intel.com>
References: <20250416021720.12305-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479144216.31282.5860920068823591064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ea68e39190cff86f457bd286c70b535e2a99a94d
Gitweb:        https://git.kernel.org/tip/ea68e39190cff86f457bd286c70b535e2a99a94d
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 09:44:14 +02:00

x86/fpu/apx: Disallow conflicting MPX presence

XSTATE components are architecturally independent. There is no rule
requiring their offsets in the non-compacted format to be strictly
ascending or mutually non-overlapping. However, in practice, such
overlaps have not occurred -- until now.

APX is introduced as xstate component 19, following AMX. In the
non-compacted XSAVE format, its offset overlaps with the space previously
occupied by the now-deprecated MPX feature:

    45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")

To prevent conflicts, the kernel must ensure the CPU never expose both
features at the same time. If so, it indicates unreliable hardware. In
such cases, XSAVE should be disabled entirely as a precautionary measure.

Add a sanity check to detect this condition and disable XSAVE if an
invalid hardware configuration is identified.

Note: MPX state components remain enabled on legacy systems solely for
KVM guest support.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-4-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index dfd07af..14f5c1b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -814,6 +814,17 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	if (fpu_kernel_cfg.max_features & XFEATURE_MASK_APX &&
+	    fpu_kernel_cfg.max_features & (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR)) {
+		/*
+		 * This is a problematic CPU configuration where two
+		 * conflicting state components are both enumerated.
+		 */
+		pr_err("x86/fpu: Both APX/MPX present in the CPU's xstate features: 0x%llx, disabling XSAVE.\n",
+		       fpu_kernel_cfg.max_features);
+		goto out_disable;
+	}
+
 	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
 					      XFEATURE_MASK_INDEPENDENT;
 

