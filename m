Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A759375387
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEFMPP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbhEFMPI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73224C061761;
        Thu,  6 May 2021 05:14:10 -0700 (PDT)
Date:   Thu, 06 May 2021 12:14:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1frjhNAPdWu6iknMPF4As0BhSenaX59gl6MM1luhtVs=;
        b=OYnZSiumvcH7WUHtqm2pdpbtnssmhL6G05Ui/8b03CEAgEX80tTMBGqUDtp6Z9nqJbQ93W
        VD0DWa/NCp3qxh/T7ajULdEN2wCIt1nnfVRxjJmxc7phoWCuwJpd8s0S8pxoCvMxqM5dE1
        9XaFeRKYqaiLZU0a6UBRoqGPrAKy9Y63a8a7Q2uZD+eTLT7eO8Vh6O7fDmNPwwx4AXP4sC
        PushOcAXUkNd4Em3F38g2L8sxmvHgDheiaIdktMUjOHkTRTc4exRvNkrRYXzf47QfvDBJV
        hqvnup2XfbEZmAoxPBftqjyplNfGKZ1MpjgCWFi1dsh1gy98El8CYjVh3L1QAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1frjhNAPdWu6iknMPF4As0BhSenaX59gl6MM1luhtVs=;
        b=XxQ+s4pfaKNAzMb79PnLf4gVDbDT4iIW/sY//ORPLcYD25d0MOfkMc5C8z8g2MAUdITVFc
        HZlLyWym3yonxuDA==
From:   "tip-bot2 for Wan Jiabing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/smpboot: Remove duplicate includes
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210427063835.9039-1-wanjiabing@vivo.com>
References: <20210427063835.9039-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Message-ID: <162030324849.29796.7973695577093488360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3cf4524ce40b204418537e6a3a55ed44911b3f53
Gitweb:        https://git.kernel.org/tip/3cf4524ce40b204418537e6a3a55ed44911b3f53
Author:        Wan Jiabing <wanjiabing@vivo.com>
AuthorDate:    Tue, 27 Apr 2021 14:38:26 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 21:50:13 +02:00

x86/smpboot: Remove duplicate includes

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210427063835.9039-1-wanjiabing@vivo.com

---
 arch/x86/kernel/smpboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7ffb0cf..0ad5214 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1865,9 +1865,6 @@ static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
-
 #define X86_MATCH(model)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
 		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
