Return-Path: <linux-tip-commits+bounces-5566-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE24AB9892
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 11:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCA94A199C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ECC230274;
	Fri, 16 May 2025 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3SZwQfM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MFbEseL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB322FAE1;
	Fri, 16 May 2025 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387149; cv=none; b=mezESp7iAX1hMd1rPIVXjf0DNIDB1a48+85hu3ikGLAgADc2qvLwxlYfMuIGM9tXGLFgPFvwbQ/AYdkpej6seTFLbU1symHSe48hUePYamvsEc9k5o93U1yx8rDN6GwGkSJ+Nwmwpa6A9D02HIYItjQwMejI6C4dGcYv7ZBPiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387149; c=relaxed/simple;
	bh=Gzy9ycnh4x38+Ab/+UxXnKGzpV70olbsyIAinWMRlv8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JFHRgx+BwC5eFyB+KVJmtkUgfhrevlBfcATV8OE+F8X3QhtsTyOoUaBpZRy5SAl33Q8Jc2ysGFCUvuWGv3NU+hbE41PuCBTzTL94zOIkNEJY9ix/E9wWxaeHGILf7Ji6Y0eIQLbnjSZI0LmMO+j0Z0ek7W2z3+dQEc/9lsuKhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3SZwQfM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MFbEseL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 09:19:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747387145;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3gijar6DsjhFRoqKfJa+IWDYBjfnmQDTkMSs9zyG2w=;
	b=F3SZwQfMJ48w3WflxQLSDw8hwBLjlgz+aonCJiOLoRnWBSD36vwpGHtbZe99LcXZmBS7sT
	a6o42u4sVV3ySc8NDyPpR2HSC4oUViVeBG2Ysy74zFyfIieK0t7zpWm/ZNjJhCqiE6Jmrt
	bcwvjqRyj3ucEQKYKaZhH7Ku28QX98G2zVcWXXbUjcjgrmbUB33KQnHbMtIb6M3g8UtiWV
	QPIE/Vn3oJ5GvZwWMd/DG17MMnbLauVagKE6xoCcOqt8bC8Scp2fFXh48uRN01sRcPWi7o
	yzzRsWiFXYjQE8O87FnQ+TbJKyJqxNudAE+Td4sJRP3abkQPqdYa+rxJ1X33Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747387145;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3gijar6DsjhFRoqKfJa+IWDYBjfnmQDTkMSs9zyG2w=;
	b=3MFbEseL/VFNlJSoju9YTOBJwnaDCLLSHBiFX3hWAX3/ly6d5kWeaRXVBdpwXDtQqKOOsg
	vXDa8NJa9bzs0xCg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpuid: Rename
 hypervisor_cpuid_base()/for_each_possible_hypervisor_cpuid_base() to
 cpuid_base_hypervisor()/for_each_possible_cpuid_base_hypervisor()
Cc: Ingo Molnar <mingo@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aCZOi0Oohc7DpgTo@lx-t490>
References: <aCZOi0Oohc7DpgTo@lx-t490>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738714388.406.4052840094593108684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3bf8ce828419810f45a272948805cf9a2b685529
Gitweb:        https://git.kernel.org/tip/3bf8ce828419810f45a272948805cf9a2b685529
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 15 May 2025 22:28:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 10:54:47 +02:00

x86/cpuid: Rename hypervisor_cpuid_base()/for_each_possible_hypervisor_cpuid_base() to cpuid_base_hypervisor()/for_each_possible_cpuid_base_hypervisor()

In order to let all the APIs under <cpuid/api.h> have a shared "cpuid_"
namespace, rename hypervisor_cpuid_base() to cpuid_base_hypervisor().

To align with the new style, also rename:

    for_each_possible_hypervisor_cpuid_base(function)

to:

    for_each_possible_cpuid_base_hypervisor(function)

Adjust call-sites accordingly.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/aCZOi0Oohc7DpgTo@lx-t490
---
 arch/x86/include/asm/acrn.h           | 2 +-
 arch/x86/include/asm/cpuid/api.h      | 6 +++---
 arch/x86/include/asm/xen/hypervisor.h | 2 +-
 arch/x86/kernel/jailhouse.c           | 2 +-
 arch/x86/kernel/kvm.c                 | 2 +-
 arch/x86/kvm/cpuid.c                  | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 1dd1438..fab1119 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -25,7 +25,7 @@ void acrn_remove_intr_handler(void);
 static inline u32 acrn_cpuid_base(void)
 {
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return hypervisor_cpuid_base("ACRNACRNACRN", 0);
+		return cpuid_base_hypervisor("ACRNACRNACRN", 0);
 
 	return 0;
 }
diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index ccf20c6..44fa82e 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -188,14 +188,14 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	return false;
 }
 
-#define for_each_possible_hypervisor_cpuid_base(function) \
+#define for_each_possible_cpuid_base_hypervisor(function) \
 	for (function = 0x40000000; function < 0x40010000; function += 0x100)
 
-static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
+static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
 {
 	u32 base, eax, signature[3];
 
-	for_each_possible_hypervisor_cpuid_base(base) {
+	for_each_possible_cpuid_base_hypervisor(base) {
 		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
 
 		/*
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index bd0fc69..c2fc786 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -43,7 +43,7 @@ extern struct start_info *xen_start_info;
 
 static inline uint32_t xen_cpuid_base(void)
 {
-	return hypervisor_cpuid_base(XEN_SIGNATURE, 2);
+	return cpuid_base_hypervisor(XEN_SIGNATURE, 2);
 }
 
 struct pci_dev;
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index cd8ed1e..9e9a591 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -49,7 +49,7 @@ static uint32_t jailhouse_cpuid_base(void)
 	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return 0;
 
-	return hypervisor_cpuid_base("Jailhouse\0\0\0", 0);
+	return cpuid_base_hypervisor("Jailhouse\0\0\0", 0);
 }
 
 static uint32_t __init jailhouse_detect(void)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f364222..921c1c7 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -875,7 +875,7 @@ static noinline uint32_t __kvm_cpuid_base(void)
 		return 0;	/* So we don't blow up on old processors */
 
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return hypervisor_cpuid_base(KVM_SIGNATURE, 0);
+		return cpuid_base_hypervisor(KVM_SIGNATURE, 0);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7f43d8d..ecd85f4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -236,7 +236,7 @@ static struct kvm_hypervisor_cpuid kvm_get_hypervisor_cpuid(struct kvm_vcpu *vcp
 	struct kvm_cpuid_entry2 *entry;
 	u32 base;
 
-	for_each_possible_hypervisor_cpuid_base(base) {
+	for_each_possible_cpuid_base_hypervisor(base) {
 		entry = kvm_find_cpuid_entry(vcpu, base);
 
 		if (entry) {

