Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE53568C2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350632AbhDGKEQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350509AbhDGKDm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:42 -0400
Date:   Wed, 07 Apr 2021 10:03:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTn1dcOzp/Lvw4slZVbGW0fAEE+2+SLHEkATfTZP3uw=;
        b=Bvkkah85vHMCh2KVQiwBFuuzdLRC2ucy2n760w+4QA+I+/j8GADGQyBsPNeyIsRqDbIhHP
        4GzZdrZapPOQPRYM1/iIXEMiNBtd28n1csBoLQMbq8aS6TNX0/6xeniniXbomqsdz3/tu7
        7jW0rRVQaP5dgmJiW33y9AmF80v2Vm0zSGag4ZmfkyC32YZLG0vqzuNs9VB2RA1f+VkZzo
        ODtwk/bpQYo1gxFfXPEIW5SDufnF9knBJflkJJPytHwwXw5eTZGZAf7waYp9vGcGVQIH91
        goV/9NvYw/26QLcxkTeD6zyPfJkAC2TsYX9wnY22lPxi1z23U07x5wIbRP2QoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTn1dcOzp/Lvw4slZVbGW0fAEE+2+SLHEkATfTZP3uw=;
        b=nZZUdlVVUZeVPR1JWJbtrMk2cvPHGBJvuo9/hfjKUpi+ZNxKwUteEmLBzUrPPkt9qhL7Oh
        a99s4koa+gMpUsAg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add encls_faulted() helper
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c1f955898110de2f669da536fc6cf62e003dff88.1616136308.git.kai.huang@intel.com>
References: <c1f955898110de2f669da536fc6cf62e003dff88.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981102.29796.12746888945346904779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     a67136b458e5e63822b19c35794451122fe2bf3e
Gitweb:        https://git.kernel.org/tip/a67136b458e5e63822b19c35794451122fe2bf3e
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:23:06 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 09:43:42 +02:00

x86/sgx: Add encls_faulted() helper

Add a helper to extract the fault indicator from an encoded ENCLS return
value.  SGX virtualization will also need to detect ENCLS faults.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/c1f955898110de2f669da536fc6cf62e003dff88.1616136308.git.kai.huang@intel.com
---
 arch/x86/kernel/cpu/sgx/encls.h | 15 ++++++++++++++-
 arch/x86/kernel/cpu/sgx/ioctl.c |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index be5c496..9b20484 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -40,6 +40,19 @@
 	} while (0);							  \
 }
 
+/*
+ * encls_faulted() - Check if an ENCLS leaf faulted given an error code
+ * @ret:	the return value of an ENCLS leaf function call
+ *
+ * Return:
+ * - true:	ENCLS leaf faulted.
+ * - false:	Otherwise.
+ */
+static inline bool encls_faulted(int ret)
+{
+	return ret & ENCLS_FAULT_FLAG;
+}
+
 /**
  * encls_failed() - Check if an ENCLS function failed
  * @ret:	the return value of an ENCLS function call
@@ -50,7 +63,7 @@
  */
 static inline bool encls_failed(int ret)
 {
-	if (ret & ENCLS_FAULT_FLAG)
+	if (encls_faulted(ret))
 		return ENCLS_TRAPNR(ret) != X86_TRAP_PF;
 
 	return !!ret;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 354e309..11e3f96 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -568,7 +568,7 @@ static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
 		}
 	}
 
-	if (ret & ENCLS_FAULT_FLAG) {
+	if (encls_faulted(ret)) {
 		if (encls_failed(ret))
 			ENCLS_WARN(ret, "EINIT");
 
