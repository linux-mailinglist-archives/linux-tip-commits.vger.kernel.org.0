Return-Path: <linux-tip-commits+bounces-2220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF053972081
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B818284DFD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB76185628;
	Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZCGw8Zq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Af9mb4+K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686F17D366;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902868; cv=none; b=W9CeFbKAlZlzx+cj6LHGNSRtF4GxNwOCi11Uij3tHd69G+ZPmq+dfjJ3WMTUusmesqeESpgUqN8OIdXE5oaJcf6eQ4lIw1WZSEF9Q+AaYXSFqtZYAetryFt8RK33tjZQ7BM6obYvRa+CtNHeoHpSVSvnIMSsJVEvg50wb9JYkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902868; c=relaxed/simple;
	bh=aSCuA0ROcQziJIqdZhhyxI3pQc3LjRDi7UuzzWFPN0M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wwf2u7bUBb9ufSE4jkFpa8G9SoTAP2775trpqqVGumDqw4UiMfQwvco8Q2rZRWbD9rPZZn6rhQE6ISbTq4Dsgzw87UUoncmMjGgQdTpw4e6FO3naYyZkCG9oZP+tZD6x0N8qxzWVDpl8J/swAI5CKTYXHeUC9sOqJw1yOcBqZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZCGw8Zq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Af9mb4+K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj7LcUVX8rRYwmSYu+f1fnCFLloY2QbSbrzOuTAoVq0=;
	b=tZCGw8ZqfepIH599K38yQ/3kN+asy825eIvAJ6VtvMsgn3AJe5+trcgr46zCt7Y7vhTWOc
	V3WNFD2tYIu1oMNUoH8ArpJuAnBivhklM03Tt9CYTGCQeC9Sg+FOq0rZsBQKY+D17hFskk
	h4EvhL5AlWnoEY8EeJg9NkeLnM2uNGWQsV4gYHrS2xm6PFe9BHaY8+vOaJXYOFW46Ge26X
	fSZeMQGqtKnGvCJ2uIk1+IE7mBSlVfG8vc6JaD2lQGaTzcbKItsERS6Q/oC/1ATdiJRTzZ
	GzLm8ZLYf8sihPOMg0LzPpqg4T5yb1BHw2Uc7EgLujQQc8M4bYaeTlMFSIT0GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj7LcUVX8rRYwmSYu+f1fnCFLloY2QbSbrzOuTAoVq0=;
	b=Af9mb4+KN5M2qZ5+dvwYho168d5cGPhAm+EkST3KIxXpn1Ij726Jg8/8ifkIHiqBxMReo/
	FEbJSeCNk3b+rdBA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] proc: Add nbcon support for /proc/consoles
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-14-john.ogness@linutronix.de>
References: <20240904120536.115780-14-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286321.2215.6763307654100869183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     c83a20662dd099dbac9ef6df44134ef446980c56
Gitweb:        https://git.kernel.org/tip/c83a20662dd099dbac9ef6df44134ef446980c56
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:32 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:33 +02:00

proc: Add nbcon support for /proc/consoles

Update /proc/consoles output to show 'W' if an nbcon console is
registered. Since the write_thread() callback is mandatory, it
enough just to check if it is an nbcon console.

Also update /proc/consoles output to show 'N' if it is an
nbcon console.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-14-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 7036fdf..b7cab1a 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -21,6 +21,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
+		{ CON_NBCON,		'N' },
 		{ CON_PRINTBUFFER,	'p' },
 		{ CON_BRL,		'b' },
 		{ CON_ANYTIME,		'a' },
@@ -58,8 +59,8 @@ static int show_console_dev(struct seq_file *m, void *v)
 	seq_printf(m, "%s%d", con->name, con->index);
 	seq_pad(m, ' ');
 	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-',
-			con->write ? 'W' : '-', con->unblank ? 'U' : '-',
-			flags);
+		   ((con->flags & CON_NBCON) || con->write) ? 'W' : '-',
+		   con->unblank ? 'U' : '-', flags);
 	if (dev)
 		seq_printf(m, " %4d:%d", MAJOR(dev), MINOR(dev));
 

