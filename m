Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07942285902
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgJGHME (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJGHMD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEBDC061755;
        Wed,  7 Oct 2020 00:12:03 -0700 (PDT)
Date:   Wed, 07 Oct 2020 07:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYRV1PLfwBf6rP9T+9D3DHBJfp4eS5t0VT1vWVHNe0M=;
        b=zIePvRPLps4kY/LiPrWg6MCsFwGxOfkq4txvw8pdxyzoR28Gm+ub7eDCk3/zQKcbcvxkk/
        PXD9lAwS4L3UGNllPpfv69jQ7EC2iKFaVBjW5udQQDgCeUE2XuFaLb4V0N98ZhnuWPf2lM
        m8tkKTb7+xC+BY4b85ZeoZdWx8ePaMUnvVePmHHTmXN0YRyBVAmWoPwTRoYUKCgKNYgPRF
        tiT+UuzTijgZK0vYlhteXWQB3znIzSKon99fUBfcYjNKj8T95NQB9Um1QU7Wec7nq2BXfm
        B1hBoaR7AQD6WZQQ/kL1uSgv5TZoZgO7wwPA6BnFNfcnqD7MJ23DA3y2RkfxAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYRV1PLfwBf6rP9T+9D3DHBJfp4eS5t0VT1vWVHNe0M=;
        b=DjJwTOjkovm4JwdW4N1vpxhq/kUXTcVzwkmJDWII6OJm3ALRa/7xqqg7Inq7GILntxrHQ0
        J1mpeMTMwRtl5dAA==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update node present counting
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-11-mike.travis@hpe.com>
References: <20201005203929.148656-11-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472130.7002.9651855394776094338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     d6922effe4f3d5c643c8c05d51a572d6db4c9cb3
Gitweb:        https://git.kernel.org/tip/d6922effe4f3d5c643c8c05d51a572d6db4c9cb3
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:26 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 09:08:35 +02:00

x86/platform/uv: Update node present counting

The changes in the UV5 arch shrunk the NODE PRESENT table to just 2x64
entries (128 total) so are in to 64 bit MMRs instead of a depth of 64
bits in an array.  Adjust references when counting up the nodes present.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-11-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 64a1c59..9b44f45 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1436,20 +1436,32 @@ static int __init decode_uv_systab(void)
 /* Set up physical blade translations from UVH_NODE_PRESENT_TABLE */
 static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 {
+	unsigned long np;
 	int i, uv_pb = 0;
 
-	pr_info("UV: NODE_PRESENT_DEPTH = %d\n", UVH_NODE_PRESENT_TABLE_DEPTH);
-	for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
-		unsigned long np;
-
-		np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
-		if (np)
+	if (UVH_NODE_PRESENT_TABLE) {
+		pr_info("UV: NODE_PRESENT_DEPTH = %d\n",
+			UVH_NODE_PRESENT_TABLE_DEPTH);
+		for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
+			np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
 			pr_info("UV: NODE_PRESENT(%d) = 0x%016lx\n", i, np);
-
+			uv_pb += hweight64(np);
+		}
+	}
+	if (UVH_NODE_PRESENT_0) {
+		np = uv_read_local_mmr(UVH_NODE_PRESENT_0);
+		pr_info("UV: NODE_PRESENT_0 = 0x%016lx\n", np);
+		uv_pb += hweight64(np);
+	}
+	if (UVH_NODE_PRESENT_1) {
+		np = uv_read_local_mmr(UVH_NODE_PRESENT_1);
+		pr_info("UV: NODE_PRESENT_1 = 0x%016lx\n", np);
 		uv_pb += hweight64(np);
 	}
 	if (uv_possible_blades != uv_pb)
 		uv_possible_blades = uv_pb;
+
+	pr_info("UV: number nodes/possible blades %d\n", uv_pb);
 }
 
 static void __init build_socket_tables(void)
