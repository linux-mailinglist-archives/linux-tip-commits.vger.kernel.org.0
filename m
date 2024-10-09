Return-Path: <linux-tip-commits+bounces-2391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12006996243
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Oct 2024 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4261B1C213C1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Oct 2024 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044617CA0B;
	Wed,  9 Oct 2024 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lM8AW9cH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ld6w2wVs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7880183CA7;
	Wed,  9 Oct 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461949; cv=none; b=NL/X44UWzW9oA+TWx8AifzFiYmDblZvIw0ddBRaCFw3zerh/AofWsNgtce5rZccO8goIwwopMoK/U4e26g3z1XgaFjm8Xy8ImXgHbDJOV4YQf7Fqv+RvC0yIoj/vFlcKaplKn1s8VFgRFiN7TsZEVqJ4OMP+IUunTSrFt83ABCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461949; c=relaxed/simple;
	bh=1gwGVIuimmryLZ0/PN8tLbBcO+nE++TiNXvBvW8g3gc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=UEGWnBbhlBPlExnTwA24DhfIh359pN8uzC7Tk0alcoCjWpvyF6h59UI3UugkHU3woWxwdGbZNErqr3bDKiCWt6oHQKCwMeWMIJ7hVH3fTABTZUNw48HBzKcZ1Q5saZXkZLa/4HBqxeqIUDNZiMZRJ3JeoY3WRlLn+cCoYMqlltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lM8AW9cH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ld6w2wVs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Oct 2024 08:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728461946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8wwoHAqKz/DC4cgWQpPQtbnA9eq1uGdQxciLsQJDpL4=;
	b=lM8AW9cH4kt+oCVrNhPVjvDTx7omdJaawZKBydCzV2BHYIyB3KRg+7EAQDe35phFsrP65W
	MPeM+HrQhuU8wOABriq3IFsw1zpq72zA8Mg03zTttKWaxtBQGMJJIve1tEt0/x9PW9Nhkk
	um8SxZY2x8f0PJTWzAhUI8w7wW0Qp80vFhYtZsmaS9YxYR3brNPFAUpB0Y4S8at8Oj4ouE
	sbmKBF7AoLBdxxz9Cy5LMdM2nLJRK3jtHvPGX29/7f5wpU8WDm/eZX2pE7DhIZ2KSpFdvw
	0oeQ46yM7wQVg7oNzZ/UofJ2SIgPOVB5QHbfpT6dFPtjNDWpX/stNfn4M597IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728461946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8wwoHAqKz/DC4cgWQpPQtbnA9eq1uGdQxciLsQJDpL4=;
	b=Ld6w2wVsHKwO0kJeSc3ycr9Lr6PiH2P47hO+xWs9TZ8mZsi89q0uiqpXuQsO/CNcnxsmBW
	J1bksgoZ+a0CW8CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] fs/bcachefs: Fix __wait_on_freeing_inode()
 definition of waitqueue entry
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, NeilBrown <neilb@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172846194512.1442.15051268384195551570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7266f0a6d3bb73f42ea06656d3cc48c7d0386f71
Gitweb:        https://git.kernel.org/tip/7266f0a6d3bb73f42ea06656d3cc48c7d0386f71
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Oct 2024 10:00:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2024 10:00:09 +02:00

fs/bcachefs: Fix __wait_on_freeing_inode() definition of waitqueue entry

The following recent commit made DEFINE_WAIT_BIT() type requirements stricter:

  2382d68d7d43 ("sched: change wake_up_bit() and related function to expect unsigned long *")

.. which results in a build failure:

  > fs/bcachefs/fs.c: In function '__wait_on_freeing_inode':
  > fs/bcachefs/fs.c:281:31: error: initialization of 'long unsigned int *' from incompatible pointer type 'u32 *' {aka 'unsigned int *'} [-Wincompatible-pointer-types]
  >   281 |         DEFINE_WAIT_BIT(wait, &inode->v.i_state, __I_NEW);

Since this code relies on the waitqueue initialization within
inode_bit_waitqueue() anyway, the DEFINE_WAIT_BIT() initialization
is unnecessary - we can just declare a waitqueue entry.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/bcachefs/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 5bfc26d..c410133 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -183,8 +183,9 @@ static void __wait_on_freeing_inode(struct bch_fs *c,
 				    struct bch_inode_info *inode,
 				    subvol_inum inum)
 {
+	struct wait_bit_queue_entry wait;
 	wait_queue_head_t *wq;
-	DEFINE_WAIT_BIT(wait, &inode->v.i_state, __I_NEW);
+
 	wq = inode_bit_waitqueue(&wait, &inode->v, __I_NEW);
 	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->v.i_lock);

