Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CF2342BE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbgGaJZ1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:25:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbgGaJXg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:36 -0400
Date:   Fri, 31 Jul 2020 09:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jXl5D8yDFyK7tpaoaQjb4VMrYavXMcvfvyR2+oMCeKE=;
        b=a/iHnF/dlO5amVxttIc2kqRsEQmkmd8HF9dmEG4tqe/i9KyBhCMc1fLeF87JZJffgcjAqT
        1SwutNzMaZo2ZpuOvOaZHTyXmfm0rQLaBebqc5Tx40wF0Wa2+SkqUjzYW+EOWCAiDvugsS
        K1rT2mhSYHLnRXfaD6ZPTk5+dGaps39VENHRMYF6BrqNF4buiwyT7YYRV0yMyNMoFEz1u1
        bfBmMwI5U/5YG7V31P26I98UiSxq8ulBZzXhDJ0354zVE2tRiSLTmd0N8euHWW8MhMy55r
        04T+DwSGYtInkE0nBhYD49AWoCDziS1+xUhFs3aKRgB+ub+ousxsfvSGRer++Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jXl5D8yDFyK7tpaoaQjb4VMrYavXMcvfvyR2+oMCeKE=;
        b=+TovTS7RkKYIWpktDM9Oq7Jttxmm3yimAr+k2N+EAs/YFmaDECz4NF+NbSNn/YTkD4ucLu
        Yad7JkU/4y+rvYDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] fs/btrfs: Add cond_resched() for
 try_release_extent_mapping() stalls
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741390.4006.17706937058387359266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9f47eb5461aaeb6cb8696f9d11503ae90e4d5cb0
Gitweb:        https://git.kernel.org/tip/9f47eb5461aaeb6cb8696f9d11503ae90e4d5cb0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 08 May 2020 14:15:37 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls

Very large I/Os can cause the following RCU CPU stall warning:

RIP: 0010:rb_prev+0x8/0x50
Code: 49 89 c0 49 89 d1 48 89 c2 48 89 f8 e9 e5 fd ff ff 4c 89 48 10 c3 4c =
89 06 c3 4c 89 40 10 c3 0f 1f 00 48 8b 0f 48 39 cf 74 38 <48> 8b 47 10 48 85 c0 74 22 48 8b 50 08 48 85 d2 74 0c 48 89 d0 48
RSP: 0018:ffffc9002212bab0 EFLAGS: 00000287 ORIG_RAX: ffffffffffffff13
RAX: ffff888821f93630 RBX: ffff888821f93630 RCX: ffff888821f937e0
RDX: 0000000000000000 RSI: 0000000000102000 RDI: ffff888821f93630
RBP: 0000000000103000 R08: 000000000006c000 R09: 0000000000000238
R10: 0000000000102fff R11: ffffc9002212bac8 R12: 0000000000000001
R13: ffffffffffffffff R14: 0000000000102000 R15: ffff888821f937e0
 __lookup_extent_mapping+0xa0/0x110
 try_release_extent_mapping+0xdc/0x220
 btrfs_releasepage+0x45/0x70
 shrink_page_list+0xa39/0xb30
 shrink_inactive_list+0x18f/0x3b0
 shrink_lruvec+0x38e/0x6b0
 shrink_node+0x14d/0x690
 do_try_to_free_pages+0xc6/0x3e0
 try_to_free_mem_cgroup_pages+0xe6/0x1e0
 reclaim_high.constprop.73+0x87/0xc0
 mem_cgroup_handle_over_high+0x66/0x150
 exit_to_usermode_loop+0x82/0xd0
 do_syscall_64+0xd4/0x100
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

On a PREEMPT=n kernel, the try_release_extent_mapping() function's
"while" loop might run for a very long time on a large I/O.  This commit
therefore adds a cond_resched() to this loop, providing RCU any needed
quiescent states.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 fs/btrfs/extent_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 68c9605..7042395 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4515,6 +4515,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 
 			/* once for us */
 			free_extent_map(em);
+
+			cond_resched(); /* Allow large-extent preemption. */
 		}
 	}
 	return try_release_extent_state(tree, page, mask);
