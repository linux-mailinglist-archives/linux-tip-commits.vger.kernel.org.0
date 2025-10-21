Return-Path: <linux-tip-commits+bounces-6969-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0088BF5CA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A98118C80EC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19E2EE616;
	Tue, 21 Oct 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeZ58Zyu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3icKIyk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0826CE2E;
	Tue, 21 Oct 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042926; cv=none; b=kJZg7opljQbiycl7nzoC/2qHbLtM7TNyVpzUUI5iXd+s0txu4iU59+BJdBGCj7/zAAwpHiQqOrZCvFitrMseXKtEDjBhp4/9UBG+TrhYquu2TFqUWujEV8bKJ1VcFnbNuJUJdwZPTsrv+u4p5+w17eBzPfFJFp1Da6F7tXiyNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042926; c=relaxed/simple;
	bh=eMRXJIsuP4Q5pgsy5aTDwef06h4FdDkbSacjbNZ8UXk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n3oymN9g/y4wlwChUiYMUq9DFkOR92FIdBl8owzXdNmLxbvX7+kuJw/me2ZFfIhD2UyM54WaGO6T42La4wb6xnV4aRqWNOKqQfMjGfrSx9RVhpD65K/JsWJSXc0+cuIgCRsFyxv1ttdbWsBuv8FfFeAzyp7Uc4FifNONhLPpKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MeZ58Zyu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3icKIyk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NQHr0O8U6Os/qRzZzjEDgIf3ewnuyoNMhiRSN/DKnc=;
	b=MeZ58ZyucTyII7lgvID/Vxm1zJGnLuO0uRNzRabd0t5ZH6GkgUyqkmve2WN1epC5+6f86g
	UcGh7kykoSqDhoJg8YvVz7peUXvzK+iU/72JIZNb5zcT2Fznq8YwkBqRLBTE5jG76d9vJM
	pLh08gNvw9JucqrvcSFQBZi+FE4fYfmr3RrkxZDvH4e1TeCJc5yjHi0SEdC8h+fJnzEXYE
	GEwWVOhAMJcdtcdLSbh8G+IPvj6Hi84b3fAVTOMJdvXegfmBB9tLtYVx7OqDzVOVfXF9Ma
	oSryR7zqFhNsmr91dTbfCAEbDF2d+LlbZeOVi9ih55nELz+EQkHUEBS2LlmM/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NQHr0O8U6Os/qRzZzjEDgIf3ewnuyoNMhiRSN/DKnc=;
	b=E3icKIykoXNk5N2KsvinzJpOzZt1ZWXIzbZ/AlTCYLYnSPhiT8xF+Pxvvcri0yTLIHIvTS
	HJpAAfSoh41k3wAA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Change do_task_stat() to use
 scoped_seqlock_read()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251008123059.GA20446@redhat.com>
References: <20251008123059.GA20446@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104292132.2601451.5637554410583858580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b76f72bea2c601afec81829ea427fc0d20f83216
Gitweb:        https://git.kernel.org/tip/b76f72bea2c601afec81829ea427fc0d20f=
83216
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Wed, 08 Oct 2025 14:30:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:57 +02:00

seqlock: Change do_task_stat() to use scoped_seqlock_read()

To simplify the code and make it more readable.

[peterz: change to new interface]
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/proc/array.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2ae6318..cbd4bc4 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -481,7 +481,6 @@ static int do_task_stat(struct seq_file *m, struct pid_na=
mespace *ns,
 	unsigned long flags;
 	int exit_code =3D task->exit_code;
 	struct signal_struct *sig =3D task->signal;
-	unsigned int seq =3D 1;
=20
 	state =3D *get_task_state(task);
 	vsize =3D eip =3D esp =3D 0;
@@ -538,10 +537,7 @@ static int do_task_stat(struct seq_file *m, struct pid_n=
amespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan =3D !task_is_running(task);
=20
-	do {
-		seq++; /* 2 on the 1st/lockless path, otherwise odd */
-		flags =3D read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
-
+	scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
 		cmin_flt =3D sig->cmin_flt;
 		cmaj_flt =3D sig->cmaj_flt;
 		cutime =3D sig->cutime;
@@ -563,8 +559,7 @@ static int do_task_stat(struct seq_file *m, struct pid_na=
mespace *ns,
 			}
 			rcu_read_unlock();
 		}
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+	}
=20
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);

