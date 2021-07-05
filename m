Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB73BB855
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhGEH4Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhGEH4U (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:20 -0400
Date:   Mon, 05 Jul 2021 07:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiytURJ6KBy/ai/Dp2EW9jEZkFghg8on+uPdErHGkm4=;
        b=BktPSi9sQvepwpBknqJfvSG0GnaOz1Q2oHw7a8ppS/24FezUwTKJ01hEH7VbHIAGogsrXg
        URDFEsJyfu+xmfgq61bv5R2xTkMZbF5nSDtBipvsehZRIk6XLpUNnHGunZhS2XD8N+sIEd
        ChbmOLYicRjnKrCFcmAH5YfGusFFi+mZYW+5cT0sVvFRWe/Zgbn0XHstZw/5Ks0Yej5uJx
        vhm5qIlDIeYKk8UX2aDW8+2/T363nRmyKLHQ5qaPtQzaoanpcavbPmaNPFLbQRZ4c98bBe
        79sOlvZphMnOI7jx8gST++I6NcSrXp689gkUFA43UK4UcnTrTEG0rHUGImmMcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiytURJ6KBy/ai/Dp2EW9jEZkFghg8on+uPdErHGkm4=;
        b=sIVbDLtnbuGA5czPvLo+KYc3kJOHZN7zFJVNvqA3LbaOViJnuZWwlx5SgKEQc96vBRg+V4
        Wv3XuB6wAkxit8Cg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 UPI support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-10-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-10-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162210.395.7315211190167341440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da5a9156cd2a3be2b00f8defb529ee3e35e5769b
Gitweb:        https://git.kernel.org/tip/da5a9156cd2a3be2b00f8defb529ee3e35e5769b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:33 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:39 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server UPI support

Sapphire Rapids uses a coherent interconnect for scaling to multiple
sockets known as Intel UPI. Intel UPI technology provides a cache
coherent socket to socket external communication interface between
processors.

The layout of the control registers for a UPI uncore unit is similar to
a M2M uncore unit.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-10-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 72ba8d4..20045ba 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5698,6 +5698,11 @@ static struct intel_uncore_type spr_uncore_m2m = {
 	.name			= "m2m",
 };
 
+static struct intel_uncore_type spr_uncore_upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "upi",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5709,7 +5714,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	NULL,
 	&spr_uncore_imc,
 	&spr_uncore_m2m,
-	NULL,
+	&spr_uncore_upi,
 	NULL,
 	NULL,
 	NULL,
