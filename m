Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2024A10F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHSODo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 10:03:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHSOCs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:48 -0400
Date:   Wed, 19 Aug 2020 14:02:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845763;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybfux/plDej2QnCzVvPtT6lQnEJJ3FMCNAnFRx96xA8=;
        b=ssCXA3y5JVn4qJ573glyS/j+Wse1v8bY2u7sU7MvI3CIPYtZHstfoLKeEirlbfq9SVN1/M
        iauhOFtRIc4BWjrjq2wMRyJWQo94YiAM5/1MkKcProWMA1OO8eOg/StO4SONXwn6i/a76v
        ByaFgt8S6L+dHOTd1AIQdR6RErVa/SreiukuQbPprAcsJ+7Ldye8cEh2plOutnoYhaz3t9
        jUAZDpzo2tYgNr9jRzDIGxMZRU5c8sBr/VPA0iwbUEMSRt3JqtAgTRnDjjuilQAnCxppma
        1yZPE2tb6LdepctICX7pd5tqkMEvwjpbIH+67wzVWRuhk1QSUx1PQUDVjnEcsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845763;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybfux/plDej2QnCzVvPtT6lQnEJJ3FMCNAnFRx96xA8=;
        b=8FBJQKJ/ld0axqqIKW+nvajv3NkoTxXBQ9gVdUqghLxnpNuCKTT1muBKgWFRoeWneEQcmr
        /dN7R4NI9jM8C9AQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark SD_ASYM_PACKING as SDF_NEEDS_GROUPS
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-15-valentin.schneider@arm.com>
References: <20200817113003.20802-15-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576306.3192.8158218605534227857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     33199b0143daf4778d6301f966cb914d75f122eb
Gitweb:        https://git.kernel.org/tip/33199b0143daf4778d6301f966cb914d75f122eb
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:30:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:49 +02:00

sched/topology: Mark SD_ASYM_PACKING as SDF_NEEDS_GROUPS

Being a load-balancing flag, it requires 2+ groups to have any effect.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-15-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index b7f4d80..2998ece 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -123,10 +123,11 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  * Place busy tasks earlier in the domain
  *
  * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
- * up, but currently assumed to be set from the base domain upwards (see
- * update_top_cache_domain()).
+ *               up, but currently assumed to be set from the base domain
+ *               upwards (see update_top_cache_domain()).
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD)
+SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Prefer to place tasks in a sibling domain
