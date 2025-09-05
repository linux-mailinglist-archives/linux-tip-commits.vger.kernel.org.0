Return-Path: <linux-tip-commits+bounces-6494-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F5B463A6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 21:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9183BB2D9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9049827814A;
	Fri,  5 Sep 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/vr7Oav";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rSPc+n2D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7E1ADC97;
	Fri,  5 Sep 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100790; cv=none; b=TBmToPtHfCGMeXNz1ghSpw6fWUdPQjvLsIqFeeZqAswxUhSANTnaZIWaSSdn9C9KnmVARLYr7WkJcLND8laxMWk5wAQqeI7unQsONBRoTwz6YEaX7P+TIkZULqM+Jn9u41hWxIOdCA/bh9qW7PxjOCYPDwEiqxIj4P09/LlgFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100790; c=relaxed/simple;
	bh=+8u/KZiIpgsuvmdpT0jzcGifxPiDjcl+HGyQGZO7e/c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=q4p7CeQqLYbk5G9b5VWCguIzrHNXtSMorEpS9Zztc4Ox3brT8Ptq5vOcHN3Fyza7tQxUuD+nsFE/akM+Tt0w6eW6vcPoMWhxsTR8xmdJk0RPjUVmpBQFZiiz7rMCPZf2JSYl95U8vmz6p0dlR/j90hzquyu86gdSlTfQiXZ+HAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/vr7Oav; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rSPc+n2D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 19:33:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757100786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hSdSIcSInoehyBkz+fWc+SORoj/vrx1sYUOHa3ILjX0=;
	b=h/vr7Oavj5vGfaqIMZPr/YLTceafMSdSAjXrGOLGdC3BVEJRfIzd65xuJze+2MuIp5sf8j
	O7muSQ9UfZcmI4xOf9brEM0b+OwY33WT2yKeEJejLMUJjU+P3FswCvJgNBoXOVdWYXH60/
	23pY3JdHSsIeZyRt5cbCF9hvvwLrIof9SUCZGdBk3zcvjVefbfvNSVDOPKwS3YI3d5uku0
	fhkeTwLcxctM2etMrz+f5/KDGYoDlfZF0lmHXNb0gEGLpyfb3P0d5qfBv+//igbhX2XH/l
	Ui8UcgyrF2+9YWk+W2z57sKq1eFhCN5Ma/jFGzfLnA3GKV/JOUna4jePmfaPcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757100786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hSdSIcSInoehyBkz+fWc+SORoj/vrx1sYUOHa3ILjX0=;
	b=rSPc+n2DbR2/lzRgu3eu5Dn46l12uclXv1yEfxE3IBEvjUs+6iEtRQSZn3zySdRsuBt97B
	mmHlKF2YUaGMLfCw==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/tdx] KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs
Cc: Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Farrah Chen <farrah.chen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175710078473.1920.4613730592644125505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     61221d07e815008ba758995d79fd442b5217f51a
Gitweb:        https://git.kernel.org/tip/61221d07e815008ba758995d79fd442b521=
7f51a
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Mon, 01 Sep 2025 18:09:30 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 05 Sep 2025 10:40:41 -07:00

KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs

On TDX platforms, during kexec, the kernel needs to make sure there
are no dirty cachelines of TDX private memory before booting to the new
kernel to avoid silent memory corruption to the new kernel.

To do this, the kernel has a percpu boolean to indicate whether the
cache of a CPU may be in incoherent state.  During kexec, namely in
stop_this_cpu(), the kernel does WBINVD if that percpu boolean is true.
TDX turns on that percpu boolean on a CPU when the kernel does SEAMCALL,
Thus making sure the cache will be flushed during kexec.

However, kexec has a race condition that, while remaining extremely rare,
would be more likely in the presence of a relatively long operation such
as WBINVD.

In particular, the kexec-ing CPU invokes native_stop_other_cpus()
to stop all remote CPUs before booting to the new kernel.
native_stop_other_cpus() then sends a REBOOT vector IPI to remote CPUs
and waits for them to stop; if that times out, it also sends NMIs to the
still-alive CPUs and waits again for them to stop.  If the race happens,
kexec proceeds before all CPUs have processed the NMI and stopped[1],
and the system hangs.

But after tdx_disable_virtualization_cpu(), no more TDX activity
can happen on this cpu.  When kexec is enabled, flush the cache
explicitly at that point; this moves the WBINVD to an earlier stage than
stop_this_cpus(), avoiding a possibly lengthy operation at a time where
it could cause this race.

[1] https://lore.kernel.org/kvm/b963fcd60abe26c7ec5dc20b42f1a2ebbcc72397.1750=
934177.git.kai.huang@intel.com/

[Make the new function a stub for !CONFIG_KEXEC_CORE. - Paolo]
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/all/20250901160930.1785244-8-pbonzini%40redhat.=
com
---
 arch/x86/include/asm/tdx.h  |  6 ++++++
 arch/x86/kvm/vmx/tdx.c      | 10 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index c178360..6120461 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -228,5 +228,11 @@ static inline const char *tdx_dump_mce_info(struct mce *=
m) { return NULL; }
 static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL=
; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
=20
+#ifdef CONFIG_KEXEC_CORE
+void tdx_cpu_flush_cache_for_kexec(void);
+#else
+static inline void tdx_cpu_flush_cache_for_kexec(void) { }
+#endif
+
 #endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f457b2e..04b6d33 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -423,6 +423,16 @@ void tdx_disable_virtualization_cpu(void)
 		tdx_flush_vp(&arg);
 	}
 	local_irq_restore(flags);
+
+	/*
+	 * Flush cache now if kexec is possible: this is necessary to avoid
+	 * having dirty private memory cachelines when the new kernel boots,
+	 * but WBINVD is a relatively expensive operation and doing it during
+	 * kexec can exacerbate races in native_stop_other_cpus().  Do it
+	 * now, since this is a safe moment and there is going to be no more
+	 * TDX activity on this CPU from this point on.
+	 */
+	tdx_cpu_flush_cache_for_kexec();
 }
=20
 #define TDX_SEAMCALL_RETRIES 10000
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2abf53e..330b560 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1872,3 +1872,22 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page =
*page)
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_hkid);
+
+#ifdef CONFIG_KEXEC_CORE
+void tdx_cpu_flush_cache_for_kexec(void)
+{
+	lockdep_assert_preemption_disabled();
+
+	if (!this_cpu_read(cache_state_incoherent))
+		return;
+
+	/*
+	 * Private memory cachelines need to be clean at the time of
+	 * kexec.  Write them back now, as the caller promises that
+	 * there should be no more SEAMCALLs on this CPU.
+	 */
+	wbinvd();
+	this_cpu_write(cache_state_incoherent, false);
+}
+EXPORT_SYMBOL_GPL(tdx_cpu_flush_cache_for_kexec);
+#endif

