Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435B528590F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJGHMQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgJGHMH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C29C0613D2;
        Wed,  7 Oct 2020 00:12:07 -0700 (PDT)
Date:   Wed, 07 Oct 2020 07:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3cQu5oaBj/Ig4zLV/fKPnYkjENaN+ZRtz2gM4nkCbU=;
        b=ca8nO5vpemphFGLiIv/owE5if/VztbcuJqCQBwVe6/iDem8TpX06gv9iH0rvMz8ZpxDTUN
        4Oc6Lsxb9SxxLLNPH2A0jNxyhQktceb+Ji4RwNtn0TbwjR/U9dET/hLaKfa5mNMvqnMNBe
        7l+LHY2E4vD6M2Mhx2wePrIc/FJ0knWwHvb/MF6D23tOkT+Vnwv0FGO6xx74J7PhS7TkSQ
        lNCJ9Ii5VxICenNN82V38IlUaswwQeLPmIhWnPUPHJAvdeDgBGRGwm/xcYB+yXbokIGT7N
        mDx/W6XN29ejCQjUWO8SURDTUV5Rf9eZUILuoHlB2A+3IezjD8A2f0UO0pAJKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3cQu5oaBj/Ig4zLV/fKPnYkjENaN+ZRtz2gM4nkCbU=;
        b=rKCYGohHAhLg5Jl/WBakkZGd3AkCk95Jv2zy2aYazNln1bWs22vlOF5yziJ27oEdOQrW7C
        J8/1gOQSgxfOfqBA==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] drivers/misc/sgi-xp: Adjust references in UV
 kernel modules
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-4-mike.travis@hpe.com>
References: <20201005203929.148656-4-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472494.7002.1526841959986940221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     788b66e34e8ab82a93c63a83ba5a9d04f2f4ae26
Gitweb:        https://git.kernel.org/tip/788b66e34e8ab82a93c63a83ba5a9d04f2f4ae26
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 06 Oct 2020 16:34:27 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 08:56:05 +02:00

drivers/misc/sgi-xp: Adjust references in UV kernel modules

Remove the define is_uv() is_uv_system and just use the latter as is.
This removes a conflict with a new symbol in the generated uv_mmrs.h
file (is_uv()).

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-4-mike.travis@hpe.com
---
 drivers/misc/sgi-xp/xp.h            | 7 +------
 drivers/misc/sgi-xp/xp_main.c       | 4 ++--
 drivers/misc/sgi-xp/xp_uv.c         | 6 ++++--
 drivers/misc/sgi-xp/xpc_main.c      | 6 +++---
 drivers/misc/sgi-xp/xpc_partition.c | 2 +-
 drivers/misc/sgi-xp/xpnet.c         | 2 +-
 6 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
index 06469b1..2b6aabc 100644
--- a/drivers/misc/sgi-xp/xp.h
+++ b/drivers/misc/sgi-xp/xp.h
@@ -17,11 +17,6 @@
 
 #if defined CONFIG_X86_UV || defined CONFIG_IA64_SGI_UV
 #include <asm/uv/uv.h>
-#define is_uv()		is_uv_system()
-#endif
-
-#ifndef is_uv
-#define is_uv()		0
 #endif
 
 #ifdef USE_DBUG_ON
@@ -79,7 +74,7 @@
 
 #define XPC_MSG_SIZE(_payload_size) \
 				ALIGN(XPC_MSG_HDR_MAX_SIZE + (_payload_size), \
-				      is_uv() ? 64 : 128)
+				      is_uv_system() ? 64 : 128)
 
 
 /*
diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 61b03fc..0eea2f5 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -233,7 +233,7 @@ xp_init(void)
 	for (ch_number = 0; ch_number < XPC_MAX_NCHANNELS; ch_number++)
 		mutex_init(&xpc_registrations[ch_number].mutex);
 
-	if (is_uv())
+	if (is_uv_system())
 		ret = xp_init_uv();
 	else
 		ret = 0;
@@ -249,7 +249,7 @@ module_init(xp_init);
 static void __exit
 xp_exit(void)
 {
-	if (is_uv())
+	if (is_uv_system())
 		xp_exit_uv();
 }
 
diff --git a/drivers/misc/sgi-xp/xp_uv.c b/drivers/misc/sgi-xp/xp_uv.c
index f15a9f2..5dcca03 100644
--- a/drivers/misc/sgi-xp/xp_uv.c
+++ b/drivers/misc/sgi-xp/xp_uv.c
@@ -148,7 +148,9 @@ xp_restrict_memprotect_uv(unsigned long phys_addr, unsigned long size)
 enum xp_retval
 xp_init_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_system());
+	if (!is_uv_system())
+		return xpUnsupported;
 
 	xp_max_npartitions = XP_MAX_NPARTITIONS_UV;
 #ifdef CONFIG_X86
@@ -168,5 +170,5 @@ xp_init_uv(void)
 void
 xp_exit_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_system());
 }
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 8a495dc..e3261e6 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -1043,7 +1043,7 @@ xpc_do_exit(enum xp_retval reason)
 
 	xpc_teardown_partitions();
 
-	if (is_uv())
+	if (is_uv_system())
 		xpc_exit_uv();
 }
 
@@ -1226,7 +1226,7 @@ xpc_init(void)
 	dev_set_name(xpc_part, "part");
 	dev_set_name(xpc_chan, "chan");
 
-	if (is_uv()) {
+	if (is_uv_system()) {
 		ret = xpc_init_uv();
 
 	} else {
@@ -1312,7 +1312,7 @@ out_2:
 
 	xpc_teardown_partitions();
 out_1:
-	if (is_uv())
+	if (is_uv_system())
 		xpc_exit_uv();
 	return ret;
 }
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 099a53b..a47b3bd 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -433,7 +433,7 @@ xpc_discovery(void)
 	 */
 	region_size = xp_region_size;
 
-	if (is_uv())
+	if (is_uv_system())
 		max_regions = 256;
 	else {
 		max_regions = 64;
diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 837d6c3..8ee3991 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -515,7 +515,7 @@ xpnet_init(void)
 {
 	int result;
 
-	if (!is_uv())
+	if (!is_uv_system())
 		return -ENODEV;
 
 	dev_info(xpnet, "registering network device %s\n", XPNET_DEVICE_NAME);
