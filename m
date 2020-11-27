Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA392C6A20
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Nov 2020 17:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgK0Qt2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Nov 2020 11:49:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbgK0Qt2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Nov 2020 11:49:28 -0500
Date:   Fri, 27 Nov 2020 16:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606495766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IBjEXeOlEmy3hM2qVs6Dl2EjTYceZB+BznSCUxi+akI=;
        b=4z2op+FlWHTQwBucrSB6/2hl9+aNUGOUtfaOG0T87D/3XrM+H8RDp/rM9gzGg5wg4uqfjR
        YDUSemahuoVxLAHjhmDwh0BsYq28cVjhdMQH6LEMwyAVhB+Hoa2ECkomHrU2OjEnTTyXU2
        l4nZcBgmwG7erRuaBAC9bmZf0H9MZ8R4iUIrdBNI8S3FgUW/4mcA9V1SFpIgT/OAZ38xmp
        iZow3YJTUp+i/XAXSJ8daacr3RxygYtUdyu8l2deQi28q794RsA4dhEP92SXXQFbM2WPzS
        r6DiVEM6uUOrdDVV5ISA+PBLG+3XnjLIQ+p0RZgv1OQkqwO3U6oUHeTMoWnuDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606495766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IBjEXeOlEmy3hM2qVs6Dl2EjTYceZB+BznSCUxi+akI=;
        b=xmd6KqEPYtJ7+flhs+wYRtQ0h90yJUlPFeF1KEuxjDBOakF0WG1Tsfx37uNGs0BgQw7e5Q
        p4/WWBaKWl80Z4Dw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efivarfs: revert "fix memory leak in efivarfs_create()"
Cc:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160649576599.3364.9419789594382396613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     ff04f3b6f2e27f8ae28a498416af2a8dd5072b43
Gitweb:        https://git.kernel.org/tip/ff04f3b6f2e27f8ae28a498416af2a8dd5072b43
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 25 Nov 2020 08:45:55 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 25 Nov 2020 16:55:02 +01:00

efivarfs: revert "fix memory leak in efivarfs_create()"

The memory leak addressed by commit fe5186cf12e3 is a false positive:
all allocations are recorded in a linked list, and freed when the
filesystem is unmounted. This leads to double frees, and as reported
by David, leads to crashes if SLUB is configured to self destruct when
double frees occur.

So drop the redundant kfree() again, and instead, mark the offending
pointer variable so the allocation is ignored by kmemleak.

Cc: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Fixes: fe5186cf12e3 ("efivarfs: fix memory leak in efivarfs_create()")
Reported-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/inode.c | 2 ++
 fs/efivarfs/super.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 96c0c86..0297ad9 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -7,6 +7,7 @@
 #include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/ctype.h>
+#include <linux/kmemleak.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
 
@@ -103,6 +104,7 @@ static int efivarfs_create(struct inode *dir, struct dentry *dentry,
 	var->var.VariableName[i] = '\0';
 
 	inode->i_private = var;
+	kmemleak_ignore(var);
 
 	err = efivar_entry_add(var, &efivarfs_list);
 	if (err)
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index f943fd0..15880a6 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -21,7 +21,6 @@ LIST_HEAD(efivarfs_list);
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
-	kfree(inode->i_private);
 }
 
 static const struct super_operations efivarfs_ops = {
