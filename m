Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2150424A107
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHSOC4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgHSOCr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76DC061383;
        Wed, 19 Aug 2020 07:02:46 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845762;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ckJeiS/DWXHXyS8NzN3xiQGdTAKjAdTUNsWAa4Smc4=;
        b=F9KtcfA+U7ABojo1+QaSBTOvfbljwPjrU3zmUejWaNXilwzCznU0RW+Jl6sAU3ho+zAEfv
        K3gjHfQVCIyZxmIcjGwn/1iF4F/wUvmcvkzYDhxkY98F+6rE8RNiIpMC6WacAelEF/mYMS
        sMOc/ZARp8YVcIXX0lRIA9dbFgB53O+O18EvAQl1pvCIB03AhUzZhM0ND0v9hFaw3y4Xf2
        v08w4WGKu8ea6XwKcSOW5/hwlu41DurJqAnJ7JUd2mF9DYWlniIwI6M8gYn+t6L0c3quMB
        i1XP002ZgXEwU83HzgAJ6CwXvAhXeBRNertculuEf95eBbzV7G8iii90GJjmMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845762;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ckJeiS/DWXHXyS8NzN3xiQGdTAKjAdTUNsWAa4Smc4=;
        b=DyQ12eXkc3sE7lKU1IgRyjsCRv3EGw7P+Wkp42P/YrXjPBLKhY52mikuBWWGXMOwmEdFeb
        Xs8YvpWK2sXs6PCA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark SD_NUMA as SDF_NEEDS_GROUPS
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-17-valentin.schneider@arm.com>
References: <20200817113003.20802-17-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576167.3192.9507446083732831397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5f4a1c4ea44728aa80be21dbf3a0469b5ca81d88
Gitweb:        https://git.kernel.org/tip/5f4a1c4ea44728aa80be21dbf3a0469b5ca81d88
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:30:02 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:50 +02:00

sched/topology: Mark SD_NUMA as SDF_NEEDS_GROUPS

There would be no point in preserving a sched_domain with a single group
just because it has this flag set. Add it to SD_DEGENERATE_GROUPS_MASK.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-17-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 29af5f0..34b21e9 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -151,5 +151,6 @@ SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  * Cross-node balancing
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
+ * NEEDS_GROUPS: No point in preserving domain if it has a single group.
  */
-SD_FLAG(SD_NUMA, SDF_SHARED_PARENT)
+SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
