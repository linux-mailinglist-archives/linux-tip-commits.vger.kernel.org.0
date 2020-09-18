Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9626F735
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIRHmi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgIRHmc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BF1C06174A;
        Fri, 18 Sep 2020 00:42:32 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amQsudwaM7dQyRL1V3JHlgjmezj4ww2nyNxuOnA88hw=;
        b=EESe9E7j+E83Ke3tDLJqW7YWDaZ/rrqmnswGws2yQf09r78ZRBMe4X4ayRxueI6T98NNed
        4w6+xtwz1MlcSMtwzeSBanPjY5Z87+ENqm2EEEFch+QmLKc9glf46M9mgJIserjW8/gNdu
        jx7Ozq0Xw5B4wbLM8Mg2bBk6lKEFeQYO+txIbEX2fh0v5JvV0qxkFs9Ts2b0brL5z5/CE0
        T3HIjQRVLZKuyyIDARZ6F0j6LvV939A2IL8eFEQaOndL0G1nNZtbY+EOeFHmVq4kjLfAtf
        t2uUHTEP4T7YuKZ5DsgH3/O94milOpO8YqblbwxMJJhHVXk20K9fRol6tcPfkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amQsudwaM7dQyRL1V3JHlgjmezj4ww2nyNxuOnA88hw=;
        b=ClcoxsVRqBfAqMxHNXYSDAo+kAwzX5ZJ28I8TRIh0HiPQLrvygicjRcuKeLEdwSFR0ClmO
        8uEfGZoBmNyYKNBQ==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] mm: Add a pasid member to struct mm_struct
Cc:     Christoph Hellwig <hch@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-8-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-8-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041495015.15536.4295027285506021453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     52ad9bc64c74167466e70e0df4b99ee5ccef0078
Gitweb:        https://git.kernel.org/tip/52ad9bc64c74167466e70e0df4b99ee5ccef0078
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:11 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 20:22:15 +02:00

mm: Add a pasid member to struct mm_struct

A PASID is shared by all threads in a process. So the logical place to
keep track of it is in the mm_struct. Both ARM and x86 would use this
PASID.

 [ bp: Massage commit message. ]

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1600187413-163670-8-git-send-email-fenghua.yu@intel.com
---
 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff..1ff0615 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -542,6 +542,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+
+#ifdef CONFIG_IOMMU_SUPPORT
+		u32 pasid;
+#endif
 	} __randomize_layout;
 
 	/*
