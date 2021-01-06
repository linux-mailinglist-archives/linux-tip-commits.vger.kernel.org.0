Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15E72EBDD4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Jan 2021 13:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFMnN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Jan 2021 07:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFMnN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Jan 2021 07:43:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D4FC06134C;
        Wed,  6 Jan 2021 04:42:31 -0800 (PST)
Date:   Wed, 06 Jan 2021 12:42:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609936944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmgF16zcAnsqNhzVW75E/FiSXuBXNdBXTcEta/hI2Yc=;
        b=MJwo6HhhYwUtC6jn7FKJfUTNzvVgv72pbeJariOa4Wp00ZpT4Vj3MUC6rsgZStiN1e0Lug
        6cJnBeBaFX/v4UbUsEPh4p9TKiqOFO3pZH6BFf58JkmOVo4xAhpx5cvcarb1upCyLyjGal
        8jx42BVADuKcr36fubpiwDySP1WatEMo1lrsS3oJa0nFwJYsONalfHXZsyWYKLhryRnCoD
        At5NndN/w1WJSC+FyPznMfO89Su0GBzalw6C3Mx3qigiZkt/8xfD/kCTaz5AVpwUOh2tHN
        qAbcfWJbdkuw7iSO81m5oR/xORRTIHnHKMRVz7NrFjBw3bao+fy57GuCOq6Pcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609936944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmgF16zcAnsqNhzVW75E/FiSXuBXNdBXTcEta/hI2Yc=;
        b=Qe71e2tonXte8Kw65MgkNIQGpUy2QCNuL9AAbXgf57c1zG+QP86JRuWKrDUqiF2/cSg4bW
        Q4VPTKQsYsa8kqCQ==
From:   "tip-bot2 for Ying-Tsun Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mtrr: Correct the range check before performing
 MTRR type lookups
Cc:     "Ying-Tsun Huang" <ying-tsun.huang@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201215070721.4349-1-ying-tsun.huang@amd.com>
References: <20201215070721.4349-1-ying-tsun.huang@amd.com>
MIME-Version: 1.0
Message-ID: <160993694388.414.2374569391219500703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cb7f4a8b1fb426a175d1708f05581939c61329d4
Gitweb:        https://git.kernel.org/tip/cb7f4a8b1fb426a175d1708f05581939c61329d4
Author:        Ying-Tsun Huang <ying-tsun.huang@amd.com>
AuthorDate:    Tue, 15 Dec 2020 15:07:20 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Jan 2021 13:01:13 +01:00

x86/mtrr: Correct the range check before performing MTRR type lookups

In mtrr_type_lookup(), if the input memory address region is not in the
MTRR, over 4GB, and not over the top of memory, a write-back attribute
is returned. These condition checks are for ensuring the input memory
address region is actually mapped to the physical memory.

However, if the end address is just aligned with the top of memory,
the condition check treats the address is over the top of memory, and
write-back attribute is not returned.

And this hits in a real use case with NVDIMM: the nd_pmem module tries
to map NVDIMMs as cacheable memories when NVDIMMs are connected. If a
NVDIMM is the last of the DIMMs, the performance of this NVDIMM becomes
very low since it is aligned with the top of memory and its memory type
is uncached-minus.

Move the input end address change to inclusive up into
mtrr_type_lookup(), before checking for the top of memory in either
mtrr_type_lookup_{variable,fixed}() helpers.

 [ bp: Massage commit message. ]

Fixes: 0cc705f56e40 ("x86/mm/mtrr: Clean up mtrr_type_lookup()")
Signed-off-by: Ying-Tsun Huang <ying-tsun.huang@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201215070721.4349-1-ying-tsun.huang@amd.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 23ad8e9..a29997e 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -167,9 +167,6 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	*repeat = 0;
 	*uniform = 1;
 
-	/* Make end inclusive instead of exclusive */
-	end--;
-
 	prev_match = MTRR_TYPE_INVALID;
 	for (i = 0; i < num_var_ranges; ++i) {
 		unsigned short start_state, end_state, inclusive;
@@ -261,6 +258,9 @@ u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 	int repeat;
 	u64 partial_end;
 
+	/* Make end inclusive instead of exclusive */
+	end--;
+
 	if (!mtrr_state_set)
 		return MTRR_TYPE_INVALID;
 
