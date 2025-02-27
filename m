Return-Path: <linux-tip-commits+bounces-3699-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85475A479E1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2132189277D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9842622B8AF;
	Thu, 27 Feb 2025 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lLqOawkM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmj5UmrE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3022B59F;
	Thu, 27 Feb 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651132; cv=none; b=C8kodeNYs3uPOh2IEtGf0SEUXcZjvfWZ8C5mvJXe2Va0X31O9JY63qIvcINhQQNT053dRPfcuLYPj+5pT1oJ1FyV7m8q9zUfO7E/U3L5lDMFxPx5BIH6guOgWTK1OXNRIOQRM8V35t9HPUJyYxIO5NW8AUhrd1ZupzspcjqoUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651132; c=relaxed/simple;
	bh=NYTJzUq8LMZazHhCUVUP4z6hpl248vwZzFmOQqjUvYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tb9gXCkjgKW0TXX6J9pPSofs+L9vlHSd9xrpCMARlMNC7pfRWFRA8P7MUrnC6GdA0cVDmYvpqv+PYF+kY0uc5tx/GbOn4PpIOXCMPmSoCH8UTwuzMcbEZP2EH6oOUVYflTd22bz7OwDyccfklWJnKyXW0ZpPby6A8hvb91KQZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lLqOawkM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmj5UmrE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740651129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK1VLvMRNrcKCbveLsvnWkFM89NFY8AjE1Ea9fAeIIE=;
	b=lLqOawkMs7xbC1mvobxYRaKysGxMy7N2FRpeAEGsORXneedlE9lDdSErXO/JFWjiJu2TQk
	u34wghuE2xZxBQ/ZuOjLieARglzX9FlGO1qApAlqBqCWQQ+xPqJ4R7GG3LRH7RfGmjxyS5
	jjVtfvWXbhUJUweEd9kHQJbP0B5MAaU9zM+7OhtWy1qHjUu492+jY06IMLGLIVaAXjSHH1
	nKVlBPKtMvV0ZIwNVp7eT9pJjjV5spE8bzyMPJqHk3Mj2tDQ1ySlQFcHZV+qOD2Io4adRR
	KvImh0Xxm4hT/0RF4/uAax1GscowA+fd1rY/K50Mo6FYVsUo3HiVJhFmaT6v6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740651129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK1VLvMRNrcKCbveLsvnWkFM89NFY8AjE1Ea9fAeIIE=;
	b=pmj5UmrEAhgS3H3leVIXRlabhkCMiOa+++Cv7DIo3tGCvUGJfBCXTjI5F/8BeavIIlV+pF
	XDGbaB2xl1a71oDg==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] selftests/x86/xstate: Fix spelling mistake "hader" -> "header"
Cc: Colin Ian King <colin.i.king@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250227091533.599213-1-colin.i.king@gmail.com>
References: <20250227091533.599213-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065112920.10177.13696580835482624549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     bd64e9d6aafd12e5437685d2a06360f86418d277
Gitweb:        https://git.kernel.org/tip/bd64e9d6aafd12e5437685d2a06360f86418d277
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Thu, 27 Feb 2025 09:15:33 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:49:31 +01:00

selftests/x86/xstate: Fix spelling mistake "hader" -> "header"

There is a spelling mistake in a sig_print() message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250227091533.599213-1-colin.i.king@gmail.com
---
 tools/testing/selftests/x86/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index 8757779..23c1d6c 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -391,7 +391,7 @@ static void validate_sigfpstate(int sig, siginfo_t *si, void *ctx_void)
 	if (get_xstatebv(xbuf) & xstate.mask)
 		sig_print("[OK]\t'xfeatures' in XSAVE header is valid\n");
 	else
-		sig_print("[FAIL]\t'xfeatures' in XSAVE hader is not valid\n");
+		sig_print("[FAIL]\t'xfeatures' in XSAVE header is not valid\n");
 
 	if (validate_xstate_same(stashed_xbuf, xbuf))
 		sig_print("[OK]\txstate delivery was successful\n");

