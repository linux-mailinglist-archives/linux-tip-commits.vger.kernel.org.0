Return-Path: <linux-tip-commits+bounces-3270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B299A1389B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 12:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F408C3A112C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1607B1DDC2B;
	Thu, 16 Jan 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rDAauNYO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nTH/AWFU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CB199931;
	Thu, 16 Jan 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026007; cv=none; b=PKW+CiHuXwLBZYW+jyz2n4tBiEW16MQFBriZ3NLj6blSyg1lB6tb5NDlOqIJ9cJkdFfttE2UEKaGrbgMnZVnS2NQffproBSOEUzyeBguaxNJ5rWXs5plWZEWFz816ba0cKOeqy8chexWj+oEWvxbrecLxxTCAWChGpR4yGOVU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026007; c=relaxed/simple;
	bh=xLyxorKysY6BbSgVqLbxTYMC86nQBx9VX0jqSF4LYBI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hS/1//flc/dHmKjSrx3Mei+FPsxO9h1846TREajvfCWsBouFjmauBsTj902/uWpAJ10dQbjwOCbd9kXuYyVLEYRzn5kwk197DNhp+OmqBzI7KKzVDUjHlxDFJGJZBJjGXxZ3OiOSC6zcXiYXPxwjrWsB3vlUnrbN6Mdkxo9VXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rDAauNYO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nTH/AWFU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 11:13:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737026003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzojExpDBKHSUb+L2oEmIMcxBBj/GzgMvkbh94EJF6Y=;
	b=rDAauNYOu/MkKHZPj/EmhuQeCipueQhQ4gx7i7v4t4NRNKXRp/DrEa6wiWEKce4YJFb/w0
	GHoBwvCm3HhugsBBGcVzuU3kbj8gWqlLRp4xiQm2QpbtwDjkrWIVWjhl0qX3a6+m+FomyS
	RVgmJsHcPryhRbTiorShOOuNVo82Ic3Zn5O+2H5eZUWRMNpWFOtyD/GMSqdkXv6vyCt+KK
	t4n33y44u9gMnzGC7sLUTL8vhwy2Tup4+Lsx+Zg4HlRKi37ht5MK5Yg2hQPrHB45jS0GE1
	SLald1Oj3bc9ZH+0fjoUeEtqttR1rTxH4qjsCtBFxPohKYXzheN/Hoqm6Cck2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737026003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzojExpDBKHSUb+L2oEmIMcxBBj/GzgMvkbh94EJF6Y=;
	b=nTH/AWFUoLDNlnqhihgYWAxmK77dMhxnPSH9Ceq058unAN5NDNyA391kl0gQGlc515YI3i
	eHoADWBUQk060+AQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Enforce group initialization
 visibility to tree walkers
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250114231507.21672-3-frederic@kernel.org>
References: <20250114231507.21672-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173702600286.31546.14749239571137281200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     4a6e60740a304765285446aa260f88b7c5e51c1b
Gitweb:        https://git.kernel.org/tip/4a6e60740a304765285446aa260f88b7c5e51c1b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 15 Jan 2025 00:15:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 12:04:47 +01:00

timers/migration: Enforce group initialization visibility to tree walkers

Commit 2522c84db513 ("timers/migration: Fix another race between hotplug
and idle entry/exit") fixed yet another race between idle exit and CPU
hotplug up leading to a wrong "0" value migrator assigned to the top
level. However there is yet another situation that remains unhandled:

         [GRP0:0]
      migrator  = TMIGR_NONE
      active    = NONE
      groupmask = 1
      /     \      \
     0       1     2..7
   idle      idle   idle

0) The system is fully idle.

         [GRP0:0]
      migrator  = CPU 0
      active    = CPU 0
      groupmask = 1
      /     \      \
     0       1     2..7
   active   idle   idle

1) CPU 0 is activating. It has done the cmpxchg on the top's ->migr_state
but it hasn't yet returned to __walk_groups().

         [GRP0:0]
      migrator  = CPU 0
      active    = CPU 0, CPU 1
      groupmask = 1
      /     \      \
     0       1     2..7
   active  active  idle

2) CPU 1 is activating. CPU 0 stays the migrator (still stuck in
__walk_groups(), delayed by #VMEXIT for example).

                    [GRP1:0]
                migrator = TMIGR_NONE
                active   = NONE
                groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
      migrator  = CPU 0           migrator = TMIGR_NONE
      active    = CPU 0, CPU1     active   = NONE
      groupmask = 1               groupmask = 2
      /     \      \
     0       1     2..7                   8
   active  active  idle                !online

3) CPU 8 is preparing to boot. CPUHP_TMIGR_PREPARE is being ran by CPU 1
which has created the GRP0:1 and the new top GRP1:0 connected to GRP0:1
and GRP0:0. CPU 1 hasn't yet propagated its activation up to GRP1:0.

                    [GRP1:0]
               migrator = GRP0:0
               active   = GRP0:0
               groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
     migrator  = CPU 0           migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = NONE
     groupmask = 1               groupmask = 2
     /     \      \
    0       1     2..7                   8
  active  active  idle                !online

4) CPU 0 finally resumed after its #VMEXIT. It's in __walk_groups()
returning from tmigr_cpu_active(). The new top GRP1:0 is visible and
fetched and the pre-initialized groupmask of GRP0:0 is also visible.
As a result tmigr_active_up() is called to GRP1:0 with GRP0:0 as active
and migrator. CPU 0 is returning to __walk_groups() but suffers again
a #VMEXIT.

                    [GRP1:0]
               migrator = GRP0:0
               active   = GRP0:0
               groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
     migrator  = CPU 0           migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = NONE
     groupmask = 1               groupmask = 2
     /     \      \
    0       1     2..7                   8
  active  active  idle                 !online

5) CPU 1 propagates its activation of GRP0:0 to GRP1:0. This has no
   effect since CPU 0 did it already.

                    [GRP1:0]
               migrator = GRP0:0
               active   = GRP0:0, GRP0:1
               groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
     migrator  = CPU 0           migrator = CPU 8
     active    = CPU 0, CPU1     active   = CPU 8
     groupmask = 1               groupmask = 2
     /     \      \                     \
    0       1     2..7                   8
  active  active  idle                 active

6) CPU 1 links CPU 8 to its group. CPU 8 boots and goes through
   CPUHP_AP_TMIGR_ONLINE which propagates activation.

                                   [GRP2:0]
                              migrator = TMIGR_NONE
                              active   = NONE
                              groupmask = 1
                             /                \
                    [GRP1:0]                    [GRP1:1]
               migrator = GRP0:0              migrator = TMIGR_NONE
               active   = GRP0:0, GRP0:1      active   = NONE
               groupmask = 1                  groupmask = 2
             /                   \
         [GRP0:0]                  [GRP0:1]                [GRP0:2]
     migrator  = CPU 0           migrator = CPU 8        migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = CPU 8        active   = NONE
     groupmask = 1               groupmask = 2           groupmask = 0
     /     \      \                     \
    0       1     2..7                   8                  64
  active  active  idle                 active             !online

7) CPU 64 is booting. CPUHP_TMIGR_PREPARE is being ran by CPU 1
which has created the GRP1:1, GRP0:2 and the new top GRP2:0 connected to
GRP1:1 and GRP1:0. CPU 1 hasn't yet propagated its activation up to
GRP2:0.

                                   [GRP2:0]
                              migrator = 0 (!!!)
                              active   = NONE
                              groupmask = 1
                             /                \
                    [GRP1:0]                    [GRP1:1]
               migrator = GRP0:0              migrator = TMIGR_NONE
               active   = GRP0:0, GRP0:1      active   = NONE
               groupmask = 1                  groupmask = 2
             /                   \
         [GRP0:0]                  [GRP0:1]                [GRP0:2]
     migrator  = CPU 0           migrator = CPU 8        migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = CPU 8        active   = NONE
     groupmask = 1               groupmask = 2           groupmask = 0
     /     \      \                     \
    0       1     2..7                   8                  64
  active  active  idle                 active             !online

8) CPU 0 finally resumed after its #VMEXIT. It's in __walk_groups()
returning from tmigr_cpu_active(). The new top GRP2:0 is visible and
fetched but the pre-initialized groupmask of GRP1:0 is not because no
ordering made its initialization visible. As a result tmigr_active_up()
may be called to GRP2:0 with a "0" child's groumask. Leaving the timers
ignored for ever when the system is fully idle.

The race is highly theoretical and perhaps impossible in practice but
the groupmask of the child is not the only concern here as the whole
initialization of the child is not guaranteed to be visible to any
tree walker racing against hotplug (idle entry/exit, remote handling,
etc...). Although the current code layout seem to be resilient to such
hazards, this doesn't tell much about the future.

Fix this with enforcing address dependency between group initialization
and the write/read to the group's parent's pointer. Fortunately that
doesn't involve any barrier addition in the fast paths.

Fixes: 10a0e6f3d3db ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250114231507.21672-3-frederic@kernel.org

---
 kernel/time/timer_migration.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c8a8ea2..371a62a 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -534,8 +534,13 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 			break;
 
 		child = group;
-		group = group->parent;
+		/*
+		 * Pairs with the store release on group connection
+		 * to make sure group initialization is visible.
+		 */
+		group = READ_ONCE(group->parent);
 		data->childmask = child->groupmask;
+		WARN_ON_ONCE(!data->childmask);
 	} while (group);
 }
 
@@ -1578,7 +1583,12 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 		child->groupmask = BIT(parent->num_children++);
 	}
 
-	child->parent = parent;
+	/*
+	 * Make sure parent initialization is visible before publishing it to a
+	 * racing CPU entering/exiting idle. This RELEASE barrier enforces an
+	 * address dependency that pairs with the READ_ONCE() in __walk_groups().
+	 */
+	smp_store_release(&child->parent, parent);
 
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);

