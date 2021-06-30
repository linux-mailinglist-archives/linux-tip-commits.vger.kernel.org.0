Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797A3B83FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhF3Nvr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhF3Num (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:42 -0400
Date:   Wed, 30 Jun 2021 13:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JWQUsI+AzLp1/Tfn8HnXhVGui6X/xKItxiEXjDpo4k0=;
        b=1UE+Gx18jYRDw2ea582N+gyWqt4IRx0vZOxwXbnK0mgcNKcu1Pi4iH8uebrtmm8+v6v9w+
        yFT5T5ZcEsXqNr7zPg2bFdlI3YMnmW2Mm6lEVPiherNmxhCAPlOQQlqEx0SGdD0gbgwrMO
        37nSpmLnYsUt051DT+3Q8HlcVDPqT3UyDMgiGuiR5ExBmxKSr3kQsMoVwMMqdinuoKLSG0
        RYfTeQX0BDv7WVv22sP/9uK7CYUoy+cBQ99dfH8LNRPNGja/xYhhokLn1oNqr+XrPfdBmA
        7z+mC8eZ00ILn7OM6XncJC8ziLZIscHnuEUR/BB4xh6HVgSp97Lu8oB9UrZQFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JWQUsI+AzLp1/Tfn8HnXhVGui6X/xKItxiEXjDpo4k0=;
        b=8JmUdxYyvy3xbYlRA1Q9J5j72KEBMf1gSUJFNQM+OduTCgjRKJCezYT8Wk5+edZHvZfV6X
        b+ksbj7utgR7liCQ==
From:   "tip-bot2 for Maninder Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm/slub: Fix backtrace of objects to handle redzone
 adjustment
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Vaneet Narang <v.narang@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087637.395.12392795156320605388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0cbc124bce8c527eb14c87f634683c5bcf4299c7
Gitweb:        https://git.kernel.org/tip/0cbc124bce8c527eb14c87f634683c5bcf4299c7
Author:        Maninder Singh <maninder1.s@samsung.com>
AuthorDate:    Tue, 16 Mar 2021 16:07:10 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:01:41 -07:00

mm/slub: Fix backtrace of objects to handle redzone adjustment

This commit fixes commit 8e7f37f2aaa5 ("mm: Add mem_dump_obj() to print
source of memory block").

With current code, the backtrace of allocated object is incorrect:
/ # cat /proc/meminfo
[   14.969843]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at 0x6b6b6b6b
[   14.970635]     0x6b6b6b6b
[   14.970794]     0x6b6b6b6b
[   14.970932]     0x6b6b6b6b
[   14.971077]     0x6b6b6b6b
[   14.971202]     0x6b6b6b6b
[   14.971317]     0x6b6b6b6b
[   14.971423]     0x6b6b6b6b
[   14.971635]     0x6b6b6b6b
[   14.971740]     0x6b6b6b6b
[   14.971871]     0x6b6b6b6b
[   14.972229]     0x6b6b6b6b
[   14.972363]     0x6b6b6b6b
[   14.972505]     0xa56b6b6b
[   14.972631]     0xbbbbbbbb
[   14.972734]     0xc8ab0400
[   14.972891]     meminfo_proc_show+0x40/0x4fc

The reason is that the object address was not adjusted for the red zone.
With this fix, the backtrace is correct:
/ # cat /proc/meminfo
[   14.870782]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 128 size 64 allocated at meminfo_proc_show+0x40/0x4f4
[   14.871817]     meminfo_proc_show+0x40/0x4f4
[   14.872035]     seq_read_iter+0x18c/0x4c4
[   14.872229]     proc_reg_read_iter+0x84/0xac
[   14.872433]     generic_file_splice_read+0xe8/0x17c
[   14.872621]     splice_direct_to_actor+0xb8/0x290
[   14.872747]     do_splice_direct+0xa0/0xe0
[   14.872896]     do_sendfile+0x2d0/0x438
[   14.873044]     sys_sendfile64+0x12c/0x140
[   14.873229]     ret_fast_syscall+0x0/0x58
[   14.873372]     0xbe861de4

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index feda53a..8f2d135 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4002,6 +4002,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	    !(s->flags & SLAB_STORE_USER))
 		return;
 #ifdef CONFIG_SLUB_DEBUG
+	objp = fixup_red_left(s, objp);
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	kpp->kp_ret = (void *)trackp->addr;
 #ifdef CONFIG_STACKTRACE
