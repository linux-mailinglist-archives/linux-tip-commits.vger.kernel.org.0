Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C47C24A108
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgHSOC7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgHSOCr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E70C061757;
        Wed, 19 Aug 2020 07:02:46 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845763;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxItqI+MXVfAQhADfcV+T8vg4ucBEyiaO/XGtNNK1Z4=;
        b=a1rBEe6hTq2VOpRwPDBAFewgDDdzkixUp7sDNXLUTE+dd9p3AWfqfdW/NvWICR4ESCqU/8
        fgTahcNpgwaqz2QxlNLOqKmtdAaQqY3ph3YqE8grVnWjo2kgBMLgErVvya/CpXk5pClp12
        0ufo2GTPYMekzgeTsqBGlVqmR3BVqYL5onhZaSydKFv+5wHqoD0yewqVlsosh3p9GBOSI0
        EOLrYuDbLmtxTguUB5NTKI4w4Kdf254eYcIhFPNg0481jSLMYpRsAR5BFyIbJ+mEte6iUW
        l+UCY5LgwJVfPlRzhk2frpPEelrtHPPWkYuHxJOVTXI4IejWH9IMUjJ7CWBNhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845763;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxItqI+MXVfAQhADfcV+T8vg4ucBEyiaO/XGtNNK1Z4=;
        b=w+hGBs4pwfblBBgJ52cihQwYrBhMaH0oh6qI48vzJp8vgpys3WW1Yg92M/4HEtJwh5iZL3
        iSFsoNXuHZlqRoAQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark SD_OVERLAP as SDF_NEEDS_GROUPS
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-16-valentin.schneider@arm.com>
References: <20200817113003.20802-16-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576240.3192.13249038734963416301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3551e954f5d95faf3dbc340d422da7624658c230
Gitweb:        https://git.kernel.org/tip/3551e954f5d95faf3dbc340d422da7624658c230
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:30:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:50 +02:00

sched/topology: Mark SD_OVERLAP as SDF_NEEDS_GROUPS

A sched_domain can only have overlapping sched_groups if it has more than
one group.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-16-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 2998ece..29af5f0 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -143,8 +143,9 @@ SD_FLAG(SD_PREFER_SIBLING, SDF_NEEDS_GROUPS)
  * sched_groups of this level overlap
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
+ * NEEDS_GROUPS: Overlaps can only exist with more than one group.
  */
-SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT)
+SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Cross-node balancing
