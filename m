Return-Path: <linux-tip-commits+bounces-6146-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B2B0B121
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAD317A8C8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768402874FB;
	Sat, 19 Jul 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTRylTqn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYqQuvQA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2014F70;
	Sat, 19 Jul 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946820; cv=none; b=Qkg+NNku/YbPNonEnpLU08DoY9raILZb1HDetE6rtVuRfhmEb0WqC2Va6B4zYq1lzQ5/xa/Wt6s+W7mpCkjNNGZbAv59PBAOWSOX1z8VxkJbrdUIBy5XYqbLssEurNt8arzQttFKJSg58+FtdvSJNxOjmc2Xi7JPeAcuRYt0FUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946820; c=relaxed/simple;
	bh=skA+4fBR0hDXfHQbYxzqz2vHn2KoxBleGr+cwaLJA5Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mPzh1ozB3A7eFnz0Qly7iP/G6hhufNcsDKM+zsEE9rG8lhEXiuY9uxA9vIEG29O0j5u2bx+w50nDEslK5SaFwk2P7KoxVN2AfKu6CtmdMawuiUOYOcHgl01BsEcB+/Rqh5EQf++o5dd3rKwpc9NtizYMdeFYz68zcY26srnEpmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTRylTqn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYqQuvQA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r632AJmrCiQlyKzNh7POBFi39iChlZhD+Q0eTj98DK4=;
	b=VTRylTqnqNO1dpOIo1cHKNQcQLIia2yruPccg9WcGtlCqxZaj2Me8/ViiTdLpJ9TynO1Ur
	1p50zhPA5YrUpXHmjGNwGX4tWLfw+aYxlw2lyWsUtThZX40NcpeCeX5Aw/LkmS31UMc4DS
	G7yqIhkwG8dguLErpCMRg2/j71n5x8FT2Fo1WFp4/0EmVHAE+li+V4i1fTODOKPNYregP6
	wD1XrpgJMvn2EyPLT9WiI8ypt7byLXPfcm7Oki/3kvh+xPlhvZswnp4WUt0N+DU0MBq2u7
	T8sOHyTW7+kS46DxWDQ/6VFHpZgTxRM4PCQ0Nhz3n8TC8oyswrdDCYCto56ynA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r632AJmrCiQlyKzNh7POBFi39iChlZhD+Q0eTj98DK4=;
	b=NYqQuvQA1D07u3LdpgaFFwImYm9LjLsu/+etNw0HAGAV4x/gqSygGkmN/Pp3tuxzr+1/TK
	uSbJq0YgWMbhUyAA==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Cc: Erik Lundgren <elundgren@meta.com>, Breno Leitao <leitao@debian.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294680733.1420.1210512165865622668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7a3cedafccf8e7d038ad4cfec5b38052647ceac5
Gitweb:        https://git.kernel.org/tip/7a3cedafccf8e7d038ad4cfec5b38052647=
ceac5
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Fri, 21 Mar 2025 02:30:49 -07:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Mon, 14 Jul 2025 21:57:29 -07:00

lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization

lockdep_unregister_key() is called from critical code paths, including
sections where rtnl_lock() is held. For example, when replacing a qdisc
in a network device, network egress traffic is disabled while
__qdisc_destroy() is called for every network queue.

If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
which gets blocked waiting for synchronize_rcu() to complete.

For example, a simple tc command to replace a qdisc could take 13
seconds:

  # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
    real    0m13.195s
    user    0m0.001s
    sys     0m2.746s

During this time, network egress is completely frozen while waiting for
RCU synchronization.

Use synchronize_rcu_expedited() instead to minimize the impact on
critical operations like network connectivity changes.

This improves 10x the function call to tc, when replacing the qdisc for
a network card.

   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
     real     0m1.789s
     user     0m0.000s
     sys      0m1.613s

[boqun: Fixed the comment and add more information for the temporary
workaround, and add TODO information for hazptr]

Reported-by: Erik Lundgren <elundgren@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250321-lockdep-v1-1-78b732d195fb@debian.org
---
 kernel/locking/lockdep.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0c94141..2d4c5ba 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6616,8 +6616,16 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (need_callback)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
=20
-	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-	synchronize_rcu();
+	/*
+	 * Wait until is_dynamic_key() has finished accessing k->hash_entry.
+	 *
+	 * Some operations like __qdisc_destroy() will call this in a debug
+	 * kernel, and the network traffic is disabled while waiting, hence
+	 * the delay of the wait matters in debugging cases. Currently use a
+	 * synchronize_rcu_expedited() to speed up the wait at the cost of
+	 * system IPIs. TODO: Replace RCU with hazptr for this.
+	 */
+	synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
=20

