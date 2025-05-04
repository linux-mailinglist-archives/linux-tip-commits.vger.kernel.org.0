Return-Path: <linux-tip-commits+bounces-5214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4BAA84E0
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 10:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0BD3B8F62
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07618E377;
	Sun,  4 May 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gaRdjhqM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b/4d1SQw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDDDF5C;
	Sun,  4 May 2025 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348867; cv=none; b=XOR8MgKQ9mzyLGbNALa5DxyoI+8U6HqTJA2EeZXluOP7d2nMgROQozEYKCismE5BVrhKQwibtjkZEVqM49UF2RaRlfqZ/PhsquEAODPTfpigZSy+NntnmUYQL0oY/FqAmTvc29doduYkb7RFuPiZK4Wbmqutw4vjveMwlpooqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348867; c=relaxed/simple;
	bh=3CwNG0QIew4jt4I0gx+IjgmDoBiHfvazUP2L6RVu84A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qd3aqCPKss81l2NR94/PxuSQvHMZLOVSL50cj0WAq0SQN9s78TP9WPnYMiWKuDZkuBI/yuGeXmvXefJzXlaDlJnA1HdNe1Aooaq3GVYEw8Se3OCaE5q0I+dI1f7tfpK5rhdQ9iErQb8gqVnpr8eSacwKkQ0GVga+cW3GOzlJB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gaRdjhqM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b/4d1SQw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 08:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746348863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htu2sH03rd2qKxU2W0bLnN88MvsTiEeqbpAwZUPp1c4=;
	b=gaRdjhqMkan7V1Yzy19TVapS6neqBrEykYT07Hi1Rq3fWUMS7AbLE/3m60Cn1F2qYgcmrG
	78DAB1ZZszMQXAZiukSubuQJTCTPDOLGWcwUX1zx7G2PqvfrB1E/gWi+Uhi2Nx+19yhQ2Q
	E5AzAO/fo0kcaF52f2cSr1Q3kZUxY+/1VY3iBpkSZhsIG3a0KTFw5D8szvCVBXAUqXTam8
	/6yS/JRYB82Wg+ehcFeGO6rIwriZSDgTxCu1EJZMmX3immnvWamT7+V+b9R0x54e6MguKl
	nTIe1A1QIEYgtPnYzzw/gJzZ6VIFaeyrwSV6nXn1qF5wiQj84PPYXD+Vp6f5ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746348863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htu2sH03rd2qKxU2W0bLnN88MvsTiEeqbpAwZUPp1c4=;
	b=b/4d1SQwONPii68TruoptJYLL5tMS3wFvtYDqrQN4zoWXM7kJgdaUcAY0j6waRnBsanT2L
	NIliTzzxvCfQ0ACA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Check TIF_NEED_FPU_LOAD instead of
 PF_KTHREAD|PF_USER_WORKER in fpu__drop()
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250503143856.GA9009@redhat.com>
References: <20250503143856.GA9009@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174634886289.22196.15264637778984869937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     016a2e6f8ae5ed544ba8fb2b6d78f64ddfd9d01b
Gitweb:        https://git.kernel.org/tip/016a2e6f8ae5ed544ba8fb2b6d78f64ddfd9d01b
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sat, 03 May 2025 16:38:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 10:29:25 +02:00

x86/fpu: Check TIF_NEED_FPU_LOAD instead of PF_KTHREAD|PF_USER_WORKER in fpu__drop()

PF_KTHREAD|PF_USER_WORKER tasks should never clear TIF_NEED_FPU_LOAD,
so the TIF_NEED_FPU_LOAD check should equally filter them out.

And this way an exiting userspace task can avoid the unnecessary "fwait"
if it does context_switch() at least once on its way to exit_thread().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Chang S . Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250503143856.GA9009@redhat.com
---
 arch/x86/kernel/fpu/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8d67443..fa13129 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -693,8 +693,7 @@ void fpu__drop(struct task_struct *tsk)
 {
 	struct fpu *fpu;
 
-	/* PF_KTHREAD tasks do not use the FPU context area: */
-	if (tsk->flags & (PF_KTHREAD | PF_USER_WORKER))
+	if (test_tsk_thread_flag(tsk, TIF_NEED_FPU_LOAD))
 		return;
 
 	fpu = x86_task_fpu(tsk);

