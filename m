Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4842B82FC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgKRRS5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56200 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgKRRS3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:29 -0500
Date:   Wed, 18 Nov 2020 17:18:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNuAPqbl+6SeZtGUbrXqmHtNr089rfPjyudFjVJn/d4=;
        b=kVnhApxfFJvxrnDBcGHF9iQDQzBhlY9eeMyU4Bd+BAOjYjmjjstPHL+69/kXz1Eb60MGSI
        w/DcYb13JPd3QnRcmMxrhD/cvJZ5QGVNb2+ZLxg7xJhNIxZL7ZUqxl8JGLHrn/4T/lwkO0
        95TmmsF9+NmCCtsv+Rl4HMFjl5mAdYPrkx1My4MedGEw9U3DTZDA01DAUUkuEkh8n4Dp9x
        BXh2H4k2CNPeDwkzX0LiMoUPDtj+rrEz/bJUoTm5lb1iN17SszkUC2lBpjtSpZbVncvG+o
        MiiZ2y1rmApxQkjLeko5kKhkrCarPM1YDmirbLkdt27UkKMcQJzx8O+cyBWfVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNuAPqbl+6SeZtGUbrXqmHtNr089rfPjyudFjVJn/d4=;
        b=+T8UQxiys8SX2yUnxyFIWzc1bjLoK1jODAW2g6FrTHjM81nMXbZvJW1nYcEEc88hZS6tCG
        byLCMOBUT7c/jMCg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/cpu/intel: Detect SGX support
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-8-jarkko@kernel.org>
References: <20201112220135.165028-8-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990644.11244.10929900835369757046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     224ab3527f89f69ae57dc53555826667ac46a3cc
Gitweb:        https://git.kernel.org/tip/224ab3527f89f69ae57dc53555826667ac4=
6a3cc
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:13 +01:00

x86/cpu/intel: Detect SGX support

Kernel support for SGX is ultimately decided by the state of the launch
control bits in the feature control MSR (MSR_IA32_FEAT_CTL).  If the
hardware supports SGX, but neglects to support flexible launch control, the
kernel will not enable SGX.

Enable SGX at feature control MSR initialization and update the associated
X86_FEATURE flags accordingly.  Disable X86_FEATURE_SGX (and all
derivatives) if the kernel is not able to establish itself as the authority
over SGX Launch Control.

All checks are performed for each logical CPU (not just boot CPU) in order
to verify that MSR_IA32_FEATURE_CONTROL is correctly configured on all
CPUs. All SGX code in this series expects the same configuration from all
CPUs.

This differs from VMX where X86_FEATURE_VMX is intentionally cleared only
for the current CPU so that KVM can provide additional information if KVM
fails to load like which CPU doesn't support VMX.  There=E2=80=99s not much t=
he
kernel or an administrator can do to fix the situation, so SGX neglects to
convey additional details about these kinds of failures if they occur.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-8-jarkko@kernel.org
---
 arch/x86/kernel/cpu/feat_ctl.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 29a3bed..d38e973 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -93,16 +93,32 @@ static void init_vmx_capabilities(struct cpuinfo_x86 *c)
 }
 #endif /* CONFIG_X86_VMX_FEATURE_NAMES */
=20
+static void clear_sgx_caps(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_SGX);
+	setup_clear_cpu_cap(X86_FEATURE_SGX_LC);
+}
+
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 {
 	bool tboot =3D tboot_enabled();
+	bool enable_sgx;
 	u64 msr;
=20
 	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
 		clear_cpu_cap(c, X86_FEATURE_VMX);
+		clear_sgx_caps();
 		return;
 	}
=20
+	/*
+	 * Enable SGX if and only if the kernel supports SGX and Launch Control
+	 * is supported, i.e. disable SGX if the LE hash MSRs can't be written.
+	 */
+	enable_sgx =3D cpu_has(c, X86_FEATURE_SGX) &&
+		     cpu_has(c, X86_FEATURE_SGX_LC) &&
+		     IS_ENABLED(CONFIG_X86_SGX);
+
 	if (msr & FEAT_CTL_LOCKED)
 		goto update_caps;
=20
@@ -124,13 +140,16 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 			msr |=3D FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
 	}
=20
+	if (enable_sgx)
+		msr |=3D FEAT_CTL_SGX_ENABLED | FEAT_CTL_SGX_LC_ENABLED;
+
 	wrmsrl(MSR_IA32_FEAT_CTL, msr);
=20
 update_caps:
 	set_cpu_cap(c, X86_FEATURE_MSR_IA32_FEAT_CTL);
=20
 	if (!cpu_has(c, X86_FEATURE_VMX))
-		return;
+		goto update_sgx;
=20
 	if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
 	    (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
@@ -143,4 +162,12 @@ update_caps:
 		init_vmx_capabilities(c);
 #endif
 	}
+
+update_sgx:
+	if (!(msr & FEAT_CTL_SGX_ENABLED) ||
+	    !(msr & FEAT_CTL_SGX_LC_ENABLED) || !enable_sgx) {
+		if (enable_sgx)
+			pr_err_once("SGX disabled by BIOS\n");
+		clear_sgx_caps();
+	}
 }
