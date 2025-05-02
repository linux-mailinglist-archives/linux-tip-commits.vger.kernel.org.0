Return-Path: <linux-tip-commits+bounces-5165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA66AA6D93
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAD31BC68F5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16C231856;
	Fri,  2 May 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mBrjKmN+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7xavM0w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8A22E412;
	Fri,  2 May 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176666; cv=none; b=SvS1z9NCylfm/ytMIn9J/z54SQdjWhEsz/wahnlORP9hkY9Uvk2m/9BF4fZoa4DiqpxTWDHQLsHdtbPJXhwvlDlKmZCmJc7W2TkL1MRkKhjFY6Di1rteImKg+czX5OsZkCW0iIXP4Hd/J85dqbILPl1SYHdSjeaKjG3Xt8SxZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176666; c=relaxed/simple;
	bh=2AmozFOjni2dUHfyxHJGpMVvxMMylwgijtSnvQiZZFs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=siQpcAUYp2kYipJJWaR8VoFCGRn6knCtPpdEEip6Yuo9VghMwtJpvDYXBy7OH08t4/W5T4elquk8qvv283cF+tSyYwPmiLfo9cPcQXENGS44EoEsgw8qPtATz/y9KoL+pCBKOtJOn7Ec2np9eaLPGVula/khEIdvxUttxyqB7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mBrjKmN+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7xavM0w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx3WHQz/vUbAeXXmu6E2bXpWh3bZqEh/RXSvd7rzHJQ=;
	b=mBrjKmN+2WJkIAHTFKBckhhMd8kVNxUBJym3cw2ig7b1fquYr4HA/Xs5LZNcBAJ3o3K4S9
	qEVsqRMTA7CNjGFfT+Z8F7ketJFaqSia7zHDE4njdguTKR2vEf22hvVCYGlOKRpJkgwGpp
	uirac0eMZtm8f+ANE2qaF+5Snj8OXdp3AFmS+2veUW+u9a1M0LrNUDa0W4ojFmTO7AysIo
	+B7ap/NWU3n7TAwZzTv+HlDQryJyDjekmPkqh5Mr9cm2f1GQEUO+m8sG+kOQeMLFOq1tBe
	I6uRKzsPPDxxezrXi7ETN0fs3FdIcOo+C8CymDHwQh8BEDUqMiTSUQbAwVBfmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx3WHQz/vUbAeXXmu6E2bXpWh3bZqEh/RXSvd7rzHJQ=;
	b=Q7xavM0wOvTUV2N7gZXM6H0mAb/QRyrPUJLQYPwffslLH6um4mWdV8sWcVCh/Eo7iEEUxK
	sjx9ts6tWvdk8cCQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/xen/msr: Remove calling
 native_{read,write}_msr{,_safe}() in pmu_msr_{read,write}()
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-11-xin@zytor.com>
References: <20250427092027.1598740-11-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666081.22196.7546626489676308152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     0cb6f4128a7d8dca9c9bb45f9ecbddcd5cf377aa
Gitweb:        https://git.kernel.org/tip/0cb6f4128a7d8dca9c9bb45f9ecbddcd5cf377aa
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:22 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:35 +02:00

x86/xen/msr: Remove calling native_{read,write}_msr{,_safe}() in pmu_msr_{read,write}()

hpa found that pmu_msr_write() is actually a completely pointless
function:

  https://lore.kernel.org/lkml/0ec48b84-d158-47c6-b14c-3563fd14bcc4@zytor.com/

all it does is shuffle some arguments, then calls pmu_msr_chk_emulated()
and if it returns true AND the emulated flag is clear then does
*exactly the same thing* that the calling code would have done if
pmu_msr_write() itself had returned true.

And pmu_msr_read() does the equivalent stupidity.

Remove the calls to native_{read,write}_msr{,_safe}() within
pmu_msr_{read,write}().  Instead reuse the existing calling code
that decides whether to call native_{read,write}_msr{,_safe}() based
on the return value from pmu_msr_{read,write}().  Consequently,
eliminate the need to pass an error pointer to pmu_msr_{read,write}().

While at it, refactor pmu_msr_write() to take the MSR value as a u64
argument, replacing the current dual u32 arguments, because the dual
u32 arguments were only used to call native_write_msr{,_safe}(), which
has now been removed.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
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
Link: https://lore.kernel.org/r/20250427092027.1598740-11-xin@zytor.com
---
 arch/x86/xen/enlighten_pv.c |  8 ++++++--
 arch/x86/xen/pmu.c          | 27 ++++-----------------------
 arch/x86/xen/xen-ops.h      |  4 ++--
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 8ddd9e5..530b59b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1091,7 +1091,7 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
 {
 	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
 
-	if (pmu_msr_read(msr, &val, err))
+	if (pmu_msr_read_emulated(msr, &val))
 		return val;
 
 	if (err)
@@ -1133,6 +1133,8 @@ static void set_seg(unsigned int which, unsigned int low, unsigned int high,
 static void xen_do_write_msr(unsigned int msr, unsigned int low,
 			     unsigned int high, int *err)
 {
+	u64 val;
+
 	switch (msr) {
 	case MSR_FS_BASE:
 		set_seg(SEGBASE_FS, low, high, err);
@@ -1159,7 +1161,9 @@ static void xen_do_write_msr(unsigned int msr, unsigned int low,
 		break;
 
 	default:
-		if (!pmu_msr_write(msr, low, high, err)) {
+		val = (u64)high << 32 | low;
+
+		if (!pmu_msr_write_emulated(msr, val)) {
 			if (err)
 				*err = native_write_msr_safe(msr, low, high);
 			else
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 3c01fba..0062dbb 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -314,37 +314,18 @@ static bool pmu_msr_chk_emulated(unsigned int msr, uint64_t *val, bool is_read,
 	return true;
 }
 
-bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
+bool pmu_msr_read_emulated(u32 msr, u64 *val)
 {
 	bool emulated;
 
-	if (!pmu_msr_chk_emulated(msr, val, true, &emulated))
-		return false;
-
-	if (!emulated) {
-		*val = err ? native_read_msr_safe(msr, err)
-			   : native_read_msr(msr);
-	}
-
-	return true;
+	return pmu_msr_chk_emulated(msr, val, true, &emulated) && emulated;
 }
 
-bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
+bool pmu_msr_write_emulated(u32 msr, u64 val)
 {
-	uint64_t val = ((uint64_t)high << 32) | low;
 	bool emulated;
 
-	if (!pmu_msr_chk_emulated(msr, &val, false, &emulated))
-		return false;
-
-	if (!emulated) {
-		if (err)
-			*err = native_write_msr_safe(msr, low, high);
-		else
-			native_write_msr(msr, low, high);
-	}
-
-	return true;
+	return pmu_msr_chk_emulated(msr, &val, false, &emulated) && emulated;
 }
 
 static u64 xen_amd_read_pmc(int counter)
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index dc886c3..2de3061 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -271,8 +271,8 @@ void xen_pmu_finish(int cpu);
 static inline void xen_pmu_init(int cpu) {}
 static inline void xen_pmu_finish(int cpu) {}
 #endif
-bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err);
-bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err);
+bool pmu_msr_read_emulated(u32 msr, u64 *val);
+bool pmu_msr_write_emulated(u32 msr, u64 val);
 int pmu_apic_update(uint32_t reg);
 u64 xen_read_pmc(int counter);
 

