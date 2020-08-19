Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B445524A13C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgHSOF5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHSOCr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503CC061343;
        Wed, 19 Aug 2020 07:02:46 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KlUDXAISjSrDI5ljamC2YtWOgQzG2FcrXXK336l8/s=;
        b=DkayOpHQoUUzri9U1kCyYmqWQ4xzLHvNoK3rAlVVkXwuJ5OZzz2tQ8xO6mfnLUHHj7MoR0
        /avbEub+REMELPRi14MNUi6gfYcxbChLNrNsJBPT7VZK8X2tQEIj0KG8IFomVBIgrVeZAY
        7Q8yOv1yEVuIaXBQBXI5aLE9W+iMWyy+0PL6UoHYhkxJJiSP1ihceOgA5wxhwkxfSJSLsZ
        1/YxIg/0p7A70Da6byYnP6zNxDaMkNeXuXQTtPVoVDCXgwInyfQ+cHvCpniKYD1+NlkYAR
        uNVaxH1cUrXZEUczzkpqMqOensqbK6CiB/kIrgwUlwg4It2LkKfcRbozIeBRSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KlUDXAISjSrDI5ljamC2YtWOgQzG2FcrXXK336l8/s=;
        b=I1ApoD8M3TrfsqAviXXFLeAEFcfxNmdzT5WbAO/J9BNf5wdBDfXTFl0ENDRf4x0uzse69p
        ChrFEK7SIVBBLADw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark SD_BALANCE_WAKE as SDF_NEEDS_GROUPS
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-13-valentin.schneider@arm.com>
References: <20200817113003.20802-13-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576438.3192.5642714675174743483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     94b858fea1f2246a2fb7f7af21840fd14ced028f
Gitweb:        https://git.kernel.org/tip/94b858fea1f2246a2fb7f7af21840fd14ced028f
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:49 +02:00

sched/topology: Mark SD_BALANCE_WAKE as SDF_NEEDS_GROUPS

Even if no mainline topology uses this flag, it is a load balancing flag
just like SD_BALANCE_FORK and requires 2+ groups to have any effect.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-13-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index d28fe67..729510a 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -70,8 +70,9 @@ SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
  * Balance on wakeup
  *
  * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_WAKE, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_WAKE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Consider waking task on waking CPU.
