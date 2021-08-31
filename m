Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1599B3FC714
	for <lists+linux-tip-commits@lfdr.de>; Tue, 31 Aug 2021 14:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhHaMMF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 31 Aug 2021 08:12:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbhHaMIk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 31 Aug 2021 08:08:40 -0400
Date:   Tue, 31 Aug 2021 12:07:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630411664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaDDoay7M867wALtTdRMDh8HhxzGPAoRSjmTiOHV/vw=;
        b=eJMkotj6b7pupvQ0c+WpwVafDcAObSygLEUSmYFAqw/TeEGq5C/eLClPYIzj4zhfOqLMk3
        +khb9fBriE/5e8d6zhudB4kv+JnKs6PROgJszAtf6chj4rlnoF2UjQZv0PWXGYzkJKcjcr
        dyge3zOwoIQNFF2+YXn1JPcWVAFCZCy8AHQnZ1caDP8GxOMfnT5kkXguz+5CxAovyz7qKu
        2ckBxr758X35epyxCHbmBhvfq+FqkvKnpo95F7rNGg5fdFd+MuZq9jnbjLtJ+E9u2BQZHj
        jqXFjEKJ41lTSFLq3bWqa2GQXe6PkOIBzPxg9ucmMNeGunSBYNSxT7UWFSTiJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630411664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaDDoay7M867wALtTdRMDh8HhxzGPAoRSjmTiOHV/vw=;
        b=xUwaRzdPR9fMD+Z19uzhbfi3U9X85NtXW7/wIK9zttf9RVleTu6t9NPyz4RwC5aP4STEhn
        Gsx4QGcwTJ5l8ZDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix Intel SPR CHA event constraints
Cc:     Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1629991963-102621-5-git-send-email-kan.liang@linux.intel.com>
References: <1629991963-102621-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163041166337.25758.16682118767145913282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9d756e408e080d40e7916484b00c802026e6d1ad
Gitweb:        https://git.kernel.org/tip/9d756e408e080d40e7916484b00c802026e6d1ad
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 26 Aug 2021 08:32:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 31 Aug 2021 13:59:36 +02:00

perf/x86/intel/uncore: Fix Intel SPR CHA event constraints

SPR CHA events have the exact same event constraints as SKX, so add the
constraints.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1629991963-102621-5-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d941854..ce85ee5 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5649,6 +5649,7 @@ static struct intel_uncore_type spr_uncore_chabox = {
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
 	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
 	.num_shared_regs	= 1,
+	.constraints		= skx_uncore_chabox_constraints,
 	.ops			= &spr_uncore_chabox_ops,
 	.format_group		= &spr_uncore_chabox_format_group,
 	.attr_update		= uncore_alias_groups,
