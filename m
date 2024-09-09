Return-Path: <linux-tip-commits+bounces-2229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1893972098
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5AA1F2487A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0C188CBB;
	Mon,  9 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FE8ROagY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d1athWHA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CB187879;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902871; cv=none; b=GDzsfvA+w6QRQ4uRJ6WY/6nAtkEY/5jPxEKUKlwL2p5+u9Up2YVNKI7BEtssNOLcpU2tB1Y+U3P7hDEIcNBfcO/eCNcP2qgH+4RGGabcFERfLKLgITC1DTTrXHkV5Pjw5OhxkCA0WnzQwB9WUhtwy3lSfA+VTrQ/zXPJQCoIQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902871; c=relaxed/simple;
	bh=LIkWGfbLrGbgyUK5ApGRXCJz6fZSiCH+TCKhFOeqRHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sxjJEzSB9OCUNCWiVi/LO1Sms9/H+uSp9PFl0g/6Agh9h6ysvLQtitJs2NDmJWjVdFzvc053ztDI2Usp73tzBFn+4mBToMYjAZ5E7v7zqY5vaGU2/kjnYhS/vUeQI542dLlBRnmA6apjiLI80BT/txoH5ql7Ocq0CNmNNIsuepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FE8ROagY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d1athWHA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAQEBcDwnzIt8heX8NLDhDOJda/Vt2FZ91B5+vaAFJI=;
	b=FE8ROagY1KO58IcroKhKGdwwTRRognesqDXHE6GRzdRlpO9XTr8vUAbS7KlqhIeIp+SZmn
	qP7Mxy7m1YnLCpRHF2z7Qe+TEmhd3VvDwS40dsG3fNEzqUlNNu82Kk6vL/3WZy33f1aDWt
	eawYK+frhcqfEZ3OlQU96elav3irDZ2nl/wohngegAyHikB8fhMy1NUyL3bjY1EAHeVleK
	BYabKjc/gktrJ0JmBV6JHNS3zpKEEtbunyd6A2uYafmUZ9Nxj83eAVltZVVre31Am83MVn
	3fTc6h489AjQ9RBOa9IzMrrqiOR03sTYWlvPHOcFiEx8M3gvoNURnyo6Q06L3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAQEBcDwnzIt8heX8NLDhDOJda/Vt2FZ91B5+vaAFJI=;
	b=d1athWHA2VBVXkG24IcTU6qrGsZfof8QYWVvEhS24q3pdbFpAa2Y6ny7fxj3fhOwuzUp3P
	RuxDxNtMxVrzAUBA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Flush console on unregister_console()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-4-john.ogness@linutronix.de>
References: <20240904120536.115780-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286638.2215.7689151913808015067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     0e53e2d9f72080b7ea1a4003558041fee78cdef9
Gitweb:        https://git.kernel.org/tip/0e53e2d9f72080b7ea1a4003558041fee78cdef9
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:22 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: Flush console on unregister_console()

Ensure consoles have flushed pending records before
unregistering. The console should print up to at least its
related "console disabled" record.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-4-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index acf6680..c79e962 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3771,11 +3771,16 @@ static int unregister_console_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
+	if (!console_is_registered_locked(console))
+		res = -ENODEV;
+	else if (console_is_usable(console, console->flags))
+		__pr_flush(console, 1000, true);
+
 	/* Disable it unconditionally */
 	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
 
-	if (!console_is_registered_locked(console))
-		return -ENODEV;
+	if (res < 0)
+		return res;
 
 	/*
 	 * Use the driver synchronization to ensure that the hardware is not

