Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17673568CB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350635AbhDGKEZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbhDGKDo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:44 -0400
Date:   Wed, 07 Apr 2021 10:03:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGJy6+B+ysl0LidNL1phL+d3yvDnsXj7jwbfm/1+2+o=;
        b=20XZvlZxxENnvwX2ZbW4BmF3JuwW+lYZXybFCnjP3BLws1BijLBD8RN6QmvHC/CATx4WXi
        qbseG8DDFvWGSR6bx+TF6QXbVkjbybTjDGXUpmBTpkqi2qm8hFd+Kgl3hEPe+/VOxjNA4D
        li4bSlx9m6z6IIhn8r/LE2odFoBPvSj3t37DQ+qdnw0gIzh0l54zFDg0V5c4lcLL+4IXWw
        xvh2HIW0L1NnUIpK41g3xZtLNObqZrDjp3sqWfXtgMt1rkYKXlYYMJRPwiisMTL0H+dEvJ
        vg5jcnOUnLMdl4dQnSZxM45ufUofUOBUbfbMO8e12PJZDNj5jNK5vEi1zH9H2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGJy6+B+ysl0LidNL1phL+d3yvDnsXj7jwbfm/1+2+o=;
        b=Z2lec153KZbrZlq7TjBfQvPNwCG0USjVE14G1ij2A5mgTKxBzH4SQ1b9f9Ksa9nt8AtdFS
        iM0FVZJOIDl85RBA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add SGX_CHILD_PRESENT hardware error code
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <050b198e882afde7e6eba8e6a0d4da39161dbb5a.1616136308.git.kai.huang@intel.com>
References: <050b198e882afde7e6eba8e6a0d4da39161dbb5a.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981358.29796.3334786653256595050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     231d3dbdda192e3b3c7b79f4c3b0616f6c7f31b7
Gitweb:        https://git.kernel.org/tip/231d3dbdda192e3b3c7b79f4c3b0616f6c7f31b7
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:22:20 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 26 Mar 2021 22:51:36 +01:00

x86/sgx: Add SGX_CHILD_PRESENT hardware error code

SGX driver can accurately track how enclave pages are used.  This
enables SECS to be specifically targeted and EREMOVE'd only after all
child pages have been EREMOVE'd.  This ensures that SGX driver will
never encounter SGX_CHILD_PRESENT in normal operation.

Virtual EPC is different.  The host does not track how EPC pages are
used by the guest, so it cannot guarantee EREMOVE success.  It might,
for instance, encounter a SECS with a non-zero child count.

Add a definition of SGX_CHILD_PRESENT.  It will be used exclusively by
the SGX virtualization driver to handle recoverable EREMOVE errors when
saniziting EPC pages after they are freed.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/050b198e882afde7e6eba8e6a0d4da39161dbb5a.1616136308.git.kai.huang@intel.com
---
 arch/x86/kernel/cpu/sgx/arch.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/arch.h b/arch/x86/kernel/cpu/sgx/arch.h
index dd7602c..abf99bb 100644
--- a/arch/x86/kernel/cpu/sgx/arch.h
+++ b/arch/x86/kernel/cpu/sgx/arch.h
@@ -26,12 +26,14 @@
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
+ * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
  * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
  *				public key does not match IA32_SGXLEPUBKEYHASH.
  * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
  */
 enum sgx_return_code {
 	SGX_NOT_TRACKED			= 11,
+	SGX_CHILD_PRESENT		= 13,
 	SGX_INVALID_EINITTOKEN		= 16,
 	SGX_UNMASKED_EVENT		= 128,
 };
