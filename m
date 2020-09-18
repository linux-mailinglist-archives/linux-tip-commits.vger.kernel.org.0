Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4422926F741
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgIRHnA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgIRHme (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B471C06174A;
        Fri, 18 Sep 2020 00:42:34 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P83LTqW8l5Uy4xRSqZuMoUSzlosDwVBSpW+wSayVODc=;
        b=eboWB9paKvQyb2W27ygKP/eIc3wjl3Yw/oKZrD9M8zEogYhIaneG4AZqX+uSMorclPO1CL
        U8Agj7iA4XzUYUHQwKcZZGH+TsgP/vO+RbyI9pPyPx1i7OF01PHoZlXzSxW311EpuA8KDe
        hNrO9RduT3Fz3CFaturC/OdbH8UENnOF9cupIXJ3vYFSdgeM3BUpc6WQtPgyHStto8ANQW
        s+vtNcoShVwJwQHefy9jCmaXFyXw8SiP9fI/eGKQXRFQoF263NV6Bg/Nlgjjc5pD5dmrmd
        He0AswxpfTZSSniyVN4CrpL4plSOQv8sy/TVg/vvSDemoSsyfCKpBFxjfp8Bjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P83LTqW8l5Uy4xRSqZuMoUSzlosDwVBSpW+wSayVODc=;
        b=Edj++DlIFYjkJiA6v5a63CaeR85eTwQ8Qyx0ODpCHUQY0nBqDEItyLnue58+qRsVKPNZ1e
        XVQKNzu1xpnxuzDA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/msr-index: Define an IA32_PASID MSR
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-7-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-7-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041495087.15536.13150699323092837842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     f0f2f9feb4ee6f28729e5388da3c03ce1dac077a
Gitweb:        https://git.kernel.org/tip/f0f2f9feb4ee6f28729e5388da3c03ce1dac077a
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 20:22:15 +02:00

x86/msr-index: Define an IA32_PASID MSR

The IA32_PASID MSR (0xd93) contains the Process Address Space Identifier
(PASID), a 20-bit value. Bit 31 must be set to indicate the value
programmed in the MSR is valid. Hardware uses the PASID to identify a
process address space and direct responses to the right address space.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1600187413-163670-7-git-send-email-fenghua.yu@intel.com
---
 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2859ee4..aaddc6a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -257,6 +257,9 @@
 #define MSR_IA32_LASTINTFROMIP		0x000001dd
 #define MSR_IA32_LASTINTTOIP		0x000001de
 
+#define MSR_IA32_PASID			0x00000d93
+#define MSR_IA32_PASID_VALID		BIT_ULL(31)
+
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
