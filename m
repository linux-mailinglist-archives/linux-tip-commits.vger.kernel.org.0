Return-Path: <linux-tip-commits+bounces-4289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E87EA6502C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD1E3A8FAD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57A323ED40;
	Mon, 17 Mar 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6YGjhvh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfCWfj63"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1423E32E;
	Mon, 17 Mar 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216654; cv=none; b=cuAdG3nxId747CgzTdyRE60KWM9ab/ZIFe2FsxVY8etuG98amEizHnToFhLBpB9p5yGMquJljZ72v89lYHQ3P33cb2ZmRTsI0Dc0LYgGCAba573B2qj6VJlKfx7UkiEKe0vhVZF+E6Maji+1+bIGhTXvWm+anygfe0LG3i3LZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216654; c=relaxed/simple;
	bh=KVUNmQdehuyTOB1NM2ZuDHvypCGHYTpjpC/HxaStcNU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=eXfdA0dOMLGqPlFNJ507e3uhR8qiDoDEuxb34DIascl6IOn1987hdZObcoOgeTgvB9t+isQD3b7weuV6SAuVdG0OEG5hGOzcyyFDePFu66aCF/rdw91x7NaT9ZZ0Fymam50dx+cAwmYdbhA7vX+eqi5Pk9attWlZt5rDkppngq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6YGjhvh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfCWfj63; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 13:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742216650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6dkw96a023iuOdRzg3FQ8Drz5v8x2QWbz4/l3/X8tU0=;
	b=Q6YGjhvhvXz0x92A38D5LTV+Yt7B+6wUm1n6PvxCL2XD5k92x/9FsCJ6CkjZRddaJQgTvc
	z0rQ19S4b9WaKH9JCXjdEXngF48zwUXM5Qoy1/EBS8MOSI+Ndsb5+efbJvS5vFlx+ICjP/
	m9Twx4Ay7IMyriRUxuL970BFp3utefv91Nvs5dLsaTpsMVFXZGz0IMYtVLjm7WBy/LlnVg
	dCcXD7Ez4IbzOGKxlY1d5fPjkl3mvoE+0eEWy9RJgfBCMc0wp2L8MfLOfwZSM2IPVoVGS1
	9+7NXLMG7kTcDkA+2nr75qGMTXmIKalPwvxow79iBOHyOa2QQemMdSErkTqQmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742216650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6dkw96a023iuOdRzg3FQ8Drz5v8x2QWbz4/l3/X8tU0=;
	b=AfCWfj63fAEfDznDAGoDF8tq3LAYcsqIglMPE3SR6xhAC/E+g6/WlEMNaYX0ppAKD7jhhM
	0DAWIRcN/52O+1Dw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Clarify the "xa" symbolic name used in the
 XSTATE* macros
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174221664750.14745.17196771195042757712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     4348e9177813656d5d8bd18f34b3e611df004032
Gitweb:        https://git.kernel.org/tip/4348e9177813656d5d8bd18f34b3e611df004032
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 17 Mar 2025 13:47:12 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Mar 2025 13:47:12 +01:00

x86/fpu: Clarify the "xa" symbolic name used in the XSTATE* macros

Tie together the %[xa] in the XSAVE/XRSTOR definitions with the
respective usage in the asm macros so that it is perfectly clear.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/fpu/xstate.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 1418423..0fd34f5 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -109,6 +109,10 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 /*
  * After this @err contains 0 on success or the trap number when the
  * operation raises an exception.
+ *
+ * The [xa] input parameter below represents the struct xregs_state pointer
+ * and the asm symbolic name for the argument used in the XSAVE/XRSTOR insns
+ * above.
  */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\

