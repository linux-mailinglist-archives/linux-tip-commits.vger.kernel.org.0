Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EA671C02
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jan 2023 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjARM0c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Jan 2023 07:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjARMZH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Jan 2023 07:25:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00C69213;
        Wed, 18 Jan 2023 03:45:30 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:45:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674042329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eguYxvYQvWOq87mQBf1IYFW3ssD3uE2OjKvba4U0DD0=;
        b=1nb7vQZEh7dBfP1gioow3zjqH0CKSY6VxOyhclmTJiGAK/2gQxPxcHsAwniiKMX0+lXDVl
        x0NLLRMBdy1HgLgU8nHNeXMaIj9OnfaCMVKUDILvgEm5fg0+m9pmrldf3FS+XSt+yfZA6Q
        ngySeo4PNVOO9KNNcPlHgaO7uKy+ObN//8aHM9Hh8n+sDLTzLap9FZPLEqNZKxglX82I7Y
        9ScOc+21ZBXHp+hP6GYKrb9EBwbr8cgvGeWD71yv8ayX5sl6Yt/PZPULtJr3WBsThJN3K/
        tVfeCcJVoUyJgOJn08tkHOgxeypGxgRBrSTYjKeb4cQT0xrXI9JBzBXNb3Zlbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674042329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eguYxvYQvWOq87mQBf1IYFW3ssD3uE2OjKvba4U0DD0=;
        b=nOak67VhUZDY2Wh9xxZntDJf+2uQ6xyI9i3j8ooOE9w4d6QyPMJMdp/y4UMzcv5RYWgteq
        AmG+W6VMIOeIpiAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/cstate: Add Emerald Rapids
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230106160449.3566477-2-kan.liang@linux.intel.com>
References: <20230106160449.3566477-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167404232856.4906.5130030313856361485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5a8a05f165fb18d37526062419774d9088c2a9b9
Gitweb:        https://git.kernel.org/tip/5a8a05f165fb18d37526062419774d9088c2a9b9
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 06 Jan 2023 08:04:47 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 12:42:49 +01:00

perf/x86/intel/cstate: Add Emerald Rapids

>From the perspective of Intel cstate residency counters,
Emerald Rapids is the same as the Sapphire Rapids and Ice Lake.
Add Emerald Rapids model.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230106160449.3566477-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 3019fb1..551741e 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -677,6 +677,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&icx_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
