Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF824530E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Aug 2020 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgHOV6B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 15 Aug 2020 17:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgHOVwA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3135DC09B04D;
        Sat, 15 Aug 2020 08:47:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597506409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhVDuc+GBmgbisdIWALz/5oYFoWo5Vw7YVssDeQ7kWs=;
        b=qKP7wYKR2wGhdmboFZQAdjVlgNTB+Nujx96/BM+7y+49dK9w6ARHyAKP+MGMCEf0RLffIv
        Q4RKqln3rkr5JodWE/QPoArjdXzAZScXjI5VjW71My2xEQGGD26dHr/ytFQVRAUrrze9jQ
        0isuWeX9oDEbONKIxgx32zoAiT5MtlVX1j8ZBlvubFso9fDwDEgN5wFZmE+9PYoqTKsJVX
        HOspw7A4q7XP0sXwMEdkVHfVoSr5Q5EBThg2P8a98wvglqBceWTZa1b8md0G+HQgferBkO
        vUdF7dAtdiInLzsj2Zc70kNQFTcWtjPsQPs36ifJubH3BLYCilOmSfLACjERKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597506409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhVDuc+GBmgbisdIWALz/5oYFoWo5Vw7YVssDeQ7kWs=;
        b=u0+eamYgoDkUvVsr5okL/2UOiz0Eqi080rkDmlCC0P0l3uuWnePNlJ3deF2dbuClEXAAWY
        VF45oX5Fop8yUSCg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/64: Update comment in preallocate_vmalloc_pages()
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200814151947.26229-3-joro@8bytes.org>
References: <20200814151947.26229-3-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159750640830.3192.8167910620509487065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     7a27ef5e83089090f3a4073a9157c862ef00acfc
Gitweb:        https://git.kernel.org/tip/7a27ef5e83089090f3a4073a9157c862ef00acfc
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 14 Aug 2020 17:19:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Aug 2020 13:56:16 +02:00

x86/mm/64: Update comment in preallocate_vmalloc_pages()

The comment explaining why 4-level systems only need to allocate on
the P4D level caused some confustion. Update it to better explain why
on 4-level systems the allocation on PUD level is necessary.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200814151947.26229-3-joro@8bytes.org
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 777d835..b5a3fa4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1252,14 +1252,19 @@ static void __init preallocate_vmalloc_pages(void)
 		if (!p4d)
 			goto failed;
 
-		/*
-		 * With 5-level paging the P4D level is not folded. So the PGDs
-		 * are now populated and there is no need to walk down to the
-		 * PUD level.
-		 */
 		if (pgtable_l5_enabled())
 			continue;
 
+		/*
+		 * The goal here is to allocate all possibly required
+		 * hardware page tables pointed to by the top hardware
+		 * level.
+		 *
+		 * On 4-level systems, the P4D layer is folded away and
+		 * the above code does no preallocation.  Below, go down
+		 * to the pud _software_ level to ensure the second
+		 * hardware level is allocated on 4-level systems too.
+		 */
 		lvl = "pud";
 		pud = pud_alloc(&init_mm, p4d, addr);
 		if (!pud)
