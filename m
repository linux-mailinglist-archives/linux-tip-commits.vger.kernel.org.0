Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2984E3568C1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350512AbhDGKEO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350513AbhDGKDl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB306C061764;
        Wed,  7 Apr 2021 03:03:32 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bx33vIOm8RmYG0IaTLaXs5nY1l00KOUveRaoy+WvdSw=;
        b=LsndnoCJp/XCy57Ztnn0qT+uhkGjT+KgjETJI+whautqPRnt+rudUYxIaJiXjo+6DWJWhg
        nV8fQ8p4tQwFBMDNS8C7u2K6BWVWNnmd8TFlc7ke+8nkzsp6b+eXWmpIeqnKJwsltg6dy9
        96+W4LT7/FX3WPwtbBKNzL4SwxatutLMckZdNvqHFs+hblbArTOr40XgT1TsugFOmJU0Eg
        Y+mTmGz09dYBkVR2lAjxkIcedfk+MEEjNaCgPlNUKikbwGSsV90FcWUKBSne54WCsNROLh
        suy27LCgZN5b6/Gh59/IGyw2cT8M6CxmtuX+B32bURpPs7iHs6vzeXgeb3t32A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bx33vIOm8RmYG0IaTLaXs5nY1l00KOUveRaoy+WvdSw=;
        b=Hr1ZYGmoJxt0K0+gUm6QDQ+nFJIpjbgnbacPxQRjXEL6HUjfZMYTkYCIXwVahe+GY47onz
        dddg68S6+O+3qNCQ==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add helper to update SGX_LEPUBKEYHASHn MSRs
Cc:     Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dfb7cd39d4dd62ea27703b64afdd8bccb579f623.1616136308.git.kai.huang@intel.com>
References: <dfb7cd39d4dd62ea27703b64afdd8bccb579f623.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981067.29796.4465997089203150088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     73916b6a0c714258f9c2619408a66c6696a761a7
Gitweb:        https://git.kernel.org/tip/73916b6a0c714258f9c2619408a66c6696a761a7
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:23:07 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 09:43:42 +02:00

x86/sgx: Add helper to update SGX_LEPUBKEYHASHn MSRs

Add a helper to update SGX_LEPUBKEYHASHn MSRs.  SGX virtualization also
needs to update those MSRs based on guest's "virtual" SGX_LEPUBKEYHASHn
before EINIT from guest.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/dfb7cd39d4dd62ea27703b64afdd8bccb579f623.1616136308.git.kai.huang@intel.com
---
 arch/x86/kernel/cpu/sgx/ioctl.c |  5 ++---
 arch/x86/kernel/cpu/sgx/main.c  | 16 ++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h   |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 11e3f96..7be9c06 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -495,7 +495,7 @@ static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
 			 void *token)
 {
 	u64 mrsigner[4];
-	int i, j, k;
+	int i, j;
 	void *addr;
 	int ret;
 
@@ -544,8 +544,7 @@ static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
 
 			preempt_disable();
 
-			for (k = 0; k < 4; k++)
-				wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + k, mrsigner[k]);
+			sgx_update_lepubkeyhash(mrsigner);
 
 			ret = __einit(sigstruct, token, addr);
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 1c8a228..227f1e2 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -727,6 +727,22 @@ static bool __init sgx_page_cache_init(void)
 	return true;
 }
 
+/*
+ * Update the SGX_LEPUBKEYHASH MSRs to the values specified by caller.
+ * Bare-metal driver requires to update them to hash of enclave's signer
+ * before EINIT. KVM needs to update them to guest's virtual MSR values
+ * before doing EINIT from guest.
+ */
+void sgx_update_lepubkeyhash(u64 *lepubkeyhash)
+{
+	int i;
+
+	WARN_ON_ONCE(preemptible());
+
+	for (i = 0; i < 4; i++)
+		wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
+}
+
 static int __init sgx_init(void)
 {
 	int ret;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index e4cbc71..4628ace 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -93,4 +93,6 @@ static inline int __init sgx_vepc_init(void)
 }
 #endif
 
+void sgx_update_lepubkeyhash(u64 *lepubkeyhash);
+
 #endif /* _X86_SGX_H */
