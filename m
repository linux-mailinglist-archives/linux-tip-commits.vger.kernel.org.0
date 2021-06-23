Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547753B2364
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFWWOf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhFWWNd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:13:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A32C0617AD;
        Wed, 23 Jun 2021 15:09:30 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6S6J4h5ZeKW0e8s70Ku2yVQatEsjPB0CvAfowXmf3s=;
        b=VJ2uJ2LKR/741A0IkHnc1mtrP9WbzWpzjpr2Jik2nTgwal4/nsstF4xPrh3jr1U+RH9U3i
        mDrrBKXRPQW5f6QydHC72gV8tbfQ0kuagAgpNVkPwhmEiimOql1KHdQ4tmnjqjKG6yaWO1
        yGg278Rgl619y3FEgkBtsEGHVT46FQkJXDfKGyMsQX4zz79QcuUJa1ak2k9jYHLJD6I51d
        Ddw3Fl2OPRO7dpqMAWkgOm9bfApSUpGmxffMYrF2h2HVmyJ7O5als2qzfDiVMcWpYiNu2C
        cZ7HFCx+qriv0JlRThj5pwE6GJoxHmzih8VRB47Aawy7azesNj9yEPtUYNxOuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6S6J4h5ZeKW0e8s70Ku2yVQatEsjPB0CvAfowXmf3s=;
        b=Uot6Uj6uyj52Vl2lO+y98FuKYtQmW6f0OHdpj6VA4YpZuYj8NlzPCN9+8XKxAv6Rh77NYY
        1yjIdyCGggWphkCg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/kvm: Avoid looking up PKRU in XSAVE buffer
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.541037562@linutronix.de>
References: <20210623121453.541037562@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616821.395.11390575510895361251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     71ef453355a9197fcfd8ff22391a4ad7861d79e6
Gitweb:        https://git.kernel.org/tip/71ef453355a9197fcfd8ff22391a4ad7861d79e6
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 23 Jun 2021 14:01:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/kvm: Avoid looking up PKRU in XSAVE buffer

PKRU is being removed from the kernel XSAVE/FPU buffers.  This removal
will probably include warnings for code that look up PKRU in those
buffers.

KVM currently looks up the location of PKRU but doesn't even use the
pointer that it gets back.  Rework the code to avoid calling
get_xsave_addr() except in cases where its result is actually used.

This makes the code more clear and also avoids the inevitable PKRU
warnings.

This is probably a good cleanup and could go upstream idependently
of any PKRU rework.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.541037562@linutronix.de
---
 arch/x86/kvm/x86.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e0f4a46..c25bf24 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4604,20 +4604,21 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask = valid & -valid;
 		int xfeature_nr = fls64(xfeature_mask) - 1;
-		void *src = get_xsave_addr(xsave, xfeature_nr);
-
-		if (src) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr == XFEATURE_PKRU)
-				memcpy(dest + offset, &vcpu->arch.pkru,
-				       sizeof(vcpu->arch.pkru));
-			else
-				memcpy(dest + offset, src, size);
+		void *src;
+
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
 
+		if (xfeature_nr == XFEATURE_PKRU) {
+			memcpy(dest + offset, &vcpu->arch.pkru,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			src = get_xsave_addr(xsave, xfeature_nr);
+			if (src)
+				memcpy(dest + offset, src, size);
 		}
 
 		valid -= xfeature_mask;
@@ -4647,18 +4648,20 @@ static void load_xsave(struct kvm_vcpu *vcpu, u8 *src)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask = valid & -valid;
 		int xfeature_nr = fls64(xfeature_mask) - 1;
-		void *dest = get_xsave_addr(xsave, xfeature_nr);
-
-		if (dest) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr == XFEATURE_PKRU)
-				memcpy(&vcpu->arch.pkru, src + offset,
-				       sizeof(vcpu->arch.pkru));
-			else
+
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
+
+		if (xfeature_nr == XFEATURE_PKRU) {
+			memcpy(&vcpu->arch.pkru, src + offset,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			void *dest = get_xsave_addr(xsave, xfeature_nr);
+
+			if (dest)
 				memcpy(dest, src + offset, size);
 		}
 
