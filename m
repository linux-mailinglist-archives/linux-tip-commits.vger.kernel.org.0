Return-Path: <linux-tip-commits+bounces-2221-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A1972082
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7201C239C8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1B18592C;
	Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="opFiJW4v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJqsrvuB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691117D372;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902868; cv=none; b=VcsIuPOrEOjbrvinOFX1PhDuv/EKp4LrSax0FywF1CCgAXb8utrFPEfCFMoB2i/qbBZKttZo7pE+eKfRMLNXk/nc2r1f3b09MEawlRYUqZ0ubXY0gyu0futp1asfto9Bi3pE5P1kcHISbN+NImTjq+wpHaxkVT3sQTUJSM1676c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902868; c=relaxed/simple;
	bh=n0NvX9BxiJG+2Gb6qdrdBvJXQHkiAccTsXJ0cntslNA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VBKYjxob5D3snDvA9kd65QoprAf3FCl7+tS+IhSYt8Na+YVBd1bH2Chxtqa7Wog7HmjHOfTbln7ih05vMLGutYu/u8fOWdCU04OuZ8rYlAgwmN+wO+/DpOqmtWsGGtlnrDpctn6jHmRthiZimYNa8HWaf+HYaCaKoDHdVFZNAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=opFiJW4v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJqsrvuB; arc=none smtp.client-ip=193.142.43.55
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
	bh=4FYox0ePFnsrNqwBiNpjmotZaYr6QtVHhtZOYAZ2LjY=;
	b=opFiJW4v+ZIPYLor1mqqcf0WhvbV+lvIZLZiMAfeR5Nh2FnZKMPjI2qeteq/I8T/dAl7AF
	uVHjGZRH8ZBeuRkNggZH4TSV2Eroidzyo10GoGCDcVt6rZg+AZeaq6B/dEmEcfYxLp7ugl
	UGk+wScxCuW6XglixozgzH8kK1JjHmrPZkgYhp1JgiM63+JzwAbal4PG/ih9hgQJkpSWAM
	riQZlc9XWJwyHrLepko2yqFKjjaqIZwAZ/vrKcnZvkImDtcg+r84OhTLlk0QwzsQM2bHqT
	Oe5eIzL8gcyo2GR9yaW4tEQ9jXceFFG1cyzqU2LuuS3KtNpc4Ega2EY3N62UhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FYox0ePFnsrNqwBiNpjmotZaYr6QtVHhtZOYAZ2LjY=;
	b=lJqsrvuBbU+O1Wq+m2B3s7O8I9JQQpS6pzsp8AcuyuCkxEkTo8883fSLS2ZA8bDk5zH/zO
	ZgIHFApkWFkFZ/CQ==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] proc: consoles: Add notation to c_start/c_stop
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-13-john.ogness@linutronix.de>
References: <20240904120536.115780-13-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286353.2215.18146417947393556034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     fe6fa88d865e9c1a41b41f92ae0531470c86f0da
Gitweb:        https://git.kernel.org/tip/fe6fa88d865e9c1a41b41f92ae0531470c86f0da
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:31 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

proc: consoles: Add notation to c_start/c_stop

fs/proc/consoles.c:78:13: warning: context imbalance in 'c_start'
	- wrong count at exit
fs/proc/consoles.c:104:13: warning: context imbalance in 'c_stop'
	- unexpected unlock

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-13-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index e0758fe..7036fdf 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -68,6 +68,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
+	__acquires(&console_mutex)
 {
 	struct console *con;
 	loff_t off = 0;
@@ -94,6 +95,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 }
 
 static void c_stop(struct seq_file *m, void *v)
+	__releases(&console_mutex)
 {
 	console_list_unlock();
 }

