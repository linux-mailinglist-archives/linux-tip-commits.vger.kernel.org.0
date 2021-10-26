Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7F43B6CC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhJZQTK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhJZQTH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D51C061767;
        Tue, 26 Oct 2021 09:16:43 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf3hsFvAeN6w31Awm4Gs0A2G56VZ2NPNAKygrJsqexY=;
        b=uOtGX5tiSD3hW5k8/CN71FOF+0FTyrjAAWKbMt5iLyox1/am7/mCRF5G3cwuFf8L2OjMJI
        rm0RABajh+w4EM+AGsoXp1HgxN9AhnGZNeJ0Ls5v7N7SkX8Sod5jNIQ889QfwdNfKvCyp2
        P92ZnA5vYLPFM0r9OK0B5T/VVXQ+AMalwAOcWgQTpYAq9Y+E8+rSxFT5+7B+MFcTO4gSGH
        UDS/DE7rciW3xklWP/QGp8uw1aoJNd8VTz/ZhUhdM27yGQBRQQE62PeWdTnRpXMueERC0g
        5xPsazEIhnQjB525VqN+1sEfMl7Rv3ULUrJ2lhDlXv7pKECteS7NBdZl5HNTvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf3hsFvAeN6w31Awm4Gs0A2G56VZ2NPNAKygrJsqexY=;
        b=TeC1vDoFbDwxhlQe5DjjByiQFp7PWD4KHv7QRxrergotM1OZ+0gQXG33CFYt5wdGHdOkRW
        hbSwzqRf3RBYLzBQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/cpufeatures: Add eXtended Feature Disabling (XFD)
 feature bit
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-13-chang.seok.bae@intel.com>
References: <20211021225527.10184-13-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500132.626.5263605512679379351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c351101678ce54492b6e09810ec02efc0df036a9
Gitweb:        https://git.kernel.org/tip/c351101678ce54492b6e09810ec02efc0df036a9
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:16 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/cpufeatures: Add eXtended Feature Disabling (XFD) feature bit

Intel's eXtended Feature Disable (XFD) feature is an extension of the XSAVE
architecture. XFD allows the kernel to enable a feature state in XCR0 and
to receive a #NM trap when a task uses instructions accessing that state.

This is going to be used to postpone the allocation of a larger XSTATE
buffer for a task to the point where it is actually using a related
instruction after the permission to use that facility has been granted.

XFD is not used by the kernel, but only applied to userspace. This is a
matter of policy as the kernel knows how a fpstate is reallocated and the
XFD state.

The compacted XSAVE format is adjustable for dynamic features. Make XFD
depend on XSAVES.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-13-chang.seok.bae@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cf..ab7b3a2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -277,6 +277,7 @@
 #define X86_FEATURE_XSAVEC		(10*32+ 1) /* XSAVEC instruction */
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
+#define X86_FEATURE_XFD			(10*32+ 4) /* "" eXtended Feature Disabling */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index defda61..d9ead9c 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{}
 };
 
