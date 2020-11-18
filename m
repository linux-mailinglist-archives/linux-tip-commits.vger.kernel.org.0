Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7304B2B82E9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgKRRSc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgKRRSc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:32 -0500
Date:   Wed, 18 Nov 2020 17:18:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAdoaec3jRz/TGBrtVPCF5eirnCMLEC6dXKiQwEYPeU=;
        b=0SGMSzhGs0m4x71tVuIuChCARw5jldGtUuNwsJIwwxTxhuBiQqyJst7jgo12zXBmLoNPcZ
        adK/7t6BWOcVbBAzBozxEat8PtDFaBkyWlNLEJ/w5fdtAdI9k/+0qWlzbvcMeHwWQYIZCr
        EU2j5+H72xoqREEfKoPC/sNRIdARKQohLC26Fc4OEYAm1Vi/I5IRVL/Bz+MwgO+mhuq9Tv
        aJrBM41006myi1d0rzkupOVL6Njya420DQcGlE1ZIXBpMIxQXWREd7EXRVAXZ9L1hMa86g
        qMctSEI8lxt2JafUH6x2YLWJ2YNM2QqFj4atDZZMH1sg+m38vPM9eczhk5mCsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAdoaec3jRz/TGBrtVPCF5eirnCMLEC6dXKiQwEYPeU=;
        b=MVpFrMKHmR/rrE9RfDKIB4EnNtyQmyFaCRWpqOHWDBs9i1YnyFXXVPDr4OgJLwR9SZqylF
        tI+RLetF36lHs5Bw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/{cpufeatures,msr}: Add Intel SGX Launch Control
 hardware bits
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-5-jarkko@kernel.org>
References: <20201112220135.165028-5-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990830.11244.7912646466686726421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     d205e0f1426e0f99e2b4f387c49f2d8b66e129dd
Gitweb:        https://git.kernel.org/tip/d205e0f1426e0f99e2b4f387c49f2d8b66e129dd
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:13 +01:00

x86/{cpufeatures,msr}: Add Intel SGX Launch Control hardware bits

The SGX Launch Control hardware helps restrict which enclaves the
hardware will run.  Launch control is intended to restrict what software
can run with enclave protections, which helps protect the overall system
from bad enclaves.

For the kernel's purposes, there are effectively two modes in which the
launch control hardware can operate: rigid and flexible. In its rigid
mode, an entity other than the kernel has ultimate authority over which
enclaves can be run (firmware, Intel, etc...). In its flexible mode, the
kernel has ultimate authority over which enclaves can run.

Enable X86_FEATURE_SGX_LC to enumerate when the CPU supports SGX Launch
Control in general.

Add MSR_IA32_SGXLEPUBKEYHASH{0, 1, 2, 3}, which when combined contain a
SHA256 hash of a 3072-bit RSA public key. The hardware allows SGX enclaves
signed with this public key to initialize and run [*]. Enclaves not signed
with this key can not initialize and run.

Add FEAT_CTL_SGX_LC_ENABLED, which informs whether the SGXLEPUBKEYHASH MSRs
can be written by the kernel.

If the MSRs do not exist or are read-only, the launch control hardware is
operating in rigid mode. Linux does not and will not support creating
enclaves when hardware is configured in rigid mode because it takes away
the authority for launch decisions from the kernel. Note, this does not
preclude KVM from virtualizing/exposing SGX to a KVM guest when launch
control hardware is operating in rigid mode.

[*] Intel SDM: 38.1.4 Intel SGX Launch Control Configuration

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-5-jarkko@kernel.org
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1181f5c..f5ef2d5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -357,6 +357,7 @@
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 #define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
+#define X86_FEATURE_SGX_LC		(16*32+30) /* Software Guard Extensions Launch Control */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 258d555..d0c6cff 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -609,6 +609,7 @@
 #define FEAT_CTL_LOCKED				BIT(0)
 #define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
 #define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_SGX_LC_ENABLED			BIT(17)
 #define FEAT_CTL_SGX_ENABLED			BIT(18)
 #define FEAT_CTL_LMCE_ENABLED			BIT(20)
 
@@ -629,6 +630,12 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+/* Intel SGX Launch Enclave Public Key Hash MSRs */
+#define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
+#define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
+#define MSR_IA32_SGXLEPUBKEYHASH2	0x0000008E
+#define MSR_IA32_SGXLEPUBKEYHASH3	0x0000008F
+
 #define MSR_IA32_SMM_MONITOR_CTL	0x0000009b
 #define MSR_IA32_SMBASE			0x0000009e
 
