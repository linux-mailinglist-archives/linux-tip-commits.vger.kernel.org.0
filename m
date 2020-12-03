Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8B2CDC52
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgLCR0D (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 12:26:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLCR0C (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 12:26:02 -0500
Date:   Thu, 03 Dec 2020 17:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607016320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ENOrf4pJnjaltkMdfBqRyQRe5scB86a028pmLJHifg=;
        b=F3gQ6KIutH7hi9RYZDmzUE90gRdytpxxaj7Sl1XgOFPUDjzHKCTBUeOiyE8vJZfaS3Qu+o
        9lvN5M6At1NpwUqsvvzyAYvm2nxSrRpAhR7QEOO4AqVf4uRSgA517LUhKvmG0qX6E9oTmT
        0gE4fjlZ6yhyNUcJDsc3xq4k1qaXjRFs2qrwz3hGVwhUDtZxzXZiO+AF6CBpd0RW9w9IXK
        BazU86qtLvbBxKqwjM9zCLgE3oC3VbpTSe1Je7S4t9WdffEU6ZQrSpxxTFecmTcwGaq0Rv
        ibwq6UgOYkmk0/lhrEL7BE4e4O/Pb2Z7fdvGEz+6uzrSAT62oX7L3qneuU6XLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607016320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ENOrf4pJnjaltkMdfBqRyQRe5scB86a028pmLJHifg=;
        b=KknVXHRE9Z4fsxr2lz2yv7TEvoiaJU7P+ePFf15RwP7wsv4131lBmCBM/w19CP8TM9Eewe
        WPWgyqbRO1GIA2BQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Fix UV4 hub revision adjustment
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201203152252.371199-1-mike.travis@hpe.com>
References: <20201203152252.371199-1-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160701631938.3364.11621785550869389030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8dcc0e19dfbd73ad6b3172924d6da8f7f3f8b3b0
Gitweb:        https://git.kernel.org/tip/8dcc0e19dfbd73ad6b3172924d6da8f7f3f8b3b0
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Thu, 03 Dec 2020 09:22:52 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Dec 2020 18:09:18 +01:00

x86/platform/uv: Fix UV4 hub revision adjustment

Currently, UV4 is incorrectly identified as UV4A and UV4A as UV5. Hub
chip starts with revision 1, fix it.

 [ bp: Massage commit message. ]

Fixes: 647128f1536e ("x86/platform/uv: Update UV MMRs for UV5")
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Link: https://lkml.kernel.org/r/20201203152252.371199-1-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1b98f8c..235f5cd 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -161,7 +161,7 @@ static int __init early_set_hub_type(void)
 	/* UV4/4A only have a revision difference */
 	case UV4_HUB_PART_NUMBER:
 		uv_min_hub_revision_id = node_id.s.revision
-					 + UV4_HUB_REVISION_BASE;
+					 + UV4_HUB_REVISION_BASE - 1;
 		uv_hub_type_set(UV4);
 		if (uv_min_hub_revision_id == UV4A_HUB_REVISION_BASE)
 			uv_hub_type_set(UV4|UV4A);
