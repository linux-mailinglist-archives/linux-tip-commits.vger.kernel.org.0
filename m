Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1873809AA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 May 2021 14:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhENMgm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 May 2021 08:36:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhENMgl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 May 2021 08:36:41 -0400
Date:   Fri, 14 May 2021 12:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620995729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2TRdEOo2opgyxg4Ofb2+3cG+kZ9FdY0Z3rbJ6w55A4=;
        b=ZoUEhU1/c3YEn78s5J0bW5BKGm/Ue0e8eKmXR9CQh0iEOtnQHP9xj8ONJ+N08ZqlG75ZMD
        eIKD+mtPR2mzSpsc+49lYQh5tQg6CZZdYdDZF7AHXmAQdDPF28dKc8SKzET/dLnZB9rE7A
        zY6MdWhvB3aFORZKdibRK/zguXheJh2yxuHaSkxOD4w5RyNLTknnYzd0Uoge5IL0bSL7q6
        CZvzC9UK/mVJEiRXqEuyIEigQeXiwCLsATt0Kh/WfywuEkjzgvACKgj9RJBe/k0CQ3/vx8
        cKM6Rm25otTu/pW5bNf7GrOasd6ebFWkrLSpUksyTqDk2dcV7+X2Aev9g0iW5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620995729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2TRdEOo2opgyxg4Ofb2+3cG+kZ9FdY0Z3rbJ6w55A4=;
        b=iMRf3Tj4S9ew341/UiLj+deQMYM5Bx7nGSDfbBbF2o+MxWr1GZE41WBiA1/yaVLGZ96e4U
        4Z1aAhg03INzGiBg==
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Fix core name for Sapphire Rapids
Cc:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210513163904.3083274-1-ak@linux.intel.com>
References: <20210513163904.3083274-1-ak@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162099572850.29796.9809922742922576170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     28188cc461f6cf8b7d28de4f6df52014cc1d5e39
Gitweb:        https://git.kernel.org/tip/28188cc461f6cf8b7d28de4f6df52014cc1d5e39
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Thu, 13 May 2021 09:39:04 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 14 May 2021 14:31:14 +02:00

x86/cpu: Fix core name for Sapphire Rapids

Sapphire Rapids uses Golden Cove, not Willow Cove.

Fixes: 53375a5a218e ("x86/cpu: Resort and comment Intel models")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210513163904.3083274-1-ak@linux.intel.com
---
 arch/x86/include/asm/intel-family.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 955b06d..2715843 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -102,7 +102,8 @@
 
 #define INTEL_FAM6_TIGERLAKE_L		0x8C	/* Willow Cove */
 #define INTEL_FAM6_TIGERLAKE		0x8D	/* Willow Cove */
-#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Willow Cove */
+
+#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Golden Cove */
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
