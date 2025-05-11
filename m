Return-Path: <linux-tip-commits+bounces-5518-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8EAB271F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 May 2025 10:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AEE1752B0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 May 2025 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F328FD;
	Sun, 11 May 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xx/sMCnZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLh1YHHK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9813BAF1;
	Sun, 11 May 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951101; cv=none; b=UpJyZLUDJxfV/fYMfmip8ktLBtqKfpJyF+O6zTbnqQm3XTUvsfMZidg8N1rMid1EjXa7ldkExegUO/TWOYeIzBdtmNQqYopCB/qRo56M60IFlsxmhxEzlKYrCIZzdyY7UHXy7QfcoVdtMvl9znAAoqf0Wz2Pwd+aKYCwmltJagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951101; c=relaxed/simple;
	bh=yK4ahCza8TbbcdrJScmCg9Adt0N6k/EJklC2rTOweGY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iJVehDu0B8En4COn89i+PBV3hM6CKi6FoJpgi6xtXlVYZPAmJItvavu0VqWKRssvfzRYEi3Up92tdtp3aO6RlV1BSFwsNY0Wdk4nSr7fPRIWFT5w6wKrEHTx8sZGR7wO7a7jfWF+EG8DwWK9UIcbSW3H1Q29pNIbfxMLxBylu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xx/sMCnZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zLh1YHHK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 May 2025 08:11:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746951092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOdk++yGxo5I5tl1JLhOpwsBoXiUfzp+zUr3nIx6XWM=;
	b=Xx/sMCnZzZMsDYl48cUWqx07NAjt+37HK5BkY6sDWp1vlJrHHyeFFyUdtSt41OPrVM+yvV
	1OWaJ4TEJeXon9nVb9uj5yQ9wLXlqq/vq8EC/+7MxjcasxmJ3omeCQpieV+sw4yVlJXnOi
	ibIjSQ4hVS1C47f2xPtz6QyRt4OUIEA9TADmIVA+CtlUtMtSSOl+MUa1JbHLiZumJAiiiq
	7t+F3xB2tw9tUkE8DSBi4ecvJmX5Xrc+2XIIfGGO9d5jbqVLwc0EWuzg45+oqu8SR6U5ko
	nTVJCUWeghVhUN59DpM3eum5OZsKE2X1CJ4aBVy2b98cpbEZpzUcEoBCBa51ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746951092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOdk++yGxo5I5tl1JLhOpwsBoXiUfzp+zUr3nIx6XWM=;
	b=zLh1YHHKiVbsSQzVmPm3ac5KSoOGa2GmRi+odZBn9tkCfyWVdDA3wSVgTnmsvsB5p7o0Bs
	kQ+VoRhnz8U0afDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Relax the rcu_assign_pointer() assignment
 of mm->futex_phash in futex_mm_init()
Cc: Ingo Molnar <mingo@kernel.org>, andrealmeid@igalia.com,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aB8SI00EHBri23lB@gmail.com>
References: <aB8SI00EHBri23lB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174695109115.406.3560364055449285428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     094ac8cff7858bee5fa4554f6ea66c964f8e160e
Gitweb:        https://git.kernel.org/tip/094ac8cff7858bee5fa4554f6ea66c964f8=
e160e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 10 May 2025 10:45:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 11 May 2025 10:02:12 +02:00

futex: Relax the rcu_assign_pointer() assignment of mm->futex_phash in futex_=
mm_init()

The following commit added an rcu_assign_pointer() assignment to
futex_mm_init() in <linux/futex.h>:

  bd54df5ea7ca ("futex: Allow to resize the private local hash")

Which breaks the build on older compilers (gcc-9, x86-64 defconfig):

   CC      io_uring/futex.o
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from ./include/linux/compiler.h:390,
                    from ./include/linux/array_size.h:5,
                    from ./include/linux/kernel.h:16,
                    from io_uring/futex.c:2:
   ./include/linux/futex.h: In function 'futex_mm_init':
   ./include/linux/rcupdate.h:555:36: error: dereferencing pointer to incompl=
ete type 'struct futex_private_hash'

The problem is that this variant of rcu_assign_pointer() wants to
know the full type of 'struct futex_private_hash', which type
is local to futex.c:

   kernel/futex/core.c:struct futex_private_hash {

There are a couple of mechanical solutions for this bug:

  - we can uninline futex_mm_init() and move it into futex/core.c

  - or we can share the structure definition with kernel/fork.c.

But both of these solutions have disadvantages: the first one adds
runtime overhead, while the second one dis-encapsulates private
futex types.

A third solution, implemented by this patch, is to just initialize
mm->futex_phash with NULL like the patch below, it's not like this
new MM's ->futex_phash can be observed externally until the task
is inserted into the task list, which guarantees full store ordering.

The relaxation of this initialization might also give a tiny speedup
on certain platforms.

Fixes: bd54df5ea7ca ("futex: Allow to resize the private local hash")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/aB8SI00EHBri23lB@gmail.com
---
 include/linux/futex.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index eccc997..168ffd5 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -88,7 +88,14 @@ void futex_hash_free(struct mm_struct *mm);
=20
 static inline void futex_mm_init(struct mm_struct *mm)
 {
-	rcu_assign_pointer(mm->futex_phash, NULL);
+	/*
+	 * No need for rcu_assign_pointer() here, as we can rely on
+	 * tasklist_lock write-ordering in copy_process(), before
+	 * the task's MM becomes visible and the ->futex_phash
+	 * becomes externally observable:
+	 */
+	mm->futex_phash =3D NULL;
+
 	mutex_init(&mm->futex_hash_lock);
 }
=20

