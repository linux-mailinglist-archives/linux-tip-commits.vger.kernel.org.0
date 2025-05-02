Return-Path: <linux-tip-commits+bounces-5164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F002AAA6D90
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29944C1AD6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3362309AA;
	Fri,  2 May 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olF66gdB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cEgk4C1z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186022D78B;
	Fri,  2 May 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176665; cv=none; b=ncX62BD8wU7IzH4yKbFRn+C/Csnqk14/Yse+zTv0jRIzGoz/J6ej9qUzhUNTRtyN4UI0dgOWtrN3rZcK14BIcYqcHi0nain2sjr5p5rm7LGj+AKbn0mASlR0BgW/qXovUgIsSmm66IA7cAbX5w38AFw8+Kk3WZY0NOEPLWwzbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176665; c=relaxed/simple;
	bh=QU4Co/SiX/1JUS3xdc2zSbdRe3IGb/vmTUiSYKWTkkU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V4jbzECcSi6svJxUM67FpCWbAUMPvomeRRx7VuGwiIN3uoeFezNlurLZpSXsu1qHsFqm37Qhx6gtrOgqcCbCiaatQRNaGiqE449tUadpPEuXO2GEF3Syt88LnCHfYLkp5A4m7YaPXJ2oUat10z/1wayD3gyQAjfcP+lJ6bVPoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olF66gdB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cEgk4C1z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DX4q/oZrWYVFNYipoaEElNKiSDClpqxdvKWGsW1aKGw=;
	b=olF66gdBAvgjY8cNy9ogGqK4yyeY7hO8JUKgiTRjmeyxEPSqWOXhmhtZk3EiTDV/Pu9z0v
	R2MM6nokXlOpP2nAIKff/hviWz4ZES7fqfHY3dsgGalPrME4JtmvHyMLoBOELyUPPOxi8j
	ilPtj308vvrbckCIlQXZ2yICEDdsYYLk0C5fcD9MaiFmjsVJuS7nO+XVGivnCIEr9M9C0R
	QTIEK8+3ng7qwMvN2xoiWKIIQmNxII5N+UJIJewkaAtA7GNDYbk5flpmC0NQW9JBvbchni
	EXvJNdlms9XQJyxhRBMLpOEfT0HF82TuoRm4NYMPHrHR6URC8ghMZLTY5d5uaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DX4q/oZrWYVFNYipoaEElNKiSDClpqxdvKWGsW1aKGw=;
	b=cEgk4C1z8bXVCMKI/MMDhYxymMlpDnz96iba2HhpAHEY/4uGiHLmSk4cJ4oJ0DJ4AxM5qH
	YnADTMoISYdPluAA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/xen/msr: Remove pmu_msr_{read,write}()
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-12-xin@zytor.com>
References: <20250427092027.1598740-12-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666013.22196.7109101589277660040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     f7998621db691b6fad4d84ad7d8ecc1a0a9b703f
Gitweb:        https://git.kernel.org/tip/f7998621db691b6fad4d84ad7d8ecc1a0a9b703f
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:23 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:35 +02:00

x86/xen/msr: Remove pmu_msr_{read,write}()

As pmu_msr_{read,write}() are now wrappers of pmu_msr_chk_emulated(),
remove them and use pmu_msr_chk_emulated() directly.

As pmu_msr_chk_emulated() could easily return false in the cases where
it would set *emul to false, remove the "emul" argument and use the
return value instead.

While at it, convert the data type of MSR index to u32 in functions
called in pmu_msr_chk_emulated().

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Suggested-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-12-xin@zytor.com
---
 arch/x86/xen/enlighten_pv.c | 15 ++++++++-------
 arch/x86/xen/pmu.c          | 33 ++++++++-------------------------
 arch/x86/xen/xen-ops.h      |  3 +--
 3 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 530b59b..719370d 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1091,7 +1091,7 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
 {
 	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
 
-	if (pmu_msr_read_emulated(msr, &val))
+	if (pmu_msr_chk_emulated(msr, &val, true))
 		return val;
 
 	if (err)
@@ -1163,12 +1163,13 @@ static void xen_do_write_msr(unsigned int msr, unsigned int low,
 	default:
 		val = (u64)high << 32 | low;
 
-		if (!pmu_msr_write_emulated(msr, val)) {
-			if (err)
-				*err = native_write_msr_safe(msr, low, high);
-			else
-				native_write_msr(msr, low, high);
-		}
+		if (pmu_msr_chk_emulated(msr, &val, false))
+			return;
+
+		if (err)
+			*err = native_write_msr_safe(msr, low, high);
+		else
+			native_write_msr(msr, low, high);
 	}
 }
 
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 0062dbb..043d72b 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -129,7 +129,7 @@ static inline uint32_t get_fam15h_addr(u32 addr)
 	return addr;
 }
 
-static inline bool is_amd_pmu_msr(unsigned int msr)
+static bool is_amd_pmu_msr(u32 msr)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
@@ -195,8 +195,7 @@ static bool is_intel_pmu_msr(u32 msr_index, int *type, int *index)
 	}
 }
 
-static bool xen_intel_pmu_emulate(unsigned int msr, u64 *val, int type,
-				  int index, bool is_read)
+static bool xen_intel_pmu_emulate(u32 msr, u64 *val, int type, int index, bool is_read)
 {
 	uint64_t *reg = NULL;
 	struct xen_pmu_intel_ctxt *ctxt;
@@ -258,7 +257,7 @@ static bool xen_intel_pmu_emulate(unsigned int msr, u64 *val, int type,
 	return false;
 }
 
-static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
+static bool xen_amd_pmu_emulate(u32 msr, u64 *val, bool is_read)
 {
 	uint64_t *reg = NULL;
 	int i, off = 0;
@@ -299,33 +298,17 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 	return false;
 }
 
-static bool pmu_msr_chk_emulated(unsigned int msr, uint64_t *val, bool is_read,
-				 bool *emul)
+bool pmu_msr_chk_emulated(u32 msr, u64 *val, bool is_read)
 {
 	int type, index = 0;
 
 	if (is_amd_pmu_msr(msr))
-		*emul = xen_amd_pmu_emulate(msr, val, is_read);
-	else if (is_intel_pmu_msr(msr, &type, &index))
-		*emul = xen_intel_pmu_emulate(msr, val, type, index, is_read);
-	else
-		return false;
-
-	return true;
-}
-
-bool pmu_msr_read_emulated(u32 msr, u64 *val)
-{
-	bool emulated;
+		return xen_amd_pmu_emulate(msr, val, is_read);
 
-	return pmu_msr_chk_emulated(msr, val, true, &emulated) && emulated;
-}
+	if (is_intel_pmu_msr(msr, &type, &index))
+		return xen_intel_pmu_emulate(msr, val, type, index, is_read);
 
-bool pmu_msr_write_emulated(u32 msr, u64 val)
-{
-	bool emulated;
-
-	return pmu_msr_chk_emulated(msr, &val, false, &emulated) && emulated;
+	return false;
 }
 
 static u64 xen_amd_read_pmc(int counter)
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 2de3061..090349b 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -271,8 +271,7 @@ void xen_pmu_finish(int cpu);
 static inline void xen_pmu_init(int cpu) {}
 static inline void xen_pmu_finish(int cpu) {}
 #endif
-bool pmu_msr_read_emulated(u32 msr, u64 *val);
-bool pmu_msr_write_emulated(u32 msr, u64 val);
+bool pmu_msr_chk_emulated(u32 msr, u64 *val, bool is_read);
 int pmu_apic_update(uint32_t reg);
 u64 xen_read_pmc(int counter);
 

