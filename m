Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1B26F734
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIRHmd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIRHmc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C5C06174A;
        Fri, 18 Sep 2020 00:42:32 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BygGoUICl4VAbXGpzUPMCvLGcd1ptdMQMJ1B2bqTPgQ=;
        b=HneEJQ/IK6c7WivSR2OtJ1VhP417OHpSETXFbJCw/fj7ZrWZ5o0HD447maIUBKoBYVhKJY
        uuKtm8PXxKDKdMgz2dl8nRVzyX7WW+M6obp+tLodm7/J/Exq7ZiphsfVEXW08dBYEhErP7
        tgKnDd2hhJyN5EEyTOVvyDGrU+anzZchOk21NddNTzu9odY8p7aXSM6Lr9shyH341HGMnd
        5DfKpAqykApcwk5fqtuxrUSo4TUE7Vwmi1D5SWPtolPsQsbKpxQN5yh2m8Tegwlaa6E4IL
        WxZjsZl9A3pGkSldGfB6s7HTPH8gAO8hotnqOpl0h1JF5QUoV331dd4jeE+TqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BygGoUICl4VAbXGpzUPMCvLGcd1ptdMQMJ1B2bqTPgQ=;
        b=uLnlzueMvvskbD7A55YIGvl2FDjVzUi1gkpLAvrVtQwkYsXcriBJdkO1zx65hJDmiVTcIt
        Ndb3/2tdcfWq52Cw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/cpufeatures: Mark ENQCMD as disabled when configured out
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-9-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-9-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041494942.15536.9169991459338138359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     1478b99a76534b6c244cfe24fa616280a9441118
Gitweb:        https://git.kernel.org/tip/1478b99a76534b6c244cfe24fa616280a9441118
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:12 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 20:22:15 +02:00

x86/cpufeatures: Mark ENQCMD as disabled when configured out

Currently, the ENQCMD feature depends on CONFIG_IOMMU_SUPPORT. Add
X86_FEATURE_ENQCMD to the disabled features mask so that it gets
disabled when the IOMMU config option above is not enabled.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1600187413-163670-9-git-send-email-fenghua.yu@intel.com
---
 arch/x86/include/asm/disabled-features.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 4ea8584..5861d34 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,6 +56,12 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
+#ifdef CONFIG_IOMMU_SUPPORT
+# define DISABLE_ENQCMD	0
+#else
+# define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -75,7 +81,8 @@
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
+#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
+			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
