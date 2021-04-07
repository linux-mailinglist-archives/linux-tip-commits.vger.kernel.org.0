Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5B3568C0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbhDGKEN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350511AbhDGKDl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50754C061763;
        Wed,  7 Apr 2021 03:03:32 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w41BqWDssgPEvrNAkf6IMMmXT+w/bLziISlAkNSh3yw=;
        b=0q192M+Qw6jLHzRphn2b8AagcAMXUMdnSrqB7Xy+IvcrGYFAoIymfHIa+TIIe8t/CVehRd
        8Y++B6plIoMQ01KY6rD+lJ9hHEhg9swfxcRED3acHtH73Wuu9gC5ZlA9wrHZC3nTjbRiD2
        UbFNCESBThcv66/GKA+BuMqd7k9BdJfDgAexLclGjQnWx5HBFTIny3jOioql7724XYv1m+
        SoB92jNzviSYaSlLHVDri76BvVRgp7AJD7fWRQnYBKNze4kwZVW5gtrzlcIdGmZG+Yyp//
        VCEdlmUI4vbdwBcMgYigwcFcgHDkUtdiR2Tv2EqUxRA2DctFO3v4eKUSBjajEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w41BqWDssgPEvrNAkf6IMMmXT+w/bLziISlAkNSh3yw=;
        b=MYRWM4yryVV2jQTADNTT9IqIilKWCLxgUgf4xlK9Umknx1IW30jXfwLROzgTMHqBuCk66r
        0o7tPn/w9gt3IXCw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add helpers to expose ECREATE and EINIT to KVM
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20e09daf559aa5e9e680a0b4b5fba940f1bad86e.1616136308.git.kai.huang@intel.com>
References: <20e09daf559aa5e9e680a0b4b5fba940f1bad86e.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981031.29796.5376351701665332325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     d155030b1e7c0e448aab22a803f7a71ea2e117d7
Gitweb:        https://git.kernel.org/tip/d155030b1e7c0e448aab22a803f7a71ea2e117d7
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:23:08 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 19:18:27 +02:00

x86/sgx: Add helpers to expose ECREATE and EINIT to KVM

The host kernel must intercept ECREATE to impose policies on guests, and
intercept EINIT to be able to write guest's virtual SGX_LEPUBKEYHASH MSR
values to hardware before running guest's EINIT so it can run correctly
according to hardware behavior.

Provide wrappers around __ecreate() and __einit() to hide the ugliness
of overloading the ENCLS return value to encode multiple error formats
in a single int.  KVM will trap-and-execute ECREATE and EINIT as part
of SGX virtualization, and reflect ENCLS execution result to guest by
setting up guest's GPRs, or on an exception, injecting the correct fault
based on return value of __ecreate() and __einit().

Use host userspace addresses (provided by KVM based on guest physical
address of ENCLS parameters) to execute ENCLS/EINIT when possible.
Accesses to both EPC and memory originating from ENCLS are subject to
segmentation and paging mechanisms.  It's also possible to generate
kernel mappings for ENCLS parameters by resolving PFN but using
__uaccess_xx() is simpler.

 [ bp: Return early if the __user memory accesses fail, use
   cpu_feature_enabled(). ]

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20e09daf559aa5e9e680a0b4b5fba940f1bad86e.1616136308.git.kai.huang@intel.com
---
 arch/x86/include/asm/sgx.h     |   7 ++-
 arch/x86/kernel/cpu/sgx/virt.c | 117 ++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3b025af..954042e 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -365,4 +365,11 @@ struct sgx_sigstruct {
  * comment!
  */
 
+#ifdef CONFIG_X86_SGX_KVM
+int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
+		     int *trapnr);
+int sgx_virt_einit(void __user *sigstruct, void __user *token,
+		   void __user *secs, u64 *lepubkeyhash, int *trapnr);
+#endif
+
 #endif /* _ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 259cc46..7d221ea 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -257,3 +257,120 @@ int __init sgx_vepc_init(void)
 
 	return misc_register(&sgx_vepc_dev);
 }
+
+/**
+ * sgx_virt_ecreate() - Run ECREATE on behalf of guest
+ * @pageinfo:	Pointer to PAGEINFO structure
+ * @secs:	Userspace pointer to SECS page
+ * @trapnr:	trap number injected to guest in case of ECREATE error
+ *
+ * Run ECREATE on behalf of guest after KVM traps ECREATE for the purpose
+ * of enforcing policies of guest's enclaves, and return the trap number
+ * which should be injected to guest in case of any ECREATE error.
+ *
+ * Return:
+ * -  0:	ECREATE was successful.
+ * - <0:	on error.
+ */
+int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
+		     int *trapnr)
+{
+	int ret;
+
+	/*
+	 * @secs is an untrusted, userspace-provided address.  It comes from
+	 * KVM and is assumed to be a valid pointer which points somewhere in
+	 * userspace.  This can fault and call SGX or other fault handlers when
+	 * userspace mapping @secs doesn't exist.
+	 *
+	 * Add a WARN() to make sure @secs is already valid userspace pointer
+	 * from caller (KVM), who should already have handled invalid pointer
+	 * case (for instance, made by malicious guest).  All other checks,
+	 * such as alignment of @secs, are deferred to ENCLS itself.
+	 */
+	if (WARN_ON_ONCE(!access_ok(secs, PAGE_SIZE)))
+		return -EINVAL;
+
+	__uaccess_begin();
+	ret = __ecreate(pageinfo, (void *)secs);
+	__uaccess_end();
+
+	if (encls_faulted(ret)) {
+		*trapnr = ENCLS_TRAPNR(ret);
+		return -EFAULT;
+	}
+
+	/* ECREATE doesn't return an error code, it faults or succeeds. */
+	WARN_ON_ONCE(ret);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sgx_virt_ecreate);
+
+static int __sgx_virt_einit(void __user *sigstruct, void __user *token,
+			    void __user *secs)
+{
+	int ret;
+
+	/*
+	 * Make sure all userspace pointers from caller (KVM) are valid.
+	 * All other checks deferred to ENCLS itself.  Also see comment
+	 * for @secs in sgx_virt_ecreate().
+	 */
+#define SGX_EINITTOKEN_SIZE	304
+	if (WARN_ON_ONCE(!access_ok(sigstruct, sizeof(struct sgx_sigstruct)) ||
+			 !access_ok(token, SGX_EINITTOKEN_SIZE) ||
+			 !access_ok(secs, PAGE_SIZE)))
+		return -EINVAL;
+
+	__uaccess_begin();
+	ret = __einit((void *)sigstruct, (void *)token, (void *)secs);
+	__uaccess_end();
+
+	return ret;
+}
+
+/**
+ * sgx_virt_einit() - Run EINIT on behalf of guest
+ * @sigstruct:		Userspace pointer to SIGSTRUCT structure
+ * @token:		Userspace pointer to EINITTOKEN structure
+ * @secs:		Userspace pointer to SECS page
+ * @lepubkeyhash:	Pointer to guest's *virtual* SGX_LEPUBKEYHASH MSR values
+ * @trapnr:		trap number injected to guest in case of EINIT error
+ *
+ * Run EINIT on behalf of guest after KVM traps EINIT. If SGX_LC is available
+ * in host, SGX driver may rewrite the hardware values at wish, therefore KVM
+ * needs to update hardware values to guest's virtual MSR values in order to
+ * ensure EINIT is executed with expected hardware values.
+ *
+ * Return:
+ * -  0:	EINIT was successful.
+ * - <0:	on error.
+ */
+int sgx_virt_einit(void __user *sigstruct, void __user *token,
+		   void __user *secs, u64 *lepubkeyhash, int *trapnr)
+{
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC)) {
+		ret = __sgx_virt_einit(sigstruct, token, secs);
+	} else {
+		preempt_disable();
+
+		sgx_update_lepubkeyhash(lepubkeyhash);
+
+		ret = __sgx_virt_einit(sigstruct, token, secs);
+		preempt_enable();
+	}
+
+	/* Propagate up the error from the WARN_ON_ONCE in __sgx_virt_einit() */
+	if (ret == -EINVAL)
+		return ret;
+
+	if (encls_faulted(ret)) {
+		*trapnr = ENCLS_TRAPNR(ret);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sgx_virt_einit);
