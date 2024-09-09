Return-Path: <linux-tip-commits+bounces-2252-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99169720DB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708591F24856
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3018C904;
	Mon,  9 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KR/YBU7h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMepkBKz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA318B474;
	Mon,  9 Sep 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902879; cv=none; b=b452qw4LnKTfs++y2zjKt34dFiVJuePKx+p6ebzjhCXS75J0bFM4Xl3UDIvwx8FhcB71pRzDKYIY0hPr4Zrd7nIYdXLOttNkcb/r5b3wtqMFbnJaztGlORJUJENowb/H5hCirjfRNppjb1lBrKVe+PmTCfCwzCTLTH4Wggw1pnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902879; c=relaxed/simple;
	bh=iFlUUl8n7mo4Y7L9GJDHErUVhBN5vb1T+9F2OnNU0MY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X7GjqOUlxLWVCnmu6ZpGqssOT6aTJCWHpyygzfHgX4Em1JqTBoenZ/povDJ5asRFdReZe3TOm+QbXQlHLw0g3CbjIW0S/Njjy4YcGF0HmwEkx+jJ5kPACMBmvDINR9VvPu8hip0UkQzEZnVyCOtOtffHuFKISYeIWse1dLemhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KR/YBU7h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMepkBKz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBuiJ0/75+XDEusRqwhmf9ywozZzK2Ef4TsWZTgSmJY=;
	b=KR/YBU7hGntr3jWBt0Knju5LrhAy16aACsDoh7/w7EHJ4Izldj0QelZrOio7gJm7jZon4G
	FopWTnk/CTbYRk7cVte9HJNDsVjMWMZICEyakBwScaCUMpAw+WS3QG2IJ7ITu2p+qTyfUe
	MdZh9yOibCWVPQkK+WK7ySQ/kS3CLq+3t9+nQ3OB+x4LiB8zG7Gy4kuGlX3/LQaBe1ggVU
	Oc3D/kCUhjYOpKH+wVqg2T5WrMhmLRBvuWGGlMf9LK3qXuSSqjjaELmL0rZ5lCrI1+ED5U
	TzaeI5Sm5Ww6elV+IPGH47rz8LM/DCYbbSpjr/l/XVFGRraOFl8rDJpfeL2BSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBuiJ0/75+XDEusRqwhmf9ywozZzK2Ef4TsWZTgSmJY=;
	b=LMepkBKzdHQu/puU5fvRqbGJwI5JYww8I7SJvbh+7z9yW+qcZdN5HFz33Hi5lMZzR4Z6Gj
	LKMJrrDhNoTp1UCA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Let console_is_usable() handle nbcon
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-18-john.ogness@linutronix.de>
References: <20240820063001.36405-18-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287439.2215.6043727995385637145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     20846d1ce2adacd2b1f8672e24d6acb26b2e757b
Gitweb:        https://git.kernel.org/tip/20846d1ce2adacd2b1f8672e24d6acb26b2e757b
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:43 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: Let console_is_usable() handle nbcon

The nbcon consoles use a different printing callback. For nbcon
consoles, check for the write_atomic() callback instead of
write().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-18-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5d9deb5..448a5fc 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -86,6 +86,8 @@ void nbcon_free(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
  * records.
  *
  * Requires the console_srcu_read_lock.
@@ -100,8 +102,13 @@ static inline bool console_is_usable(struct console *con)
 	if ((flags & CON_SUSPENDED))
 		return false;
 
-	if (!con->write)
-		return false;
+	if (flags & CON_NBCON) {
+		if (!con->write_atomic)
+			return false;
+	} else {
+		if (!con->write)
+			return false;
+	}
 
 	/*
 	 * Console drivers may assume that per-cpu resources have been

