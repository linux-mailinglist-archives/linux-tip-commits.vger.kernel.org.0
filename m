Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C33B297D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhFXHls (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhFXHlp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:41:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBB3C061574;
        Thu, 24 Jun 2021 00:39:26 -0700 (PDT)
Date:   Thu, 24 Jun 2021 07:39:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624520365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpPNS4xyauniYJW56YaOHZtmEnNTVYTo3onXx7MsYO4=;
        b=3sG3bqQtMOPEHbHuxCz8U73CXymfI/TGcoPqxdJnJsJa5Z2M6CkgZ/oK9dsZc/v3VpI0PB
        PvRKBz8mvut7qsWC1dsT7FmFpAb8C7Rj8wePCMVVWNdDwYaEOoQPWTZiFuiQQt11h4/uTv
        rlr5g0D58EpcqDtSw0ZTSrSUSuwnWvuBklwTQ+f9yBJ6FkP1gIw8WEu0h/SQ3GLB3+SaK5
        pq0u+zdYhdxf2kUWGNDLoIVUwKjo8tip3nfA2XL3vr+8pkE2zPorhVNw3iyVzvX9a3CyRd
        hf/FAKkq9S+rf007RHeGvwLxNMYknaBMYtRJhmEH8CSjbr9/cjxbakJeM5Y3qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624520365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpPNS4xyauniYJW56YaOHZtmEnNTVYTo3onXx7MsYO4=;
        b=b6a/XizcP5PXXv1t4+JObUxMhOOw5wvCLybLRodIitfbCl7KIFGDHIjNOTJHiu5zhpXcoi
        zStkx+sCqiZfsHBQ==
From:   "tip-bot2 for Beata Michalska" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/doc: Update the CPU capacity asymmetry bits
Cc:     Beata Michalska <beata.michalska@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210603140627.8409-4-beata.michalska@arm.com>
References: <20210603140627.8409-4-beata.michalska@arm.com>
MIME-Version: 1.0
Message-ID: <162452036425.395.16870349433407414584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     adf3c31e18b765ea24eba7b0c1efc076b8ee3d55
Gitweb:        https://git.kernel.org/tip/adf3c31e18b765ea24eba7b0c1efc076b8ee3d55
Author:        Beata Michalska <beata.michalska@arm.com>
AuthorDate:    Thu, 03 Jun 2021 15:06:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Jun 2021 09:07:51 +02:00

sched/doc: Update the CPU capacity asymmetry bits

Update the documentation bits referring to capacity aware scheduling
with regards to newly introduced SD_ASYM_CPUCAPACITY_FULL sched_domain
flag.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20210603140627.8409-4-beata.michalska@arm.com
---
 Documentation/scheduler/sched-capacity.rst | 6 ++++--
 Documentation/scheduler/sched-energy.rst   | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 9b7cbe4..805f85f 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -284,8 +284,10 @@ whether the system exhibits asymmetric CPU capacities. Should that be the
 case:
 
 - The sched_asym_cpucapacity static key will be enabled.
-- The SD_ASYM_CPUCAPACITY flag will be set at the lowest sched_domain level that
-  spans all unique CPU capacity values.
+- The SD_ASYM_CPUCAPACITY_FULL flag will be set at the lowest sched_domain
+  level that spans all unique CPU capacity values.
+- The SD_ASYM_CPUCAPACITY flag will be set for any sched_domain that spans
+  CPUs with any range of asymmetry.
 
 The sched_asym_cpucapacity static key is intended to guard sections of code that
 cater to asymmetric CPU capacity systems. Do note however that said key is
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index afe02d3..8fbce5e 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -328,7 +328,7 @@ section lists these dependencies and provides hints as to how they can be met.
 
 As mentioned in the introduction, EAS is only supported on platforms with
 asymmetric CPU topologies for now. This requirement is checked at run-time by
-looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
+looking for the presence of the SD_ASYM_CPUCAPACITY_FULL flag when the scheduling
 domains are built.
 
 See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
