Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0618728E370
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgJNPnX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 11:43:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59468 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgJNPnX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 11:43:23 -0400
Date:   Wed, 14 Oct 2020 15:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602690201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdwtKkZDdyzWvKjhd4L8ijmt3BqvbwVLIQ5uAEObevk=;
        b=L+P5J8Gx5l+eF0NXLI8AGT/5xEEuS99C89+TRuXr81OQIks5j08MjknWmZlv9vVFJ6bgOt
        IvEI8vRtjmCktMKUjecFqoyG0V9Bk4lITHX6qSYsUDNds/e8xMaJ5GPdw9Brx7Lm1fD86Q
        q1QjDi/LyWLTTxOsBwq9pK0WT7w1Cst78xyppGewuWpJHEQr+Kkj6M0jEgXaf2qCW3HVvg
        TaMLG7/qgWP4FlAPpH7x1BPIVgLE39+MOOdK8BUl9p7o5d98D6S1o+aTORQb28UqPRNOae
        QAVPh+TOXxIOw/rN2iU85TTg+k8xBuu4/UfmeH9MYVtCpi5V2fEAZWZrLIlpTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602690201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdwtKkZDdyzWvKjhd4L8ijmt3BqvbwVLIQ5uAEObevk=;
        b=lrCc6r0ZWGMenJp6cMY9fHE7Wbwc6dcNwIY0H7BhmpU3snIq5SO+qEw0mYQHmYWE3uaE9L
        k7W7FvR/TBlSvIBA==
From:   "tip-bot2 for Kairui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kexec: Use up-to-dated screen_info copy to fill
 boot params
Cc:     Kairui Song <kasong@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201014092429.1415040-2-kasong@redhat.com>
References: <20201014092429.1415040-2-kasong@redhat.com>
MIME-Version: 1.0
Message-ID: <160269020077.7002.6607120194042289745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     afc18069a2cb7ead5f86623a5f3d4ad6e21f940d
Gitweb:        https://git.kernel.org/tip/afc18069a2cb7ead5f86623a5f3d4ad6e21f940d
Author:        Kairui Song <kasong@redhat.com>
AuthorDate:    Wed, 14 Oct 2020 17:24:28 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 Oct 2020 17:05:03 +02:00

x86/kexec: Use up-to-dated screen_info copy to fill boot params

kexec_file_load() currently reuses the old boot_params.screen_info,
but if drivers have change the hardware state, boot_param.screen_info
could contain invalid info.

For example, the video type might be no longer VGA, or the frame buffer
address might be changed. If the kexec kernel keeps using the old screen_info,
kexec'ed kernel may attempt to write to an invalid framebuffer
memory region.

There are two screen_info instances globally available, boot_params.screen_info
and screen_info. Later one is a copy, and is updated by drivers.

So let kexec_file_load use the updated copy.

[ mingo: Tidied up the changelog. ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20201014092429.1415040-2-kasong@redhat.com
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 57c2ecf..ce831f9 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
 
 	/* Copying screen_info will do? */
-	memcpy(&params->screen_info, &boot_params.screen_info,
-				sizeof(struct screen_info));
+	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
 
 	/* Fill in memsize later */
 	params->screen_info.ext_mem_k = 0;
