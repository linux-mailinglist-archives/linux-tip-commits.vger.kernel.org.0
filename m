Return-Path: <linux-tip-commits+bounces-2269-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293139720F6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DE51F24831
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440B18F2DF;
	Mon,  9 Sep 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4T/xKjGu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+mbDIucC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5B18CBFC;
	Mon,  9 Sep 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902884; cv=none; b=HhmqRho1KWG24t6OgnrNQMB0NqV6QJ54TC8swVBUxh9hBcKcLiagC/7zXhfGushtRmm7DSHOKqXIZUAkRSz9cuB1RT8VDs+PgGY7D1OYMWyrbvNbKSGVcZfcwjbRAD1tf5LmpwFdi4okF1+YW0D6ru+GA7AFOSKBLDy3uMS4Hi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902884; c=relaxed/simple;
	bh=6VhcIoM5s2ByUOysQfg4ygQP1C2hv80guP97jvR911c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uwBkjryty4SUhUm4+yRzXmfy81cluWqzbX4i296iu+lCog7SHTRCb39PF/uV9GBEse3A2NlxwSqtgQOeO7aArkH5iyKwcxe8sax5kyxQhVBcEP0IgCXYN5dDmVW4JQ4Ucy0RD1tIHf9rVn5iaL1z+jyAfmSWy4wCle2OTySRIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4T/xKjGu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+mbDIucC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902880;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZbVK0/gT3YFDUZ2cwgDczkeb5ZmTGqV03Kn2z8oduE=;
	b=4T/xKjGu+PhBXJoeoYtEYRb3GzxNUdtVUH/QSdICD4BBPS1jvNGy3dz1U5mm77CTZ69Frl
	fBchcSgw154Plv60V5rj/WBdloGtKKBIav4lmN2wU0op+zePSUJYDVRAXpYJYXHwTnMdC7
	AeSBp5d3znDXKKyW2v+kPwqJY6tpWfIXBvlvDC7OHvH/Pxp3/qVUDrMbWgbAXyYnzLQCZL
	Ffk+Y8AY1NoJBFsKZMCgG8t+4O4roQRSkBYrMUTe/rk2bD2XImWj0Sm/rB7K8xI3ZB1QmG
	mYXeLBMDhnv8NkW7dTs8Ai4oIq+Y7DMos4aaRWH4wn8SgnBJ/W+p8X/nNNDRug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902880;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZbVK0/gT3YFDUZ2cwgDczkeb5ZmTGqV03Kn2z8oduE=;
	b=+mbDIucCX4AsD27ceTeKidzLs5yRmZFzUreO+LUpavBRPW+zmtuNE89oLw/6gzTICxdfiF
	uu49iXTougV9omDw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Consolidate alloc() and init()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-3-john.ogness@linutronix.de>
References: <20240820063001.36405-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287978.2215.10709901240334242629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     f37b105faef637cdaff334c0369b451410566ca0
Gitweb:        https://git.kernel.org/tip/f37b105faef637cdaff334c0369b451410566ca0
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:28 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:22 +02:00

printk: nbcon: Consolidate alloc() and init()

Rather than splitting the nbcon allocation and initialization into
two pieces, perform all initialization in nbcon_alloc(). Later,
the initial sequence is calculated and can be explicitly set using
nbcon_seq_force(). This removes the need for the strong rules of
nbcon_init() that even included a BUG_ON().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-3-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 --
 kernel/printk/nbcon.c    | 37 +++++++++++--------------------------
 kernel/printk/printk.c   |  2 +-
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 19dcc58..398ecb4 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -75,7 +75,6 @@ u16 printk_parse_prefix(const char *text, int *level,
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 
 #else
@@ -96,7 +95,6 @@ static inline bool printk_percpu_data_ready(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c8093bc..670692d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -929,17 +929,22 @@ update_con:
 }
 
 /**
- * nbcon_alloc - Allocate buffers needed by the nbcon console
- * @con:	Console to allocate buffers for
+ * nbcon_alloc - Allocate and init the nbcon console specific data
+ * @con:	Console to initialize
  *
- * Return:	True on success. False otherwise and the console cannot
- *		be used.
+ * Return:	True if the console was fully allocated and initialized.
+ *		Otherwise @con must not be registered.
  *
- * This is not part of nbcon_init() because buffer allocation must
- * be performed earlier in the console registration process.
+ * When allocation and init was successful, the console must be properly
+ * freed using nbcon_free() once it is no longer needed.
  */
 bool nbcon_alloc(struct console *con)
 {
+	struct nbcon_state state = { };
+
+	nbcon_state_set(con, &state);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), 0);
+
 	if (con->flags & CON_BOOT) {
 		/*
 		 * Boot console printing is synchronized with legacy console
@@ -959,26 +964,6 @@ bool nbcon_alloc(struct console *con)
 }
 
 /**
- * nbcon_init - Initialize the nbcon console specific data
- * @con:	Console to initialize
- *
- * nbcon_alloc() *must* be called and succeed before this function
- * is called.
- *
- * This function expects that the legacy @con->seq has been set.
- */
-void nbcon_init(struct console *con)
-{
-	struct nbcon_state state = { };
-
-	/* nbcon_alloc() must have been called and successful! */
-	BUG_ON(!con->pbufs);
-
-	nbcon_seq_force(con, con->seq);
-	nbcon_state_set(con, &state);
-}
-
-/**
  * nbcon_free - Free and cleanup the nbcon console specific data
  * @con:	Console to free/cleanup nbcon data
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 93c67eb..a47017c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3618,7 +3618,7 @@ void register_console(struct console *newcon)
 	console_init_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON)
-		nbcon_init(newcon);
+		nbcon_seq_force(newcon, newcon->seq);
 
 	/*
 	 * Put this console in the list - keep the

