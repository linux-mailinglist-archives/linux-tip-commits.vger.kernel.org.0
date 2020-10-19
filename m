Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F3292C2F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgJSRCp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:02:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32856 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730877AbgJSRCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:45 -0400
Date:   Mon, 19 Oct 2020 17:02:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yu1Kt8dPnW54mmTs+LVIdbTeM1ogn52+qvOilt60iwc=;
        b=NGwTu4pHOGipUgE1ok3WMFcUTw3IV3hG7PxI7cRAocC/b47gT5RgggrbmBPkDe4QF6Nzd/
        8/Be+3Bn8fFMO+eAtrNJlss851SidgfF1rmZuEDMEZTRKD1IsgPgqaa+dnmAKf2NLTCCBa
        uEujansUJkNtFKAoU1Z4Ey7u7FzdLSnswSKNYUmH7MGZvMn2g5Fum8MJm2+yOldnjLFThY
        W7NwJ5fzEOq7UEWYpylEto6yi4dJUeqmVUZ3yDydjc4Dmwgn6fb/8IcRor2GJY1TZPa+yw
        HBVnm64SdU1RQPXZp9EuURpB80ralIACdMFE6X40VQv7vuwYxSIoea0RvM1EpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yu1Kt8dPnW54mmTs+LVIdbTeM1ogn52+qvOilt60iwc=;
        b=Gel0jr25w2lP4QvqrlXJYmZi6p5IQpzRKoB82SqE9SmE9Nn/Jgw9e9II5ARzPDXeVdYcyC
        rb33o4zakhIw8EBA==
From:   "tip-bot2 for Jan Kara" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] reiserfs: Initialize inode keys properly
Cc:     syzbot+d94d02749498bb7bab4b@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160312696219.7002.5065617515683098473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d3bb68fa8d43bcd889ce86249f73a70e3ba221aa
Gitweb:        https://git.kernel.org/tip/d3bb68fa8d43bcd889ce86249f73a70e3ba221aa
Author:        Jan Kara <jack@suse.cz>
AuthorDate:    Mon, 21 Sep 2020 15:08:50 +02:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Sat, 17 Oct 2020 08:31:22 +02:00

reiserfs: Initialize inode keys properly

commit 4443390e08d34d5771ab444f601cf71b3c9634a4 upstream.

reiserfs_read_locked_inode() didn't initialize key length properly. Use
_make_cpu_key() macro for key initialization so that all key member are
properly initialized.

CC: stable@vger.kernel.org
Reported-by: syzbot+d94d02749498bb7bab4b@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 1509775..e43fed9 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -1551,11 +1551,7 @@ void reiserfs_read_locked_inode(struct inode *inode,
 	 * set version 1, version 2 could be used too, because stat data
 	 * key is the same in both versions
 	 */
-	key.version = KEY_FORMAT_3_5;
-	key.on_disk_key.k_dir_id = dirino;
-	key.on_disk_key.k_objectid = inode->i_ino;
-	key.on_disk_key.k_offset = 0;
-	key.on_disk_key.k_type = 0;
+	_make_cpu_key(&key, KEY_FORMAT_3_5, dirino, inode->i_ino, 0, 0, 3);
 
 	/* look for the object's stat data */
 	retval = search_item(inode->i_sb, &key, &path_to_sd);
