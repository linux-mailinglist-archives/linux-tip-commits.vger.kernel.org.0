Return-Path: <linux-tip-commits+bounces-6066-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9FEB005A0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4231C47968
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EF2749C0;
	Thu, 10 Jul 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jpzxchlS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wq1f9naj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125E274676;
	Thu, 10 Jul 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158871; cv=none; b=h1jayKGuRIuzuzl+lOoOvnpw+LahEs2mDmpwUyQJVzE3Kov9MptsG5pqRT5advSy/k1E4j00xq+OpU0kvJ9evw6XVYcUxGqiw8gzZ8jyPQsMD02VH2DsY1QMqntaa8jD7g43byM2CgOl/EM94CoKoCADKwTGiS4zK/jLzFwLvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158871; c=relaxed/simple;
	bh=IleIfbWg8j62z7UFu1OIt42/M6hDSZH5CEQx48OOwYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jsBE0hZRdB+3ChyHct6iiheClXDmPZYDidn7W8/Khg4BaeelseYTyUkQRB/MX2G2Q/GgZU7HrRO18ysFzAugu9UV1t/MwQPL9fSly3c6+lYIHqN//zqzOVEJ+AxYt1Ww3Wm4sxkekKcRUdcYkB/kzttDv7tZTYgq6cwTv9h/WvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jpzxchlS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wq1f9naj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 14:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752158867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDXQSfzcIDd7KHtWsZxeYcbG57KInhV8gWfAownWTl8=;
	b=jpzxchlSWZ0rTXItIeqijiKSuDK7wgDYVTRmztyyNZkYQgc+MnvsuY6kBu0k7wrymVEmkN
	7rxDsKnMwgrL9lebndDjgwpcJJx4mnvoJI/VrbyUZIyzwWcocHg3LKh+kBCw3syqqx9d+x
	4dO5aqRoJeMOKHnmaeGWciKYv1Hwyn3Bg1afFW2EXZ6Ai03bEo8U3hOkHewopnsIEjkeUi
	QszhfRaaiKKAXxdV/oBCjxXAdqz6X/YzuleJ7VwUrXRCGfAajgh0osTGxTSaXOLnpgUs4S
	Inhyz18ET4xXhhw6gN2pmwo6K547AmWXc00e/uAMqPdXaH4HJOuOSOHLdoz1LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752158867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDXQSfzcIDd7KHtWsZxeYcbG57KInhV8gWfAownWTl8=;
	b=wq1f9najDaCwF3UUdsEGVf3sfSF48B9cDyVl2biriTXzb0o5ySS7SrdCoiO2QHLpoN4d03
	8xDDg39z+d68a3Dw==
From: "tip-bot2 for Zheyun Shen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/lib: Add WBINVD and WBNOINVD helpers to target
 multiple CPUs
Cc: Zheyun Shen <szy0127@sjtu.edu.cn>, Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250522233733.3176144-5-seanjc@google.com>
References: <20250522233733.3176144-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215886584.406.10370603448880022710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4fdc3431e03b9c11803f399f91837fca487029a1
Gitweb:        https://git.kernel.org/tip/4fdc3431e03b9c11803f399f91837fca487029a1
Author:        Zheyun Shen <szy0127@sjtu.edu.cn>
AuthorDate:    Thu, 22 May 2025 16:37:28 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Jul 2025 13:30:17 +02:00

x86/lib: Add WBINVD and WBNOINVD helpers to target multiple CPUs

Extract KVM's open-coded calls to do writeback caches on multiple CPUs to
common library helpers for both WBINVD and WBNOINVD (KVM will use both).
Put the onus on the caller to check for a non-empty mask to simplify the
SMP=n implementation, e.g. so that it doesn't need to check that the one
and only CPU in the system is present in the mask.

  [sean: move to lib, add SMP=n helpers, clarify usage]

Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/r/20250128015345.7929-2-szy0127@sjtu.edu.cn
Link: https://lore.kernel.org/20250522233733.3176144-5-seanjc@google.com
---
 arch/x86/include/asm/smp.h | 12 ++++++++++++
 arch/x86/kvm/x86.c         |  3 +--
 arch/x86/lib/cache-smp.c   | 12 ++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e08f1ae..22bfebe 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -113,7 +113,9 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 void wbinvd_on_all_cpus(void);
+void wbinvd_on_cpus_mask(struct cpumask *cpus);
 void wbnoinvd_on_all_cpus(void);
+void wbnoinvd_on_cpus_mask(struct cpumask *cpus);
 
 void smp_kick_mwait_play_dead(void);
 void __noreturn mwait_play_dead(unsigned int eax_hint);
@@ -154,11 +156,21 @@ static inline void wbinvd_on_all_cpus(void)
 	wbinvd();
 }
 
+static inline void wbinvd_on_cpus_mask(struct cpumask *cpus)
+{
+	wbinvd();
+}
+
 static inline void wbnoinvd_on_all_cpus(void)
 {
 	wbnoinvd();
 }
 
+static inline void wbnoinvd_on_cpus_mask(struct cpumask *cpus)
+{
+	wbnoinvd();
+}
+
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a9d992d..5a2160f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8289,8 +8289,7 @@ static int kvm_emulate_wbinvd_noskip(struct kvm_vcpu *vcpu)
 		int cpu = get_cpu();
 
 		cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
-		on_each_cpu_mask(vcpu->arch.wbinvd_dirty_mask,
-				wbinvd_ipi, NULL, 1);
+		wbinvd_on_cpus_mask(vcpu->arch.wbinvd_dirty_mask);
 		put_cpu();
 		cpumask_clear(vcpu->arch.wbinvd_dirty_mask);
 	} else
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 74e0d5b..c5c60d0 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -20,6 +20,12 @@ void wbinvd_on_all_cpus(void)
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
 
+void wbinvd_on_cpus_mask(struct cpumask *cpus)
+{
+	on_each_cpu_mask(cpus, __wbinvd, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(wbinvd_on_cpus_mask);
+
 static void __wbnoinvd(void *dummy)
 {
 	wbnoinvd();
@@ -30,3 +36,9 @@ void wbnoinvd_on_all_cpus(void)
 	on_each_cpu(__wbnoinvd, NULL, 1);
 }
 EXPORT_SYMBOL_GPL(wbnoinvd_on_all_cpus);
+
+void wbnoinvd_on_cpus_mask(struct cpumask *cpus)
+{
+	on_each_cpu_mask(cpus, __wbnoinvd, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(wbnoinvd_on_cpus_mask);

