Return-Path: <linux-tip-commits+bounces-4788-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35373A823E8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D007B8357
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407CD25EF97;
	Wed,  9 Apr 2025 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EghB5Ni2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBItUrza"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9B25E46A;
	Wed,  9 Apr 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199069; cv=none; b=NwyNtWlQVxTXXcyMWnOdC4SXHTptRIFaZZAzRKKOHzse4pyCwm5hAGi5iAGnlkUdTIY30hZXt1hieG76rX+CbV1Iozhbz/wn05NBbiUBsnW3MvAkK27fUe1HGWWK7urrczbXElWyaP3SDrauuADNZNu8kFp1IbWOl+r/t1aRAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199069; c=relaxed/simple;
	bh=Y6GcMKcCqNyBbDIDQwbvNYStMieKcZ2jn7prB87kqjY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S21mEoouWMadVBmE4RINP4drfvHMOWGwSO6Zi5wFoWetpOumfhRrLfBQnCrs8SLsDiWl0WxbOsKClJROmw1aZZx4rklKwQmoepiiLTTqWVmBUr5V7BKCBus2Op2mDD3zCRAwZ40sGb9lXEWpOI5Y82TwAL5Brecj7AjX6xLZ1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EghB5Ni2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBItUrza; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:44:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744199065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5N4SIsMP1iBn0ZhJ/u3AKuEDGC7TFeKQOEOaIYX6d4=;
	b=EghB5Ni20uKa+7CVQ4lLH3W7c7Do8WgmS/vNjfhkAvlR7g1PZvryUXop3Fo20tpu7yhQoH
	I05MeWyLJ7XtTMJQUrWWrZprfho5ZZTOd5FLJDmVhsFayPCB/QTpPa1xpRi/zzN2/tarpW
	XpozeVEMhtuqBW+y97/JsuYhWjSkWOBWW3P7GNQ5fN3gdMvU+JgIBH04JZTgcCxdDX3Rmc
	foyJk9BpkBqOxa15b12Au3LEwYorKtwtsOVOmrSOjV5bmoJRkk8PRvR/SrurqlOtdHC8EC
	SVfvBMNLF66STzYMB7RDfZZlmXZXqxvvINU3edK18yzDHRjdmfZQkKrvCUTqMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744199065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5N4SIsMP1iBn0ZhJ/u3AKuEDGC7TFeKQOEOaIYX6d4=;
	b=OBItUrzazz4/iPQQ2rXbWClPmUgXfi0NyfUQM3CVJ+lonrpZ3HewAMRlnxoiHrLNbd+mwd
	PecZnN/JPDZepeCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Fix RSB clearing in
 indirect_branch_prediction_barrier()
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <bba68888c511743d4cd65564d1fc41438907523f.1744148254.git.jpoimboe@kernel.org>
References:
 <bba68888c511743d4cd65564d1fc41438907523f.1744148254.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419906465.31282.1403799089359507668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b1b19cfcf4656c75088dc06b7499f493e0dec3e5
Gitweb:        https://git.kernel.org/tip/b1b19cfcf4656c75088dc06b7499f493e0dec3e5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 14:47:32 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:41:30 +02:00

x86/bugs: Fix RSB clearing in indirect_branch_prediction_barrier()

IBPB is expected to clear the RSB.  However, if X86_BUG_IBPB_NO_RET is
set, that doesn't happen.  Make indirect_branch_prediction_barrier()
take that into account by calling write_ibpb() which clears RSB on
X86_BUG_IBPB_NO_RET:

	/* Make sure IBPB clears return stack preductions too. */
	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_BUG_IBPB_NO_RET

Note that, as of the previous patch, write_ibpb() also reads
'x86_pred_cmd' in order to use SBPB when applicable:

	movl	_ASM_RIP(x86_pred_cmd), %eax

Therefore that existing behavior in indirect_branch_prediction_barrier()
is not lost.

Fixes: 50e4b3b94090 ("x86/entry: Have entry_ibpb() invalidate return predictions")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/bba68888c511743d4cd65564d1fc41438907523f.1744148254.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h | 6 +++---
 arch/x86/kernel/cpu/bugs.c           | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 591d1db..5c43f14 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -514,11 +514,11 @@ void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 		: "memory");
 }
 
-extern u64 x86_pred_cmd;
-
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_msr_write(MSR_IA32_PRED_CMD, x86_pred_cmd, X86_FEATURE_IBPB);
+	asm_inline volatile(ALTERNATIVE("", "call write_ibpb", X86_FEATURE_IBPB)
+			    : ASM_CALL_CONSTRAINT
+			    :: "rax", "rcx", "rdx", "memory");
 }
 
 /* The Intel SPEC CTRL MSR base value cache */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 608bbe6..9926509 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -59,7 +59,6 @@ DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
 EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
-EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
 static u64 __ro_after_init x86_arch_cap_msr;
 

