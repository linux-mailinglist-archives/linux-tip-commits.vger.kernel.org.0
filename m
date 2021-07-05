Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32D83BB858
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhGEH40 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhGEH4X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:23 -0400
Date:   Mon, 05 Jul 2021 07:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PgD926HiSZpq2NR27GkHYIMofaeeZNwfoQTH+5IjCY=;
        b=S9cYYqj0jQWPPr6BAplT0D18bYSgnS7vf/rECNrHQUX3a0sTMRIu23Ta0PDtXJHm8+wp0l
        xqoIE18dvDkdoO6ag3yelSD8sEP8a0ZX8uhBb2nf3Jqty0V25yBGhOqtIxIw10EmboLACa
        xvgc32r/JCIs0waIWelkaoK9T0xzpkFbLdpS+hS9KLm9fHTCY5QapMZv2drtTmmws5FeQO
        0BgJWvZH3V7W6KGqd2BSr9T7HcSDULELihfaE1ge6QGxvqEnT0x7TTQS/5Mjvl/wEyD7JM
        k1Md4ZJyWxP1tNr0ozuDpf4PtSVzBXdCOUyiVWZiMpReQD1gesDjgkJuYKXsBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PgD926HiSZpq2NR27GkHYIMofaeeZNwfoQTH+5IjCY=;
        b=xaJnNBqcLoGmsHIo2Nztc4D8yM72tdmidbMKrhE4g+PRi0SsAjlwaUaJn5aGKD3DtVCRyD
        N2m7VbMNqMS9HvDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 M2PCIe support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-6-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162468.395.427435366159508589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f85ef898f8842b2a9a8f51a64eaf45ee2a8bb1f7
Gitweb:        https://git.kernel.org/tip/f85ef898f8842b2a9a8f51a64eaf45ee2a8bb1f7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:38 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server M2PCIe support

M2PCIe* blocks manage the interface between the mesh and each IIO stack.

The layout of the control registers for a M2PCIe uncore unit is similar
to a IRP uncore unit.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-6-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index de5a6d1..890a982 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5628,13 +5628,18 @@ static struct intel_uncore_type spr_uncore_irp = {
 
 };
 
+static struct intel_uncore_type spr_uncore_m2pcie = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "m2pcie",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
 	&spr_uncore_iio,
 	&spr_uncore_irp,
-	NULL,
+	&spr_uncore_m2pcie,
 	NULL,
 	NULL,
 	NULL,
