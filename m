Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4543BB852
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGEH4X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGEH4T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC752C061762;
        Mon,  5 Jul 2021 00:53:42 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UWtIdB60ggNteSxD1rKTe7pRomRiFM3rpNtz4RTIZ0=;
        b=Vqnj+GcaDACXXCZnd7ovcny+LEqEcheWkqzXzN+IE3W37UZ6qvqI353TgBcRjWmiMm1hN+
        bvBazjKqjoMRn1SkpGPY5ZMn4dJxr0bBqStVOVWfs+9qZNLvED7Z0eAnUrex8BzXuoqy+G
        PbJdK16dZ1mLGd8CH2/ZXiuQe90hIJC5P4ZfR0OqjE1CZnkE9eNr/v4m/y+27g6ANTUDtz
        kK8CgQSSutJF9+f3OesgysDYOKDBmfgQzZkv0NI+juTFI+o21OySEacSR06U8g0XZuVs7p
        s8kEBoPABzewYUvCAxzAkbBiiZono27NNLE2edxkXwHlPUNs3ZiUhe7gXakBbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UWtIdB60ggNteSxD1rKTe7pRomRiFM3rpNtz4RTIZ0=;
        b=lmYaRjCMpvW2m2mBjjE12Q8mtTTlIgAo1ywHu2FpqHXNAG0r7si+KooFfXeNTucoVm6IiJ
        T2WQoNjAThnZ2PAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 MDF support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-12-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-12-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162074.395.5088849995351352259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0d771caf728436d9ebc2cd1d50bed71685bfe7d8
Gitweb:        https://git.kernel.org/tip/0d771caf728436d9ebc2cd1d50bed71685bfe7d8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:40 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server MDF support

The MDF subsystem is a new IP built to support the new Intel Xeon
architecture that bridges multiple dies with a embedded bridge system.

The layout of the control registers for a MDF uncore unit is similar to
a IRP uncore unit.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-12-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 14b9b23..1b9ab8e 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5708,6 +5708,11 @@ static struct intel_uncore_type spr_uncore_m3upi = {
 	.name			= "m3upi",
 };
 
+static struct intel_uncore_type spr_uncore_mdf = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "mdf",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5722,7 +5727,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_upi,
 	&spr_uncore_m3upi,
 	NULL,
-	NULL,
+	&spr_uncore_mdf,
 };
 
 static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
