Return-Path: <linux-tip-commits+bounces-3965-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C19A4ED68
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B4D7A8C95
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756524C097;
	Tue,  4 Mar 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcO75E0k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJyOgo7U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1A1F4CAD;
	Tue,  4 Mar 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116837; cv=none; b=uhcdR+LSF+hYriCyq0CEfpFooyYI/Dafvr5heLphL15ew9n/y+7G0I95HFVIvxo29fD8iugD0qDXlqdKpqTp2eu5gLMoDzRDiIFSG2RbNqnR/9aXJksYanKMZIEAOABjxrxpITWqUrCROtrIO5E7tXOE700Qy8wia77Dz3xZwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116837; c=relaxed/simple;
	bh=slzexu5Q7zsRfSWaIiDt0CaTuNTHqt1yn4qswhkqhiY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hMVDenYfUdWqoo1dz/+E5IZLv6muSHvmAYZxMO6PNDIR1GwXPq0b7AHGm9oAcjjCsjYWXonbvzUhMGY3dc3thrKn0BvlNOWW66Q/vLdufxNgV/iPNe/3LHjU28wwosbHJDPNG29mpl1AhphOjeQbXeaDmbMKOaUXXblmOyjdI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcO75E0k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJyOgo7U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:33:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icICM/aywSzmYgFr0ZB2vFPoIqH6Y4Fl2ShAzOfp3w0=;
	b=vcO75E0k7qD+naRPM3IZl7PA1zfyqH/RooYVjEZOo9yIgeFCfHOWq5Esee1FWWDL0wyk94
	bSCY+vNaYvl3tA5Lh2Rsr/BUiLoIzgtWfckD9HzK//ZWndvke8oIBOCl1LqD06YjdwQzA4
	hmNZ69uRXSowyvYILagruftkkNZBhG/f307NARJiB5bZnxbJIEMj0afKqdkhxkYS/hOvKb
	Ng/8+cuff/DLSuPQpAXMCSIzwGN9sd1DyRmtzDVW3gLmTq0dBg0WDq6MY6CTyJtwE5uHK2
	gFt/zMvugAhlWkrCpws5p5dGTNWv4XFatxTxD2NAiB+HmLeMxt7aOmOljSSPYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icICM/aywSzmYgFr0ZB2vFPoIqH6Y4Fl2ShAzOfp3w0=;
	b=eJyOgo7U6Ol3zI3OKTHTUg+Or9LTW6wWRuUAN/SMEQiM5e0Vsu+P3ddms1OZYoel4sy4Ta
	Tc7toU8zlzdQNiAw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Use current_stack_pointer to avoid asm()
 in check_stack_overflow()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-4-ubizjak@gmail.com>
References: <20250303155446.112769-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111683395.14745.9568647485119144899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     d4432fb5b8798a7663974bed277a8a6e330a50d8
Gitweb:        https://git.kernel.org/tip/d4432fb5b8798a7663974bed277a8a6e330a50d8
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:28:58 +01:00

x86/irq/32: Use current_stack_pointer to avoid asm() in check_stack_overflow()

Make code more readable by using the 'current_stack_pointer' global variable.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-4-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index eab4580..8c7babb 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -31,10 +31,7 @@ int sysctl_panic_on_stackoverflow __read_mostly;
 /* Debugging check for stack overflow: is there less than 1KB free? */
 static int check_stack_overflow(void)
 {
-	long sp;
-
-	__asm__ __volatile__("andl %%esp,%0" :
-			     "=r" (sp) : "0" (THREAD_SIZE - 1));
+	unsigned long sp = current_stack_pointer & (THREAD_SIZE - 1);
 
 	return sp < (sizeof(struct thread_info) + STACK_WARN);
 }

