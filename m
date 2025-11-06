Return-Path: <linux-tip-commits+bounces-7263-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D28C3AB29
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7BD3AA16A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977030F92F;
	Thu,  6 Nov 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3rACz4a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGj7ak+1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8A30F94B;
	Thu,  6 Nov 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429262; cv=none; b=fnoev/CnVkGI64tyrZB3VtdCOYSSBY3E+wvxVCQVi9O8mgGmYkhqLgUiviGBsw5ZzJXtwFyMoQ1jaHK8D5xzVU8LF3pUCQOGez6bZub18ixD6yAxmsVIfeOhbGjlATyZzkKi4K1xfZL0srWO6YexcK1yPo5qOyru9ZHm9ISCVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429262; c=relaxed/simple;
	bh=slqEmX1ioa8R3+SQy6g00IAdTsnmdZNJLLYZhyWdZFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V9CrVoI4S8bbYaXLJKEFtJyIZMVcyqGWQktIxjNxDoq8WTs44XHI1qk67xROrJQRZ7Zp1gAYuPfTwlBeU6ITl+gjrOTFWCrFHUQvpGTiOzU6ZVg7PUfJHxInFBGog7afmT9PmPc3nf8cygl4i1xZ/9VFwHYMoJ8+Puh5u5Qe62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3rACz4a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OGj7ak+1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 11:40:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762429257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnwYQvXml/2IkFf2xhXLITKom4tbY4oOYYosysZPHi8=;
	b=q3rACz4aUcbN+i21O0TcoYJh2uX7L1wYGevt/ZY3mCfypn91UV9gmSUA+rtvL9zOgnXl3e
	0B32c68H/bFOhpYxpjkH/RKu3OvcZrILlleoP+aCCpm+AOfhTYyttO9HzhCh454SmXzg1w
	NS1fOXip7xlP2dWfWS4PkNFo8w7J1JEG2GsZ5IuZv00AphovSP2OraFKncOZTNuKji+2+d
	SOOASK1CKWn3Pc6stNaVwcy22fcjNShje9ChiP/u1OPMjA3IOtc3yfijVXjIg1mQesbIS5
	10oA1fLc134q7z299oL1YX43gmUCzpJMilSMEcpCUlrvaMaH6399wE0EhijWOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762429257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnwYQvXml/2IkFf2xhXLITKom4tbY4oOYYosysZPHi8=;
	b=OGj7ak+1a518kfy0ZVb1HSqE7hVT12kFsD9rxWctR3+uO0hH9fdBQOXTltjWJFVyR2LOcY
	e1/+a64cvspYqyCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Optimize per-cpu reference counting
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251106092929.GR4067720@noisy.programming.kicks-ass.net>
References: <20251106092929.GR4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176242925149.2601451.16934943329668653196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4cb5ac2626b5704ed712ac1d46b9d89fdfc12c5d
Gitweb:        https://git.kernel.org/tip/4cb5ac2626b5704ed712ac1d46b9d89fdfc=
12c5d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Jul 2025 16:29:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 Nov 2025 12:30:54 +01:00

futex: Optimize per-cpu reference counting

Shrikanth noted that the per-cpu reference counter was still some 10%
slower than the old immutable option (which removes the reference
counting entirely).

Further optimize the per-cpu reference counter by:

 - switching from RCU to preempt;
 - using __this_cpu_*() since we now have preempt disabled;
 - switching from smp_load_acquire() to READ_ONCE().

This is all safe because disabling preemption inhibits the RCU grace
period exactly like rcu_read_lock().

Having preemption disabled allows using __this_cpu_*() provided the
only access to the variable is in task context -- which is the case
here.

Furthermore, since we know changing fph->state to FR_ATOMIC demands a
full RCU grace period we can rely on the implied smp_mb() from that to
replace the acquire barrier().

This is very similar to the percpu_down_read_internal() fast-path.

The reason this is significant for PowerPC is that it uses the generic
this_cpu_*() implementation which relies on local_irq_disable() (the
x86 implementation relies on it being a single memop instruction to be
IRQ-safe). Switching to preempt_disable() and __this_cpu*() avoids
this IRQ state swizzling. Also, PowerPC needs LWSYNC for the ACQUIRE
barrier, not having to use explicit barriers safes a bunch.

Combined this reduces the performance gap by half, down to some 5%.

Fixes: 760e6f7befba ("futex: Remove support for IMMUTABLE")
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20251106092929.GR4067720@noisy.programming.kic=
ks-ass.net
---
 kernel/futex/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 125804f..2e77a6e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1680,10 +1680,10 @@ static bool futex_ref_get(struct futex_private_hash *=
fph)
 {
 	struct mm_struct *mm =3D fph->mm;
=20
-	guard(rcu)();
+	guard(preempt)();
=20
-	if (smp_load_acquire(&fph->state) =3D=3D FR_PERCPU) {
-		this_cpu_inc(*mm->futex_ref);
+	if (READ_ONCE(fph->state) =3D=3D FR_PERCPU) {
+		__this_cpu_inc(*mm->futex_ref);
 		return true;
 	}
=20
@@ -1694,10 +1694,10 @@ static bool futex_ref_put(struct futex_private_hash *=
fph)
 {
 	struct mm_struct *mm =3D fph->mm;
=20
-	guard(rcu)();
+	guard(preempt)();
=20
-	if (smp_load_acquire(&fph->state) =3D=3D FR_PERCPU) {
-		this_cpu_dec(*mm->futex_ref);
+	if (READ_ONCE(fph->state) =3D=3D FR_PERCPU) {
+		__this_cpu_dec(*mm->futex_ref);
 		return false;
 	}
=20

