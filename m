Return-Path: <linux-tip-commits+bounces-5168-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D5AA6DA2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220883B3D09
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4166246786;
	Fri,  2 May 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ozvgcL3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BoA+H4OO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4322367B3;
	Fri,  2 May 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176669; cv=none; b=EzobzKg88B7iWSIKktzcXkPp03YBfU4A5jI9kAXfd1S009uC4XHF7gh74kG5U5q0zPHJd4XFSv4Z+naju7kklepwtrXHOw06kXuxLCx22zgLklw8ukrVk1is9uH7bcvi69sLoml4Vgueezn1447G8hwFE6Yg8PkT7uiF/+qXkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176669; c=relaxed/simple;
	bh=ZS4sQ4S8RkaynZSHbCGiK47rbtSfj7Hjse2DzOkupfU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fWQAfKSm22xSU28kEtXnpl+Pz14wnGSABKtAhxFy+ipQTBvXLXIded5IqQCWpXgYJo45ZwwUQ9SD3LAuMJYYxm0+0M5weyECZFVo3VuAzGu+NQtFQDa1N1S3auDPOA/HIOU3RBGNeSXMBXfUkf+DbcVLb5C3xLQbRZvw+2+fzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ozvgcL3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BoA+H4OO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWNB5n+U58bb+aYPGid2PLsRGdeB9KKHfnFlwW2Tca8=;
	b=3ozvgcL33l85bqR7z3C9KnuA9cSiMUpcM5U6O7STXob8GiBEowDqb8XBb2JJfHM9l3Hg+a
	nvpR+Hq10E0xFIe//1cI2kOmwD7wOSS6m2HgOKyTSmEOLNnyY7l9jRynoppNy2McIrfW+9
	PWdMmNEnBMUQxk/e4LkfFAfDJYou8BLQSE/2ChGflxHZMvozJdOugE3NUex+f+H5zqPnIV
	orMolgKlNLCCpwiBb2BQP6vMQ2lu298eEIsZUt4IIpIesnxtTGD3ABvL+mGWFFBCS4mBq1
	Q0PPb1GrYskCUllTg5scSVjoEdIDjhymoE5duGMtUgJus2JeVNbtHdjC+4zwSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWNB5n+U58bb+aYPGid2PLsRGdeB9KKHfnFlwW2Tca8=;
	b=BoA+H4OOb1SvaGb7IsIVThSh9nyonC3n7+R92/+A8aGuLIfKQBwBzXoMcbK9m6WdVGLrFZ
	owqCoGzieNWM1kAg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/xen/msr: Return u64 consistently in Xen PMC
 xen_*_read functions
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-7-xin@zytor.com>
References: <20250427092027.1598740-7-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666440.22196.6953094631255737294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     5afa4cf54518b26e18d7b7ce2e9d9724f9cb9324
Gitweb:        https://git.kernel.org/tip/5afa4cf54518b26e18d7b7ce2e9d9724f9cb9324
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:27:22 +02:00

x86/xen/msr: Return u64 consistently in Xen PMC xen_*_read functions

The pv_ops PMC read API is defined as:

        u64 (*read_pmc)(int counter);

But Xen PMC read functions return 'unsigned long long', make them
return u64 consistently.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-7-xin@zytor.com
---
 arch/x86/xen/pmu.c     | 6 +++---
 arch/x86/xen/xen-ops.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 3cb566d..3c01fba 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -347,7 +347,7 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 	return true;
 }
 
-static unsigned long long xen_amd_read_pmc(int counter)
+static u64 xen_amd_read_pmc(int counter)
 {
 	struct xen_pmu_amd_ctxt *ctxt;
 	uint64_t *counter_regs;
@@ -367,7 +367,7 @@ static unsigned long long xen_amd_read_pmc(int counter)
 	return counter_regs[counter];
 }
 
-static unsigned long long xen_intel_read_pmc(int counter)
+static u64 xen_intel_read_pmc(int counter)
 {
 	struct xen_pmu_intel_ctxt *ctxt;
 	uint64_t *fixed_counters;
@@ -397,7 +397,7 @@ static unsigned long long xen_intel_read_pmc(int counter)
 	return arch_cntr_pair[counter].counter;
 }
 
-unsigned long long xen_read_pmc(int counter)
+u64 xen_read_pmc(int counter)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return xen_amd_read_pmc(counter);
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 25e318e..dc886c3 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -274,7 +274,7 @@ static inline void xen_pmu_finish(int cpu) {}
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err);
 bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err);
 int pmu_apic_update(uint32_t reg);
-unsigned long long xen_read_pmc(int counter);
+u64 xen_read_pmc(int counter);
 
 #ifdef CONFIG_SMP
 

