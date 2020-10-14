Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5AF28E373
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgJNPnY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 11:43:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59464 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgJNPnY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 11:43:24 -0400
Date:   Wed, 14 Oct 2020 15:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602690201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mpOy9K1flk/vxzl9xD64ffVDuS3YqxEYQAqDaJFd0w=;
        b=y9rh7IhkMPM3D0pTsaGI3NxMYJrcuKyk26QrEMkQgkc6N9mBTDvcpofPynp4tAP44NN2y1
        wjibpw/+nCMv+0gPGqav49MTNqrwmqR4M9vlEeQbyr8CBwn6zmnA/VaMaz5ozU5Q6WNHNU
        ZrEy8FhAe2rDmyO8lH2M2o3JKpEckGw3megwtbzM2zSgk2OKO8/NQkTRcb8W2hSaCoSXLY
        gbQf5tjl+kGgSLjRrzOSuH7wFKPQtYT75ROEL7UcRutk6Lyc3Gvftt5pRTM9rX2imMaNcw
        Re8k4+KSnmprkwlTw8h8YQu8zF+a1Q3CkdawaZhXxpjCS7fvcroYvDgQ0yq83w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602690201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mpOy9K1flk/vxzl9xD64ffVDuS3YqxEYQAqDaJFd0w=;
        b=C0XFs60Mo7tpRBeiP4xPaDDd0p76Fo4lCciHhzq704h7ktyMKgPPeFF5M8LCZfsQDzYtRT
        F8jMk5ZBQZ16HYCw==
From:   "tip-bot2 for Kairui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] hyperv_fb: Update screen_info after removing old
 framebuffer
Cc:     Kairui Song <kasong@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>, Wei Hu <weh@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201014092429.1415040-3-kasong@redhat.com>
References: <20201014092429.1415040-3-kasong@redhat.com>
MIME-Version: 1.0
Message-ID: <160269020010.7002.11896111566490290262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3cb73bc3fa2a3cb80b88aa63b48409939e0d996b
Gitweb:        https://git.kernel.org/tip/3cb73bc3fa2a3cb80b88aa63b48409939e0d996b
Author:        Kairui Song <kasong@redhat.com>
AuthorDate:    Wed, 14 Oct 2020 17:24:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 Oct 2020 17:05:26 +02:00

hyperv_fb: Update screen_info after removing old framebuffer

On gen2 HyperV VM, hyperv_fb will remove the old framebuffer, and the
new allocated framebuffer address could be at a differnt location,
and it might be no longer a VGA framebuffer.

Update screen_info so that after kexec the kernel won't try to reuse
the old invalid/stale framebuffer address as VGA, corrupting memory.

[ mingo: Tidied up the changelog. ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Jake Oshins <jakeo@microsoft.com>
Cc: Wei Hu <weh@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Link: https://lore.kernel.org/r/20201014092429.1415040-3-kasong@redhat.com
---
 drivers/video/fbdev/hyperv_fb.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 02411d8..e36fb1a 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1114,8 +1114,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 getmem_done:
 	remove_conflicting_framebuffers(info->apertures,
 					KBUILD_MODNAME, false);
-	if (!gen2vm)
+
+	if (gen2vm) {
+		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
+		screen_info.lfb_size = 0;
+		screen_info.lfb_base = 0;
+		screen_info.orig_video_isVGA = 0;
+	} else {
 		pci_dev_put(pdev);
+	}
 	kfree(info->apertures);
 
 	return 0;
