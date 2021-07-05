Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671F93BB856
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhGEH4Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhGEH4W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:22 -0400
Date:   Mon, 05 Jul 2021 07:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD8sN5WIcwzsuM/HBbdH8XMNg7mYSV0tsREyosKwrK4=;
        b=pfPofe+lBeu/2uvMoyPuSr4tuYmKBDNrl0MsstCC7Z6LQna5uO/WptZp6IwfP4ICzhI/BS
        +zmpzFdua171Ug4qxukTZgOGTnzsjZKgVnY75bkfmvGAWWRL9XunCWnP5ScqPFGNYLF3r/
        1vzLL0NaKjJHHx6tWWO2aZd0oPSI/O3cBL+O3yciPofajVsJkBcPzF0SQtVhwYGlJd4dCg
        rO9m0LB9pmqUzNaiPb5a+ypGWz6uJtRGigP+T1nVUTVXRdN/5Goowx2gZH+zmUXl95QWp0
        V+V+TAoqRz1SGxrpDWrD0dWZwkXyEuAt1M+3+C9PLNETEnLqQ3CM1bZjnVdSmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD8sN5WIcwzsuM/HBbdH8XMNg7mYSV0tsREyosKwrK4=;
        b=3abfUDe2Xoo8nGs5IDGrOuy9jfbTmLKHxX+Q0b9ZxvwkzkwSHTWmwBhkzHHvQyV/0tEycP
        A1LTu4pAk9Ee2iAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 PCU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-7-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162400.395.5755555096390752782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0654dfdc7e1ca30d36810ab694712da3de18440c
Gitweb:        https://git.kernel.org/tip/0654dfdc7e1ca30d36810ab694712da3de18440c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:38 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server PCU support

The PCU is the primary power controller for the Sapphire Rapids.

Except the name, all the information can be retrieved from the discovery
tables.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-7-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 890a982..913cd7a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5633,6 +5633,10 @@ static struct intel_uncore_type spr_uncore_m2pcie = {
 	.name			= "m2pcie",
 };
 
+static struct intel_uncore_type spr_uncore_pcu = {
+	.name			= "pcu",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5640,7 +5644,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_iio,
 	&spr_uncore_irp,
 	&spr_uncore_m2pcie,
-	NULL,
+	&spr_uncore_pcu,
 	NULL,
 	NULL,
 	NULL,
