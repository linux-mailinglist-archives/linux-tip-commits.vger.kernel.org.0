Return-Path: <linux-tip-commits+bounces-4313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A6A67C5C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8122C8835C1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4F213E97;
	Tue, 18 Mar 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6c5NdhH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+xOW/1CL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144621325A;
	Tue, 18 Mar 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324078; cv=none; b=D7R4DU8baR3DZE8wJKMK9BO1ghO3RVVPnILwTa5I1XMT+RvxazDKwi+0eO0hSVjsEnMzdxkTd8evrMbNUuwuqvNGy8HoC0TZTAahnZcvRb6GlNh3BD34H90HTwTlRPnzJ2MfJkT9WdsW9wOiOeZw6Lj5qvGkucga229hovLNZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324078; c=relaxed/simple;
	bh=rdV2IFVal0vHho+Ac52rLBhOprxuRxebIfQk994+M3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W2eJs6RHhymB0ygCF+7bFO+Yk2BxM1OdvqP1wDy/2QqHSWupED3REU2Z7YepK9PSi7T6BRiU7QB1HvaaT3nJcEX8TM3wKrji5/iA6/blHSl79AvNdGhU14Fc1+rZ8wFmNgcK4DXFQNaPUEMrjOB6ivwIE1C+CR9FSYHcBG93TtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P6c5NdhH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+xOW/1CL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbqC0gdNieGoijaNXyrUKe3i6OQ7N183yUPg4x4lGsc=;
	b=P6c5NdhH6ut3N0gtR6F4KdCdurlf6t1dLLRZKX3RsXBHUkvZkT5bTbvVOfvH0lXpTarSWK
	fSgk3IxxbdKqYFj33p0M3tppgqcsRQGwCyy72vYPlBYLDZRxvRDE+rtxm8U4SbQ9iuAiy5
	71YC69lgVBVfg/Bwcxbimkl50XThwI6GXW0t0OEX8zNC7rjo/8ZMncnV9HIsFZO11Nkmvs
	XWJ2LfL3cqxMRlYgdjGYV7HKqo2TtE3ypsr9THIrnN2qNYpmK23ggTmve1Fb2Et7J5ttve
	78o3ht5FjwfFjWCx+bWQjgbDJAyfBxr5bdq/lJzmEK/MdWTaXfOiZ9lty3JbKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbqC0gdNieGoijaNXyrUKe3i6OQ7N183yUPg4x4lGsc=;
	b=+xOW/1CLtkMmixpcs/tyA1sUs5dTFwnELApZnvhDSuDshNT5CD7WcWkfxssHwpdCo2q1M7
	wY+X+3uV9Br9ScAQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/microcode: Update the Intel processor flag scan check
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-4-sohil.mehta@intel.com>
References: <20250219184133.816753-4-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232407439.14745.4657850819753739092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     faeaa39c37c9334f0b57f551c106a54be387b524
Gitweb:        https://git.kernel.org/tip/faeaa39c37c9334f0b57f551c106a54be387b524
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:21 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:45 +01:00

x86/microcode: Update the Intel processor flag scan check

The Family model check to read the processor flag MSR is misleading and
potentially incorrect. It doesn't consider Family while comparing the
model number. The original check did have a Family number but it got
lost/moved during refactoring.

intel_collect_cpu_info() is called through multiple paths such as early
initialization, CPU hotplug as well as IFS image load. Some of these
flows would be error prone due to the ambiguous check.

Correct the processor flag scan check to use a Family number and update
it to a VFM based one to make it more readable.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-4-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h   | 1 +
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b657d78..f0e7ed0 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -46,6 +46,7 @@
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f3d5348..819199b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -74,7 +74,7 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
 	sig->pf = 0;
 	sig->rev = intel_get_microcode_revision();
 
-	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+	if (IFM(x86_family(sig->sig), x86_model(sig->sig)) >= INTEL_PENTIUM_III_DESCHUTES) {
 		unsigned int val[2];
 
 		/* get processor flags from MSR 0x17 */

