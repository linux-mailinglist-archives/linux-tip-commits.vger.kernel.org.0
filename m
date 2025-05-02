Return-Path: <linux-tip-commits+bounces-5174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F14AA6DB4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131C13BE6AA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC826A0F3;
	Fri,  2 May 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9iLRU3s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvBEZwxY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BD267721;
	Fri,  2 May 2025 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176675; cv=none; b=gYIe5xTSBODPB+Lywj15gMYZHUrDrSGXWjnkE1NcD+LqlroIxSSBbFo46UjT8Br1cTBWvTk/138A/qvUZAiZVzBWovIjnJmj28sRi/UxM+zcK2opPezaQSUnlxfhVBqYPKmMFCArjBzYaYwX00JTXEo3T1FoVaTsQCrs2tlLliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176675; c=relaxed/simple;
	bh=ce4/il1Jsc2hWgloEYtkUAJ83yOvgHK5zL9hxj7m+cY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H57Xba6ttUS2iHxEfO0NZ4qDZ6A3WAuUdGN2Z46G5ly23N5IP/a0YWBRfA4HxYt5meu+panroUmXGC6yhUKEkFJ7NnNjEsQ7btbhhy0DkFUIgOnmjTGfGT89Zla2HPPjUjHRFJB9/VVJCnpO9gjb/iqQjj0MmnFHzH7bvqUdL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9iLRU3s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XvBEZwxY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RopC7V2EM8tnXXziN0UcEBr1L4lmgNPPISwHFOC2Yuc=;
	b=m9iLRU3s2L++NJwVMO3COX33p4hAxj+ZM0aRlqcx8ID2sQEyuJjgfdhSZSQK74PHg5AxO6
	EI+EVGFDlzeMbSZNcYXG3hE/Molj4IltugH+1RoxElTEKUi9YF8anGD44OQLi6DUWPrFTU
	08q5cBZ5KlNlKmvrPmnI9DaKw9nvrQWq+De1wOQvv9jJjXGRdYDPqIugedU2diBdh3fck2
	KRV9VwJkwe0W+yLAICmqwxOPohcdfn7nHVWqS2Sc0mAzO4tF9Rg5J2lnOY68nmpOV3O+G0
	m9RVMMo9qVfXc4VVfvpLCQsabIvzx8FjYsmUwNL6r6LRDMIkGNaQHeARrmQkyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RopC7V2EM8tnXXziN0UcEBr1L4lmgNPPISwHFOC2Yuc=;
	b=XvBEZwxYl9lGo9lV8mSPQbXeAfEz/jbS4/3M2z2eMJeGyE9JkbzAQuK5w39LEypcreg/uN
	5p3/AxqJGhqVuuBA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/msr: Remove the unused rdpmc() method
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-4-xin@zytor.com>
References: <20250427092027.1598740-4-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666670.22196.10268361923190087856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     91882511ef905fdfb7d33be88f6ddb91012ee30f
Gitweb:        https://git.kernel.org/tip/91882511ef905fdfb7d33be88f6ddb91012ee30f
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:25:04 +02:00

x86/msr: Remove the unused rdpmc() method

rdpmc() is not used anywhere anymore, remove it.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-4-xin@zytor.com
---
 arch/x86/include/asm/msr.h      | 7 -------
 arch/x86/include/asm/paravirt.h | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index f5c0969..07d45fc 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -217,13 +217,6 @@ static inline int rdmsrq_safe(u32 msr, u64 *p)
 	return err;
 }
 
-#define rdpmc(counter, low, high)			\
-do {							\
-	u64 _l = native_read_pmc((counter));		\
-	(low)  = (u32)_l;				\
-	(high) = (u32)(_l >> 32);			\
-} while (0)
-
 #define rdpmcl(counter, val) ((val) = native_read_pmc(counter))
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 86a7752..c4dedb9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -244,13 +244,6 @@ static inline u64 paravirt_read_pmc(int counter)
 	return PVOP_CALL1(u64, cpu.read_pmc, counter);
 }
 
-#define rdpmc(counter, low, high)		\
-do {						\
-	u64 _l = paravirt_read_pmc(counter);	\
-	low = (u32)_l;				\
-	high = _l >> 32;			\
-} while (0)
-
 #define rdpmcl(counter, val) ((val) = paravirt_read_pmc(counter))
 
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)

