Return-Path: <linux-tip-commits+bounces-4962-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEDA878E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B90170AE9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D925D1F5;
	Mon, 14 Apr 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSjty9UP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GnkBp6Lp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BE25A626;
	Mon, 14 Apr 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616094; cv=none; b=ozul7xtn2977YcyGdk//6mC69oAO6/qSWlL1yTkWzlzEkVBDZhX8J+E4weBv35xklPSCsN/4dQzAYtMtOIOnftYY2thFvIwZm6X0KEMCeNxIKD30344AQzGR1CO4RTD0SXmU6yN3gtJcfs2ObiAzx1NfzSPcpCrgZphliPNGTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616094; c=relaxed/simple;
	bh=PZyIfaYG+ghmxQGzZrvRJZETx9HNobr4u5lVlKzwHWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JAh/3cECWQx/eL0sAaV7mxEojFYjR40DDy/O2QeXz/c47FbO2pYEl3FH/jn6PZ1Y7WX4CnoXRQGcCG0CzUTjm3k5Jm5Zxm9PrYtfTsoN1TsZqolZ/2p7q+rMlRjPekW6sHwxWHmJBDEVOH6K6+KPUIzeKXjS3m7hnpZcuDnBW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSjty9UP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GnkBp6Lp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qZB5hR5oKQbQR4ZnJpJ1+hmbGS1LG285DUfjjqP1s4=;
	b=MSjty9UPVNGIi1k7Qop7nSpWah8xwqbZOtFjfVJ9M69oV31EgW35vmnDXqF+YQqsyf5pEs
	lza3ncHOpPC6DYg+tOrVtwEzZo9O49o50o91rw7tKYtyP7tnoyRibyn+1e0YFR4qzpLJeb
	MjwsYkNVzsbtwKFcCc0mDGLLXrGuMFG7wkmu+MTE/7N0sdrdOU1TGmut9SG/x9sLTgh7kH
	DTS0DwfP4EupFhU1aqoGsenP/PvnXIY0GjhUWH/r78klMilTasTn7LLIUyLmNj160ilHe7
	7+t85h0GiL5T/qunenECIWsYDwBgN82HJdtzqRTtBGdMweJHFukRI4HRqK9JzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qZB5hR5oKQbQR4ZnJpJ1+hmbGS1LG285DUfjjqP1s4=;
	b=GnkBp6Lp4jF0oAVctArvlpeWV1NCF5qfh5qly3/8lyHB6Iq2OndU1NQGrJYZNr6EPCveNy
	wCAjSpH3EeTfxmCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu: Introduce the x86_task_fpu() helper method
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409211127.3544993-2-mingo@kernel.org>
References: <20250409211127.3544993-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461609058.31282.7197654052284959365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     77fbccede633a5565cae084348b5459f6849086d
Gitweb:        https://git.kernel.org/tip/77fbccede633a5565cae084348b5459f6849086d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 23:11:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu: Introduce the x86_task_fpu() helper method

The per-task FPU context/save area is allocated right
next to task_struct, currently in a variable-size
array via task_struct::thread.fpu[], but we plan to
fully hide it from the C type scope.

Introduce the x86_task_fpu() accessor that gets to the
FPU context pointer explicitly from the task pointer.

Right now this is a simple (task)->thread.fpu wrapper.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250409211127.3544993-2-mingo@kernel.org
---
 arch/x86/include/asm/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5..2f631e0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -523,6 +523,8 @@ struct thread_struct {
 	 */
 };
 
+#define x86_task_fpu(task) (&(task)->thread.fpu)
+
 extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
 
 static inline void arch_thread_struct_whitelist(unsigned long *offset,

