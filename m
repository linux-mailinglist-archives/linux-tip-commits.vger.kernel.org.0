Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727A22AA121
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgKFX1n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgKFX1c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08EC0613CF;
        Fri,  6 Nov 2020 15:27:31 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WRMCRF28h6pRNY5hY+19Ww4ZXSpZ2AcoJ/LlhK308E=;
        b=pHak251JknweP0zgyEwTO90GPSqg0FH5Q9d0kQ+REazkDQnHt9ZzDaY5Wj4irJsoiNjqGG
        PAOY89/W6wYcHEOak6A+/5SNPE4GGYEPy7wcqyxtVbaIFL85vRYZtn4v5/H322u8D6N0xw
        e8q9ZeJSzmpig2E7DV5vszEcDePo6rRwEIflq2pqVBmTUWMcBTm2w8jXfNntR2aWsxqz/t
        eDtB+keXuV2yrsPB1e8B20sWbpTDtqs1chCHjSh21C3MkwPru3z58ko68EZBozPbkEp4e6
        BQlDl6EkwsorIwPB5Tb9eR40UkxWyGOJxfi67Jduusdx/zxtylzrg2/kkB3zrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WRMCRF28h6pRNY5hY+19Ww4ZXSpZ2AcoJ/LlhK308E=;
        b=O4J1yGNBnucmHzAL3Wn4gZ4PWB1T0Vj65ZPTYXWSntxgnYdm9WpIJ/fjD08t4blI1eWr0b
        bzyhYty5O2U32UDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] fs: Remove asm/kmap_types.h includes
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095856.870272797@linutronix.de>
References: <20201103095856.870272797@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524828.397.14799125635929085668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     e8f147dc3f1f6b4c27b2eeaf82df4f469d80d469
Gitweb:        https://git.kernel.org/tip/e8f147dc3f1f6b4c27b2eeaf82df4f469d80d469
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:53 +01:00

fs: Remove asm/kmap_types.h includes

Historical leftovers from the time where kmap() had fixed slots.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Sterba <dsterba@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20201103095856.870272797@linutronix.de

---
 fs/aio.c         | 1 -
 fs/btrfs/ctree.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index c45c20d..0247daf 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -43,7 +43,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 
-#include <asm/kmap_types.h>
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0378933..01947f6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -17,7 +17,6 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <trace/events/btrfs.h>
-#include <asm/kmap_types.h>
 #include <asm/unaligned.h>
 #include <linux/pagemap.h>
 #include <linux/btrfs.h>
