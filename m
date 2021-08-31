Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE03FC711
	for <lists+linux-tip-commits@lfdr.de>; Tue, 31 Aug 2021 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhHaMMD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 31 Aug 2021 08:12:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58222 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbhHaMIj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 31 Aug 2021 08:08:39 -0400
Date:   Tue, 31 Aug 2021 12:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630411662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfE6sDSlEXHN6Eq4P7yLDnHMtkM+k07CjBn/hRXx/v4=;
        b=W1stIPT5m0V54NjS2d2YNiL6VeFxowwJGlR+2NOJAN8vPQghEpWLhOuzCnlUPYM7LxAaer
        84UocqWesZLbL6WpK6+/blp5WnBA7uSCndw/DNDxMY2WzWqY5kL9OHnxNQgCJxBlYu3Up+
        DK2lzgojmhpllCKaSo4u83WJEeW47WbKpTTeLNkNmcneJaa2X8Rxq+E99l31fkV4eadXay
        anDh3ZUezpFjWfECnVT6UdPqHg4YIagy5ZqWnRqJBiLkp8MP3Va0yYtoz304EomcstXh5C
        qDhOlY31MgIPBrKOC08uL+oL3cUFxzYt5n14gg+7Zh8dtW0efmqH787LgOWhxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630411662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfE6sDSlEXHN6Eq4P7yLDnHMtkM+k07CjBn/hRXx/v4=;
        b=w567Vg/OfWdtVqZvrgo1UQVekrc01v5lf9WMhCk9poWHEuiGKSzd23WW2aNy5Kuki2FmnQ
        Sb+Y2NY+CrnUDXBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix Intel SPR M3UPI event constraints
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1629991963-102621-8-git-send-email-kan.liang@linux.intel.com>
References: <1629991963-102621-8-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163041166071.25758.13557631748713413002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4034fb207e302cc0b1f304084d379640c1fb1436
Gitweb:        https://git.kernel.org/tip/4034fb207e302cc0b1f304084d379640c1fb1436
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 26 Aug 2021 08:32:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 31 Aug 2021 13:59:37 +02:00

perf/x86/intel/uncore: Fix Intel SPR M3UPI event constraints

SPR M3UPI have the exact same event constraints as ICX, so add the
constraints.

Fixes: 2a8e51eae7c8 ("perf/x86/intel/uncore: Add Sapphire Rapids server M3UPI support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1629991963-102621-8-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index cd53057..eb2c6ce 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5776,6 +5776,7 @@ static struct intel_uncore_type spr_uncore_upi = {
 static struct intel_uncore_type spr_uncore_m3upi = {
 	SPR_UNCORE_PCI_COMMON_FORMAT(),
 	.name			= "m3upi",
+	.constraints		= icx_uncore_m3upi_constraints,
 };
 
 static struct intel_uncore_type spr_uncore_mdf = {
