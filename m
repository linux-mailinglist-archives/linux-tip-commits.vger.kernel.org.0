Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28413292C18
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgJSRCp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbgJSRCo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB6C0613CE;
        Mon, 19 Oct 2020 10:02:44 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:02:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nrYWyo25ScaKNT2vPb+k86yODXuKdco6xmfmcgxph3Q=;
        b=AXOpjikWZMb9sXwq6SGRkXykQZs+WcgETL4tQ/B1TEWOH/TzqHT8DVyClsLHy4wZeEVA3Z
        PkkDbFz5Yw7lkuD9T7wGDMu1Bx8Vw08gyto4rOKkJmbWQjzAR+/RKQjgCFDqyGKQ3rm9wG
        ciqB/zGNzqPtaZ+AWsSsOSgERsjjDD2AcMwsZE8371mGAw0o/Ue88hLzwnXp2+5qosjQqI
        0h4dVIhbM7+5Bfu5wbJpD/xfH3PS98BI/TRzSAPQqxhM7/ef/UU9dAVssXIveg2hOzDmaZ
        pukrxNH2icOIdVX1YlyPB7zz13TEPBbpZ969zSdYRRhRDeUPihRzm8Cr/23wsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nrYWyo25ScaKNT2vPb+k86yODXuKdco6xmfmcgxph3Q=;
        b=rjF+8fOxXfnXAL6B4svYSLLW05P013AUL5q58hFBzX7i/FrMmnWtfOqfWoBxHzCxAYYlLP
        z3iwjCL4Ln6TEWAw==
From:   "tip-bot2 for Jan Kara" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] reiserfs: Fix oops during mount
Cc:     syzbot+9b33c9b118d77ff59b6f@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160312696166.7002.16055147787497008532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     061fe185e17a1519a75eee89462f35a5360ece8b
Gitweb:        https://git.kernel.org/tip/061fe185e17a1519a75eee89462f35a5360ece8b
Author:        Jan Kara <jack@suse.cz>
AuthorDate:    Wed, 30 Sep 2020 17:08:20 +02:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Sat, 17 Oct 2020 08:31:22 +02:00

reiserfs: Fix oops during mount

commit c2bb80b8bdd04dfe32364b78b61b6a47f717af52 upstream.

With suitably crafted reiserfs image and mount command reiserfs will
crash when trying to verify that XATTR_ROOT directory can be looked up
in / as that recurses back to xattr code like:

 xattr_lookup+0x24/0x280 fs/reiserfs/xattr.c:395
 reiserfs_xattr_get+0x89/0x540 fs/reiserfs/xattr.c:677
 reiserfs_get_acl+0x63/0x690 fs/reiserfs/xattr_acl.c:209
 get_acl+0x152/0x2e0 fs/posix_acl.c:141
 check_acl fs/namei.c:277 [inline]
 acl_permission_check fs/namei.c:309 [inline]
 generic_permission+0x2ba/0x550 fs/namei.c:353
 do_inode_permission fs/namei.c:398 [inline]
 inode_permission+0x234/0x4a0 fs/namei.c:463
 lookup_one_len+0xa6/0x200 fs/namei.c:2557
 reiserfs_lookup_privroot+0x85/0x1e0 fs/reiserfs/xattr.c:972
 reiserfs_fill_super+0x2b51/0x3240 fs/reiserfs/super.c:2176
 mount_bdev+0x24f/0x360 fs/super.c:1417

Fix the problem by bailing from reiserfs_xattr_get() when xattrs are not
yet initialized.

CC: stable@vger.kernel.org
Reported-by: syzbot+9b33c9b118d77ff59b6f@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/xattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 28b241c..fe63a7c 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -674,6 +674,13 @@ reiserfs_xattr_get(struct inode *inode, const char *name, void *buffer,
 	if (get_inode_sd_version(inode) == STAT_DATA_V1)
 		return -EOPNOTSUPP;
 
+	/*
+	 * priv_root needn't be initialized during mount so allow initial
+	 * lookups to succeed.
+	 */
+	if (!REISERFS_SB(inode->i_sb)->priv_root)
+		return 0;
+
 	dentry = xattr_lookup(inode, name, XATTR_REPLACE);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
