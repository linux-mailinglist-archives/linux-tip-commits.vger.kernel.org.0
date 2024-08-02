Return-Path: <linux-tip-commits+bounces-1917-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A65945E41
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BC91F23F30
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C561E4868;
	Fri,  2 Aug 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFY2ESgt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1OYZ1uZ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1B1E484D;
	Fri,  2 Aug 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603675; cv=none; b=Na44uE/fUWzVqYNqTE3c1nwKjj58+2qrxc+GBXbtyt2jmdoSoXJkYG2a1PF+4SvDzU0TB+viKZd/U1Oq5il5XNOs/xN6+A2W5nzJzTqhXDbKfr0jj4DzEhQw1Mnh24hg6tT+iUGft7JP+b9ovoMJs+HjSh1IygILbq24pyRjW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603675; c=relaxed/simple;
	bh=6xbV5coL9L5DcczCTWZA4EFCUOZG4PiFIyo8+E/q9lI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FRXOU6HcGRqks3WESrV02mPAUyY1VPoiRx6XfegxsI0qd27XciU/5grySml+256Qw9uqhjrxL4wl6cHDv9z9pfdezS55MkSyttIEPoaxUu9j/XvopD+d9n3NykohwpvsqTHDpsPFoWb/yn6HAwfULy14V5/R83iBHFARErsHHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eFY2ESgt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1OYZ1uZ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 13:01:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzybNjFD6Yd8xfm8fn2cw0riknejZym0ljhPOh4Zmks=;
	b=eFY2ESgtTRpDGt5aX3xKSlS2dkIS/AhAKx2bNWZ2MHIQ5U1ZKHT9UqmupNyj1nCMu7PpJ5
	ZR/2wu8HVSyi/ITZX3EjxAkfJn7TYpvEt98Ty1KForduXK75z++zDbKbxY2nuFOa9NFkRd
	YAbJU5AU7XzwQbVxJjHs6yHpwtIfKLNDKQ6TeVPmIa8BrPROVUZJ1sHXGJz9XzrzbJO0vd
	OQ/i2NHPJlMMEGrfPLxZpU3PfOV6TxOgOsgHv6J0Ib+1t3zK9IJSncVzbeUcxxO1sA9C3K
	EGYkqznLt5edcN93vZlRkBwfhW6jhhThZh9RGn0piFCYJbwq1LcSXr2tytIV7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzybNjFD6Yd8xfm8fn2cw0riknejZym0ljhPOh4Zmks=;
	b=1OYZ1uZ2+azOnRRteSDLzUl4e5EQQrCCGDB4IgexyLXJh+P3Uhu5xUhKHRpRL3XqkpESFH
	Iu2uExsYx6eaFOAQ==
From: "tip-bot2 for Aruna Ramakrishna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/pkeys: Restore altstack access in sigreturn()
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802061318.2140081-5-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-5-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260367109.2215.3503021469640609513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d10b554919d4cc8fa8fe2e95b57ad2624728c8e4
Gitweb:        https://git.kernel.org/tip/d10b554919d4cc8fa8fe2e95b57ad2624728c8e4
Author:        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
AuthorDate:    Fri, 02 Aug 2024 06:13:17 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 14:12:21 +02:00

x86/pkeys: Restore altstack access in sigreturn()

A process can disable access to the alternate signal stack by not
enabling the altstack's PKEY in the PKRU register.

Nevertheless, the kernel updates the PKRU temporarily for signal
handling. However, in sigreturn(), restore_sigcontext() will restore the
PKRU to the user-defined PKRU value.

This will cause restore_altstack() to fail with a SIGSEGV as it needs read
access to the altstack which is prohibited by the user-defined PKRU value.

Fix this by restoring altstack before restoring PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802061318.2140081-5-aruna.ramakrishna@oracle.com

---
 arch/x86/kernel/signal_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053..ee94538 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -260,13 +260,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_signal_shadow_stack())
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_signal_shadow_stack())
 		goto badframe;
 
 	return regs->ax;

