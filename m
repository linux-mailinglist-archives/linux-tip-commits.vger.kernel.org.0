Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9692B37B868
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 10:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhELIsy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhELIsx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 04:48:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56402C061761;
        Wed, 12 May 2021 01:47:45 -0700 (PDT)
Date:   Wed, 12 May 2021 08:47:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620809263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQheMuVOvvuHGyocn6u884NV2M1cxe0aC3IuTqIBdNc=;
        b=Zsl/GvcgZzszp0Q5HACHevfAYzO6tffHpbo4uULiHIlV9gjKtvdbYI7t2U2egqmJ6gu+JO
        KCJqyGsLxoxwz0Pn9XK6G6Y+q936GJmh2wfwbqy5ZGqhH/6bhdlnG54Ea37vHzJSfbLiyI
        fownwfn8F/SjyqMpLZ5o+l7mRrMhNjE57HHFMyRvfxQmrEowKA0SfGEgiE9CFvlzgKcthY
        Adcd9q5F0ED1ZJgqhlr6Ac8CAEqqJ59CF0QzxPMadXPEKgdJGRMkUQaXXunpmBcB1PeQWL
        sM7Aj1ZyvijYSTfA/zZyoDCxw+VKGFo47nNBG9E1kGbeLHMhEDRxo30GQd15rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620809263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQheMuVOvvuHGyocn6u884NV2M1cxe0aC3IuTqIBdNc=;
        b=vfPKtkp2HHQ2o4mcOdwbr3qqmuCzs3MGAcOF+KPyJL80bd/Cn5Pkw8Suc5c0xxkBpuv/b9
        X6ciRr++ByoQEADg==
From:   "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Drop unnecessary NULL checks
 after container_of()
Cc:     Guenter Roeck <linux@roeck-us.net>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210510224849.2349861-1-linux@roeck-us.net>
References: <20210510224849.2349861-1-linux@roeck-us.net>
MIME-Version: 1.0
Message-ID: <162080926219.29796.17403001869463771532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     440e906702410f59ae5397ec9e3b639edb53f80e
Gitweb:        https://git.kernel.org/tip/440e906702410f59ae5397ec9e3b639edb53f80e
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Mon, 10 May 2021 15:48:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:44:21 +02:00

perf/x86/intel/uncore: Drop unnecessary NULL checks after container_of()

The parameter passed to the pmu_enable() and pmu_disable() functions can not be
NULL because it is dereferenced by the caller.

That means the result of container_of() on that parameter can also never be NULL.
The existing NULL checks are therefore unnecessary and misleading. Remove them.

This change was made automatically with the following Coccinelle script.

  @@
  type t;
  identifier v;
  statement s;
  @@

  <+...
  (
    t v = container_of(...);
  |
    v = container_of(...);
  )
    ...
    when != v
  - if (\( !v \| v == NULL \) ) s
  ...+>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510224849.2349861-1-linux@roeck-us.net
---
 arch/x86/events/intel/uncore.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index df7b07d..9bf4dbb 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -801,8 +801,6 @@ static void uncore_pmu_enable(struct pmu *pmu)
 	struct intel_uncore_box *box;
 
 	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
-	if (!uncore_pmu)
-		return;
 
 	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
 	if (!box)
@@ -818,8 +816,6 @@ static void uncore_pmu_disable(struct pmu *pmu)
 	struct intel_uncore_box *box;
 
 	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
-	if (!uncore_pmu)
-		return;
 
 	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
 	if (!box)
