Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22472D8C7F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 10:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405507AbgLMJ0x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 04:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405251AbgLMJ0w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 04:26:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FBCC0613CF;
        Sun, 13 Dec 2020 01:26:11 -0800 (PST)
Date:   Sun, 13 Dec 2020 09:26:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607851569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2FKsp/UvUY+SYDsBs87AhUa2pNu2au8e7VMA7lSsciA=;
        b=r3GjPN51uLqQxolKmcTD+LyJnJ6UneBvmef6MX7IfF1l5Gk8s1GjWBivqHeCbL363hJT4H
        oXwuW5X2HR11eZJFL1xM9kllUwwG3ChvmODkhTs1AdOrnAMPegGYjLm74gbJPEiYlXaXAk
        7y3jvRFBjITmYVOS70v2Cr4n/PhUR5Z43U8kVKMXmpdcIP6MxPhTl21gaX5ve/89OObi7l
        vqcQUWeXLmhsKVSmPrb7AZwLbnUtq6La2WbAVfZUNPa3pDhZxGf5hwo+/2uc9in9BZOdJ3
        cuxYABTAlzId+ermDcr7NRb+rbRHhYBkbQL2Kxtl/MiJSVRy6jneqPobljNpFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607851569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2FKsp/UvUY+SYDsBs87AhUa2pNu2au8e7VMA7lSsciA=;
        b=zvzzRx5Ee6f6VthB398dy+9AOA3tb4dDrjvZsdd5od7p6BSWozffAHws+TUKhgQkaearBz
        i0WiRcwtjRVfUcAg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Fix prototype in the !CONFIG_GENERIC_CMOS_UPDATE case
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160785156829.3364.3073127459161350249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3cabca87b329cbcbdf295be0094adbd72c7b1f67
Gitweb:        https://git.kernel.org/tip/3cabca87b329cbcbdf295be0094adbd72c7b1f67
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 12 Dec 2020 18:29:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 13 Dec 2020 10:16:31 +01:00

ntp: Fix prototype in the !CONFIG_GENERIC_CMOS_UPDATE case

In the !CONFIG_GENERIC_CMOS_UPDATE case the update_persistent_clock64() function
gets defined as a stub in ntp.c - make the prototype in <linux/timekeeping.h>
conditional on CONFIG_GENERIC_CMOS_UPDATE as well.

Fixes: 76e87d96b30b5 ("ntp: Consolidate the RTC update implementation")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeping.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7f7e4a3..929d3f3 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -303,6 +303,8 @@ extern int persistent_clock_is_local;
 extern void read_persistent_clock64(struct timespec64 *ts);
 void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 					  struct timespec64 *boot_offset);
+#ifdef CONFIG_GENERIC_CMOS_UPDATE
 extern int update_persistent_clock64(struct timespec64 now);
+#endif
 
 #endif
