Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE22AFB13
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKKWGk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 17:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgKKWGk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 17:06:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F7C0613D1;
        Wed, 11 Nov 2020 14:06:40 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:06:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605132398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHIH9LpyT4Dbv8HR+sFU4CN6faf/ITto3tvN71lc5JM=;
        b=Pt1fH94nExq3+XmOWZ1HDvSaguTYhkNyREHCWTDkWGi6XdrDFue0iy4z8rp03x1dDTvPig
        aoLT8b2ISogWSNKbtuj1VE3oeWCrC2ps2Ivvm7SpzjEswQZJRpWusYP948j1O2nVN2aY0M
        W9oLYW5zYkR8eBiMWvhN84QtZASX2Fwl/mDIcCYAehD4QDrzjblo7zMjyD8Lvap4r5FJnc
        zK7nAvZ8SxUEo8ZyW46Wa62Glo6ZirDE8Fb2/CgyuXw+ipiJ2kJe9Ut6ThqJ08cgF6PLA2
        zDVlmD1kxLDZpazC5XyqgoegE77gaHDmDfqHUpnUSnxwQuJfgWiMV/ILoJVUOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605132398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHIH9LpyT4Dbv8HR+sFU4CN6faf/ITto3tvN71lc5JM=;
        b=j76T9QeNs3U/347nV/DFfndyk+r0Ad3jzvXUWRYvucjd4rIlLPRGSbw0FOyWtVPUjZRW7L
        0pegXPZg/aJNb3AQ==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/amd: Fix union of bitfields in intcapxt support
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201111144322.1659970-2-dwmw2@infradead.org>
References: <20201111144322.1659970-2-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160513239741.11244.10669580713889904996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2fb6acf3edfeb904505f9ba3fd01166866062591
Gitweb:        https://git.kernel.org/tip/2fb6acf3edfeb904505f9ba3fd01166866062591
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 11 Nov 2020 14:43:21 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Nov 2020 23:01:57 +01:00

iommu/amd: Fix union of bitfields in intcapxt support

All the bitfields in here are overlaid on top of each other since
they're a union. Change the second u64 to be in a struct so it does
the intended thing.

Fixes: b5c3786ee370 ("iommu/amd: Use msi_msg shadow structs")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201111144322.1659970-2-dwmw2@infradead.org

---
 drivers/iommu/amd/init.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 263670d..c2769f2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1967,13 +1967,15 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 
 union intcapxt {
 	u64	capxt;
-	u64	reserved_0		:  2,
-		dest_mode_logical	:  1,
-		reserved_1		:  5,
-		destid_0_23		: 24,
-		vector			:  8,
-		reserved_2		: 16,
-		destid_24_31		:  8;
+	struct {
+		u64	reserved_0		:  2,
+			dest_mode_logical	:  1,
+			reserved_1		:  5,
+			destid_0_23		: 24,
+			vector			:  8,
+			reserved_2		: 16,
+			destid_24_31		:  8;
+	};
 } __attribute__ ((packed));
 
 /*
