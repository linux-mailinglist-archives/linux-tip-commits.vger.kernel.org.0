Return-Path: <linux-tip-commits+bounces-6968-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9155BF5C9F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E95481D42
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489FE2EA17D;
	Tue, 21 Oct 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sPwxCSRH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="biLbWher"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBC1990C7;
	Tue, 21 Oct 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042925; cv=none; b=H+GI7fdilMml/h9AaI4rz257/1LNN2FDLHqRy0j5bWZLwu2YRYYZ8t1ChcpqvP08f8tEWcDTNhkvgqg7+pQHs9x23GIynhH545xT4rsiZ6JeOsM8rjEBTaC/Ijjf2EAFvgBY99f+WjJ+hdeXz/kmAKsW8hFKcNEsWmb8Hs5kcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042925; c=relaxed/simple;
	bh=w8n+sdg06yLhNGTI+qGGRbkKkOyFPmcbnlHjtZQw2F4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=csemOuluijImhPCTRIBrjkw4BeO9lzbMElvp4Jjh/CA26qz10CiUE7csDb98wUxDQJN4zI5IZqTkqdAVJlKNUwWtp+QdcSi4NVc+BEWC586U5kXOZGIQ7y2RG6cAU3+KcjBzVWmj7UZiaFC1hPBW9ldVplOnYHA1mpYZH6tx4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sPwxCSRH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=biLbWher; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RF8Te0ie+tDshv9fq+8QA0BBRYztKlhPAMoCdK2hqxI=;
	b=sPwxCSRHvL9nm5lGwNtepbGD0yUT2oGDfQilD3rYJxGBn6TugF82L5WwGOEr/ISLv2xJhk
	FQkRgufxgcIegubw9jtQ4a2/VUzDHm2Twd/FRGr3mUO308i4UeNJCBMXN7udIl9iy+QF4C
	fSi1I9KHHHHLwOzLPYGkNKD0DvS/wbAVViQzZ7qjwY6isaZrNkXNZnbeu4bNk3vWnBuN9+
	PoMnD8NWTnecxCOixjiCKDTV42/62AnEh45uEcBdLaoLbjeLUCKlBHqF2ROH8THGBGTg9N
	UtA/imez0sJOnz04cCm2KbDmgyWjShKvtIY8G/ZQct8A1T4JVZ3HEIEM6IWgUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RF8Te0ie+tDshv9fq+8QA0BBRYztKlhPAMoCdK2hqxI=;
	b=biLbWher2ZJGhmPM38LHgjlQcfbh7KhCSK2UoW+6h9h9lV15lEB8V8/NUwx4lXy3Br1wg5
	KIZ7iiygArONYqBg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Change do_io_accounting() to use
 scoped_seqlock_read()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251008123105.GA20449@redhat.com>
References: <20251008123105.GA20449@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104292009.2601451.1208802602283544481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     795aab353d0650b2d04dc3aa2e22a51000cb2aaa
Gitweb:        https://git.kernel.org/tip/795aab353d0650b2d04dc3aa2e22a51000c=
b2aaa
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Wed, 08 Oct 2025 14:31:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:57 +02:00

seqlock: Change do_io_accounting() to use scoped_seqlock_read()

To simplify the code and make it more readable.

[peterz: change to new interface]
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/proc/base.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6299878..407b41c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3043,21 +3043,14 @@ static int do_io_accounting(struct task_struct *task,=
 struct seq_file *m, int wh
 	if (whole) {
 		struct signal_struct *sig =3D task->signal;
 		struct task_struct *t;
-		unsigned int seq =3D 1;
-		unsigned long flags;
-
-		rcu_read_lock();
-		do {
-			seq++; /* 2 on the 1st/lockless path, otherwise odd */
-			flags =3D read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
=20
+		guard(rcu)();
+		scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
 			acct =3D sig->ioac;
 			__for_each_thread(sig, t)
 				task_io_accounting_add(&acct, &t->ioac);
=20
-		} while (need_seqretry(&sig->stats_lock, seq));
-		done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
-		rcu_read_unlock();
+		}
 	} else {
 		acct =3D task->ioac;
 	}

