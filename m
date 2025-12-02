Return-Path: <linux-tip-commits+bounces-7571-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3BC9B1E8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 02 Dec 2025 11:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D2A934297C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Dec 2025 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F230E0CC;
	Tue,  2 Dec 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wFbLZZ65";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lN5mQZ6z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1B30DEDE;
	Tue,  2 Dec 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671005; cv=none; b=tfcHjewOuv7yaJXTB0CJxWZbjrbltloSB9+aEcqWR18AnR4jQar5zQs7+w3AV10dRLKpDG1gMTXtGPJfoW2jGB1fRmMU4eESRt4EbU0OuNUvGmD+DIlbWTUy9GRdHiyJ1X1NUHnduoTHtlo+ygCFprzA2TQhU00R/98BZJJ0WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671005; c=relaxed/simple;
	bh=7ucLvAc7pZvN3qWkkA5/8+urWSh5UnxD7Eej8FRnPHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j1LeadwbseqVeTf7yn4KX9I0EiUuh5d4RrcC9xtJ9tTENzj3pNEq3C04v6lQqGfM1bXYTVYO3EQI4pW+Bh74kTOaDx1OBwl8k6SHK9BH2S3TD7J7/n0n4MaX/IHKGIji2N21pfult+Rk4jf4AlGqwV/btmluuU2fEx0rCl++UMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFbLZZ65; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lN5mQZ6z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Dec 2025 10:23:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764671000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fseVajnoITEg2fPFXMvQEHPkwAoeTxHfYmlZuVxUbnQ=;
	b=wFbLZZ65DrTqFu3WJn46vWjvMHtnugd4TTwqhD1mYXr7fYLddCvMA8WgLJmDtfCUI2Mdnx
	LKaNFJCxSo0ndclMHilMwCkjHd6Z1CH30rJ1yNP2A2YFoVzupjZ0gJ6PZxQDwspS+fmUw5
	8eTbqE+TyIigZWTmugj6cF/z4w5KfhaCHhZ/X3FmIha1HKO7OOK5uwrjwtcqxTpk5dSVxT
	I3NQgNAl8oXNGOPl3ZzyY/ekcyodhSr2lMydGHMcNziVq06AgRywMjLIgDmw6xH3NW7Hwe
	h0eKjeHAcZMIErX6UcJr+O3iq/ydecTRtDy0g5LqGbNgOdFL4DERYfwDYuDniA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764671000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fseVajnoITEg2fPFXMvQEHPkwAoeTxHfYmlZuVxUbnQ=;
	b=lN5mQZ6zrfg5Fdq3EC+6bbRHLWjFiEePO/3pZ028urI4sgoL3ZeCoufUhAP8/4lBMZSA9h
	9Tbcp0pofxnCDfAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] seqlock, procfs: Match scoped_seqlock_read()
 critical section vs. RCU ordering in do_task_stat() to do_io_accounting()
Cc: Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <aS6rwnaPbHFCdHp1@gmail.com>
References: <aS6rwnaPbHFCdHp1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176467099575.498.10639662191686704780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     24bc5ea5c01a7695a1308ac24435810855ec71c9
Gitweb:        https://git.kernel.org/tip/24bc5ea5c01a7695a1308ac24435810855e=
c71c9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 10:05:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Dec 2025 11:21:07 +01:00

seqlock, procfs: Match scoped_seqlock_read() critical section vs. RCU orderin=
g in do_task_stat() to do_io_accounting()

There's two patterns of taking the RCU read-lock and the
sig->stats_lock read-seqlock in do_task_stat() and
do_io_accounting(), with a different ordering:

	# do_io_accounting():

	guard(rcu)();
	scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {

	# do_task_stat():

	scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
	...
			rcu_read_lock();

The ordering is RCU-read+seqlock_read in the first
case, seqlock_read+RCU-read in the second case.

While technically these read locks can be taken in any order,
nevertheless it's good practice to use the more intrusive lock
on the inside (which is the IRQs-off section in this case),
and reduces head-scratching during review when done consistently,
so let's use the do_io_accounting() pattern in do_task_stat().

This will also reduce irqs-off latencies in do_task_stat() a tiny bit.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://patch.msgid.link/aS6rwnaPbHFCdHp1@gmail.com
---
 fs/proc/array.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index cbd4bc4..42932f8 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -537,27 +537,27 @@ static int do_task_stat(struct seq_file *m, struct pid_=
namespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan =3D !task_is_running(task);
=20
-	scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
-		cmin_flt =3D sig->cmin_flt;
-		cmaj_flt =3D sig->cmaj_flt;
-		cutime =3D sig->cutime;
-		cstime =3D sig->cstime;
-		cgtime =3D sig->cgtime;
-
-		if (whole) {
-			struct task_struct *t;
-
-			min_flt =3D sig->min_flt;
-			maj_flt =3D sig->maj_flt;
-			gtime =3D sig->gtime;
-
-			rcu_read_lock();
-			__for_each_thread(sig, t) {
-				min_flt +=3D t->min_flt;
-				maj_flt +=3D t->maj_flt;
-				gtime +=3D task_gtime(t);
+	scoped_guard(rcu) {
+		scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
+			cmin_flt =3D sig->cmin_flt;
+			cmaj_flt =3D sig->cmaj_flt;
+			cutime =3D sig->cutime;
+			cstime =3D sig->cstime;
+			cgtime =3D sig->cgtime;
+
+			if (whole) {
+				struct task_struct *t;
+
+				min_flt =3D sig->min_flt;
+				maj_flt =3D sig->maj_flt;
+				gtime =3D sig->gtime;
+
+				__for_each_thread(sig, t) {
+					min_flt +=3D t->min_flt;
+					maj_flt +=3D t->maj_flt;
+					gtime +=3D task_gtime(t);
+				}
 			}
-			rcu_read_unlock();
 		}
 	}
=20

